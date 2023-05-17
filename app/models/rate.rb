class Rate < ApplicationRecord
  def self.x(code, value)
    Rate.find_by(code: code.upcase).rate * value
  end
end
