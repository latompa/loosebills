class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :pin_hash
      t.string :pin_salt

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
