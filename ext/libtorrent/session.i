%{
#include "libtorrent/session.hpp"
#include <typeinfo>
%}

namespace libtorrent {

  class session
  {
  public:

    session(fingerprint const& print = fingerprint("LT", 0, 10, 0, 0));
    session(
      fingerprint const& print
      , std::pair<int, int> listen_port_range
      , char const* listen_interface = "0.0.0.0");

    ~session();

    torrent_handle add_torrent(
      torrent_info const& ti
      , boost::filesystem::path const& save_path
      , entry const& resume_data = entry()
      , bool compact_mode = true
      , int block_size = 16 * 1024);

    torrent_handle add_torrent(
      char const* tracker_url
      , sha1_hash const& info_hash
      , boost::filesystem::path const& save_path
      , entry const& resume_data = entry()
      , bool compact_mode = true
      , int block_size = 16 * 1024);

    void remove_torrent(const torrent_handle& h);

    session_status status() const;

    void enable_extension(extension_index i);
    void disable_extensions();

    %rename("ip_filter=") set_ip_filter(ip_filter const& f);
    void set_ip_filter(ip_filter const& f);
    %rename("peer_id=") set_peer_id(peer_id const& pid);
    void set_peer_id(peer_id const& pid);
    %rename("key=") set_key(int key);
    void set_key(int key);

    %rename("listening?") is_listening() const;
    bool is_listening() const;
    unsigned short listen_port() const;

    session_settings const& settings();
    %rename("settings=") set_settings(session_settings const& s);
    void set_settings(session_settings const& s);
    %rename("upload_rate_limit=") set_upload_rate_limit(int bytes_per_second);
    void set_upload_rate_limit(int bytes_per_second);
    %rename("download_rate_limit=") set_download_rate_limit(int bytes_per_second);
    void set_download_rate_limit(int bytes_per_second);
    %rename("max_uploads=") set_max_uploads(int limit);
    void set_max_uploads(int limit);
    %rename("max_connections=") set_max_connections(int limit);
    void set_max_connections(int limit);
    %rename("max_half_open_connections=") set_max_half_open_connections(int limit);
    void set_max_half_open_connections(int limit);
    %rename("severity_level=") set_severity_level(alert::severity_t s);
    void set_severity_level(alert::severity_t s);

    %extend {
      bool listen_on(int port) {
        return self->listen_on(std::make_pair(port, port));
      }

      bool listen_on(int low_port, int high_port) {
        return self->listen_on(std::make_pair(low_port, high_port));
      }

      libtorrent::torrent_handle add_torrent(const libtorrent::torrent_info& ti, std::string save_path) {
        return self->add_torrent(ti, save_path);
      }

      VALUE torrents() {
        VALUE array = rb_ary_new();
        std::vector<libtorrent::torrent_handle> tv = self->get_torrents();
        for (std::vector<libtorrent::torrent_handle>::const_iterator i = tv.begin();
             i != tv.end(); ++i) {
          libtorrent::torrent_handle*p = new libtorrent::torrent_handle(*i);
          VALUE obj = SWIG_NewPointerObj(SWIG_as_voidptr(p), SWIGTYPE_p_libtorrent__torrent_handle, SWIG_POINTER_OWN);
          if (obj != Qnil) rb_ary_push(array, obj);
        }
        return array;
      }

      VALUE alerts() {
        VALUE array = rb_ary_new();
        libtorrent::alert* p; 

        while ((p = self->pop_alert().release())) {
          swig_type_info* swig_type = NULL;

          if (dynamic_cast<libtorrent::chat_message_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__chat_message_alert;
          } else if (dynamic_cast<libtorrent::fastresume_rejected_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__fastresume_rejected_alert;
          } else if (dynamic_cast<libtorrent::file_error_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__file_error_alert;
          } else if (dynamic_cast<libtorrent::hash_failed_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__hash_failed_alert;
          } else if (dynamic_cast<libtorrent::invalid_request_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__invalid_request_alert;
          } else if (dynamic_cast<libtorrent::listen_failed_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__listen_failed_alert;
          } else if (dynamic_cast<libtorrent::metadata_failed_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__metadata_failed_alert;
          } else if (dynamic_cast<libtorrent::metadata_received_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__metadata_received_alert;
          } else if (dynamic_cast<libtorrent::peer_ban_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__peer_ban_alert;
          } else if (dynamic_cast<libtorrent::peer_error_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__peer_error_alert;
          } else if (dynamic_cast<libtorrent::torrent_finished_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__torrent_finished_alert;
          } else if (dynamic_cast<libtorrent::tracker_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__tracker_alert;
          } else if (dynamic_cast<libtorrent::tracker_announce_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__tracker_announce_alert;
          } else if (dynamic_cast<libtorrent::tracker_reply_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__tracker_reply_alert;
          } else if (dynamic_cast<libtorrent::tracker_warning_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__tracker_warning_alert;
          } else if (dynamic_cast<libtorrent::url_seed_alert*>(p)) {
            swig_type = SWIGTYPE_p_libtorrent__url_seed_alert;
          }

          if (swig_type) {
            VALUE obj = SWIG_NewPointerObj(SWIG_as_voidptr(p), swig_type, SWIG_POINTER_OWN);
            if (obj != Qnil) rb_ary_push(array, obj);
          }
        }

        return array;
      }
    }
  };

}
