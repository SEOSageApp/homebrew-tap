cask "seosage" do
  arch arm: "M-series", intel: "Intel"

  version "1.141.169"
  sha256 arm:   "8a0f886021e894de3d02d4b86e214d659565088de12bfa5b6890331c64bfb583",
         intel: "af85b933c55c9a0cb3c857f146e8571899ea1783e85027fa5cbaeca8c909ed6e"

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
