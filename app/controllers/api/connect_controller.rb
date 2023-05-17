class Api::ConnectController < Api::BaseController
  def connect
    response   = ConnectRequest.new.connect(connect_params)

    return invalid_return_to unless response['data'].present?

    render json: response['data']
  end

  def reconnect
    response   = ConnectRequest.new.reconnect(reconnect_params)
    pp response
    render json: response['data']
  end

  def refresh
    connection_ids = Account.where(user_id: current_user.id).pluck(:connection_id).uniq
    connection_ids.each do |connection_id|
      response = ConnectRequest.new.refresh(connection_id:)
      pp response
    end
    head 200
  end

  private

  def invalid_return_to
    render json: { errors: ['Invalid return_to'] }, status: 409
  end

  def connect_params
    {
      data: {
        customer_id: current_user.customer_id,
        return_connection_id: true,
        consent: {
          scopes: %w[account_details transactions_details]
        },
        attempt: {
          return_to: params[:return_to]
        }
      }
    }
  end

  def reconnect_params
    {
      data: {
        customer_id: current_user.customer_id,
        connection_id: params[:connection_id],
        return_connection_id: true,
        consent: {
          scopes: %w[account_details transactions_details]
        },
        attempt: {
          return_to: params[:return_to]
        }
      }
    }
  end

  def refresh_params
    {
      connection_id: params[:connection_id]
    }
  end
end
