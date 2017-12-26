class NotificationsController < ApplicationController

	def index
	  @notifications = current_user.notifications.page(params[:page]).per(20)
    end

	def link_through
		@notification = Notification.find(params[:id])
		@all = Notification.where('question_id'=> @notification.question_id, 'user_id' => current_user)
		@all.each do |n|
		    n.update read:true
	    end
		redirect_to question_path @notification.question
	end
end
