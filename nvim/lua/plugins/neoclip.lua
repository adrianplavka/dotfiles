return {
  {
    "kkharji/sqlite.lua",
    module = "sqlite",
  },
  {
    "AckslD/nvim-neoclip.lua",
    opts = function(_, opts)
      opts.history = 100
      opts.enable_persistent_history = true
      opts.continuous_sync = true
    end,
  },
}
