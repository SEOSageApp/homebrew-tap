cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.141.132"
  sha256 arm:   "0d5e5a4a7e6df44e416c1508d62e8db590f30d221c7aa5e7eff9ef5d771cdf53",
         intel: "94907e2ef60d7b7e280d75e96cd9f9f6d8e37ab27a488de6d017b7758a16f2ad"

  url "https://seosage.co/downloads/SEOSage-#{version}-Mac-#{arch}.dmg"
  name "SEOSage"
  desc "Desktop SEO audit software"
  homepage "https://seosage.co/"

  livecheck do
    url "https://seosage.co/updates/latest.json"
    strategy :json do |json|
      json["version"]
    end
  end

  depends_on :macos

  app "SEOSage.app"

  # SEOSage is not Apple-notarised yet. Homebrew no longer skips the macOS
  # warning, so clear it here (same as the manual "xattr" step on the website).
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/SEOSage.app"], must_succeed: false
  end

  uninstall quit: "co.seosage.app"

  zap trash: [
    "~/Library/Preferences/co.seosage.app.plist",
    "~/Library/Saved Application State/co.seosage.app.savedState",
  ]
end
