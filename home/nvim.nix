{ inputs, ... }:

{
  # LazyVim
  programs.lazyvim = {
    enable = true;
    extras = {
      lang.nix.enable = true;
    };
    plugins = {
      colorscheme = ''
        return {
          "catppuccin/nvim",
          name = "catppuccin",
          lazy = false,
          priority = 1000,
          opts = {
            flavour = "mocha", -- "transparent" is not a valid flavour
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
            -- Force transparency for UI elements that the plugin might miss
            vim.api.nvim_create_autocmd("ColorScheme", {
              pattern = "catppuccin",
              callback = function()
                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
                vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
                vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
                vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
              end,
            })
            vim.cmd.colorscheme("catppuccin")
          end,
        }
      '';
    };
  };
}
