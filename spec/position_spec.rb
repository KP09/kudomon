describe Position do
  let(:x_coordinate) { rand }
  let(:y_coordinate) { rand }
  let(:valid_position) { Position.new({x: x_coordinate, y: y_coordinate}) }

  describe "#initialize" do
    let(:x_coordinate_neg) { -rand }
    let(:nil_position) { Position.new(nil) }
    let(:no_arguments) { Position.new }
    let(:non_hash_coordinates) { Position.new([x: x_coordinate, y: y_coordinate]) }
    let(:missing_coordinate) { Position.new({x: x_coordinate}) }
    let(:negative_position) { Position.new({x: x_coordinate_neg, y: y_coordinate}) }

    it "stores coordinates" do
      expect(valid_position.coordinates[:x]).to eq x_coordinate
      expect(valid_position.coordinates[:y]).to eq y_coordinate
    end

    it "can be created with nil coordinates" do
      expect(valid_position.class).to eq Position
    end

    it "raises an error when not given any arguments" do
      expect{no_arguments}.to raise_error(ArgumentError)
    end

    it "raises an error when not given a hash as its argument" do
      expect{non_hash_coordinates}.to raise_error("Coordinates must be in hash format")
    end

    it "raises an error when a coordinate is missing" do
      expect{missing_coordinate}.to raise_error("Coordinate(s) missing")
    end

    it "raises an error when a coordinate is negative" do
      expect{negative_position}.to raise_error("Coordinates cannot be negative")
    end
  end

  describe "#nearby" do
    let(:nearby) { NEARBY/2 }
    let(:too_far) { NEARBY + 1 }

    let(:nearby_coordinates) { {x: x_coordinate + nearby, y: y_coordinate + nearby} }
    let(:too_far_coordinates) { {x: x_coordinate + too_far, y: y_coordinate + too_far} }

    it "returns true if a position is nearby given coordinates" do
      expect(valid_position.nearby?(nearby_coordinates)).to eq true
    end

    it "returns false if a position is not nearby given coordinates" do
      expect(valid_position.nearby?(too_far_coordinates)).to eq false
    end
  end
end
