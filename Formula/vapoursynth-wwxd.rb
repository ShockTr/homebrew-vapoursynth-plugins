class VapoursynthWwxd < Formula
  homepage "https://github.com/dubhater/vapoursynth-wwxd"
  url "https://github.com/dubhater/vapoursynth-wwxd.git",
      tag: "v1.0",
      revision: "a5870862fd85138b5e4822a076377b96592c9cd2"
  head "https://github.com/dubhater/vapoursynth-wwxd.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "pkg-config" => :build
  uses_from_macos "gcc" => :build

  def install
    system "gcc", "-o", shared_library("libwwxd"), "-fPIC",
           "-shared", "-O2", "-Wall", "-Wextra",
           "-Wno-unused-parameter", *`pkg-config --cflags vapoursynth`.strip.split,
           "src/wwxd.c", "src/detection.c"
    mkdir lib/"vapoursynth" unless (lib/"vapoursynth").exist?
    (lib/"vapoursynth").install shared_library("libwwxd").to_s
  end
end
