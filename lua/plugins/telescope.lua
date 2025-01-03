local utils = require("utils")
local is_available = utils.is_available

return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      defaults = {
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-x>"] = actions.delete_buffer,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            q = actions.close,
            ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
        file_ignore_patterns = {
          "node_modules",
          "yarn.lock",
          ".git",
          ".sl",
          "_build",
          ".next",
        },
      },
    })
    -- Enable telescope extensions, if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    -- See `:help telescope.builtin`
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Find Select Telescope" })
    vim.keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find current Word" })
    vim.keymap.set("n", "<leader>fC", builtin.grep_string, { desc = "Find commands" })
    vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find by Grep" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
    vim.keymap.set("n", "<leader>fR", builtin.resume, { desc = "Find Resume" })
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Recent Files" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find existing buffers" })
    vim.keymap.set("n", "<leader>fm", builtin.man_pages, { desc = "Find man" })
    vim.keymap.set("n", "<leader>f<CR>", function()
      require("telescope.builtin").resume()
    end, { desc = "Resume previous search" })
    vim.keymap.set("n", "<leader>f'", function()
      require("telescope.builtin").marks()
    end, { desc = "Find marks" })
    vim.keymap.set("n", "<leader>fr", builtin.registers, { desc = "Find registers" })
    vim.keymap.set("n", "<leader>fF", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "Find all files" })
    vim.keymap.set("n", "<leader>fW", function()
      require("telescope.builtin").live_grep({
        additional_args = function(args)
          return vim.list_extend(args, { "--hidden", "--no-ignore" })
        end,
      })
    end, { desc = "Find words in all files" })
    vim.keymap.set("n", "<leader>ls", function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end, { desc = "Search symbols" })
    vim.keymap.set("n", "<leader>f'", function()
      require("telescope.builtin").marks()
    end, { desc = "Find marks" })

    if is_available("nvim-notify") then
      vim.keymap.set("n", "<leader>fn", function()
        require("telescope").extensions.notify.notify()
      end, { desc = "Find notifications" })
      vim.keymap.set("n", "<leader>uD", function()
        require("notify").dismiss({ pending = true, silent = true })
      end, { desc = "Dismiss notifications" })
    end

    vim.keymap.set("n", "<leader>f/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
      }))
    end, { desc = "Fuzzily search in current buffer" })

    -- Also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set("n", "<leader>fO", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "Find in Open Files" })

    -- Shortcut for searching your neovim configuration files
    vim.keymap.set("n", "<leader>fn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "Find Neovim files" })
  end,
}
