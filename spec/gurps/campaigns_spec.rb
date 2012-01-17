require_relative '../spec_helper'

describe Gurps::Campaign do
  it "should have 100 starting points by default" do
    Gurps::Campaign.new.starting_points.should == 100
  end

  it "should have 50 disadvantage limit by default" do
    Gurps::Campaign.new.disadvantage_limit.should == 50
  end
end