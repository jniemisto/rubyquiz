class SolitaireCipher
  CHARACTER_ENCODING_TABLE = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  def process(msg)
    msg = apply_padding(strip_characters(msg).upcase)
    keystream = SolitaireDeck.new.keystream(msg.size)
    msg_array = convert_to_number_array(msg)
    keystream_array = convert_to_number_array(keystream)
    combined = combine_arrays(msg_array, keystream_array)
    add_whitespaces(convert_to_string(combined))
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

  def convert_to_string(numbers)
    numbers.map { |n| convert_to_char(n) }.join
  end

  def convert_to_number(char)
    CHARACTER_ENCODING_TABLE.index(char) + 1
  end

  def convert_to_char(number)
    CHARACTER_ENCODING_TABLE[number-1]
  end

end

class SolitaireCipherEncoder < SolitaireCipher
  def encode(msg)
    process(msg)
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

class SolitaireCipherDecoder < SolitaireCipher
  def decode(msg)
    process(msg)
  end

  def combine_arrays(array1, array2)
    combined_array = array1.zip(array2).map do |zipped|
      zipped.reduce(&:-)
    end
    combined_array.map do |n|
      n < 0 ? n + 26 : n
    end
  end
end


class SolitaireDeck
  CHARACTER_ENCODING_TABLE = %w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)

  attr_reader :deck

  def initialize
    @deck = (1..52).to_a + %w(A B)
  end

  def keystream(size)
    output = ""
    while output.size < size
      move_A
      move_B
      triple_cut
      count_cut
      char = convert_to_char(get_index)
      output << char if char
    end
    output
  end

  def move_A
    move_card_down("A")
  end

  def move_B
    move_card_down("B")
    move_card_down("B")
  end

  def triple_cut
    index_a = @deck.index("A")
    index_b = @deck.index("B")
    if index_a < index_b
      lower_index = index_a
      higher_index = index_b
    else
      higher_index = index_a
      lower_index = index_b
    end
    part_a = @deck[0..lower_index-1]
    part_b = @deck[lower_index..higher_index]
    part_c = @deck[higher_index+1..@deck.size-1]
    @deck = part_c + part_b + part_a
  end

  def count_cut
    return if %w(A B).include?(@deck.last)
    part_a = @deck[0..@deck.last-1]
    part_b = @deck[@deck.last..@deck.size-2]
    part_c = [@deck.last]
    @deck = part_b + part_a + part_c
  end

  def get_index
    index = @deck.first
    index = 53 if %w(A B).include?(index)
    @deck[index]
  end

  def convert_to_char(number)
    return if %w(A B).include?(number)
    number-=26 if number >= 26
    CHARACTER_ENCODING_TABLE[number-1]
  end

  private

  # moves card down 1 place, if already last card, moves it to the top second card
  def move_card_down(card)
    original_index = @deck.index(card)
    new_index = original_index + 1
    new_index = 1 if original_index == @deck.size - 1
    @deck.delete_at(original_index)
    @deck.insert(new_index, card)
  end
end
