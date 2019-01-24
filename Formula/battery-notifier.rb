class BatteryNotifier < Formula
  desc "battery-notifier is a MacOS daemon that keeps track of the battery charging status and notifies the user when the battery is sufficiently charged (80\%-90\%)."
  homepage "https://github.com/LucaAngioloni/battery-notifier"
  url "https://github.com/LucaAngioloni/battery-notifier/archive/0.2.tar.gz"
  sha256 "3c56279b588b385ddc5ec1f8daff75f437c4e06a853afcb65b664a4989ac683e"
  
  depends_on "terminal-notifier"

  keg_only "for this deamon there is no point in linking the script. It doesn't make sense to call it from the terminal once."

  def install
    prefix.install "battery-notifier.sh"
    prefix.install "battery.png"
    # prefix.install_metafiles
    system "chmod", "+x", "#{prefix}/battery-notifier.sh"
    # system "ln", "#{prefix}/battery-notifier.sh", "/usr/local/bin/battery-notifier"
    # system "ln", "#{prefix}/battery.png", "/usr/local/bin/battery.png"
  end

  def caveats
    "Use brew services to start and stop the daemon: \nbrew services start battery-notifier\n\nDon't use sudo, even if homebrew suggests you to do it. There is no need."
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
            <string>#{prefix}/battery-notifier.sh</string>
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
