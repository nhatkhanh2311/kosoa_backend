class CreateSystemTerms < ActiveRecord::Migration[6.1]
  def change
    create_table :system_terms do |t|
      t.string :term, null: false
      t.string :pronunciation
      t.string :definition
      t.string :description
      t.string :example
      t.string :note
      t.integer :level, null: false
      t.string :type, null: false
      t.integer :order, null: false
      t.timestamps
    end
  end
end
