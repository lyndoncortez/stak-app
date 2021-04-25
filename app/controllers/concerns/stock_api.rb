module StockApi
  extend ActiveSupport::Concern

  included do
    before_action :fetch_api
  end

  private

  def fetch_api
    @client = IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/stable'
    )
  end
end