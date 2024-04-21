return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })

      -- Add VSCode-like icons & formatting
      local cmp_kinds = {
        Text = "  ",
        Method = "  ",
        Function = "  ",
        Constructor = "  ",
        Field = "  ",
        Variable = "  ",
        Class = "  ",
        Interface = "  ",
        Module = "  ",
        Property = "  ",
        Unit = "  ",
        Value = "  ",
        Enum = "  ",
        Keyword = "  ",
        Snippet = "  ",
        Color = "  ",
        File = "  ",
        Reference = "  ",
        Folder = "  ",
        EnumMember = "  ",
        Constant = "  ",
        Struct = "  ",
        Event = "  ",
        Operator = "  ",
        TypeParameter = "  ",
      }

      opts.formatting = {
        fields = { "kind", "abbr" },
        format = function(_, vim_item)
          vim_item.kind = cmp_kinds[vim_item.kind] or ""
          return vim_item
        end,
      }
    end,
  },
}
