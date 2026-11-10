cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.141.126"
  sha256 arm:   "8a79a0b447e1f180b133ac49c93ac73a5d3f46ef2aee034c0b0f96707d690a39",
         intel: "4667bb13f9351b7c5e85bfe0cea7babea979ae96de6978d1ed4e5e1e6fcc3bbb"

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
