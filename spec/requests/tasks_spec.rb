# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  # init test data
  let(:user) { create(:user) }
  let!(:task) { create_list(:task, 10, user_id: user.id) }
  let(:task_id) { task.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /tasks
  describe 'GET /tasks' do
    before { get '/tasks', params: {}, headers: headers }

    it 'returns tasks' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  #
  # Test suite for GET /tasks/:id
  describe 'GET /tasks/:id' do
    before { get "/tasks/#{task_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the task' do
        expect(json).not_to be_empty
        expect(json[:id]).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test suite for POST /tasks
  describe 'POST /tasks' do
    # valid payload
    let!(:valid_attributes) { { description: 'my_task', status: 'to-do', user_id: user.id }.to_json }

    context 'when the request is valid' do
      before { post '/tasks', params: valid_attributes, headers: headers }

      it 'creates a task' do
        expect(json[:description]).to eq('my_task')
        expect(json[:status]).to eq('to-do')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/tasks', params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist, Description can't be blank, Status can't be blank/)
      end
    end
  end

  # # Test suite for PUT /tasks/:id
  describe 'PUT /tasks/:id' do
    let!(:valid_attributes) { { description: 'my_task_updated', status: 'to-do', user_id: user.id }.to_json }

    context 'when the record exists' do
      before { put "/tasks/#{task_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /tasks/:id
  describe 'DELETE /tasks/:id' do
    before { delete "/tasks/#{task_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
