module Tomodachi
  class API < Grape::API
    version 'v1', using: :header, vendor: 'tomodachi'
    format :json
    prefix :api

    resource :people do
      desc 'List people'
      get do
        Person::Index.()["model"]
      end
    end
  end
end
