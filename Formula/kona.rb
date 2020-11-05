class Kona < Formula
  desc "Open-source implementation of the K programming language"
  homepage "https://github.com/kevinlawler/kona"
  url "https://github.com/kevinlawler/kona/archive/Win64-20201009.tar.gz"
  sha256 "ec00734f36e966dd8b16e3752bee963a85b9ad415a4f1b200ae7ca28a3ad4d37"
  license "ISC"
  head "https://github.com/kevinlawler/kona.git"

  livecheck do
    url "https://github.com/kevinlawler/kona/releases/latest"
    regex(%r{href=.*?/tag/(?:Win(?:64)?[._-])?v?(\d+(?:\.\d+)*)[^"' >]*["' >]}i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "0b6a2f66ebbbaa1f13c31e8e08d0c3d9d98e1dbc91d83d6c0c7afba82dfec16f" => :catalina
    sha256 "831a58ea078f331d73ae872436bfdc1cfa7936ec116e88684ae78268c1532ef7" => :mojave
    sha256 "df2344d823528bcdb6068f591a52b6fc9f4ba9b4367ca72c44101f7acd5fac84" => :high_sierra
  end

  def install
    system "make"
    bin.install "k"
  end

  test do
    assert_match "Hello, world!", pipe_output("#{bin}/k", '`0: "Hello, world!"')
  end
end
