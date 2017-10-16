# controls the back end for all pages inside /pages
class PagesController < ApplicationController
  def index
  end

  def home
  end

  def profile
  	# grab username from user in url as :id
  	if (User.find_by_username(params[:id]))
	  	@username = params[:id]
	else 
		#redirect to 404, but root for now
		redirect_to root_path, :notice=>"User not found!"
	end
  end

  def explore
  end
end
