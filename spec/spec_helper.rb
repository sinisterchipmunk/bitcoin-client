require 'fakeweb'

# bitcoin user settings
$user = 'user'
$pass = 'pass'

require File.expand_path('../lib/bitcoin_client-client', File.dirname(__FILE__))

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each { |f| require f }

FakeWeb.allow_net_connect = false

RSpec.configure do |c|
  c.include FixturesHelper
end
