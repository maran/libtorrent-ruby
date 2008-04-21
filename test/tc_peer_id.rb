require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestPeerId < Test::Unit::TestCase
  def setup
    @peer_id1 = BigNumber.new
    @peer_id2 = BigNumber.new
    @peer_id3 = BigNumber.new
    BigNumber::SIZE.times do |i|
      @peer_id1[i] = 1
      @peer_id2[i] = 2
      @peer_id3[i] = 1
    end
  end

  def test_clear
    @peer_id1.clear
    assert(@peer_id1.is_all_zeros)
  end

  def test_equal
    assert(@peer_id1 == @peer_id3)
  end

  def test_not_equal
    assert(@peer_id1 != @peer_id2)
  end
end
