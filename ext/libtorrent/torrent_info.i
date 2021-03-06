%{
#include <sstream>
#include "libtorrent/torrent_info.hpp"
%}

namespace libtorrent {

  struct file_entry
  {
    boost::filesystem::path path;
    size_type offset;
    size_type size;
  };

  struct file_slice
  {
    int file_index;
    size_type offset;
    size_type size;
  };

  struct announce_entry
  {
    announce_entry(std::string const& u);
    std::string url;
    int tier;
  };

  class torrent_info
  {
  public:

    torrent_info();
    torrent_info(sha1_hash const& info_hash);
    torrent_info(entry const& torrent_file);
    ~torrent_info();

    entry create_torrent() const;
    entry create_info_metadata() const;

    const std::string& comment() const;
    %rename("comment=") set_comment(char const* str);
    void set_comment(char const* str);

    const std::string& creator() const;
    %rename("creator=") set_creator(char const* str);
    void set_creator(char const* str);

    %rename("piece_size=") set_piece_size(int size);
    void set_piece_size(int size);

    void set_hash(int index, sha1_hash const& h);

    void add_tracker(std::string const& url, int tier = 0);
    void add_file(boost::filesystem::path file, size_type size);
    void add_url_seed(std::string const& url);
    boost::optional<boost::posix_time::ptime> creation_date() const;

    std::vector<file_slice> map_block(int piece, size_type offset, int size) const;
    peer_request map_file(int file, size_type offset, int size) const;

    %typemap(out) std::vector<std::string> const& url_seeds() {
      VALUE array = rb_ary_new();
      for (std::vector<std::string>::const_iterator i = $1->begin();
           i != $1->end(); ++i) {
        rb_ary_push(array, rb_str_new2(i->c_str()));
      }
      $result = array;
    }

    std::vector<std::string> const& url_seeds() const;

    const file_entry& file_at(int index) const;

    %typemap(out) const std::vector<announce_entry>& trackers() {
      VALUE array = rb_ary_new();
      for (std::vector<libtorrent::announce_entry>::const_iterator i = $1->begin();
           i != $1->end(); ++i) {
        libtorrent::announce_entry* p = new libtorrent::announce_entry(*i);
        VALUE obj = SWIG_NewPointerObj(SWIG_as_voidptr(p), SWIGTYPE_p_libtorrent__announce_entry, SWIG_POINTER_OWN);
        if (obj != Qnil) rb_ary_push(array, obj);
      }
      return array;
    }

    const std::vector<announce_entry>& trackers() const;

    size_type total_size() const;
    size_type piece_length() const;
    int num_files() const;
    int num_pieces() const;
    const sha1_hash& info_hash() const;
    const std::string& name() const;

    %rename("valid?") is_valid() const;
    bool is_valid() const;

    void convert_file_names();
    size_type piece_size(int index) const;
    const sha1_hash& hash_for_piece(int index) const;
    void parse_info_section(entry const& e);

    %extend {
      void add_file(const std::string& file_name) {
        boost::filesystem::path p(file_name);
        self->add_file(p, boost::filesystem::file_size(p));
      }

      VALUE files() const {
        VALUE array = rb_ary_new();
        for (libtorrent::torrent_info::file_iterator i = self->begin_files();
             i != self->end_files(); ++i)
        {
          VALUE obj = SWIG_NewPointerObj(SWIG_as_voidptr(&(*i)), SWIGTYPE_p_libtorrent__file_entry, 0);
          if (obj != Qnil) rb_ary_push(array, obj);
        }
        return array;
      }

      static libtorrent::torrent_info load(const char* path) const {
        return libtorrent::torrent_info(load_entry(path));
      }

      static libtorrent::torrent_info load_bytes(const std::string bytes) const {
        std::istringstream in(bytes);
        return libtorrent::torrent_info(load_entry(in));
      }

      void save(const char* path) const {
        libtorrent::entry e = self->create_torrent();
        save_entry(e, path);
      }
    }
  };
}
