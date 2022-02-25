class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      t.text :content, null: false
      t.timestamps

      t.references :course, foreign_key: true
    end
  end
end
