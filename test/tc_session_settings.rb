require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestSessionSettings < Test::Unit::TestCase
  def setup
    @settings = SessionSettings.new
  end

  def test_proxy_ip
    assert_equal("", @settings.proxy_ip)
    proxy_ip = "192.168.0.1"
    @settings.proxy_ip = proxy_ip
    assert_equal(proxy_ip, @settings.proxy_ip)
  end

  def test_proxy_port
    assert_equal(0, @settings.proxy_port)
    proxy_port = 123
    @settings.proxy_port = proxy_port
    assert_equal(proxy_port, @settings.proxy_port)
  end
end
