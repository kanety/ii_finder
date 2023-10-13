class CreateTestTables < ActiveRecord::Migration::Current
  def change
    create_table :items do |t|
      t.string  :name
      t.integer :age
      t.timestamps
    end
  end
end
