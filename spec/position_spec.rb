describe Position do
  describe "#initialize" do
    let(:x_coordinate) { rand }
    let(:y_coordinate) { rand }
    let(:x_coordinate_neg) { -rand }

    let(:valid_position) { Position.new({x: x_coordinate, y: y_coordinate}) }
    let(:nil_position) { Position.new(nil) }
    let(:no_arguments) { Position.new }
    let(:non_hash_coordinates) { Position.new([x: x_coordinate, y: y_coordinate]) }
    let(:missing_coordinate) { Position.new({x: x_coordinate}) }
    let(:negative_position) { Position.new({x: x_coordinate_neg, y: y_coordinate}) }

    it "exists as a class" do
      expect(valid_position.class).to eq Position
    end

    it "is able to store a position" do
      expect(valid_position.coordinates[:x]).to eq x_coordinate
      expect(valid_position.coordinates[:y]).to eq y_coordinate
    end

    it "can be created with nil coordinates" do
      expect(valid_position.class).to eq Position
    end

    it "raises en error when not given any arguments" do
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
end
