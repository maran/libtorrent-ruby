require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestTorrentStatus < Test::Unit::TestCase
  def setup
    @torrent_status = TorrentStatus.new
  end

  def test_state
    assert(TorrentStatus::QUEUED_FOR_CHECKING, @torrent_status.state)
    @torrent_status.state = TorrentStatus::ALLOCATING
    assert(TorrentStatus::ALLOCATING, @torrent_status.state)
  end

  def test_paused
    assert(!@torrent_status.paused)
    @torrent_status.paused = true
    assert(@torrent_status.paused)
  end

  def test_progress
    assert_equal(0, @torrent_status.progress)
    progress = rand
    @torrent_status.progress = progress
    assert_equal(progress, @torrent_status.progress)
  end

  def test_next_announce
  end

  def test_announce_interval
  end

  def test_current_tracker
    #assert_equal("", @torrent_status.current_tracker)
    @torrent_status.current_tracker = "ABC"
    assert_equal("ABC", @torrent_status.current_tracker)
  end

  def test_total_download
    assert_equal(0, @torrent_status.total_download)
    total_download = rand(1000)
    @torrent_status.total_download = total_download
    assert_equal(total_download, @torrent_status.total_download)
  end

  def test_total_upload
    assert_equal(0, @torrent_status.total_upload)
    total_upload = rand(1000)
    @torrent_status.total_upload = total_upload
    assert_equal(total_upload, @torrent_status.total_upload)
  end

  def test_total_payload_download
    assert_equal(0, @torrent_status.total_payload_download)
    total_payload_download = rand(1000)
    @torrent_status.total_payload_download = total_payload_download
    assert_equal(total_payload_download, @torrent_status.total_payload_download)
  end

  def test_total_payload_upload
    assert_equal(0, @torrent_status.total_payload_upload)
    total_payload_upload = rand(1000)
    @torrent_status.total_payload_upload = total_payload_upload
    assert_equal(total_payload_upload, @torrent_status.total_payload_upload)
  end

  def test_total_failed_bytes
    assert_equal(0, @torrent_status.total_failed_bytes)
    total_failed_bytes = rand(1000)
    @torrent_status.total_failed_bytes = total_failed_bytes
    assert_equal(total_failed_bytes, @torrent_status.total_failed_bytes)
  end

  def test_total_redundant_bytes
    assert_equal(0, @torrent_status.total_redundant_bytes)
    total_redundant_bytes = rand(1000)
    @torrent_status.total_redundant_bytes = total_redundant_bytes
    assert_equal(total_redundant_bytes, @torrent_status.total_redundant_bytes)
  end

  def test_download_rate
    assert_equal(0, @torrent_status.download_rate)
    download_rate = rand
    @torrent_status.download_rate = download_rate
    assert_equal(download_rate, @torrent_status.download_rate)
  end

  def test_upload_rate
    assert_equal(0, @torrent_status.upload_rate)
    upload_rate = rand
    @torrent_status.upload_rate = upload_rate
    assert_equal(upload_rate, @torrent_status.upload_rate)
  end

  def test_download_payload_rate
    assert_equal(0, @torrent_status.download_payload_rate)
    download_payload_rate = rand
    @torrent_status.download_payload_rate = download_payload_rate
    assert_equal(download_payload_rate, @torrent_status.download_payload_rate)
  end

  def test_upload_payload_rate
    assert_equal(0, @torrent_status.upload_payload_rate)
    upload_payload_rate = rand
    @torrent_status.upload_payload_rate = upload_payload_rate
    assert_equal(upload_payload_rate, @torrent_status.upload_payload_rate)
  end

  def test_num_peers
    assert_equal(0, @torrent_status.num_peers)
    num_peers = rand(1000)
    @torrent_status.num_peers = num_peers
    assert_equal(num_peers, @torrent_status.num_peers)
  end

  def test_num_complete
    assert_equal(-1, @torrent_status.num_complete)
    num_complete = rand(1000)
    @torrent_status.num_complete = num_complete
    assert_equal(num_complete, @torrent_status.num_complete)
  end

  def test_num_incomplete
    assert_equal(-1, @torrent_status.num_incomplete)
    num_incomplete = rand(1000)
    @torrent_status.num_incomplete = num_incomplete
    assert_equal(num_incomplete, @torrent_status.num_incomplete)
  end

  def test_pieces
  end

  def test_total_done
    assert_equal(0, @torrent_status.total_done)
    total_done = rand(1000)
    @torrent_status.total_done = total_done
    assert_equal(total_done, @torrent_status.total_done)
  end

  def test_total_wanted_done
    assert_equal(0, @torrent_status.total_wanted_done)
    total_wanted_done = rand(1000)
    @torrent_status.total_wanted_done = total_wanted_done
    assert_equal(total_wanted_done, @torrent_status.total_wanted_done)
  end

  def test_total_wanted
    assert_equal(0, @torrent_status.total_wanted)
    total_wanted = rand(1000)
    @torrent_status.total_wanted = total_wanted
    assert_equal(total_wanted, @torrent_status.total_wanted)
  end

  def test_num_seeds
    assert_equal(0, @torrent_status.num_seeds)
    num_seeds = rand(1000)
    @torrent_status.num_seeds = num_seeds
    assert_equal(num_seeds, @torrent_status.num_seeds)
  end

  def test_distributed_copies
    assert_equal(0, @torrent_status.distributed_copies)
    distributed_copies = rand
    @torrent_status.distributed_copies = distributed_copies
    assert_equal(distributed_copies, @torrent_status.distributed_copies)
  end

  def test_block_size
    assert_equal(0, @torrent_status.block_size)
    block_size = rand(1000)
    @torrent_status.block_size = block_size
    assert_equal(block_size, @torrent_status.block_size)
  end
end
