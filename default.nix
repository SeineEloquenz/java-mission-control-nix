{ stdenv
, makeDesktopItem
, lib
, fetchzip
, autoPatchelfHook
, makeWrapper
, jdk
, glibc
, webkitgtk
, gtk3
, ... }:

let

  desktopItem = makeDesktopItem {
    name = "OpenJDK Java Mission Control";
    exec = "java-mission-control";
    comment = "Java Profiling Client";
    desktopName = "Java Mission Control";
    categories = [ "Development" ];
    icon = ./src/share/icons/adoptium.png;
  };

  libraryPath = lib.makeLibraryPath [ webkitgtk glibc ];
  binPath = lib.makeBinPath [ jdk ];

in stdenv.mkDerivation rec {
  pname = "java-mission-control";
  version = "9.0.0";

  src = fetchzip {
    url = "https://github.com/adoptium/jmc-build/releases/download/${version}/org.openjdk.jmc-${version}-linux.gtk.x86_64.tar.gz";
    hash = "sha256-zGeKdykSBIXbwwbklpcY4k3EVUh2uJxCZ2lWJrtY6lM=";
    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -pv $out/bin $out/share/applications
    cp -r $src/JDK\ Mission\ Control/* $out
    chmod +x $out/jmc
    wrapProgram "$out/jmc" \
        --prefix LD_LIBRARY_PATH : "${libraryPath}" \
        --prefix PATH : "${binPath}" \
        --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}" \
        --prefix PATH ':' "${jdk}/bin"
    ln -s $out/jmc $out/bin/java-mission-control
    ln -s ${desktopItem}/share/applications $out/share/applications
  '';  

  meta = with lib; {
    description = "Java Flight Recorder and Profiler";
    homepage = "https://adoptium.net/jmc/";
    license = licenses.upl;
    platforms = platforms.linux;
  };
}
