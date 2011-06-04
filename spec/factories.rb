Factory.define :user do |user|
  user.name 'name'
  user.pin  '1234'
  user.association :account
end

Factory.define :account do |account|
  account.balance 100
end

Factory.define :bill do |bill|
  bill.denomination 20
  bill.units 10
end

Factory.define :withdrawal do |withdrawal|
  withdrawal.amount 20
  withdrawal.association :account
end