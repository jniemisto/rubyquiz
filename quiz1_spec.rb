require_relative "quiz1"

RSpec.describe SolitaireCipherEncoder do
  it "encodes given example" do
    encoded = SolitaireCipherEncoder.new.encode("Code in Ruby, live longer!")
    expect(encoded).to eq "DWJXH YRFDG TMSHP UURXJ"
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
end
