require_relative '../../spec/spec_helper'

describe Gurps::Character do
  context 'new character' do
    it "should have 100 points to spend by default" do
      Gurps::Character.new.points_to_spend.should == 100
    end

    it "should start with strength of 10" do
      Gurps::Character.new.strength.should == 10
    end

    it "should start with dexterity of 10" do
      Gurps::Character.new.dexterity.should == 10
    end

    it "should start with intelligence of 10" do
      Gurps::Character.new.intelligence.should == 10
    end

    it "should start with health of 10" do
      Gurps::Character.new.health.should == 10
    end

    it "should have basic lift of 100" do
      Gurps::Character.new.basic_lift.should == 100
    end
  end
end