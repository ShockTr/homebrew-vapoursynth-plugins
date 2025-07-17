class Bestsource < Formula
  homepage "https://github.com/vapoursynth/bestsource"
  url "https://github.com/vapoursynth/bestsource.git", 
    tag: "R13", 
    revision: "83685eeec3eb4e5a60d3bd2b076755c9c87bf93e"
  license "MIT"
  head "https://github.com/vapoursynth/bestsource.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "ffmpeg"
  depends_on "xxhash"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  def install
    # Upstream build system wants to install directly into vapoursynth's libdir and does not respect
    # prefix, but we want it in a Cellar location instead.
    inreplace "meson.build",
              "install_dir: vapoursynth_dep.get_variable(pkgconfig: 'libdir') / 'vapoursynth'",
              "install_dir: '#{lib}/vapoursynth'"
    
    system "meson", "setup", "build"
    system "meson", "configure", "build", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

end
