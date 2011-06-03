class AddFailedLoginAttemptsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :failed_logins, :integer, :default => 0
  end

  def self.down
    remove_column :users, :failed_logins
  end
end
