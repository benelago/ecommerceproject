class CheckoutController < ApplicationController
    def create
        products = Product.find(params[:cart])
        customer = Customer.find(params[:id])

        if products.nil?
            redirect_to root_path
            nil
        end

        if customer.nil?
            redirect_to root_path
            nil
        end

        products_array = []
        taxes_array = []

        products.each do |product|
            products_array.push(
                amount: (product.price * 100).to_i,
                name:product.name,
                quantity:1,
                currency:"cad"    
            )
        end

        total_amount = 0

        products_array.each do |producteach|
            total_amount += producteach[:amount]
        end

        customer.province.taxes.each do |tax|
            taxes_array.push(
                name: tax.name,
                description: tax.name == 'GST' ? 'Goods and Services Tax' : 'Provincial Sales Tax',
                amount: total_amount * tax.tax.to_i / 100,
                currency: 'cad',
                quantity: 1
            )    
        end

        prodtax_arrays = (products_array << taxes_array).flatten!

        @session = Stripe::Checkout::Session.create(
            customer_email: customer.email,
            payment_method_types: ['card'],
            line_items: [prodtax_arrays],
            success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
            cancel_url: checkout_cancel_url
        )

        respond_to do |format|
            format.js
        end

        def success
            @session = Stripe::Checkout::Session.retrieve(params[:session_id])
            @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

            products_array = []

            # if @payment_intent['charges']['data']['paid'].to_s != 'true'
            #     redirect_to checkout_cancel_path
            #     nil
            # end

            customer = Customer.find(current_customer.id)
            products = Product.find(session[:cart])

            total_amount = 0
            total_taxes = 0

            products.each do |product|
                products_array.push(
                    amount: (product.price * 100).to_i,
                    name:product.name,
                    quantity:1,
                    currency:"cad"    
                )
            end

            products_array.each do |producteach|
                total_amount += producteach[:amount]
            end

            customer.province.taxes.each do |tax|
                total_taxes += total_amount * tax.tax.to_i / 100
            end

            order = customer.orders.create(
                total: @payment_intent.amount/100,
                tax: total_taxes
            )

            products.each do |product|
                product.details.create(
                    price: product.price,
                    quantity: 1,
                    order_id: order.id,
                )
            end
        end
    end
end
