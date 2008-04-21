%{
#include "libtorrent/storage.hpp"
%}

namespace libtorrent {

  class storage
  {
  public:

    storage(const torrent_info& info, const boost::filesystem::path& path);

    void swap(storage&);
    size_type read(char* buf, int slot, int offset, int size);
    void write(const char* buf, int slot, int offset, int size);
    bool move_storage(boost::filesystem::path save_path);
    void release_files();
  };

}
