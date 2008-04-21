%{
#include "libtorrent/session.hpp"
%}

namespace libtorrent {

  struct session_status
  {
    %immutable;

    bool has_incoming_connections;

    float upload_rate;
    float download_rate;

    float payload_upload_rate;
    float payload_download_rate;

    size_type total_download;
    size_type total_upload;

    size_type total_payload_download;
    size_type total_payload_upload;

    int num_peers;

    %mutable;
  };

}
