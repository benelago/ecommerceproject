class CheckoutController < ApplicationController

    def create
        products = Product.find(params[:cart])

        if products.nil?
            redirect_to root_path
            nil
        end

        products_array = []

        products.each do |product|
            products_array.push(
                amount: product.price,
                name:product.name,
                quantity:1,
                currency:"cad"    
            )
        end

        @session = Stripe::Checkout::Session.create(
            payment_method_type: ['card'],
            line_items: [products_array],
            success_url: checkout_success_url,
            cancel_url: checkout_cancel_url
        )

        respond_to do |format|
            format.js
        end
    end
end
