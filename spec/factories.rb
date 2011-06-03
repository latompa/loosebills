Factory.define :user do |user|
  user.name 'name'
  user.pin  '1234'
  user.association :account
end

Factory.define :account do |account|
  account.balance 100
end