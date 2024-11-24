class CreateParties < ActiveRecord::Migration[7.1]
  def change
    create_table :parties do |t|
      t.string :name
      t.integer :size
      t.string :status, default: 'In Queue'
      # t.integer :queue_position # decided to determine queue position at query runtime

      t.timestamps
    end
  end
end
