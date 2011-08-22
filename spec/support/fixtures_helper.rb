module FixturesHelper
  def fixture(name)
    File.read(File.expand_path("../fixtures/#{name}.json", File.dirname(__FILE__)))
  end
end
