return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    {
      "<leader>fP",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          cwd = require("lazy.core.config").options.root,
        })
      end,
      desc = "Find Plugin File",
    },
    {
      ";f",
      function()
        local builtin = require("telescope.builtin")
        builtin.find_files({
          no_ignore = false,
          hidden = true,
        })
      end,
    },
    {
      ";r",
      function()
        local builtin = require("telescope.builtin")
        builtin.live_grep()
      end,
    },
    {
      ";b",
      function()
        local builtin = require("telescope.builtin")
        builtin.buffers()
      end,
    },
    {
      ";t",
      function()
        local builtin = require("telescope.builtin")
        builtin.help_tags()
      end,
    },
    {
      ";;",
      function()
        local builtin = require("telescope.builtin")
        builtin.resume()
      end,
    },
    {
      ";e",
      function()
        local builtin = require("telescope.builtin")
        builtin.diagnostics()
      end,
    },
    {
      ";s",
      function()
        local builtin = require("telescope.builtin")
        builtin.treesitter()
      end,
    },
    {
      ";y",
      function()
        vim.cmd("Telescope neoclip")
      end,
    },
    {
      "sf",
      function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          sorting_strategy = "ascending",
          layout_config = { height = 40 },
        })
      end,
    },
  },
  config = function(_, opts)
    opts.default = vim.tbl_deep_extend("force", opts.defaults, {
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        n = {},
      },
    })

    opts.pickers = {
      diagnostics = {
        theme = "ivy",
        initial_mode = "normal",
        layout_config = {
          preview_cutoff = 9999,
        },
      },
    }
  end,
}
