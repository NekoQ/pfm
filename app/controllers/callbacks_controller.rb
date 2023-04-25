class CallbacksController < ApplicationController
  def success
    pp request.body
  end

  def fail
    pp request.body
  end

  def notify
    stage               = params.dig('data', 'stage')
    return unless stage == 'finish'

    customer_id         = params.dig('data', 'customer_id')
    user                = User.find_by(customer_id:)
    return unless user

    ImporterJob.perform_later(user)
  end
end
