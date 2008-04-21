require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestPeerRequest < Test::Unit::TestCase
  def setup
    @peer_request1 = PeerRequest.new
    @peer_request1.piece = 1
    @peer_request1.start = 2;
    @peer_request1.length = 3;
    @peer_request2 = PeerRequest.new
    @peer_request2.piece = 1
    @peer_request2.start = 2;
    @peer_request2.length = 3;
    @peer_request3 = PeerRequest.new
    @peer_request3.piece = 3
    @peer_request3.start = 2;
    @peer_request3.length = 1;
  end

  def test_piece
    piece = rand(1000)
    @peer_request1.piece = piece
    assert_equal(piece, @peer_request1.piece)
  end

  def test_start
    start = rand(1000)
    @peer_request1.start = start
    assert_equal(start, @peer_request1.start)
  end

  def test_length
    length = rand(1000)
    @peer_request1.length = length
    assert_equal(length, @peer_request1.length)
  end

  def test_equals
    assert(@peer_request1 == @peer_request2)
    assert(@peer_request2 != @peer_request3)
  end
end
