%{
#include "libtorrent/fingerprint.hpp"
%}

namespace libtorrent {

  struct fingerprint
  {
    fingerprint(const char* id_string, int major, int minor, int revision, int tag);

    %rename("__str__") to_string() const;
    std::string to_string() const;

    %typemap(out) char name[2] {
      char temp[2];
      strncpy(temp, $1, 2);
      temp[2] = 0;
      $result = rb_str_new2(temp);
    }

    char name[2];

    %typemap(out) char {
      $result = CHR2FIX($1);
    }

    char major_version;
    char minor_version;
    char revision_version;
    char tag_version;
  };

}
