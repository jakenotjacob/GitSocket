require 'socket'
require 'open-uri'
require 'json'
require 'ipaddr'

class GitSocket

  #Grab official servers from Git
  GIT_SERVERS = JSON.parse(open("https://api.github.com/meta").read())
  WHITELIST = GIT_SERVERS["hooks"].map { |srv| srv = IPAddr.new(srv) }

  def initialize (port)
    @server = TCPServer.new(port)
  end

  def listen
    puts "Loop Thread: #{Thread.current}"
    puts "Requests accepted and saved: \n"
    loop do
      Thread.fork(@server.accept) { |socket|
        incoming_host = IPAddr.new(socket.peeraddr.last)

        puts "Peer Thread: #{Thread.current}"
        puts "Peer Addr: #{socket.peeraddr}"

        #Check if incoming IP matches ALLOWED network/host addresses
        ##If it does, run somethin!
        WHITELIST.each { |srv|
          if srv.include? incoming_host
            puts "MATCH FOUND!"
            # ...
            # This is where you execute your code.
            # ie -
            # Dir.chdir("/path/to/my/repo")
            # `git pull`
            # ...
          else
            puts "NO MATCH FOUND."
            socket.close
          end
        }
        socket.close
        Thread.exit
      }
    end
  end
end
