%{
#include "libtorrent/session_settings.hpp"
%}

namespace libtorrent {

  struct session_settings
  {
    session_settings();

    std::string proxy_ip;
    int proxy_port;
    std::string proxy_login;
    std::string proxy_password;
    std::string user_agent;

    int tracker_completion_timeout;
    int tracker_receive_timeout;
    int stop_tracker_timeout;
    int tracker_maximum_response_length;
    int piece_timeout;

    float request_queue_time;

    int sequenced_download_threshold;
    int max_allowed_in_request_queue;
    int max_out_request_queue;
    int whole_pieces_threshold;
    int peer_timeout;
    int urlseed_timeout;
  };

}
