return {
  {
    "ThePrimeagen/harpoon",
    lazy = true,
    config = function()
      local harpoon_ui = require("harpoon.ui")
      local harpoon_mark = require("harpoon.mark")

      -- Open harpoon ui
      vim.keymap.set("n", "<leader>ho", function()
        harpoon_ui.toggle_quick_menu()
      end, { desc = "Open harpoon" })

      -- Add current file to harpoon
      vim.keymap.set("n", "<leader>ha", function()
        harpoon_mark.add_file()
      end, { desc = "Add curretn file to harpoon" })

      -- Remove current file from harpoon
      vim.keymap.set("n", "<leader>hr", function()
        harpoon_mark.rm_file()
      end, { desc = "Remove current file from harpoon" })

      -- Remove all files from harpoon
      vim.keymap.set("n", "<leader>hc", function()
        harpoon_mark.clear_all()
      end, { desc = "Remove all files from harpoon" })

      -- Quickly jump to harpooned files
      vim.keymap.set("n", "<leader>1", function()
        harpoon_ui.nav_file(1)
      end, { desc = "Quick jump to harpoon 1" })

      vim.keymap.set("n", "<leader>2", function()
        harpoon_ui.nav_file(2)
      end, { desc = "Quick jump to harpoon 2" })

      vim.keymap.set("n", "<leader>3", function()
        harpoon_ui.nav_file(3)
      end, { desc = "Quick jump to harpoon 3" })

      vim.keymap.set("n", "<leader>4", function()
        harpoon_ui.nav_file(4)
      end, { desc = "Quick jump to harpoon 4" })

      vim.keymap.set("n", "<leader>5", function()
        harpoon_ui.nav_file(5)
      end, { desc = "Quick jump to harpoon 5" })
    end,
  },
}
