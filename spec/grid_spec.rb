describe "Grid" do
  describe "#initialize" do
    it "spawns the expected number of Trainers" do
      expect{Grid.new("Player name")}.to change \
      { Trainer.all.count }.by(COMPUTER_NAMES.length + 1)
    end

    it "spawns a random number of uncaught Kudomon" do
      expect{Grid.new("Player name")}.to change \
      { ObjectSpace.each_object(Kudomon).to_a.count - Kudomon.free.count }
    end

    it "spawns a random number of free Kudomon" do
      expect{Grid.new("Player name")}.to change { Kudomon.free.count }
    end
  end

  describe "#move_trainer" do
    let(:grid) { Grid.new("Player name")}
    let(:trainer) { grid.trainer }
    let(:x_shift) { GRID_SIZE/4 }
    let(:y_shift) { GRID_SIZE/4 }
    let(:mid_grid) { {x: GRID_SIZE/2, y: GRID_SIZE/2} }
    let(:top_left) { {x: 0, y: GRID_SIZE} }
    let(:bottom_right) { {x: GRID_SIZE, y: 0} }

    it "moves a trainer by a specified amount within the grid" do
      # Set the trainer in the middle of the grid
      trainer.coordinates = mid_grid

      expect{ grid.move_trainer(y_shift, 0)}.to \
      change { trainer.coordinates[:y] }.by(y_shift)

      expect{ grid.move_trainer(0, x_shift)}.to \
      change { trainer.coordinates[:x] }.by(x_shift)
    end

    it "does not allow a trainer to move outside the grid" do
      # Set the trainer at the top left of the grid
      trainer.coordinates = top_left

      expect{ grid.move_trainer(0, 1)}.to \
      change { trainer.coordinates[:y] }.by(0)

      # Set the trainer at the bottom right of the grid
      trainer.coordinates = bottom_right

      expect{ grid.move_trainer(1, 0)}.to \
      change { trainer.coordinates[:x] }.by(0)
    end
  end
end
