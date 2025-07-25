class VapoursynthFftspectrumRs < Formula
  homepage "https://github.com/sgt0/vapoursynth-fftspectrum-rs"
  url "https://github.com/sgt0/vapoursynth-fftspectrum-rs.git",
    tag: "v1.0.8",
    revision: "6bae4f30dcdb51f7252773f62a9a1bbefac7d266"
  license "MIT"
  head "https://github.com/sgt0/vapoursynth-fftspectrum-rs.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "rust" => :build

  def install
    ENV.append "RUSTFLAGS", "-C target-cpu=native"
    system "cargo", "build", "--release"
    
    mkdir lib/"vapoursynth" unless (lib/"vapoursynth").exist?
    (lib/"vapoursynth").install "target/release/#{shared_library("libfftspectrum_rs")}"
  end

end
