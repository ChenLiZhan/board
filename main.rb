require 'sinatra/base'
require 'slim'
require 'dm-core'
require 'dm-migrations'
require './asset-handler'
class Message
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :message, Text
  property :created, Integer
end

DataMapper.finalize

class Board < Sinatra::Base
  use AssetHandler

  configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  end

  helpers do
    def css(*stylesheets)
      stylesheets.map do |stylesheet|
        "<link href=\"/#{AssetHandler.settings.cssdir}/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
      end.join
    end
  end

  get '/' do
    slim :home
  end

  get '/show' do
    @message = Message.all
    slim :show
  end

  get '/create' do
    slim :create
  end

  post '/create' do
    Message.create(:title => params['title'], :message => params['content'], :created => Time.now.to_i)
    redirect to('/show')
  end
end
