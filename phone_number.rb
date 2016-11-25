class PhoneNumber
  attr_reader :phone_number

  INVALID_NUMBER = '0000000000'

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def number
    return INVALID_NUMBER if contains_letters?
    handle_prefix
    return INVALID_NUMBER if clean_number.length != 10
    clean_number
  end

  def contains_letters?
    phone_number.chars.any? { |character| character  =~ /[[:alpha:]]/ }
  end

  def clean_number
    phone_number.chars.select { |character| /\A\d+\z/.match(character) }.join
  end

  def handle_prefix
    remove_prefix if phone_number[0].to_i == 1 && valid_length?
  end

  def to_s
    handle_prefix if valid_length?
    "(#{area_code}) #{exchange}-#{station_number}"
  end

  def area_code
    phone_number[0..2]
  end

  def exchange
    phone_number[3..5]
  end

  def station_number
    phone_number[6..10]
  end

  def valid_length?
    phone_number.length > 10
  end

  def remove_prefix
    phone_number.sub!(phone_number[0], '')
  end
end
