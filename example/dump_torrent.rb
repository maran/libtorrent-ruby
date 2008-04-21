#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), "../ext/libtorrent")

require 'libtorrent'

torrent_info = Libtorrent::TorrentInfo.load(ARGV[0])

puts "trackers:"
torrent_info.trackers.each do |tracker|
  puts "   #{tracker.tier}: #{tracker.url}"
end

puts "number of pieces: #{torrent_info.num_pieces}"
puts "piece length: #{torrent_info.piece_length}"
puts "info hash: #{torrent_info.info_hash.to_s}"
puts "comment: #{torrent_info.comment}"
puts "created by: #{torrent_info.creator}"

puts "files:"
torrent_info.files.each do |file|
  puts "   #{file.path} (#{file.size / 1024} KB)"
end
