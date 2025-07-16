class Vsgenstubs4 < Formula
  include Language::Python::Virtualenv

  homepage "https://github.com/vapoursynth/vsrepo"
  license "MIT"
  head "https://github.com/vapoursynth/vsrepo.git", branch: "master"

  depends_on "vapoursynth"
  
  def install
    python = Formula["vapoursynth"].deps
                                   .find { |d| d.name.match?(/^python@\d\.\d+$/) }
                                   .to_formula
                                   .opt_libexec/"bin/python"
    # Create a virtualenv in `libexec`.
    venv = virtualenv_create(libexec, python)
    # Install all of the resources declared on the formula into the virtualenv.
    venv.pip_install resources
    # `pip_install_and_link` takes a look at the virtualenv's bin directory
    # before and after installing its argument. New scripts will be symlinked
    # into `bin`. `pip_install_and_link buildpath` will install the package
    # that the formula points to, because buildpath is the location where the
    # formula's tarball was unpacked.
    venv.pip_install_and_link buildpath
  end

end
