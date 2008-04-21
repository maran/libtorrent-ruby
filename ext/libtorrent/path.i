%{
#include "boost/filesystem/path.hpp"
%}

namespace boost
{
  namespace filesystem
  {

    class path
    {
    public:

      path();
      path(const std::string&);
      path(const char*);

      path& normalize();

      %rename("__str__") string() const;
      const std::string & string() const;

      std::string native_file_string() const;
      std::string native_directory_string() const;

      path root_path() const;
      std::string root_name() const;
      std::string root_directory() const;
      path relative_path() const;
      std::string leaf() const;
      path branch_path() const;

      %rename("empty?") empty() const;
      bool empty() const;

      %rename("complete?") is_complete() const;
      bool is_complete() const;

      %rename("has_root_path?") has_root_path() const;
      bool has_root_path() const;

      %rename("has_root_name?") has_root_name() const;
      bool has_root_name() const;

      %rename("has_root_directory?") has_root_directory() const;
      bool has_root_directory() const;

      %rename("has_relative_path?") has_relative_path() const;
      bool has_relative_path() const;

      %rename("has_leaf?") has_leaf() const;
      bool has_leaf() const;

      %rename("has_branch_path?") has_branch_path() const;
      bool has_branch_path() const;

      bool operator==(const path&) const;
    };

  }
}
