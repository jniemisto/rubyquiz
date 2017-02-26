class SolitaireCipherEncoder
  def encode(msg)
    strip_characters(msg)
  end

  def strip_characters(msg)
    msg.gsub(/[^A-Za-z]/, "")
  end
end
