Given /^the ATM machine has no bills$/ do
  Factory(:bill, :denomination => 20, :units => 0)
end

Given /^the ATM machine has bills$/ do
  Factory(:bill, :denomination => 20, :units => 20)
end

