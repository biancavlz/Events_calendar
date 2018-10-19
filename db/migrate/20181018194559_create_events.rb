class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.text :information
      t.string :place
      t.string :source

      t.timestamps
    end
  end
end
