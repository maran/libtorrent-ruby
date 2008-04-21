require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestTorrentHandle < Test::Unit::TestCase
  def setup
    @torrent_handle = TorrentHandle.new
  end

  def test_is_paused
    puts @torrent_handle.is_seed
  end
end
