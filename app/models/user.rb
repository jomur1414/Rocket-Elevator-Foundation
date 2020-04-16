class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :zxcvbnable
  
  has_one :employee


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable


  def is_employee(email)
 
    @all_Employees = Employee.all

    @all_Employees.each do |employee| 

      if email == employee.email
 
      return true
      
      end
    end
    return false
    
  end

    
end

