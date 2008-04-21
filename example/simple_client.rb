#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), "../ext/libtorrent")

require 'libtorrent'

include Libtorrent

session = Session.new
session.severity_level = Alert::INFO
session.listen_on(6881)
torrent_handle = session.add_torrent(TorrentInfo.load(ARGV[0]), "./")

while true do
  torrent_status = torrent_handle.status
  puts "state: #{torrent_status.state}"
  session.alerts.each do |alert|
    puts "#{alert.timestamp}: #{alert.message} (#{alert.timestamp.localtime})"
  end
  sleep(1)
end
