class PhoneNumber
  attr_reader :phone_number

  INVALID = '0000000000'

  def initialize(phone_number)
    @phone_number = phone_number
  end

  def number
    return INVALID if contains_letters?
    remove_one
    return INVALID if clean_number.length != 10
    clean_number
  end

  def contains_letters?
    phone_number.chars.any? { |character| character  =~ /[[:alpha:]]/ }
  end

  def clean_number
    phone_number.chars.select do |character|
       /\A\d+\z/.match(character)
    end.join
  end

  def remove_one
    if phone_number[0].to_i == 1 && phone_number.length > 10
      phone_number.sub!(phone_number[0], '')
    end
  end

  def area_code
    phone_number[0..2]
  end

  def to_s
    if phone_number.length > 10
      phone_number.sub!(phone_number[0], '')
    end
    "(#{phone_number[0..2]}) #{phone_number[3..5]}-#{phone_number[6..10]}"
  end
end
