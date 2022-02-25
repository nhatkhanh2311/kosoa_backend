class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|
      t.boolean :accepted, null: false
      t.timestamps

      t.references :user, foreign_key: true
      t.references :course, foreign_key: true
    end
  end
end
