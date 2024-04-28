return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "gopls",
        "luacheck",
        "selene",
        "shellcheck",
        "shfmt",
        "stylua",
        "tailwindcss-language-server",
        "typescript-language-server",
      })
    end,
  },
  {
    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "astro",
          "cmake",
          "cpp",
          "css",
          "fish",
          "gitignore",
          "go",
          "graphql",
          "http",
          "java",
          "php",
          "rust",
          "scss",
          "sql",
          "zig",
        },
      },
      config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)

        -- Add MDX configuration
        vim.filetype.add({
          extension = {
            mdx = "mdx",
          },
        })
        vim.treesitter.language.register("markdown", "mdx")
      end,
    },
  },
}
