class TableEmployees < ActiveRecord::Migration[5.2]
  def change

    create_table :employees do |t|
    t.references :user, foreign_key: true
    t.string :email
    t.string :firstName
    t.string :lastName
    t.string :job_title
    t.string "encrypted_password", default: "", null: false
    # t.string :password

    
    end
  end
end
