class Gel < Formula
  desc "Modern gem manager"
  homepage "https://gel.dev"
  url "https://github.com/gel-rb/gel/archive/v0.2.0.tar.gz"
  sha256 "7d69f745986c9c33272f080496aea53719d69d4f465993c740f432ef5f0a3bd3"

  bottle do
    cellar :any_skip_relocation
    sha256 "ca4a4081014f2baab6285c44e1fddd6975cb33f22f76bddbc5eaa4a3a1956867" => :mojave
    sha256 "ca4a4081014f2baab6285c44e1fddd6975cb33f22f76bddbc5eaa4a3a1956867" => :high_sierra
    sha256 "628fbe3459425b7c30690ce3c4e2f5cadd39e2726833e866c54ef4fdb25f30b3" => :sierra
  end

  def install
    ENV["PATH"] = "bin:#{ENV["HOME"]}/.local/gel/bin:#{ENV["PATH"]}"
    system "gel", "install"
    system "rake", "man"
    bin.install "exe/gel"
    prefix.install "lib"
    man1.install Pathname.glob("man/man1/*.1")
  end

  test do
    (testpath/"Gemfile").write <<~EOS
      source "https://rubygems.org"
      gem "gel"
    EOS
    system "#{bin}/gel", "install"
  end
end
