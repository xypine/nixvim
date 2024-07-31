{ pkgs, ... }:

{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "markdown.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "MeanderingProgrammer";
        repo = "markdown.nvim";
        rev = "35f8bd24809e21219c66e2a58f1b9f5d547cc2c3";
        hash = "sha256-LJ+QzAZejj6E0lwlq1vlo9Y4sCzPVWfWojPwj584f1U=";
      };
    })
  ];
}
