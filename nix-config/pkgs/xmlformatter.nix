{
  python3Packages,
  fetchurl,
  versions,
}:
python3Packages.buildPythonPackage {
  pname = "xmlformatter";
  version = versions.xmlformatter.version;
  src = fetchurl {
    url = versions.xmlformatter.url;
    sha256 = versions.xmlformatter.sha;
  };

  meta = {
    homepage = "https://github.com/pamoller/xmlformatter";
    description = "Format and compress XML documents";
  };
}
