require 'sinatra/base'
require 'slim'
require 'dm-core'
require 'dm-migrations'

class Message
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :message, Text
  property :created, Integer
end

DataMapper.finalize

class Board < Sinatra::Base

  configure :development do
    DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")
  end

  get '/' do
    slim :home
  end

  get '/show' do
  end

  get '/create' do
    slim :create
  end

  post '/create' do
    Message.create(:title => params['title'], :message => params['content'], :created => Time.now.to_i)
  end
end
