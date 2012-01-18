require_relative '../spec_helper'

describe Gurps::Character do
  context 'new character' do
    let(:char) do
      char = Gurps::Character.new
    end

    it "should have 100 points to spend by default" do
      char.points_to_spend.should == 100
    end

    it "should start with strength of 10" do
      char.st.should == 10
    end

    it "should start with dexterity of 10" do
      char.dx.should == 10
    end

    it "should start with intelligence of 10" do
      char.iq.should == 10
    end

    it "should start with health of 10" do
      char.ht.should == 10
    end

    it "should have lifting of 100" do
      char.lifting.should == 100
    end

    it "should have thrust damage of '1d-2'" do
      char.thr.should == '1d-2'
    end

    it "should have thrust damage of '1d-2'" do
      char.sw.should == '1d'
    end

    it "should have damage of '1d-2/1d'" do
      char.dmg.should == '1d-2/1d'
    end

    it "should have basic lift of 20" do
      char.basic_lift.should == 20
    end

    it "should have 10 hit points" do
      char.hit_points.should == 10
    end

    it "should have will of 10" do
      char.will.should == 10
    end

    it "should have perception of 10" do
      char.per.should == 10
    end

    it "should have fatigue of 10" do
      char.fat.should == 10
    end

    it "should have basic_speed of 5" do
      char.basic_speed.should == 5
    end

    it "should have dodge of 8" do
      char.dodge.should == 8
    end

    it "should have basic_move of 5" do
      char.basic_move.should == 5
    end

    it "should have encumbrance of 0," do
      char.encumbrance.should == 0
    end

    it "should have weight of 150" do
      char.weight.should == 150
    end
  end

  context "a character with 11 st and 11 dx" do
    let(:char) do
      char = Gurps::Character.new
      char.strength = char.dexterity = 11
      char
    end

    it "should have basic speed of 5.5" do
      char.basic_speed.should == 5.5
    end

    it "should have basic move of 5" do
      char.basic_move.should == 5
    end

    it "should have weight of 165" do
      char.weight.should == 165
    end
  end

  context "encumbrance" do
    let(:char) { Gurps::Character.new }

    context "when carring 10 lbs" do
      before(:each) do
        char.encumbrance = 10
      end

      it "should have encumbrance level of 0" do
        char.encumbrance_level.should == 0
      end

      it "should have move of 5" do
        char.move.should == 5
      end

      it "should have dodge 8" do
        char.dodge.should == 8
      end
    end

    context "when carring 20 lbs" do
      before(:each) do
        char.encumbrance = 20
      end

      it "should have encumbrance level of 0" do
        char.encumbrance_level.should == 0
      end

      it "should have move of 5" do
        char.move.should == 5
      end

      it "should have dodge 8" do
        char.dodge.should == 8
      end
    end

    context "when carring 21 lbs" do
      before(:each) do
        char.encumbrance = 21
      end

      it "should have encumbrance level of 1" do
        char.encumbrance_level.should == 1
      end

      it "should have move of 5" do
        char.move.should == 4
      end

      it "should have dodge 8" do
        char.dodge.should == 7
      end
    end

    context "when carring 40 lbs" do
      before(:each) do
        char.encumbrance = 40
      end

      it "should have encumbrance level of 1" do
        char.encumbrance_level.should == 1
      end

      it "should have move of 5" do
        char.move.should == 4
      end

      it "should have dodge 8" do
        char.dodge.should == 7
      end
    end

    context "when carring 41 lbs" do
      before(:each) do
        char.encumbrance = 41
      end

      it "should have encumbrance level of 2" do
        char.encumbrance_level.should == 2
      end

      it "should have move of 5" do
        char.move.should == 3
      end

      it "should have dodge 8" do
        char.dodge.should == 6
      end
    end

    context "when carring 60 lbs" do
      before(:each) do
        char.encumbrance = 60
      end

      it "should have encumbrance level of 2" do
        char.encumbrance_level.should == 2
      end

      it "should have move of 5" do
        char.move.should == 3
      end

      it "should have dodge 8" do
        char.dodge.should == 6
      end
    end

    context "when carring 61 lbs" do
      before(:each) do
        char.encumbrance = 61
      end

      it "should have encumbrance level of 3" do
        char.encumbrance_level.should == 3
      end

      it "should have move of 5" do
        char.move.should == 2
      end

      it "should have dodge 8" do
        char.dodge.should == 5
      end
    end

    context "when carring 120 lbs" do
      before(:each) do
        char.encumbrance = 120
      end

      it "should have encumbrance level of 3" do
        char.encumbrance_level.should == 3
      end

      it "should have move of 5" do
        char.move.should == 2
      end

      it "should have dodge 8" do
        char.dodge.should == 5
      end
    end

    context "when carring 121 lbs" do
      before(:each) do
        char.encumbrance = 121
      end

      it "should have encumbrance level of 4" do
        char.encumbrance_level.should == 4
      end

      it "should have move of 5" do
        char.move.should == 1
      end

      it "should have dodge 8" do
        char.dodge.should == 4
      end
    end

    context "when carring 200 lbs" do
      before(:each) do
        char.encumbrance = 200
      end

      it "should have encumbrance level of 4" do
        char.encumbrance_level.should == 4
      end

      it "should have move of 5" do
        char.move.should == 1
      end

      it "should have dodge 8" do
        char.dodge.should == 4
      end
    end
  end
end