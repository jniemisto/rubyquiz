require_relative "quiz1"

RSpec.describe SolitaireCipherEncoder do
  it "encodes given example" do
    encoded = SolitaireCipherEncoder.new.encode("Code in Ruby, live longer!")
    expect(encoded).to eq "GLNCQ MJAFF FVOMB JIYCB"
  end

  describe "character striping" do
    it "keeps a-z characters" do
      msg = "HelloRuby"
      striped_str = SolitaireCipherEncoder.new.strip_characters(msg)
      expect(striped_str).to eq msg
    end
    it "stripes non encoded characters" do
      striped_str = SolitaireCipherEncoder.new.strip_characters(",-131!")
      expect(striped_str).to eq ""
    end
  end

  describe "apply padding" do
    it "adds padding" do
      padded_str = SolitaireCipherEncoder.new.apply_padding("12345678901")
      expect(padded_str).to eq "12345678901XXXX"
    end

    it "does not add padding if not needed" do
      padded_str = SolitaireCipherEncoder.new.apply_padding("1234567890")
      expect(padded_str).to eq "1234567890"
    end
  end

  describe "add whitespaces" do
    it "adds whitespaces" do
      converted = SolitaireCipherEncoder.new.add_whitespaces("12345678901")
      expect(converted).to eq "12345 67890 1"
    end
  end

  describe "convert characters to numbers" do
    it "converts A" do
      expect(SolitaireCipherEncoder.new.convert_to_number("A")).to eq 1
    end
  end

  describe "converts strings to number array" do
    let(:input) { "CODEINRUBYLIVELONGER" }
    let(:output) { [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18] }
    it "converts example string" do
      expect(SolitaireCipherEncoder.new.convert_to_number_array(input)).to eq output
    end
  end

  describe "combine keystream arrays" do
    let(:input1) { [3, 15, 4, 5, 9, 14, 18, 21, 2, 25, 12, 9, 22, 5, 12, 15, 14, 7, 5, 18] }
    let(:input2) {[4, 23, 10, 24, 8, 25, 18, 6, 4, 7, 20, 13, 19, 8, 16, 21, 21, 18, 24, 10]}
    let(:expected_output) {[7, 12, 14, 3, 17, 13, 10, 1, 6, 6, 6, 22, 15, 13, 2, 10, 9, 25, 3, 2]}

    it "combines arrays correctly" do
      expect(SolitaireCipherEncoder.new.combine_arrays(input1, input2)).to eq expected_output
    end
  end
end

RSpec.describe SolitaireDeck do
  describe "new deck" do
    it "has 54 cards" do
      expect(SolitaireDeck.new.deck.size).to eq 54
    end

    it "has cards in initial order" do
      deck = SolitaireDeck.new.deck
      expect(deck.first).to eq 1
      expect(deck.last).to eq "B"
    end
  end
end
