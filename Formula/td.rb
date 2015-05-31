require "language/go"

class Td < Formula
  desc "Your todo list in your terminal"
  homepage "https://github.com/Swatto/td"
  url "https://github.com/Swatto/td/archive/1.2.0.tar.gz"
  sha256 "86a84cb183e2b3700a23cc5570b65ea8d133e51c5c59e321929ace727253d55b"

  depends_on "go" => :build

  go_resource "github.com/codegangsta/cli" do
    url "https://github.com/codegangsta/cli.git",
        :revision => "bf4a526f48af7badd25d2cb02d587e1b01be3b50"
  end

  go_resource "github.com/daviddengcn/go-colortext" do
    url "https://github.com/daviddengcn/go-colortext.git",
        :revision => "13eaeb896f5985a1ab74ddea58707a73d875ba57"
  end

  def install
    ENV["GOBIN"] = bin
    ENV["GOPATH"] = buildpath
    ENV["GOHOME"] = buildpath

    mkdir_p buildpath/"src/github.com/Swatto/"
    ln_sf buildpath, buildpath/"src/github.com/Swatto/td"
    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "build", "."
    bin.install "td-#{version}" => "td"
  end

  test do
    (testpath/".todos").write "[]"

    system "#{bin}/td", "a", "todo of test"
    todos = (testpath/".todos").read
    assert todos.include? "todo of test"
    assert todos.include? "pending"
  end
end
