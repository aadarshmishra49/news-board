class AddtimestampinMessage < ActiveRecord::Migration[6.1]
  def change
    add_timestamps(:messages)

  end
end
