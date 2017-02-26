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
end
