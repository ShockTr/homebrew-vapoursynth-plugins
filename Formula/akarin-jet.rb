class AkarinJet < Formula
  homepage "https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin"
  url "https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0d05de93c2bfbf6acf3f6b3e477e005c2f00f816d4d9c5a41d46fec4c6132b33"
  license "LGPL-3.0-or-later"
  head "https://github.com/Jaded-Encoding-Thaumaturgy/akarin-vapoursynth-plugin.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "llvm@20" => :build

  def install
    # Upstream build system wants to install directly into vapoursynth's libdir and does not respect
    # prefix, but we want it in a Cellar location instead.
    inreplace "meson.build",
              "install_dir: join_paths(vapoursynth_dep.get_pkgconfig_variable('libdir'), 'vapoursynth')",
              "install_dir: '#{lib}/vapoursynth'"

    system "meson", "setup", "build"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

end
