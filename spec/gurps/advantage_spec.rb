require_relative '../spec_helper'

describe Gurps::Advantage do
  let(:advantage) do
    {fat: {
        cost: '-5',
        modifiers: [
            {target: 'weight', type: 'multiplier', value: '2/3'}
        ]
    }}
  end

  before(:each) do
    Gurps::Advantage.register(:fat, advantage[:fat])
  end

  it 'should list available advantages' do
    Gurps::Advantage.available.should include(:fat)
  end

  it 'should be accessible via method and via hash' do
    Gurps::Advantage.fat
    Gurps::Advantage[:fat].should_not be_nil
  end

  context 'buying an advantage' do
    it 'should discount the cost from the character available points' do
      char = Gurps::Character.new
      lambda do
        char.add_trait(Gurps::Advantage[:fat])
      end.should change(char, :points).by(-5)
    end

    it 'should discount the cost from the character available points' do
      char = Gurps::Character.new
      expect(char.weight).to eq(150)
      char.add_trait(Gurps::Advantage[:fat])
      expect(char.weight).to eq(100)
    end
  end

  context 'Registering a new advantage' do
    it 'should register a new advantage' do
      Gurps::Advantage.fat
    end

    it 'should set the cost' do
      Gurps::Advantage.fat.cost.should == -5
    end

    it 'should set the modifiers' do
      Gurps::Advantage.fat.modifiers.should_not be_nil
    end

    it 'should allow access to the modifications properties' do
      Gurps::Advantage.fat.modifiers.first.target.should == 'weight'
      Gurps::Advantage.fat.modifiers.first.type.should == 'multiplier'
      Gurps::Advantage.fat.modifiers.first.value.should == '2/3'
    end
  end
end