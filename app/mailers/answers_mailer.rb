class AnswersMailer < ApplicationMailer

	default from: 'qashew.forum@gmail.com'

	def answer_notification(answer, question, user)
		@answer = answer
	    @question = question 
	    @asker = User.find_by_id(question.user_id)

	    # no notification needed if the asker is the same as the answerer
        return if @asker.id == user.id 
        mail(to: @asker.email, subject: 'A question was just answered!')
	    @starrers = User.where("?=ANY(starred)", @question.id)
	    @starrers.each do |starrers|
	    	# no notification if the starrer is the same as the answerer or the asker
	    	if starrers.id != user.id and starrers.id != @asker.id
		    	mail(to: starrers.email, subject: 'A question was just answered!')
		    end
	    end
    end
end
