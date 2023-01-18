# Adoptium OpenJDK Java Mission Control
This repository provides a Nix packaged instance of Adoptium OpenJDK Java Mission Control

# How to
## Run package ad hoc
Run `nix run "github:SeineEloquenz/java-mission-control-nix"` inside a terminal
## Add to system configuration
Add the following input to your system configuration flake
```
java-mission-control = {
  url = "github:SeineEloquenz/java-mission-control-nix";
  inputs.nixpkgs.follows = "nixpkgs";
};
```
Use the package inside your configuration as `inputs.java-mission-control.packages.x86_64-linux.default`
