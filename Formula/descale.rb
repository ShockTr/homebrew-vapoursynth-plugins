class Descale < Formula
  homepage "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-descale"
  url "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-descale/archive/refs/tags/r11.tar.gz"
  sha256 "18a13aee0a644d26b1d31bba5497a696a95c8ae23ffd739a42e049e67a963dec"
  head "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-descale.git", branch: "master"
  license "MIT"

  depends_on "vapoursynth"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  

  def install
    # Upstream build system wants to install directly into vapoursynth's libdir and does not respect
    # prefix, but we want it in a Cellar location instead.
    inreplace "meson.build",
              "join_paths(vs.get_variable(pkgconfig: 'libdir'), 'vapoursynth')",
              "'#{lib}/vapoursynth'"

    system "meson", "setup", "build", *std_meson_args, "-Dlibtype=vapoursynth"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

end
