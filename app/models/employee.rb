class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  belongs_to :user
  has_many :batteries

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


         

end
