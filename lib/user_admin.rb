module Loosebills
  module UserAdmin

    def UserAdmin.reset_users
      User.delete_all
      Account.delete_all
      Withdrawal.delete_all
      Loosebills::UserAdmin.users.each do |user|
        @user = User.new :name => user[:name]
        @user.pin = user[:pin] 
        @user.create_account :balance => user[:balance]
        @user.save!
      end
    end

    def UserAdmin.users
      [
        {:name => "Alice", :pin => "7643", :balance => 2000},
        {:name => "Bob",   :pin => "5954", :balance => 22400},
        {:name => "Clyde", :pin => "1562", :balance => 100},
      ]
    end
  end
end