# frozen_string_literal: true

class CreatePerson < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :name
      t.integer :age

      t.timestamps null: false
    end
  end
end
