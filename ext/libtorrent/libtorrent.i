%module libtorrent

%include "inttypes.i"
%include "std_string.i"
%include "std_vector.i"

%include "common.i"
%include "alert.i"
%include "path.i"
%include "ip_filter.i"
%include "entry.i"
%include "peer_id.i"
%include "peer_info.i"
%include "peer_request.i"
%include "fingerprint.i"
%include "torrent_info.i"
%include "hasher.i"
%include "storage.i"
%include "torrent_status.i"
%include "torrent_handle.i"
%include "session_settings.i"
%include "session_status.i"
%include "session.i"

%init %{
  boost::filesystem::path::default_name_check(boost::filesystem::no_check);
%}
