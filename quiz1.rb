class SolitaireCipherEncoder
  CHARACTER_ENCODING_TABLE = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  def encode(msg)
    add_whitespaces(apply_padding(strip_characters(msg).upcase))
  end

  def strip_characters(msg)
    msg.gsub(/[^A-Za-z]/, "")
  end

  def apply_padding(msg)
    ((5 - msg.size % 5) % 5).times { msg << "X" }
    msg
  end

  def add_whitespaces(msg)
    (1..(msg.size-1)/5).each do |i|
      msg.insert(i*5+i-1, " ")
    end
    msg
  end

  def convert_to_number_array(msg)
    msg.chars.map { |char| convert_to_number(char) }
  end

  def convert_to_number(char)
    CHARACTER_ENCODING_TABLE.index(char) + 1
  end

  def combine_arrays(array1, array2)
    combined_array = array1.zip(array2).map do |zipped|
      zipped.reduce(&:+)
    end
    combined_array.map do |n|
      n > 26 ? n - 26 : n
    end
  end
end

class SolitaireDeck
  attr_reader :deck

  def initialize
    @deck = (1..52).to_a + %w(A B)
  end

end
