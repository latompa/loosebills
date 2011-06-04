require 'user_admin'

Loosebills::UserAdmin.reset_users
Bill.delete_all
Bill.create :denomination => 20, :units => 20
Bill.create :denomination => 100, :units => 20