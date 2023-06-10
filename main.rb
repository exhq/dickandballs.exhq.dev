require 'webrick'

server = WEBrick::HTTPServer.new(Port: 6969)

server.mount_proc '/' do |req, res|
  res.content_type = 'text/plain'
  if req.path == '/' || req.path == '/favicon.ico' || 
    res.body = 'kill yourself'
    next
  end

  file_path = req.path[1..] + '.js'
  if File.exist?(file_path)
    file = File.open(file_path, 'r')
    res.body = file.read()
  else
    res.body = 'File not found'
  end
end

trap('INT') { server.shutdown }

server.start


