class CachedUser
  def self.find(id)
    user = Rails.cache.fetch("user:#{id}", expires_in: 24.hours) do
      User.find_by(id:)
    end

    Rails.cache.delete("user:#{id}") if user.nil?

    user
  end
end
