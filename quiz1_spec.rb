require_relative "quiz1"

RSpec.describe SolitaireCipherEncoder do
  it "encodes given example" do
    encoded = SolitaireCipherEncoder.new.encode("Code in Ruby, live longer!")
    expect(encoded).to eq "DWJXH YRFDG TMSHP UURXJ"
  end
end
