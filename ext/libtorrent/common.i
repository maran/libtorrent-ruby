%{
#include <sstream>
%}

%typemap(in) libtorrent::address {
  $1 = libtorrent::address::from_string(SWIG_RB2STR($input));
}

%typemap(out) libtorrent::address {
  $result = SWIG_STR2RB($1.to_string());
}

%typemap(out) libtorrent::tcp::endpoint* {
  std::ostringstream out;
  out << *$1;
  $result = SWIG_STR2RB(out.str());
}

%typemap(out) boost::posix_time::ptime {
  $result = rb_funcall(rb_cTime, rb_intern("utc"), 6,
    INT2FIX($1.date().year()),
    INT2FIX($1.date().month()),
    INT2FIX($1.date().day()),
    INT2FIX($1.time_of_day().hours()),
    INT2FIX($1.time_of_day().minutes()),
    INT2FIX($1.time_of_day().seconds())
  );
}

%typemap(out) boost::posix_time::time_duration {
  $result = INT2FIX($1.total_seconds());
}

namespace libtorrent {

  class address;
  class entry;
  class extension_index;
  class net_interface;
  class partial_piece_info;
  class result;
  class resultptr;
  %nodefaultctor tcp;
  class tcp {
    class endpoint;
  };

  typedef intmax_t size_type;

}

%{
#include <fstream>
#include <iterator>
#include "libtorrent/bencode.hpp"
#include "libtorrent/entry.hpp"

static libtorrent::entry load_entry(std::istream& in) {
  in.unsetf(std::ios_base::skipws);
  try {
    libtorrent::entry e = libtorrent::bdecode(std::istream_iterator<char>(in), std::istream_iterator<char>());
    return e;
  } catch (libtorrent::invalid_encoding) {
    rb_raise(rb_eStandardError, "Invalid torrent");
  }
}

static libtorrent::entry load_entry(const char* path) {
  std::ifstream in(path, std::ios_base::binary);
  if (!in)
    rb_raise(rb_eStandardError, "Torrent file does not exist");
  return load_entry(in);
}

static void save_entry(const libtorrent::entry& e, const char* path) {
  std::ofstream out(path, std::ios_base::binary);
  libtorrent::bencode(std::ostream_iterator<char>(out), e);
}
%}
