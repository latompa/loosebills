class AddBillsToWithdrawals < ActiveRecord::Migration
  def self.up
    add_column :withdrawals, :bills, :text
  end

  def self.down
    remove_column :withdrawals, :bills
  end
end
