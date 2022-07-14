class DriveLimiter < Formula
  desc "drive_limiter is a formula that limits the amount of CPU used by Backup and Sync by Google Drive."
  homepage "https://github.com/LucaAngioloni/drive_limiter"
  url "https://github.com/LucaAngioloni/drive_limiter/archive/v0.5.1.tar.gz"
  sha256 "6929aff234eb6d37e8bffc52e300a3be1824581f65cbb05bd71e222788e60d5d"
  
  depends_on "cpulimit"

  keg_only "for this deamon there is no point in linking the script. It doesn't make sense to call it from the terminal once."

  def install
    prefix.install "drive_limiter.sh"
    # prefix.install_metafiles
    system "chmod", "+x", "#{prefix}/drive_limiter.sh"
    # system "ln", "#{prefix}/drive_limiter.sh", "/usr/local/bin/drive_limiter"
  end

  def caveats
    "Use brew services to start and stop the daemon: \nbrew services start drive_limiter"
  end

  test do
    # Nothing to test.
    system "true"
  end

  plist_options :startup => true

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
            <string>sh</string>
            <string>-c</string>
            <string>#{prefix}/drive_limiter.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <false/>
        <key>LaunchOnlyOnce</key>        
        <true/>
    </dict>
    </plist>
    EOS
  end
  
end
