class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

    validates_presence_of     :email # optional
    validates_format_of :email, with: /\@princeton\.edu/, message: 'must be your university email address.'
    validates_uniqueness_of   :email     
    validates_presence_of     :username # required
    validates_uniqueness_of   :username # required    
    validates_presence_of     :password # recommended
    validates_confirmation_of :password # recommended
    validates_length_of       :password, minimum: 6 # recommended
end