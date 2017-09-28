describe Battle do
  let(:winning_trainer) { Trainer.new("Winner", nil) }
  let(:winning_kudomon) { Kudomon.new(KUDOMON.keys.sample, nil) }
  let(:losing_trainer) { Trainer.new("Loser", nil) }
  let(:losing_kudomon) { Kudomon.new(KUDOMON.keys.sample, nil) }
  let(:battle) { Battle.new(winning_trainer, losing_trainer, winning_kudomon)}

  describe "#initialize" do
    it "picks one of the defender's Kudomon as the defender_kudomon" do
      # Add the losing_kudomon to the losing_trainer's collection
      losing_trainer.collection << losing_kudomon

      expect(battle.defender_kudomon).to eq(losing_kudomon)
    end
  end

  describe "#run" do
    it "returns the right winning pair" do
      # Add the losing_kudomon to the losing_trainer's collection
      losing_trainer.collection << losing_kudomon

      # Massively stack the odds in favor of the winning_kudomon
      winning_kudomon.hp = losing_kudomon.cp * 1000
      losing_kudomon.hp = 1

      expect(battle.run).to eq({trainer: winning_trainer, kudomon: winning_kudomon})
    end
  end
end
