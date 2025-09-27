return {
  "nvim-neotest/neotest",
  event = "VeryLazy",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "alfaix/neotest-gtest",
    "nvim-neotest/neotest-go",
  },
  opts = function(_, opts)
    opts.adapters = {
      require("neotest-gtest").setup({}),
      require("neotest-go")({
        go_test_args = {
          "-v",
          "-count=1",
          "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
        },
      }),
    }
  end,
  config = function(_, opts)
    print("Setting up neotest")
    require("neotest").setup(opts)
  end,
}
