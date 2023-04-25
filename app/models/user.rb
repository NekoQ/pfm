class User < ApplicationRecord
  has_secure_password

  validates :email,    presence: true
  validates :password, presence: true
  validates_uniqueness_of :email

  before_save :invalidate_cache
  before_destroy :invalidate_cache

  def invalidate_cache
    Rails.cache.delete("user:#{id}")
  end
end
