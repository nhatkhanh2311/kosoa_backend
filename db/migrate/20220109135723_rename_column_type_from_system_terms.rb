class RenameColumnTypeFromSystemTerms < ActiveRecord::Migration[6.1]
  def change
    rename_column :system_terms, :type, :category
  end
end
