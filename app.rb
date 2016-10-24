require 'sinatra'
require 'sinatra/namespace'

require 'sinatra/reloader' if development?

require 'json'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
    username == ENV['ZEUSWPI_USER'] and password == ENV['ZEUSWPI_PASS']
end

get '/:file' do
  path = "files/#{params[:file]}"
  halt 404, 'File not found' unless File.exist? path
  send_file path
end

get '/' do
  erb :upload
end

post '/' do
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  ext = File.extname(filename)

  newname = ''
  path = ''

  halt 500, 'Error' unless %w(.png .jpg .jpeg).include? ext

  loop do
    newname = SecureRandom.base64(6).tr('/+', '-_') + ext
    path = "files/#{newname}"
    break unless File.exist? path
  end

  File.open(path, 'wb') do |f|
    f.write(tempfile.read)
  end

  newname
end
