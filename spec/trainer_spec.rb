require 'pry'

describe Trainer do
  # Initialize
  describe "#initialize" do
    let(:x_coordinate) { rand }
    let(:y_coordinate) { rand }
    let(:valid_trainer) { Trainer.new("Kees", {x: x_coordinate, y: y_coordinate}) }
    let(:invalid_trainer) { Trainer.new({x: x_coordinate, y: y_coordinate}) }

    it "exists as a class" do
      expect(valid_trainer.class).to eq Trainer
    end

    it "stores a position" do
      expect(valid_trainer.coordinates[:x]).to eq x_coordinate
      expect(valid_trainer.coordinates[:y]).to eq y_coordinate
    end

    it "gets an empty collection of kudomon" do
      expect(valid_trainer.collection).to eq []
    end

    it "raises an error when not given two arguments" do
      expect{invalid_trainer}.to raise_error(ArgumentError)
    end
  end

  # Catching kudomon
  describe "#catch" do
    let(:mid_grid) { GRID_SIZE/2 }
    let(:nearby) { mid_grid + 1 }
    let(:too_far) { mid_grid + NEARBY }

    let(:trainer) { Trainer.new('Kees', {x: mid_grid, y: mid_grid}) }
    let(:in_range_kudomon) { Kudomon.new('Sourbulb', {x: nearby, y: nearby}) }
    let(:out_of_range_kudomon) { Kudomon.new('Kudoise', {x: too_far, y: too_far}) }

    it "allows a trainer to catch a nearby Kudomon" do
      in_range_kudomon = double('Sourbulb', coordinates = {x: nearby, y: nearby})

    end
  end
end
