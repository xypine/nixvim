{
  plugins.web-devicons.enable = true;
  plugins.colorizer.enable = true;
  plugins.barbecue = {
    enable = true;
    settings.show_basename = false;
  };
  plugins.lualine = {
    enable = true;
    settings = {
      tabline = {
        lualine_a = [
          "buffers"
        ];
        lualine_z = [
          "tabs"
        ];
      };
    };
  };
}
