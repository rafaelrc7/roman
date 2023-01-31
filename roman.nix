{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.stdenv.mkDerivation rec {
  pname = "roman";
  version = "1.0.0";

  src = ./.;

  buildInputs = with pkgs; [
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

