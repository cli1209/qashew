class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
	  flash[:notice] = 'A confirmation email has been sent!'
  end
end