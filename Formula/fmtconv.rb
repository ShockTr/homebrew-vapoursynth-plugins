=begin
BSD 2-Clause License

Copyright (c) 2023, XiNGRZ

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
=end

class Fmtconv < Formula
  desc "Format conversion tools for Vapoursynth and Avisynth+"
  homepage "https://github.com/EleonoreMizo/fmtconv"
  url "https://gitlab.com/EleonoreMizo/fmtconv/-/archive/r30/fmtconv-r30.tar.gz"
  sha256 "96afa0bd073addd2982263c7cee8b750050cf01bc57671a77a20532f7482a488"
  license "WTFPL"
  head "https://github.com/EleonoreMizo/fmtconv.git", branch: "master"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "vapoursynth"

  def install
    chdir "build/unix" do
      system "./autogen.sh"
      system "./configure", *std_configure_args
      system "make"
      (lib/"vapoursynth").install ".libs/#{shared_library("libfmtconv")}"
    end
  end

  test do
    python = Formula["vapoursynth"].deps
                                   .find { |d| d.name.match?(/^python@\d\.\d+$/) }
                                   .to_formula
                                   .opt_libexec/"bin/python"
    system python, "-c", "from vapoursynth import core; core.fmtc"
  end
end