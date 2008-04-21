%{
#include "libtorrent/alert.hpp"
#include "libtorrent/alert_types.hpp"
%}

namespace libtorrent {

  class peer_id;
  class peer_request;
  class torrent_handle;

  %nodefaultctor alert;
  class alert
  {
  public:

    %rename("DEBUG") debug;
    %rename("INFO") info;
    %rename("WARNING") warning;
    %rename("CRITICAL") critical;
    %rename("FATAL") fatal;
    %rename("NONE") none;
    enum severity_t { debug, info, warning, critical, fatal, none };

    boost::posix_time::ptime timestamp() const;
    %rename("message") msg() const;
    const std::string& msg() const;
    severity_t severity() const;
  };

  struct tracker_alert: alert
  {
    tracker_alert(torrent_handle const& h
      , int times
      , int status
      , std::string const& msg)
      : alert(alert::warning, msg)
      , handle(h)
      , times_in_row(times)
      , status_code(status);

    torrent_handle handle;
    int times_in_row;
    int status_code;
  };

  struct tracker_warning_alert: alert
  {
    tracker_warning_alert(torrent_handle const& h
      , std::string const& msg)
      : alert(alert::warning, msg)
      , handle(h);

    torrent_handle handle;
  };

  struct tracker_reply_alert: alert
  {
    tracker_reply_alert(torrent_handle const& h
      , std::string const& msg)
      : alert(alert::info, msg)
      , handle(h);

    torrent_handle handle;
  };

  struct tracker_announce_alert: alert
  {
    tracker_announce_alert(torrent_handle const& h, std::string const& msg)
      : alert(alert::info, msg)
      , handle(h);
    
    torrent_handle handle;
  };
  
  struct hash_failed_alert: alert
  {
    hash_failed_alert(
      torrent_handle const& h
      , int index
      , std::string const& msg)
      : alert(alert::info, msg)
      , handle(h)
      , piece_index(index);

    torrent_handle handle;
    int piece_index;
  };

  struct peer_ban_alert: alert
  {
    peer_ban_alert(tcp::endpoint const& pip, torrent_handle h, std::string const& msg)
      : alert(alert::info, msg)
      , ip(pip)
      , handle(h);

    tcp::endpoint ip;
    torrent_handle handle;
  };

  struct peer_error_alert: alert
  {
    peer_error_alert(tcp::endpoint const& pip, peer_id const& pid_, std::string const& msg)
      : alert(alert::debug, msg)
      , ip(pip)
      , pid(pid_);

    tcp::endpoint ip;
    peer_id pid;
  };

  struct chat_message_alert: alert
  {
    chat_message_alert(
      const torrent_handle& h
      , const tcp::endpoint& sender
      , const std::string& msg)
      : alert(alert::critical, msg)
      , handle(h)
      , ip(sender);

    torrent_handle handle;
    tcp::endpoint ip;
  };

  struct invalid_request_alert: alert
  {
    invalid_request_alert(
      peer_request const& r
      , torrent_handle const& h
      , tcp::endpoint const& sender
      , peer_id const& pid_
      , std::string const& msg)
      : alert(alert::debug, msg)
      , handle(h)
      , ip(sender)
      , request(r)
      , pid(pid_);

    torrent_handle handle;
    tcp::endpoint ip;
    peer_request request;
    peer_id pid;
  };

  struct torrent_finished_alert: alert
  {
    torrent_finished_alert(
      const torrent_handle& h
      , const std::string& msg)
      : alert(alert::warning, msg)
      , handle(h);

    torrent_handle handle;
  };

  struct url_seed_alert: alert
  {
    url_seed_alert(
      const std::string& url_
      , const std::string& msg)
      : alert(alert::warning, msg)
      , url(url_);

    std::string url;
  };

  struct file_error_alert: alert
  {
    file_error_alert(
      const torrent_handle& h
      , const std::string& msg)
      : alert(alert::fatal, msg)
      , handle(h);

    torrent_handle handle;
  };

  struct metadata_failed_alert: alert
  {
    metadata_failed_alert(
      const torrent_handle& h
      , const std::string& msg)
      : alert(alert::info, msg)
      , handle(h);

    torrent_handle handle;
  };
  
  struct metadata_received_alert: alert
  {
    metadata_received_alert(
      const torrent_handle& h
      , const std::string& msg)
      : alert(alert::info, msg)
      , handle(h);

    torrent_handle handle;
  };

  struct listen_failed_alert: alert
  {
    listen_failed_alert(
      const std::string& msg)
      : alert(alert::fatal, msg);
  };

  struct fastresume_rejected_alert: alert
  {
    fastresume_rejected_alert(torrent_handle const& h
      , std::string const& msg)
      : alert(alert::warning, msg)
      , handle(h);

    torrent_handle handle;
  };

}
