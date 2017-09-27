describe Kudomon do
  let(:x_coordinate) { rand }
  let(:y_coordinate) { rand }
  let(:random_species) { KUDOMON.keys.sample }

  # describe "#initialize" do
  #   let(:valid_kudomon) { Kudomon.new(random_species, {x: x_coordinate, y: y_coordinate}) }
  #   let(:invalid_species) { Kudomon.new({x: x_coordinate, y: y_coordinate}) }
  #
  #   it "exists as a class" do
  #     expect(valid_kudomon.class).to eq Kudomon
  #   end
  #
  #   it "stores a position" do
  #     expect(valid_kudomon.coordinates[:x]).to eq x_coordinate
  #     expect(valid_kudomon.coordinates[:y]).to eq y_coordinate
  #   end
  #
  #   it "gets assigned a type based on its species" do
  #     expect(valid_kudomon.type).to eq KUDOMON[random_species][:type]
  #   end
  #
  #   it "raises an error when not given two arguments" do
  #     expect{invalid_species}.to raise_error(ArgumentError)
  #   end
  # end

  describe ".free" do
    let(:free_kudomon) { Kudomon.new(random_species, {x: x_coordinate, y: y_coordinate}) }
    let(:caught_kudomon) { Kudomon.new(random_species, nil) }

    it "only returns free kudomon" do
      binding.pry
      expect(Kudomon.free.last).to eq(free_kudomon)
    end

  end
end
