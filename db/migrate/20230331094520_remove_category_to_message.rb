class RemoveCategoryToMessage < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :category, :string

  end
end
