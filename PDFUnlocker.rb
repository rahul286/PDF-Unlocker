class Pdfunlocker < Formula
  include Language::Python::Shebang
  desc "A tool to unlock PDF files"
  homepage "https://github.com/rahul286/PDFUnlocker/"
  url "https://github.com/rahul286/pdf-unlock/archive/refs/heads/main.tar.gz"
  sha256 "cbeacdffcc4ab207f5192a05aa562a301e3b57e808ae8c8c9a4dfc18245694f2"
  version "1.0.0" # Add the correct version here  
  
  depends_on "python@3.12"

#   resource "cffi" do
#     url "https://files.pythonhosted.org/packages/68/ce/95b0bae7968c65473e1298efb042e10cafc7bafc14d9e4f154008241c91d/cffi-1.16.0.tar.gz"
#     sha256 "bcb3ef43e58665bbda2fb198698fcae6776483e0c4a631aa5647806c25e02cc0"
#   end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/93/a7/1498799a2ea06148463a9a2c10ab2f6a921a74fb19e231b27dc412a748e2/cryptography-42.0.8.tar.gz"
    sha256 "8d09d05439ce7baa8e9e95b07ec5b6c886f548deb7e0f69ef25f64b3bce842f2"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/1d/b2/31537cf4b1ca988837256c910a668b553fceb8f069bedc4b1c826024b52c/pycparser-2.22.tar.gz"
    sha256 "491c8be9c040f5390f5bf44a5b07752bd07f56edf992381b05c701439eec10f6"
  end

  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/dd/df/55a36cdbe4b4c9e0bfcf5d27f2073de76c56632c861d3ba3f4e906cc2ad1/pypdf-4.3.0.tar.gz"
    sha256 "0d7a4c67fd03782f5a09d3f48c11c7a31e0bb9af78861a25229bb49259ed0504"
  end
  
  def install
    bin.install "PDFUnlocker.py" => "PDFunlocker"
    rewrite_shebang detected_python_shebang, "PDFUnlocker"
    # system "pip3", "install", ".", "--prefix=#{prefix}"
  end

  def post_install
    touch ~/.config/pdfunlocker/passwords.txt
  end

  service do
    name macos: "com.rahul286.PDFUnlocker"
  end
#   test do
#     system "#{bin}/pdf.py", "--version"
#   end
end