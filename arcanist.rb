class Arcanist < Formula
  homepage 'http://phabricator.org/'
  url 'https://github.com/facebook/arcanist/archive/master.tar.gz'
  version '0.1'

  depends_on 'libphutil'

  head 'https://github.com/facebook/arcanist.git'

  def install
    # Get the location of libphutil so you can link arcanist to them
    var = `/usr/local/bin/brew --prefix libphutil`.strip

    # Create the path where arcanist will look for libphutil
    mkdir_p 'externals/includes'

    # Link arcanist to libphutil
    cd "externals/includes" do
      File.symlink(var, "libphutil")
    end

    # Remove Windows scripts - BOOM!
    rm_rf Dir['bin/*.bat']

    prefix.install Dir['*']
  end

  test do
    system "true"
  end
end
