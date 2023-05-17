Rack::Attack.throttle('ip limit', limit: 100, period: 1) do |request|
  request.ip
end

Rack::Attack.throttle('create user by ip limit', limit: 1, period: 3) do |request|
  request.ip if request.path == '/api/users' && request.post?
end
