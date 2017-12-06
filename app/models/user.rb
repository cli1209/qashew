class User < ApplicationRecord
    acts_as_voter
    has_many :questions
    has_many :answers
    after_create :set_username


    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable

    validates_presence_of     :email # optional
    validates_format_of :email, with: /\@princeton\.edu/, message: 'must be your university email address.'
    validates_uniqueness_of   :email     
    validates_presence_of     :password # recommended
    validates_confirmation_of :password # recommended
    validates_length_of       :password, minimum: 6 # recommended

    def owns_question?(question)
        id == question.user_id
    end
    def owns_answer?(answer)
        id == answer.user_id
    end

    private
    def set_username
       self.username = self.email[/^[^@]+/]
    end
end