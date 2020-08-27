require 'firebase'
require 'sinatra'

class Api < Sinatra::Base
  config = YAML.load_file('./config.yaml')

  base_uri = config['base_uri']
  db_secret = config['db_secret']

  firebase = Firebase::Client.new(base_uri, db_secret)

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST'
  end

  post '/user/message' do
    @player = JSON.parse(request.body.read)['player']

    request.body.rewind

    @message = JSON.parse(request.body.read)['message']

    firebase.push('messages/', {
                    message: @message,
                    player: @player
                  })

    'Success'
  end

  options '*' do
    response.headers['Allow'] = 'HEAD,GET,PUT,DELETE,OPTIONS'

    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'

    200
  end

  run!
end
