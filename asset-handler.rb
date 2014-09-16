class AssetHandler < Sinatra::Base
  configure do
    set :public_folder, File.dirname(__FILE__) + '/assets'
    set :cssdir, 'css'
  end
end
