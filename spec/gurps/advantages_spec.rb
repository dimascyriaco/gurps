require_relative '../spec_helper'

describe Gurps::Advantage do
  it "should list available advantages" do
    Gurps::Advantage.available.should include(:skinny)
  end

  context "buying an advantage" do
    it "should discount the cost from the character available poinnts" do
      char = Gurps::Character.new
      lambda do
        char.buy(:skinny)
      end.should change(char, :points_to_spend).by(-5)
    end
  end
end