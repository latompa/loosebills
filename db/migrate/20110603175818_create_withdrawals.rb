class CreateWithdrawals < ActiveRecord::Migration
  def self.up
    create_table :withdrawals do |t|
      t.references :account
      t.integer :amount, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :withdrawals
  end
end
