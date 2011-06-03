require 'spec_helper'

describe Withdrawal do
  it { should belong_to :account }
  it { should validate_numericality_of :amount }
end
