require "sinatra"

get '/' do
  erb :index
end

get '/multiple' do
  erb :multiple
end

get '/ajax-content' do
  <<-HTML
    <div id="ajaxed-content">
      I was pulled in by AJAX
    </div>
  HTML
end
