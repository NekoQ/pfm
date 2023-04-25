describe Api::BaseController do
  context 'authenticate_user' do
    controller(described_class) do
      def index
        render json: { success: true }
      end
    end

    before :each do
      request.headers.merge('Authorization' => 'token')
    end

    it 'extracts user_id from token' do
      expect(JwtToken)
        .to receive(:decode)
        .and_return({ 'user_id': '123' })
      get :index
      expect(assings(:current_user)).to eq '123'
      pp JSON.parse(response.body)
    end
  end
end
