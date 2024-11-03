{ pkgs, ... }:

{
  # extraPlugins = with pkgs.vimPlugins; [
  #   avante-nvim
  # ];
  # extraConfigLuaPre = ''
  #   require('avante_lib').load()
  #   require('avante').setup {
  #     provider = "remote-ollama",
  #     auto_suggestions_provider = "remote-ollama",
  #     vendors = {
  #       ["remote-ollama"] = {
  #         ["local"] = true,
  #         endpoint = "eepc:11434/v1",
  #         model = "llama3.2",
  #         parse_curl_args = function(opts, code_opts)
  #            return {
  #              url = opts.endpoint .. "/chat/completions",
  #              headers = {
  #                ["Accept"] = "application/json",
  #                ["Content-Type"] = "application/json",
  #              },
  #              body = {
  #                model = opts.model,
  #                messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
  #                max_tokens = 2048,
  #                stream = true,
  #              },
  #            }
  #          end,
  #          parse_response_data = function(data_stream, event_state, opts)
  #            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
  #          end,
  #       }
  #     },
  #   }
  # '';
}
