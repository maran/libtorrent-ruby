require 'rubygems'
require 'rake/clean'
require 'rake/testtask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/rdoctask'

def announce(message = "")
  $stderr.puts message
end

PKG_NAME = "libtorrent-ruby"

if ENV['REL']
  PKG_VERSION = ENV['REL']
end

if ENV['SVNUSER']
  SVN_USER = "#{ENV['SVNUSER']}@"
end

PKG_FILES = FileList[
  "Rakefile", "README",
  "doc/*.css", "doc/*.html",
  "example/**/*",
  "ext/**/*",
  "test/**/*"
]

task :prerelease do
end

task :tag => [:prerelease] do
  tag = PKG_VERSION
  base_url = "svn+ssh://#{SVN_USER}rubyforge.org/var/svn/libtorrent-ruby"
  trunk_url = "#{base_url}/trunk"
  tag_url = "#{base_url}/tags/release-#{tag}"
  comment = "Tagging the #{tag} release." 
  announce "Tagging SVN with #{tag}"
  sh %{svn copy #{trunk_url} #{tag_url} -m "#{comment}"}
end

Rake::PackageTask.new("package") do |p|
  p.name = PKG_NAME
  p.version = PKG_VERSION
  p.need_tar_gz = true
  p.need_zip = true
  p.package_files = PKG_FILES
end
