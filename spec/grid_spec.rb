describe Grid do
  let(:new_grid) { Grid.new('Test case') }

  describe '#initialize' do
    it 'spawns the expected number of Trainers' do
      expect { new_grid }.to change \
      { Trainer.all.count }.by(COMPUTER_NAMES.length + 1)
    end

    it 'spawns a random number of uncaught Kudomon' do
      expect { new_grid }.to change { ObjectSpace.each_object(Kudomon).to_a.count - Kudomon.free.count }
    end

    it 'spawns a random number of free Kudomon' do
      expect { new_grid }.to change { Kudomon.free.count }
    end
  end

  describe '#movement_valid?' do
    let(:grid) { new_grid }
    let(:x_shift) { GRID_SIZE / 4 }
    let(:y_shift) { GRID_SIZE / 4 }
    let(:half_grid) { { x: GRID_SIZE / 2, y: GRID_SIZE / 2 } }
    let(:max_y) { { x: 0, y: GRID_SIZE } }
    let(:max_x) { { x: GRID_SIZE, y: 0 } }

    it 'returns true if a desired movement is within the grid' do
      expect(grid.movement_valid?(half_grid, half_grid)).to eq true
    end

    it 'returns false if a desired movement is outside of the grid' do
      expect(grid.movement_valid?(max_y, max_y)).to eq false
      expect(grid.movement_valid?(max_x, max_x)).to eq false
    end
  end
end
