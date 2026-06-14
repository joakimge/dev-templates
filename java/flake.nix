{
  description = "Java dev shell for java 25, with jdtls 1.57";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAll = f: nixpkgs.lib.genAttrs systems (system: f system);

      overlay = final: prev: {
        jdt-language-server =
          (prev.jdt-language-server.override { jdk = prev.jdk25; }).overrideAttrs
            (_old: {
              version = "1.57.0";
              src = prev.fetchurl {
                url = "https://download.eclipse.org/jdtls/milestones/1.57.0/jdt-language-server-1.57.0-202602261110.tar.gz";
                hash = "sha256-9/+pP+G7vqldrBPdl83NJcWC1uVttnJY2g3M6yMCYB4=";
              };
            });
      };
    in
    {
      devShells = forAll (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              jdt-language-server
              openjdk25
              maven
              vscode-extensions.vscjava.vscode-java-debug
              vscode-extensions.vscjava.vscode-java-test
            ];
            shellHook = ''
              export JAVA_DEBUG_PATH="${pkgs.vscode-extensions.vscjava.vscode-java-debug}"
              export JAVA_TEST_PATH="${pkgs.vscode-extensions.vscjava.vscode-java-test}"
            '';
          };
        }
      );
    };
}
