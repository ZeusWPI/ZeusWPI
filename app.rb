require 'sinatra'
require 'sinatra/namespace'

require 'sinatra/reloader' if development?

require 'json'

helpers do
  def protected!
    return if authorized?

    headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
    halt 401, "Not authorized\n"
  end

  def authorized?
    return true unless ENV['ZEUSWPI_USER'] && ENV['ZEUSWPI_PASS']

    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && (@auth.credentials == [ENV['ZEUSWPI_USER'], ENV['ZEUSWPI_PASS']])
  end
end

get '/:file' do
  path = "files/#{params[:file]}"
  halt 404, 'File not found' unless File.exist? path
  response.header['Content-Disposition'] = 'attachment'
  send_file path
end

get '/' do
  protected!
  erb :upload
end

post '/' do
  protected!
  tempfile = params[:file][:tempfile]
  filename = params[:file][:filename]
  ext = File.extname(filename)

  newname = ''
  path = ''

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
