class CreateTermComments < ActiveRecord::Migration[6.1]
  def change
    create_table :term_comments do |t|
      t.string :content, null: false
      t.timestamps

      t.references :user, foreign_key: true
      t.references :system_term, foreign_key: true
    end
  end
end
