class ConnectController < ApplicationController
    require 'api_request'

    def connect
        @response = SALT_LOGIN.new(current_user, params: params).create
        binding.irb
    end

    def reconnect; end

    def refresh; end
end

