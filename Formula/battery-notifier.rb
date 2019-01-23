class BatteryNotifier < Formula
  desc "battery-notifier is a MacOS daemon that keeps track of the battery charging status and notifies the user when the battery is sufficiently charged (80\%-90\%)."
  homepage "https://github.com/LucaAngioloni/battery-notifier"
  url "https://github.com/LucaAngioloni/battery-notifier/archive/0.2.tar.gz"
  sha256 "3c56279b588b385ddc5ec1f8daff75f437c4e06a853afcb65b664a4989ac683e"
  
  depends_on "terminal-notifier"

  keg_only "because it is not needed"

  def install
    # bin.install "battery-notifier"
  end

  def caveats
    "Use brew services to start and stop the daemon"
  end

  test do
    # Nothing to test.
    system "true"
  end

  plist_options :startup => true

  def plist; <<-EOS.undent
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
            <string>#{prefix}/battery-notifier</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>StartInterval</key>
        <integer>30</integer>
    </dict>
    </plist>
    EOS
  end
end
