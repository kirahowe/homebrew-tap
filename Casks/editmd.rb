cask "editmd" do
  version "0.1.0"
  sha256 "6a011a012eb959751a71b1fe2ca2cce1e03d15751630f62bfd020a69cbf5b7be"

  url "https://github.com/kirahowe/editmd/releases/download/v#{version}/editmd-#{version}.zip"
  name "editmd"
  desc "WYSIWYG markdown editor that saves plain markdown"
  homepage "https://kirahowe.github.io/editmd/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "editmd.app"

  # Signed ad hoc rather than with a Developer ID, so Gatekeeper would refuse
  # to open the downloaded app.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/editmd.app"],
        writable_paths: ["editmd.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Caches/com.kirahowe.editmd",
    "~/Library/Preferences/com.kirahowe.editmd.plist",
    "~/Library/Saved Application State/com.kirahowe.editmd.savedState",
    "~/Library/WebKit/com.kirahowe.editmd",
  ]
end
