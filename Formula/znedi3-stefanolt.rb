class Znedi3Stefanolt < Formula
  # Upstream repo for znedi3 is yet to accept the PR for meson build system, I will use the PR's master until it merges.
  # This fork comes with a benefit of having sse2neon already included so I won't have to patch it in as well.
  homepage "https://github.com/Stefan-Olt/znedi3"
  url "https://github.com/Stefan-Olt/znedi3.git",
    revision: "3bd542a396371b1af404c8a51df144957419909c"
  license "GPL-2.0"
  head "https://github.com/Stefan-Olt/znedi3.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => :build

  def install
    system "meson", "setup", "build", *std_meson_args
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"

    cd lib do
      mkdir "vapoursynth"
      mv shared_library("libvsznedi3").to_s, "vapoursynth"
    end

    (lib/"vapoursynth").install "nnedi3_weights.bin"

  end

end
