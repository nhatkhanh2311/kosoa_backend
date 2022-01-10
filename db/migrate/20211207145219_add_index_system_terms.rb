class AddIndexSystemTerms < ActiveRecord::Migration[6.1]
  def change
    add_index :system_terms, %i[term level]
  end
end
