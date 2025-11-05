{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    quick-scope
  ];
}
