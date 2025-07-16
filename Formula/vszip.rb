class Vszip < Formula
  homepage "https://github.com/dnjulek/vapoursynth-zip"
  url "https://github.com/dnjulek/vapoursynth-zip/archive/refs/tags/R7.tar.gz"
  sha256 "30ae55a7bc82ce2348af7ed3702e3ace08b4e68be8eb5d2ae9850e5e8dc2926e"
  license "MIT"
  head "https://github.com/dnjulek/vapoursynth-zip.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "zig" => :build

  def install
    # Add headerpad linker flag to build.zig for macOS dylib compatibility
    inreplace "build.zig", "lib.linkLibC();", <<~EOS
      lib.linkLibC();
      lib.headerpad_max_install_names = true;
    EOS
    
    system "zig", "build", "-Doptimize=ReleaseFast", "--verbose"
    
    (lib/"vapoursynth").install "zig-out/lib/#{shared_library("libvszip")}"
  end

end
