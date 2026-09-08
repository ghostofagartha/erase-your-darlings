{ inputs, ... }:

{
  programs.lazyvim = {
    enable = true;

    extras = {
      lang.nix.enable = true;
    };

    config = {
      options = ''
        -- Nix manages the plugins, so lazy.nvim should not
        -- check for plugin updates at runtime.
        require("lazy.core.config").options.checker.enabled = false
      '';
    };

    plugins = {
      colorscheme = ''
        return {
          "catppuccin/nvim",
          name = "catppuccin",
          lazy = false,
          priority = 1000,

          opts = {
            flavour = "mocha",
            transparent_background = true,
            term_colors = true,

            integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
            },
          },

          config = function(_, opts)
            require("catppuccin").setup(opts)

            vim.api.nvim_create_autocmd("ColorScheme", {
              pattern = "catppuccin",
              callback = function()
                vim.api.nvim_set_hl(0, "Normal", {
                  bg = "none",
                })

                vim.api.nvim_set_hl(0, "NormalNC", {
                  bg = "none",
                })

                vim.api.nvim_set_hl(0, "NormalFloat", {
                  bg = "none",
                })

                vim.api.nvim_set_hl(0, "FloatBorder", {
                  bg = "none",
                })

                vim.api.nvim_set_hl(0, "SignColumn", {
                  bg = "none",
                })

                vim.api.nvim_set_hl(0, "LineNr", {
                  bg = "none",
                })
              end,
            })

            vim.cmd.colorscheme("catppuccin")
          end,
        }
      '';
    };
  };
}
