class RemoveFkFromReactionsToMessage < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :reactions, :messages
  end
end
