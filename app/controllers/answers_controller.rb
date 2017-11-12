class AnswersController < ApplicationController

	def new
		@answer = Answer.new
	end

	def create
		@question = Question.find(params[:question_id])
		@answer = @question.answers.create(params[:answer].permit(:content))
		@answer.user = current_user
		if @answer.save
			redirect_to question_path(@question)
		else
			redirect_to question_path(@question), notice: "Your comment wasn't posted."
		end
	end

	def upvote
	    @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
	    @answer.upvote_from current_user
	    redirect_back fallback_location: root_path
  	end

    def downvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.downvote_from current_user
        redirect_back fallback_location: root_path
    end

    def undoupvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.unliked_by current_user
        redirect_back fallback_location: root_path
    end

    def undodownvote
        @question = Question.find(params[:question_id])
        @answer = @question.answers.find(params[:answer_id])
        @answer.undisliked_by current_user
        redirect_back fallback_location: root_path
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
      params.require(:answer).permit(:content)
    end

end
