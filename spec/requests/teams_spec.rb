require 'rails_helper'

RSpec.describe 'Teams API', type: :request do
  #init test data
  let!(:teams) { create_list(:team, 10) }
  let(:team_id) { teams.first.id }

  # Test suite for GET /teams
  describe 'GET /teams' do
    before { get '/teams' }

    it 'returns teams' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /teams/:id
  describe 'GET /teams/:id' do
    let!(:team) { {id: 1, name: "my_team", users: create_list(:user, 2)} }
    before { get "/teams/#{team_id}" }

    context 'when the record exists' do
      it 'returns the team including its users' do
        expect(json).not_to be_empty
        expect(json[:id]).to eq(team_id)
        expect(json[:users].size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST /teams
  describe 'POST /teams' do
    # valid payload
    let(:valid_attributes) { { name: 'my_team', users: create_list(:user, 10)} }

    context 'when the request is valid' do
      before { post '/teams', params: valid_attributes }

      it 'creates a team with name' do
        expect(json[:name]).to eq('my_team')
      end


      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/teams', params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Name can't be blank/)
      end
    end
  end


  # Test suite for PUT /teams/:id
  describe 'PUT /teams/:id' do
    let(:valid_attributes) { { name: 'my_name_edited' } }

    context 'when the record exists' do
      before { put "/teams/#{team_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /teams/:id
  describe 'DELETE /todos/:id' do
    before { delete "/teams/#{team_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end