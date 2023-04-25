class RatesImporterJob < ApplicationJob
  queue_as :default

  def perform
    response = RatesRequest.new.get
    rates    = response['data'].map do |rate|
      {
        'code': rate['currency_code'],
        'rate': rate['rate']
      }
    end

    Rate.create!(rates)
  end
end
