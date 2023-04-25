require 'rails_helper'

describe Api::AccountsController, type: :controller do
  before :each do
    allow(controller)
      .to receive(:authenticate_user)
  end
  context 'index' do
    it 'shows the list of accounts' do
      user = FactoryBot.create :user
      allow(controller)
        .to receive(:current_user)
        .and_return(user)
      FactoryBot.create_list :account, 5, user_id: user.id

      get :index
      expect(JSON.parse(response.body).count).to eq(5)
    end
  end
end
