describe Kudomon do
  let(:x_coordinate) { rand }
  let(:y_coordinate) { rand }
  let(:random_species) { KUDOMON.keys.sample }
  let(:valid_kudomon) { Kudomon.new(random_species, {x: x_coordinate, y: y_coordinate}) }
  let(:invalid_species) { Kudomon.new({x: x_coordinate, y: y_coordinate}) }

  describe "#initialize" do
    it "stores a position" do
      expect(valid_kudomon.coordinates[:x]).to eq x_coordinate
      expect(valid_kudomon.coordinates[:y]).to eq y_coordinate
    end

    it "gets assigned a type based on its species" do
      expect(valid_kudomon.type).to eq KUDOMON[random_species][:type]
    end

    it "raises an error when not given two arguments" do
      expect{invalid_species}.to raise_error(ArgumentError)
    end
  end

  describe ".free" do
    let!(:free_kudomon) { Kudomon.new(random_species, {x: x_coordinate, y: y_coordinate}) }
    let!(:caught_kudomon) { Kudomon.new(random_species, nil) }

    it "only returns free kudomon" do
      expect(Kudomon.free).to include(free_kudomon)
      expect(Kudomon.free).to_not include(caught_kudomon)
    end
  end
end
