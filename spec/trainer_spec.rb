require 'pry'

describe Trainer do
  let(:mid_grid) { GRID_SIZE/2 }
  let(:trainer) { Trainer.new("Test Case", {x: mid_grid, y: mid_grid}) }

  describe "#initialize" do
    let(:invalid_trainer) { Trainer.new({x: mid_grid, y: mid_grid}) }

    it "stores a position" do
      expect(trainer.coordinates[:x]).to eq mid_grid
      expect(trainer.coordinates[:y]).to eq mid_grid
    end

    it "gets an empty collection of kudomon" do
      expect(trainer.collection).to eq []
    end

    it "raises an error when not given two arguments" do
      expect{invalid_trainer}.to raise_error(ArgumentError)
    end
  end

  describe "#move" do
    let(:movement) { {y: mid_grid, x: mid_grid} }
    it "moves a trainer by the correct amounts" do
      expect{trainer.move(movement)}.to change {trainer.coordinates[:y]}.by(mid_grid)
      expect{trainer.move(movement)}.to change {trainer.coordinates[:x]}.by(mid_grid)
    end
  end

  # Catching kudomon
  describe "#catch" do
    let(:nearby) { mid_grid + 1 }
    let(:too_far) { mid_grid + NEARBY }
    let!(:in_range_species) { KUDOMON.keys.sample }
    let!(:all_other_species) { KUDOMON.reject { |k,v| k == in_range_species } }
    let!(:out_of_range_species) { all_other_species.keys.sample }
    let!(:in_range_kudomon) { Kudomon.new(in_range_species, {x: nearby, y: nearby}) }
    let!(:out_of_range_kudomon) { Kudomon.new(out_of_range_species, {x: too_far, y: too_far}) }

    it "allows a trainer to catch a nearby Kudomon" do
      trainer.catch(in_range_species)
      expect(trainer.collection.map(&:species)).to include(in_range_species)
    end

    it "does not allow a trainer to catch a Kudomon they have already caught" do
      trainer.catch(in_range_species)
      expect(trainer.collection.map(&:species)).to contain_exactly(in_range_species)
    end

    it "does not allow a trainer to catch an out of range Kudomon" do
      # Select all Kudomon except for the one out of range
      # and nullify the coordinates for all of them
      other_kudomon = Kudomon.free.reject { |k| k == out_of_range_kudomon }
      other_kudomon.each { |k| k.coordinates = nil }

      trainer.catch(out_of_range_species)
      expect(trainer.collection.map(&:species)).to_not include(out_of_range_species)
    end
  end
end
