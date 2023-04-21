class AddAuthorIdToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :author_id, :integer
  end
end
