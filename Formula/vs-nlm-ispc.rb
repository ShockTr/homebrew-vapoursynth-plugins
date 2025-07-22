class VsNlmIspc < Formula
  homepage "https://github.com/AmusementClub/vs-nlm-ispc"
  url "https://github.com/AmusementClub/vs-nlm-ispc.git",
  tag: "v2",
  revision: "06547b7cfff8d3052312b6ce6264885683907ed1"

  license "GPL-3.0"
  head "https://github.com/AmusementClub/vs-nlm-ispc.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "ispc" => :build
  depends_on "llvm@20" => :build

  def install

    if Hardware::CPU.physical_cpu_arm64?
      args = %w[
      -DCMAKE_ISPC_INSTRUCTION_SETS="neon-i32x4"
      -DCMAKE_ISPC_FLAGS="--opt=fast-math"
      ]
    else
      args = %w[
      -DCMAKE_ISPC_INSTRUCTION_SETS="sse2-i32x4;avx1-i32x4;avx2-i32x8"
      -DCMAKE_ISPC_FLAGS="--opt=fast-math"
      ]
    end

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, *args
    system "cmake", "--build", "build"
    mkdir lib/"vapoursynth" unless (lib/"vapoursynth").exist?
    (lib/"vapoursynth").install "build/#{shared_library("libvsnlm_ispc").to_s}"
  end

end
