# coding: utf-8

$: << File.expand_path('../lib', File.dirname(__FILE__))
$project_path = "#{File.expand_path("../", File.dirname(__FILE__))}"

Dir[File.expand_path('../spec/support', File.dirname(__FILE__)) << "/**/*.rb"].each {|f| require f}


@server_thread = Thread.new do
  Rack::Handler::WEBrick.run(DocodocoJpSpec::Test::Server.new,
                             {
                              Port: 9292,
                              Logger: WEBrick::Log.new("/dev/null"),
                              AccessLog: [],
                              bindAddress: "localhost"
                             })
end

sleep(1) # wait a sec for the server to be booted


__END__

