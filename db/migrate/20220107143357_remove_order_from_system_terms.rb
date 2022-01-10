class RemoveOrderFromSystemTerms < ActiveRecord::Migration[6.1]
  def change
    remove_column :system_terms, :order
  end
end
