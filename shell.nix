{ nixpkgs ? import <nixpkgs> {} }:

let
  # Determine the platform
  isLinux = builtins.currentSystem == "x86_64-linux";
  isDarwin = builtins.currentSystem == "x86_64-darwin";

  # Define the common packages
  commonPackages = with nixpkgs; [
    pandoc
    imagemagick
    git
    gnumake
    # Fonts
    noto-fonts
    # TeX and XeLaTeX
    texlive.combined.scheme-full
  ];

  # Define the platform-specific packages
  platformPackages = if isDarwin then
    with nixpkgs; [
      libreoffice-bin
    ]
  else if isLinux then
    with nixpkgs; [
      libreoffice
    ]
  else
    throw "Unsupported platform";
  
in

# Create the shell environment
nixpkgs.mkShell {
  name = "vestnik-env";
  buildInputs = commonPackages ++ platformPackages;
}
