require_relative '../spec_helper'

describe Gurps::Table do
  it "should create a table class" do
    Gurps::Table['damage'].should_not be_empty
  end
end