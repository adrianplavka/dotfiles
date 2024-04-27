return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })

      opts.presets.lsp_doc_border = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }

      opts.resize = {
        enable = false,
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Prev Buffer" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Next Buffer" },
    },
  },
  {
    "Bekaboo/deadcolumn.nvim",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local lualine = require("lualine")

      local colors = {
        blue = "#92b3f5",
        cyan = "#7dcfff",
        green = "#addaa2",
        red = "#ff5189",
        white = "#c6c6c6",
        grey = "#333345",
        black = "#000001",
      }

      local function show_macro_recording()
        local recording_register = vim.fn.reg_recording()
        if recording_register == "" then
          return ""
        else
          return "Recording @" .. recording_register
        end
      end

      vim.api.nvim_create_autocmd("RecordingEnter", {
        callback = function()
          lualine.refresh({
            place = { "statusline" },
          })
        end,
      })

      vim.api.nvim_create_autocmd("RecordingLeave", {
        callback = function()
          -- This is going to seem really weird!
          -- Instead of just calling refresh we need to wait a moment because of the nature of
          -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
          -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
          -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
          -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
          local timer = vim.loop.new_timer()
          timer:start(
            50,
            0,
            vim.schedule_wrap(function()
              lualine.refresh({
                place = { "statusline" },
              })
            end)
          )
        end,
      })

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.blue },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white, bg = colors.black },
          y = { fg = colors.white, bg = colors.black },
        },

        command = {
          a = { fg = colors.black, bg = colors.blue },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white, bg = colors.black },
          y = { fg = colors.white, bg = colors.black },
        },

        insert = { a = { fg = colors.black, bg = colors.green }, y = { fg = colors.white, bg = colors.black } },
        visual = { a = { fg = colors.black, bg = colors.cyan }, y = { fg = colors.white, bg = colors.black } },
        replace = { a = { fg = colors.black, bg = colors.red }, y = { fg = colors.white, bg = colors.black } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.white },
          y = { fg = colors.white, bg = colors.black },
        },
      }

      opts.options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      }

      opts.sections = {
        lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
        lualine_b = { "branch" },
        lualine_c = {
          "filename",
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { left = "", right = "" }, left_padding = 2 },
        },
      }

      opts.inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      }

      opts.tabline = {}
      opts.extensions = {}
    end,
  },
}
