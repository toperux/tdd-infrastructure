require 'minitest/autorun'

class AppTest < MiniTest::Unit::TestCase
  def test_ruby_should_be_installed
    assert File.exists?('/usr/local/bin/ruby'), 'ruby is not installed'
  end
end
