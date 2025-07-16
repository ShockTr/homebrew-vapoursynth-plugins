class Resize2 < Formula
  homepage "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2"
  url "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2/archive/refs/tags/0.3.3.tar.gz"
  sha256 "3ab38854f633c9d4b93946c4c2e79bc3e1cb9de924c86d59e7e7eb3f63613644"

  head "https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2.git", branch: "master"

  depends_on "vapoursynth"
  depends_on "meson" => :build
  depends_on "ninja" => :build
  

  def install
    # Upstream build system wants to install directly into vapoursynth's libdir and does not respect
    # prefix, but we want it in a Cellar location instead.
    inreplace "meson.build",
              "install_dir : join_paths(vapoursynth_dep.get_variable(pkgconfig: 'libdir'), 'vapoursynth')",
              "install_dir : '#{lib}/vapoursynth'"

    # https://github.com/Jaded-Encoding-Thaumaturgy/vapoursynth-resize2/issues/10
    if Hardware::CPU.physical_cpu_arm64?
      inreplace "subprojects/packagefiles/zimg/meson.build",
                "NEON_CFLAGS = ['-march=armv7-a', '-mfpu=neon-vfpv4']",
                "NEON_CFLAGS = []"
    end

    system "meson", "setup", "build"
    system "meson", "compile", "-C", "build"
    system "meson", "install", "-C", "build"
  end

end
