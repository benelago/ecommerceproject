ActiveAdmin.register Quality do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :quality_image
  #
  # or
  #
  # permit_params do
  #   permitted = [:qualityGrade]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

    # Formtastic
    form do |f|
      f.semantic_errors
      f.inputs
      f.inputs do
        f.input :product_image, as: :file
      end
      f.actions
    end
  
end
