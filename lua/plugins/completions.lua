return {
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },
  {
    "windwp/nvim-ts-autotag",
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  {
    "xzbdmw/colorful-menu.nvim",
  },
  {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    lazy = false,
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          auto_show = function(ctx)
            return ctx.mode ~= "cmdline"
          end,
          border = "single",
          draw = {
            columns = { { "provider" }, { "kind_icon" }, { "label", gap = 1 }, { "kind" } },
            components = {
              label = {
                width = { fill = true, max = 110 },
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
              provider = {
                text = function(ctx)
                  return "[" .. ctx.item.source_name:sub(1, 3):upper() .. "]"
                end,
                highlight = "BlinkCmpGhostText",
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = "single" },
        },
        ghost_text = { enabled = false },
      },
      keymap = {
        preset = "default",
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<CR>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        -- ["<Tab>"] = {
        --   function(cmp)
        --     if cmp.snippet_active() then
        --       return cmp.accept()
        --     else
        --       return cmp.select_and_accept()
        --     end
        --   end,
        --   "snippet_forward",
        --   "fallback",
        -- },
      },
      signature = { window = { border = "single" } },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
          Array = " ",
          Boolean = "󰨙 ",
          Class = " ",
          Codeium = "󰘦 ",
          Color = " ",
          Control = " ",
          Collapsed = " ",
          Constant = "󰏿 ",
          Constructor = " ",
          Copilot = " ",
          Enum = " ",
          EnumMember = " ",
          Event = " ",
          Field = " ",
          File = " ",
          Folder = " ",
          Function = "󰊕 ",
          Interface = " ",
          Key = " ",
          Keyword = " ",
          Method = "󰊕 ",
          Module = " ",
          Namespace = "󰦮 ",
          Null = " ",
          Number = "󰎠 ",
          Object = " ",
          Operator = " ",
          Package = " ",
          Property = " ",
          Reference = " ",
          Snippet = "󱄽 ",
          String = " ",
          Struct = "󰆼 ",
          Supermaven = " ",
          TabNine = "󰏚 ",
          Text = " ",
          TypeParameter = " ",
          Unit = " ",
          Value = " ",
          Variable = "󰀫 ",
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.default",
    },
    config = function(_, opts)
      -- ia complete keymap
      vim.keymap.set("i", "<A-Tab>", 'codeium#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
    end,
  },
  -- {
  -- 	"hrsh7th/cmp-nvim-lsp",
  -- },
  -- {
  -- 	"L3MON4D3/LuaSnip",
  -- 	dependencies = {
  -- 		"saadparwaiz1/cmp_luasnip",
  -- 		"rafamadriz/friendly-snippets",
  -- 	},
  -- },
  -- {
  -- 	"hrsh7th/nvim-cmp",
  -- 	dependencies = {
  -- 		"saadparwaiz1/cmp_luasnip",
  -- 		"hrsh7th/cmp-buffer",
  -- 		"hrsh7th/cmp-path",
  -- 		"hrsh7th/cmp-nvim-lsp",
  -- 		"hrsh7th/cmp-copilot",
  -- 		"windwp/nvim-ts-autotag",
  -- 		"windwp/nvim-autopairs",
  -- 	},
  -- 	config = function()
  -- 		local cmp = require("cmp")
  -- 		local lspkind = require("lspkind")
  -- 		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  --
  -- 		require("nvim-autopairs").setup()
  --
  -- 		-- Integrate nvim-autopairs with cmp
  -- 		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  --
  -- 		-- Load snippets
  -- 		require("luasnip.loaders.from_vscode").lazy_load()
  -- 		local border_opts = {
  -- 			border = "rounded",
  -- 			winhighlight = "Normal:Pmenu,FloatBorder:None,CursorLine:PmenuSel,Search:None",
  -- 			col_offset = -3,
  -- 			side_padding = 0,
  -- 		}
  --
  -- 		-- copilot keymap
  -- 		vim.keymap.set("i", "<A-Tab>", 'copilot#Accept("\\<CR>")', {
  -- 			expr = true,
  -- 			replace_keycodes = false,
  -- 		})
  --
  -- 		cmp.setup({
  -- 			formatting = {
  -- 				expandable_indicator = true,
  -- 				fields = { "kind", "abbr", "menu" },
  -- 				format = function(entry, vim_item)
  -- 					local kind = lspkind.cmp_format({
  -- 						mode = "symbol_text",
  -- 						maxwidth = 50,
  -- 						ellipsis_char = "...",
  -- 						symbol_map = {
  -- 							Copilot = "",
  -- 						},
  -- 					})(entry, vim_item)
  -- 					local strings = vim.split(kind.kind, "%s", { trimempty = true })
  -- 					kind.kind = " " .. (strings[1] or "") .. " "
  -- 					kind.menu = "    (" .. (strings[2] or "") .. ")"
  --
  -- 					return kind
  -- 				end,
  -- 			},
  -- 			experimental = {
  -- 				ghost_text = true,
  -- 			},
  -- 			snippet = {
  -- 				expand = function(args)
  -- 					require("luasnip").lsp_expand(args.body)
  -- 				end,
  -- 			},
  -- 			duplicates = {
  -- 				nvim_lsp = 1,
  -- 				luasnip = 1,
  -- 				cmp_tabnine = 1,
  -- 				buffer = 1,
  -- 				path = 1,
  -- 			},
  -- 			confirm_opts = {
  -- 				behavior = cmp.ConfirmBehavior.Replace,
  -- 				select = false,
  -- 			},
  -- 			window = {
  -- 				completion = cmp.config.window.bordered(border_opts),
  -- 				documentation = cmp.config.window.bordered(border_opts),
  -- 			},
  -- 			completion = {
  -- 				completeopt = "menu,menuone",
  -- 			},
  -- 			mapping = {
  -- 				["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  -- 				["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  -- 				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  -- 				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  -- 				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
  -- 				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
  -- 				["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
  -- 				["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
  -- 				["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
  -- 				["<C-y>"] = cmp.config.disable,
  -- 				["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
  -- 				["<CR>"] = cmp.mapping.confirm({ select = false }),
  -- 				["<Tab>"] = cmp.mapping.confirm({ select = false }),
  -- 				-- ["<Tab>"] = cmp.mapping(function(fallback)
  -- 				--   if cmp.visible() then
  -- 				--     cmp.select_next_item()
  -- 				--   elseif luasnip.expand_or_jumpable() then
  -- 				--     luasnip.expand_or_jump()
  -- 				--   else
  -- 				--     fallback()
  -- 				--   end
  -- 				-- end, { "i", "s" }),
  -- 				-- ["<S-Tab>"] = cmp.mapping(function(fallback)
  -- 				--   if cmp.visible() then
  -- 				--     cmp.select_prev_item()
  -- 				--   elseif luasnip.jumpable(-1) then
  -- 				--     luasnip.jump(-1)
  -- 				--   else
  -- 				--     fallback()
  -- 				--   end
  -- 				-- end, { "i", "s" }),
  -- 			},
  -- 			sources = cmp.config.sources({
  -- 				{ name = "copilot", priority = 1000 },
  -- 				{ name = "nvim_lsp", priority = 750 },
  -- 				{ name = "buffer", priority = 500, max_item_count = 5 },
  -- 				{ name = "luasnip", priority = 250 },
  -- 				{ name = "path", priority = 100 },
  -- 			}),
  -- 		})
  -- 	end,
  -- },
}
