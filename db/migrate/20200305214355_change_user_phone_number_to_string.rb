class ChangeUserPhoneNumberToString < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :companyName, :string
    change_column :quotes, :phoneNumber, :string
  end
end
