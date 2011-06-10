desc "save static html to 'static' directory..."
task :build do
  require 'rake'
#  require 'sinatra'
  require File.dirname(__FILE__) << '/app'
  @request = Rack::MockRequest.new(Sinatra::Application)
  system 'rm static/*;rm -r static/*'
  system 'cp public/* static'
  
  Dir.glob('views/pages/*.haml').each do |path|
    url = path.match(/([^\/]+)\.html\.haml/)[1]
    p "creating #{url}.html"
    File.open("static/#{url}.html", 'w'){|f| f.print @request.get(url+'.html').body }
  end
  
  system 'mkdir static/stylesheets' unless File.exists?('static/stylesheets')
  Dir.glob('views/sass/*.sass').each do |path|
    url = path.match(/([^\/]+)\.css\.sass/)[1]
    p "creating #{url}.css"
    File.open("static/stylesheets/#{url}.css", 'w'){|f| f.print @request.get("stylesheets/#{url}.css").body }
  end
end

desc "export the standalone version to a 'site' directory above the root"
task  :export  do
  system "export --force public/ ../site"
  system "export --force static/ ../site"
end
