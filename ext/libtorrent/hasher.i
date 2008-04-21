%{
#include "libtorrent/hasher.hpp"
%}

namespace libtorrent {

  class hasher
  {
  public:

    hasher();
    hasher(const char* data, int len);

    void update(const char* data, int len);
    sha1_hash final();
    void reset();
  };

}
