#!/usr/bin/ruby

# Stream all the files given on the commandline to the Icecast server on
# localhost. 

require 'rubygems'
require 'shout'
require 'yaml'

BLOCKSIZE = 16384

c = YAML.load_file('config.yml')
s = Shout.new
s.host     = c[:host]  || "localhost" # beef.gina.alaska.edu
s.port     = c[:port]  || "8000"      # 8008
s.mount    = c[:mount] || "/shoutr"   #
s.user     = c[:user]  || "source"    # 
s.password = c[:password] || "hackme" # 

s.connect

def send_io(s,p,filename)
  puts "sending data from #{filename}"
  m = ShoutMetadata.new
  m.add 'filename', File.basename(filename)
  s.metadata = m

  while data = p.read(BLOCKSIZE)
    s.send data
    s.sync
  end
end

ARGV.each do |filename|
  target = filename if File.exists?(filename)
  next unless target
  if File.extname(target).downcase == '.mp3'
    puts "got an mp3 file, trying new code"
    cmd = ("mpg123 -q -w - '#{target}' | oggenc -c '#{target}' -Q -")
    IO.popen(cmd,'r') { |p| send_io(s,p,filename) } 
  elsif File.extname(target).downcase == '.ogg'
    puts "got an ogg file, using old code" 
	  File.open(filename) { |f| send_io(s,f,filename) }
  end
end

s.disconnect
