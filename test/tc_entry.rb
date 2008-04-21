require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestEntry < Test::Unit::TestCase
  def setup
    @entry = Entry.load("example/ubuntu-6.06.1-desktop-i386.iso.torrent")
  end
end
