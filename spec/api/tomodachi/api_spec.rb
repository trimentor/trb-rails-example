require 'rails_helper'

RSpec.describe Tomodachi::API do
  include Rack::Test::Methods

  def app
    Tomodachi::API
  end

  describe 'GET /api/people' do
    context 'when people exist' do
      it 'returns a collection of people' do
        res = Person::Create.({
          first_name: 'MyFirstName'
        })
        person = res['model']

        get '/api/people'

        expect(last_response.body).to be_json_eql([person].to_json)
      end
    end

    context 'when no people exist' do
      it 'returns an empty collection' do
        get '/api/people'
        expect(last_response.body).to be_json_eql([])
      end
    end
  end
end
