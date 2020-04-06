class TableInterventions < ActiveRecord::Migration[5.2]
  def change

    
    create_table :interventions do |t|

      t.bigint :author_id, null: false
      t.references :customer, foreign_key: true, null: false
      t.references :building, foreign_key: true, null: false
      t.references :battery, foreign_key: true
      t.references :column, foreign_key: true
      t.references :elevator, foreign_key: true
      t.references :employee, foreign_key: true
      t.datetime :intervention_start_time
      t.datetime :intervention_end_time
      t.string :result, default: "Incomplete"
      t.string :report
      t.string :status, default: "Pending"
  end
end
end