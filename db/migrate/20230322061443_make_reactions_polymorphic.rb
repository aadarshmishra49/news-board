class MakeReactionsPolymorphic < ActiveRecord::Migration[6.1]
  def change
    rename_column :reactions, :message_id, :likeable_id
    add_column :reactions, :likeable_type, :string

    add_index :reactions, [:user_id, :likeable_id, :likeable_type], unique: true
    add_index :reactions, [:likeable_id, :likeable_type]
  end
end
