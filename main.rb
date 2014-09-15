require 'sinatra/base'
require 'slim'

class Board < Sinatra::Base
  get '/' do
    slim :home
  end

end
