require 'minitest/autorun'

require 'net/http'

class App
  def url
    ENV.fetch 'ENDPOINT', 'http://localhost:9292'
  end

  def run
    @output = Net::HTTP.get URI "#{url}/"
  end

  def output
    @output
  end
end

class HelloTest < Minitest::Test
  def test_should_respond_with_hello_world
    app = App.new

    app.run

    assert_equal 'hello world', app.output
  end
end
