#!/usr/bin/ruby

require 'mkmf'

CONFIG['LDSHARED'] = "g++ -shared"

dir_config("boost")
dir_config("libtorrent", "/usr/local/include/libtorrent", "/usr/local/lib")
have_library("torrent")
find_executable('swig')

message "generating libtorrent wrapper... "
unless xsystem("swig -autorename -c++ -ruby -o libtorrent_wrap.cpp libtorrent.i")
  raise "Failed to generate libtorrent wrapper"
end
message "ok\n"

create_makefile("libtorrent")
