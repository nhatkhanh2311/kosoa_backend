class CreateCommentVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_votes do |t|
      t.boolean :kind, null: false
      t.timestamps

      t.references :user, foreign_key: true
      t.references :term_comment, foreign_key: true
    end
  end
end
