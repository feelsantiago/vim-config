-- return {
--   lazy = false,
--   priority = 1000,
--   "nordtheme/vim",
--   config = function()
--     -- vim.g.nord_uniform_diff_background = 1
--     -- vim.cmd.colorscheme("nord")
--   end,
-- }
return {
  "scottmckendry/cyberdream.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("cyberdream").setup({
      transparent = true,
      italic_comments = true,
      hide_fillchars = true,
      terminal_colors = false,
      cache = true,
      borderless_telescope = false,
      theme = { variant = "auto" },
    })

    vim.cmd("colorscheme cyberdream")
  end,
}
-- return {
--   "shaunsingh/nord.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     -- Example config in lua
--     vim.g.nord_contrast = true
--     vim.g.nord_borders = true
--     vim.g.nord_disable_background = true
--     vim.g.nord_italic = false
--     vim.g.nord_uniform_diff_background = true
--     vim.g.nord_bold = true
--
--     -- Load the colorscheme
--     require("nord").set()
--   end,
-- }
