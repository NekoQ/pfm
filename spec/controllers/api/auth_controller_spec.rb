require 'rails_helper'

describe Api::AuthController do
  context 'sign_in' do
    let!(:user) { FactoryBot.create :user }
    it 'generates sign_in token' do
      post :sign_in, params: {
        email: 'test@test.com',
        password: 'abc'
      }, format: :json

      expect(JSON.parse(response.body)['token']).to be_present
    end

    it 'returns error and unauthorized header' do
      post :sign_in, params: {
        email: 'test@test.com',
        password: '123'
      }, format: :json

      expect(response.status).to eq(401)
      expect(JSON.parse(response.body)['errors']).to eq(['Wrong credentials'])
    end
  end
end
