# controls the back end for all pages inside /pages
class PagesController < ApplicationController
  
  # for sorting in tag method
  helper_method :sort_param

  def index
  end

  def home
  end

  def profile
    @notifications = current_user.notifications.page(params[:page]).per(15)
  	# grab username from user in url as :id
  	if (User.find_by_username(params[:id]))
	  	@username = params[:id]
      current_user.notifications.update_all read: true
  	else 
  		#redirect to 404, but root for now
  		redirect_to root_path, :notice=>"User not found!"
  	end
  end

  def tag
    # grab tag from url as :tag_id
    @tag = params[:tag_id]
    @questions = Question.tag_search(params[:tag_id])
    @questions = @questions.term(params[:term]) if params[:term].present?
    @search_term = params[:term] if params[:term].present?
    @questions = @questions.sort_by { |m| m[sort_param] }.reverse if sort_param.present?
  end

  def explore
  end

  private
    # sanitize the ordering param
    def sort_param
      ["created_at", "cached_weighted_score"].include?(params[:sort]) ? params[:sort] : "cached_weighted_score"
    end
end
