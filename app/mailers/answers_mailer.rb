class AnswersMailer < ApplicationMailer

	default from: 'qashew.forum@gmail.com'

	def answer_notification(answer, question, user)
		@answer = answer
	    @question = question 
	    @user = user

        return if @question.user.id == @user.id 
        mail(to: @user.email, subject: 'Your question was just answered!')
	    @starrers = User.where("?=ANY(starred)", @question.id)
	    @starrers.each do |starrers|
	    	if starrers.id != @user.id and starrers.id != @question.user.id
		    	mail(to: starrers.email, subject: 'Your question was just answered!')
		    end
	    end
    end
end
