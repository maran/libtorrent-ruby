require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestTorrentInfo < Test::Unit::TestCase
  def setup
    @torrent_info = TorrentInfo.new
  end

  def test_comment
    comment = "test comment"
    @torrent_info.set_comment(comment)
    assert_equal(comment, @torrent_info.comment)
  end

  def test_creator
    creator = "test creator"
    @torrent_info.set_creator(creator)
    assert_equal(creator, @torrent_info.creator)
  end

  def test_url_seeds
    url = "http://example.com/"

    @torrent_info.add_url_seed(url)

    url_seeds = @torrent_info.url_seeds
    assert_equal(Array, url_seeds.class)
    assert_equal(1, url_seeds.length)
    assert_equal(url, url_seeds.pop)
  end

  def test_trackers
    tracker_url = "http://tracker.com/"
    tracker_tier = 1
    
    @torrent_info.add_tracker(tracker_url, tracker_tier)
    
    trackers = @torrent_info.trackers
    assert_equal(Array, trackers.class)
    assert_equal(1, trackers.length)
    tracker = trackers.pop
    assert_equal(tracker_url, tracker.url)
    assert_equal(tracker_tier, tracker.tier)
  end

  def test_files
    file_path = "test"
    file_size = 1024

    @torrent_info.add_file(file_path, file_size)
    assert_equal(file_size, @torrent_info.total_size)

    assert_equal(1, @torrent_info.num_files)

    file = @torrent_info.file_at(0)
    assert_equal(file_path, file.path)
    assert_equal(file_size, file.size)

    files = @torrent_info.files
    assert_equal(Array, files.class)
    assert_equal(1, files.length)
    file = files.pop
    assert_equal(file_path, file.path)
    assert_equal(file_size, file.size)
  end
end
