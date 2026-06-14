{
  description = "My devShell templates";

  outputs =
    { self }:
    {
      templates = {
        java = {
          path = ./java;
          description = "Java devShell (java25 + jdtls + maven) for Neovim";
        };

        c = {
          path = ./c;
          description = "C devShell with gcc, clang-tools and debugger";
        };

        go = {
          path = ./go;
          description = "Go devShell (go + gopls) for Neovim";
        };

        flutter = {
          path = ./flutter;
          description = "Flutter devShell (flutter 3.41.2) for Neovim";
        };

        zig = {
          path = ./zig;
          description = "Zig devShell";
        };

        ts = {
          path = ./ts;
        };

        default = self.templates.java;
      };
    };
}
