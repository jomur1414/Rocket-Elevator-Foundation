class AddInformationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstName, :string
    add_column :users, :lastName, :string
    add_column :users, :job_title, :string
    add_column :users, :phoneNumber, :string

end
end