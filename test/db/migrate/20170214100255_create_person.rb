class CreatePerson < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, null: false, default: ""
      t.integer :age,       null: false, default: 0

      t.timestamps :null => false
    end
  end
end
