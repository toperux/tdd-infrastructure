require 'hello'

require 'minitest/autorun'
require 'rack/test'

class HelloTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Hello.new
  end

  def test_should_say_hello_world
    get '/'

    assert_equal 'hello world', last_response.body
  end
end
