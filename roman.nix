{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "roman";
  version = "1.1.0";

  src = ./.;

  nativeBuildInputs = with pkgs; [
    bison
    flex
    gnumake
    gcc
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv roman $out/bin
  '';
}

