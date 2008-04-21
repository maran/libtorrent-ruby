require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestIpFilter < Test::Unit::TestCase
  def setup
    @ip_filter = IpFilter.new
    @ip_filter.add_rule("192.168.0.1", "192.168.0.254", IpFilter::BLOCKED)
  end

  def test_access
    assert_equal(IpFilter::BLOCKED, @ip_filter.access("192.168.0.1"))
    assert_equal(IpFilter::BLOCKED, @ip_filter.access("192.168.0.254"))
    assert_not_equal(IpFilter::BLOCKED, @ip_filter.access("192.168.1.254"))
  end

  def test_export_filter
    puts @ip_filter.export_filter
  end
end
