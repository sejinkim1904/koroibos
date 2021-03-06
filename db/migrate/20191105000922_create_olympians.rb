class CreateOlympians < ActiveRecord::Migration[5.2]
  def change
    create_table :olympians do |t|
      t.string :name
      t.string :sex
      t.integer :age
      t.integer :weight
      t.integer :height
      t.references :team, foreign_key: true
      t.references :sport, foreign_key: true
    end
  end
end
