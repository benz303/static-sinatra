# rubygems required
require 'rubygems'
require 'compass'
require 'sinatra'
require 'haml'

APP_ROOT = File.dirname(__FILE__)

# general purpose helpers
#require APP_ROOT + '/helpers/utilities'
#helpers Sinatra::Utilities

# application specific helpers
#require APP_ROOT + '/helpers/navigation'
#helpers Sinatra::Navigation
#require APP_ROOT + '/helpers/custom'
#helpers Sinatra::Custom

# ensure that every rack request creates a new css file
#require 'sass/plugin/rack'
#use Sass::Plugin::Rack
#Sass::Plugin.options[:css_location] = "public/stylesheets"
#Sass::Plugin.options[:template_location] = "views/sass"

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, "views"
set :public, "public"

# compass (Sass toolkit) config
configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.rb'))
  set :haml, { :format => :html5 }
end

# routes

get '/stylesheets/:name' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"sass/#{params[:name]}", Compass.sass_engine_options )
end

get '/*' do
  if params[:splat] == ['']
    params[:splat] = 'index.html'
  else
    params[:splat] = params[:splat][0]
  end
  haml :"pages/#{params[:splat]}", {
    :layout => :'layouts/application'
  }
end

get "/:theme/index.html" do
  haml :"pages/#{params[:theme]}/index", {
    :layout => :"layouts/application", :locals => {
      :theme_token => params[:theme],
      :theme_url => params[:theme]+"/",
      :is_home => true
    }
  }
end


# TERTIARY PAGES
get "/:theme/:audience/:seg1/:seg2/index.html" do
  haml :"pages/#{params[:theme]}/#{params[:audience]}/#{params[:seg1]}/#{params[:seg2]}/index", {
    :layout => :"layouts/application", :locals => {
      :audience_name => params[:audience],
      :theme_token => params[:theme],
      :theme_url => params[:theme]+"/",
      :is_tertiary => true
    }
  }

end


# ALL PAGES
get "/:theme/:audience/*/index.html" do
  haml :"pages/#{params[:theme]}/#{params[:audience]}/#{params[:splat].to_s}/index", {
    :layout => :"layouts/application", :locals => {
      :audience_name => params[:audience],
      :theme_token => params[:theme],
      :theme_url => params[:theme]+"/"
    }
  }
end
