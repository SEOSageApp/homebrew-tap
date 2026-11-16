cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.141.165"
  sha256 arm:   "5f2fe49aedad1404ebf2afd83a49e9b6cd6147a5f9179b9839724cb766e18711",
         intel: "0471e9059d946db9acfbe05ed2aaefda3f9efbe4fcf4383da8e4c73e6b1ec7f3"

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
