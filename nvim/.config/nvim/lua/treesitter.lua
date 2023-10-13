require "nvim-treesitter.configs".setup {
  ensure_installed = {
    "c",
    "lua",
    "nix",
    "zig",
    "bash",
    "fish",
    "java",
    "julia",
    "python",
    "scheme",
    "haskell",
    "clojure",
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["il"] = "@call.inner",
        ["al"] = "@call.outer",
        ["ic"] = "@class.inner",
        ["ac"] = "@class.outer",
        ["ik"] = "@comment.inner",
        ["ak"] = "@comment.outer",
        ["id"] = "@conditional.inner",
        ["ad"] = "@conditional.outer",
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["iu"] = "@loop.inner",
        ["au"] = "@loop.outer",
        ["im"] = "@parameter.inner",
        ["am"] = "@parameter.outer",
      },
    },
  },
}
