require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestPeerInfo < Test::Unit::TestCase
  def setup
    @peer_info = PeerInfo.new
  end

  def test_peer_info
  end
end
