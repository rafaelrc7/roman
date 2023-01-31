{ pkgs ? import <nixpkgs> { }, ... }:
pkgs.mkShell {
  packages = with pkgs; [
    bison
    flex

    gcc

    gdb
    valgrind
  ];
}

