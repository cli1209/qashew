class AnswersController < ApplicationController

  	helper_method :create_notification

	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.create(answer_params)
		@answer.user = current_user
		@answer.qualifications = params[:answer][:qualifications]
		@answer.anon = params[:anon]
		if @answer.save
			create_notification @question, @answer
			redirect_to question_path(@question)
		else
			redirect_to question_path(@question), notice: "Your comment wasn't posted."
		end
	end

	def upvote
	    @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
	    @answer.upvote_from current_user
        respond_to do |format|
	      format.js
	    end
  	end

    def downvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.downvote_from current_user
        respond_to do |format|
	      format.js
	    end
    end

    def undoupvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.unliked_by current_user
        respond_to do |format|
	      format.js
	    end
    end

    def undodownvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.undisliked_by current_user
        respond_to do |format|
	      format.js
	    end
    end

	def destroy
		@question = Question.find(params[:question_id])
		@answer = @question.answers.find(params[:id])
	    @answer.destroy
	    respond_to do |format|
	      format.html { redirect_to question_path(@question), notice: 'Answer was successfully deleted.' }
	      format.json { head :no_content }
	    end
  	end

	def answer_params
      params.require(:answer).permit(:content, :qualifications, :anon)
    end

    private
    def create_notification(question, answer)
		return if question.user.id == current_user.id 
	    Notification.create(user_id: question.user_id,
	                        notified_by_id: current_user.id,
	                        question_id: question.id,
				            identifier: answer.id,
	                        notice_type: 'asked')
	    @selected = User.where("?=ANY(starred)", question.id)
	    @selected.each do |selected|
	    	Notification.create(user_id: selected.id,
	                        notified_by_id: current_user.id,
	                        question_id: question.id,
				            identifier: answer.id,
	                        notice_type: 'starred')
	    end
	end
end
