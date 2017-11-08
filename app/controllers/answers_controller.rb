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

	def answer_params
      params.require(:answer).permit(:content)
    end

end
