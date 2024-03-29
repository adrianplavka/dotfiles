return {
  "lewis6991/gitsigns.nvim",
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      follow_files = true,
    },
    auto_attach = true,
    attach_to_untracked = false,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
      delay = 300,
      ignore_whitespace = false,
      virt_text_priority = 100,
    },
    current_line_blame_formatter = "<author>, <author_time:%d.%m.%Y> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
      -- Options passed to nvim_open_win
      border = "single",
      style = "minimal",
      relative = "cursor",
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  },
  keys = {
    {
      "<leader>hp",
      function()
        local gs = package.loaded.gitsigns
        gs.preview_hunk()
      end,
      desc = "Preview Git hunk",
    },
    {
      "<leader>hs",
      function()
        local gs = package.loaded.gitsigns
        gs.stage_hunk()
      end,
      desc = "Stage Git hunk",
    },
    {
      "<leader>hr",
      function()
        local gs = package.loaded.gitsigns
        gs.reset_hunk()
      end,
      desc = "Reset Git hunk",
    },
    {
      "<leader>hS",
      function()
        local gs = package.loaded.gitsigns
        gs.stage_buffer()
      end,
      desc = "Stage Git buffer",
    },
    {
      "<leader>hu",
      function()
        local gs = package.loaded.gitsigns
        gs.undo_stage_hunk()
      end,
      desc = "Undo Git hunk",
    },
    {
      "<leader>hR",
      function()
        local gs = package.loaded.gitsigns
        gs.reset_buffer()
      end,
      desc = "Reset Git buffer",
    },
    {
      "<leader>hb",
      function()
        local gs = package.loaded.gitsigns
        gs.blame_line({ full = true })
      end,
      desc = "Full blame Git line",
    },
    {
      "<leader>hd",
      function()
        local gs = package.loaded.gitsigns
        gs.diffthis()
      end,
      desc = "Diff Git file",
    },
    {
      "<leader>hD",
      function()
        local gs = package.loaded.gitsigns
        gs.diffthis("~")
      end,
      desc = "Diff Git HEAD~",
    },
  },
}
