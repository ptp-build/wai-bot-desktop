cask "waibot" do
  version "1.0.23"
  arch = Hardware::CPU.arch.to_s
  sha256s = {
    "x86_64" => "474c6024ac1100512c242449da8d93b521334d0d03a9457c42446293a64eaff4",
    "aarch64" => "998d15813194957de140a530605252fdf3f68fafdba1353706fa00d070c7c23d"
  }
  if arch == "arm64" then arch = "aarch64" end
  url "https://github.com/ptp-build/wai-bot-desktop/releases/download/v#{version}/WaiBot_#{version}_macos_#{arch}.dmg"
  sha256 sha256s[arch]

  name "WaiBot"
  desc "Desktop wrapper for OpenAI WaiBot"
  homepage "https://github.com/ptp-build/wai-bot-desktop#readme"

  app "WaiBot.app"

  uninstall quit: "chat.wai.bot.desktop"

  zap trash: [
    "~/.chatgpt",
    "~/Library/Caches/chat.wai.bot.desktop",
    "~/Library/HTTPStorages/chat.wai.bot.desktop.binarycookies",
    "~/Library/Preferences/chat.wai.bot.desktop.plist",
    "~/Library/Saved Application State/chat.wai.bot.desktop.savedState",
    "~/Library/WebKit/chat.wai.bot.desktop",
  ]
end
