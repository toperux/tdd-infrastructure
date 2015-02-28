require 'minitest/autorun'

class AppTest < MiniTest::Unit::TestCase
  def test_ruby_should_be_installed
    assert File.exists?('/usr/local/bin/ruby'), 'ruby is not installed'
  end

  def test_rackup_should_be_running
    rackup_pid = File.read('/usr/local/opt/hello/hello.pid').to_i
    assert_equal 1, Process.kill(0, rackup_pid), 'hello rack app is not running'
  end
end
