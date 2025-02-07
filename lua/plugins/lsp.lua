local get_icon = require("utils").get_icon

-- Function to run when neovim connects to a Lsp client
local on_attach = function(client, buffer_number)
  if client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end

  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
  vim.keymap.set(
    "n",
    "<leader>la",
    vim.lsp.buf.code_action,
    { desc = "LSP: [C]ode [A]ction", buffer = buffer_number }
  )

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

  vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Hover diagnostics", buffer = buffer_number })

  -- Telescope LSP keybinds --
  vim.keymap.set(
    "n",
    "gr",
    require("telescope.builtin").lsp_references,
    { desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
  )

  vim.keymap.set(
    "n",
    "gI",
    require("telescope.builtin").lsp_implementations,
    { desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
  )

  vim.keymap.set(
    "n",
    "<leader>ls",
    require("telescope.builtin").lsp_document_symbols,
    { desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
  )

  vim.keymap.set(
    "n",
    "<leader>lS",
    require("telescope.builtin").lsp_workspace_symbols,
    { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
  )

  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number })

  -- See `:help K` for why this keymap
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
  vim.keymap.set(
    "n",
    "<leader>lk",
    vim.lsp.buf.signature_help,
    { desc = "LSP: Signature Documentation", buffer = buffer_number }
  )
  vim.keymap.set(
    "i",
    "<C-k>",
    vim.lsp.buf.signature_help,
    { desc = "LSP: Signature Documentation", buffer = buffer_number }
  )

  -- Lesser used LSP functionality
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
  vim.keymap.set(
    "n",
    "td",
    vim.lsp.buf.type_definition,
    { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number }
  )
end

function capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())
end

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost" },
    cmd = { "LspInfo", "LspInstall", "LspUninstall" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "saghen/blink.cmp",
      "j-hui/fidget.nvim",
    },
    config = function()
      -- Default handlers for LSP
      local default_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      local servers = {
        -- LSP Servers
        cssls = {},
        html = {},
        -- eslint = {},
        jsonls = {},
        angularls = {},
        astro = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  "${3rd}/luv/library",
                  "${3rd}/love2d/library",
                  -- unpack(vim.api.nvim_get_runtime_file("", true)),
                },
              },
              telemetry = { enabled = false },
            },
          },
        },
        marksman = {},
        -- nil_ls = {},
        sqlls = {},
        -- tailwindcss = {},
        ts_ls = {
          settings = {
            maxTsServerMemory = 12000,
            -- implicitProjectConfiguration = {
            --   checkJs = true,
            -- },
          },
        },
        eslint = {
          experimental = {
            useFlatConfig = true,
          },
        },
        yamlls = {},
      }

      local formatters = {
        prettierd = {},
        stylua = {},
      }

      local linters = {
        eslint_d = {},
      }

      local ensure_installed = vim.tbl_keys(vim.tbl_deep_extend("force", {}, servers, formatters, linters))

      require("mason-tool-installer").setup({
        auto_update = true,
        run_on_start = true,
        start_delay = 3000,
        debounce_hours = 12,
        -- ensure_installed = ensure_installed,
      })

      -- Iterate over our servers and set them up
      for name, config in pairs(servers) do
        require("lspconfig")[name].setup({
          capabilities = capabilities(),
          filetypes = config.filetypes,
          handlers = vim.tbl_deep_extend("force", {}, default_handlers, config.handlers or {}),
          on_attach = on_attach,
          settings = config.settings,
        })
      end

      require("mason-lspconfig").setup()

      -- Configure borderd for LspInfo ui
      require("lspconfig.ui.windows").default_options.border = "rounded"

      local signs = {
        {
          name = "DiagnosticSignError",
          text = get_icon("DiagnosticError"),
          texthl = "DiagnosticSignError",
        },
        {
          name = "DiagnosticSignWarn",
          text = get_icon("DiagnosticWarn"),
          texthl = "DiagnosticSignWarn",
        },
        {
          name = "DiagnosticSignHint",
          text = get_icon("DiagnosticHint"),
          texthl = "DiagnosticSignHint",
        },
        {
          name = "DiagnosticSignInfo",
          text = get_icon("DiagnosticInfo"),
          texthl = "DiagnosticSignInfo",
        },
        { name = "DapStopped",    text = get_icon("DapStopped"),    texthl = "DiagnosticWarn" },
        { name = "DapBreakpoint", text = get_icon("DapBreakpoint"), texthl = "DiagnosticInfo" },
        {
          name = "DapBreakpointRejected",
          text = get_icon("DapBreakpointRejected"),
          texthl = "DiagnosticError",
        },
        {
          name = "DapBreakpointCondition",
          text = get_icon("DapBreakpointCondition"),
          texthl = "DiagnosticInfo",
        },
        { name = "DapLogPoint", text = get_icon("DapLogPoint"), texthl = "DiagnosticInfo" },
      }

      for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, sign)
      end

      local config = {
        virtual_text = true,
        signs = {
          active = signs, -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      vim.diagnostic.config(config)

      -- Configure diagnostics border
      vim.diagnostic.config({
        float = {
          border = "rounded",
        },
      })
    end,
  },
  {
    "onsails/lspkind.nvim",
    lazy = true,
    opts = {
      mode = "symbol",
      symbol_map = {
        Array = "󰅪",
        Boolean = "⊨",
        Class = "󰌗",
        Constructor = "",
        Key = "󰌆",
        Namespace = "󰅪",
        Null = "NULL",
        Number = "#",
        Object = "󰀚",
        Package = "󰏗",
        Property = "",
        Reference = "",
        Snippet = "",
        String = "󰀬",
        TypeParameter = "󰊄",
        Unit = "",
      },
      menu = {},
    },
    enabled = vim.g.icons_enabled,
    config = function()
      require("lspkind").init()
    end,
  },
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities(),
        },
      })
    end,
  },
}
