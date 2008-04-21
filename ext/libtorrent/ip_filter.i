%{
#include "libtorrent/ip_filter.hpp"
%}

namespace libtorrent {

  class ip_filter
  {
  public:

    enum access_flags
    {
      blocked = 1
    };
       
    ip_filter();
    void add_rule(address first, address last, int flags);
    int access(address const& addr) const;

    /*struct ip_range
    {
      address first;
      address last;
      int flags;
    };
          
    std::vector<ip_range> export_filter() const;*/
  };

}
