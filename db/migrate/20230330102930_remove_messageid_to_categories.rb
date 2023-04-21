class RemoveMessageidToCategories < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :message_id, :integer
    add_column :messages, :category_id, :integer
  end
end
