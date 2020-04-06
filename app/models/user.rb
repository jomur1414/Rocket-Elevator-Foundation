class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  
  has_one :employee
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_employee(email)
 
    @all_Employees = Employee.all

    @all_Employees.each do |employee| 

      if email == employee.email
 
      return true
      
      end
    end
    return false
    
  end


  #  @employee.each do |employee| 

  #   if current_user.id == employee.if 

  #   return true

    
end

