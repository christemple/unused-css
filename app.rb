require "sinatra"

get '/' do
  erb :index
end

get '/multiple' do
  erb :multiple
end
