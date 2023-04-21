class RenameOldColumnNameToNewColumnName < ActiveRecord::Migration[6.1]
  def change
        rename_column :categories, :news_cat, :name

  end
end
