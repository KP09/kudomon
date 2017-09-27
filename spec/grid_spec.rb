describe "Grid" do
  describe "#initialize" do
    it "spawns the expected number of Trainers" do
      expect{Grid.new("Player name")}.to change \
      { Trainer.all.count }.by(COMPUTER_NAMES.length + 1)
    end

    it "spawns a random number of Kudomon" do
      expect{Grid.new("Player name")}.to change \
      { (ObjectSpace.each_object(Kudomon).to_a.count) }
    end

    it "spawns a random number of free Kudomon" do
      expect{Grid.new("Player name")}.to change { Kudomon.free.count }
    end
  end

  describe "#move_trainer" do
    let(:grid) { Grid.new("Player name")}
    let(:trainer) { grid.trainer }
    let(:rand_x_shift) { rand(10) }
    let(:rand_y_shift) { rand(10) }

    it "moves a trainer by the specified amount" do
      expect{ grid.move_trainer(rand_y_shift, 0)}.to \
      change { trainer.coordinates[:y] }.by(rand_y_shift)

      expect{ grid.move_trainer(0, rand_x_shift)}.to \
      change { trainer.coordinates[:x] }.by(rand_x_shift)
    end
  end
end
