#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), "../ext/libtorrent")

require 'libtorrent'

include Libtorrent

path = Path.new(ARGV[2])
torrent_info = TorrentInfo.new

torrent_info.comment = "Created by libtorrent-ruby."
torrent_info.creator = "Joshua Bassett"
torrent_info.piece_size = 256 * 1024
torrent_info.add_file(File.basename(ARGV[2]))
torrent_info.add_tracker(ARGV[1])

# Hash each piece.
storage = Storage.new(torrent_info, path.branch_path)
hasher = Hasher.new
buffer = ""
torrent_info.num_pieces.times do |i|
  hasher.reset
  storage.read(buffer, i, 0, torrent_info.piece_size(i))
  hasher.update(buffer, torrent_info.piece_size(i))
  torrent_info.set_hash(i, hasher.final)
end

torrent_info.save(ARGV[0])
