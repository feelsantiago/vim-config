local M = {}

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--
--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--
--- Serve a notification with a title of Vim
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, M.extend_tbl({ title = "Vim" }, opts))
  end)
end

local function bool2str(bool)
  return bool and "on" or "off"
end
local function ui_notify(silent, ...)
  return not silent and M.notify(...)
end

--- Toggle notifications for UI toggles
---@param silent? boolean if true then don't sent a notification
function M.toggle_ui_notifications(silent)
  vim.g.ui_notifications_enabled = not vim.g.ui_notifications_enabled
  ui_notify(silent, string.format("Notifications %s", bool2str(vim.g.ui_notifications_enabled)))
end

--- Toggle autopairs
---@param silent? boolean if true then don't sent a notification
function M.toggle_autopairs(silent)
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    if autopairs.state.disabled then
      autopairs.enable()
    else
      autopairs.disable()
    end
    vim.g.autopairs_enabled = autopairs.state.disabled
    ui_notify(silent, string.format("autopairs %s", bool2str(not autopairs.state.disabled)))
  else
    ui_notify(silent, "autopairs not available")
  end
end

--- Toggle background="dark"|"light"
---@param silent? boolean if true then don't sent a notification
function M.toggle_background(silent)
  vim.go.background = vim.go.background == "light" and "dark" or "light"
  ui_notify(silent, string.format("background=%s", vim.go.background))
end

--- Toggle cmp entrirely
---@param silent? boolean if true then don't sent a notification
function M.toggle_cmp(silent)
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  local ok, _ = pcall(require, "cmp")
  ui_notify(silent, ok and string.format("completion %s", bool2str(vim.g.cmp_enabled)) or "completion not available")
end

--- Toggle auto format
---@param silent? boolean if true then don't sent a notification
function M.toggle_autoformat(silent)
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  ui_notify(silent, string.format("Global autoformatting %s", bool2str(vim.g.autoformat_enabled)))
end

--- Toggle buffer local auto format
---@param bufnr? number the buffer to toggle syntax on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_autoformat(bufnr, silent)
  bufnr = bufnr or 0
  local old_val = vim.b[bufnr].autoformat_enabled
  if old_val == nil then
    old_val = vim.g.autoformat_enabled
  end
  vim.b[bufnr].autoformat_enabled = not old_val
  ui_notify(silent, string.format("Buffer autoformatting %s", bool2str(vim.b[bufnr].autoformat_enabled)))
end

--- Toggle buffer semantic token highlighting for all language servers that support it
---@param bufnr? number the buffer to toggle the clients on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_semantic_tokens(bufnr, silent)
  bufnr = bufnr or 0
  vim.b[bufnr].semantic_tokens_enabled = not vim.b[bufnr].semantic_tokens_enabled
  local toggled = false
  for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens[vim.b[bufnr].semantic_tokens_enabled and "start" or "stop"](bufnr, client.id)
      toggled = true
    end
  end
  ui_notify(
    not toggled or silent,
    string.format("Buffer lsp semantic highlighting %s", bool2str(vim.b[bufnr].semantic_tokens_enabled))
  )
end

--- Toggle buffer LSP inlay hints
---@param bufnr? number the buffer to toggle the clients on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_inlay_hints(bufnr, silent)
  bufnr = bufnr or 0
  vim.b[bufnr].inlay_hints_enabled = not vim.b[bufnr].inlay_hints_enabled
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(bufnr, vim.b[bufnr].inlay_hints_enabled)
    ui_notify(silent, string.format("Inlay hints %s", bool2str(vim.b[bufnr].inlay_hints_enabled)))
  end
end

--- Toggle codelens
---@param silent? boolean if true then don't sent a notification
function M.toggle_codelens(silent)
  vim.g.codelens_enabled = not vim.g.codelens_enabled
  if not vim.g.codelens_enabled then
    vim.lsp.codelens.clear()
  end
  ui_notify(silent, string.format("CodeLens %s", bool2str(vim.g.codelens_enabled)))
end

--- Toggle showtabline=2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_tabline(silent)
  vim.opt.showtabline = vim.opt.showtabline:get() == 0 and 2 or 0
  ui_notify(silent, string.format("tabline %s", bool2str(vim.opt.showtabline:get() == 2)))
end

--- Toggle conceal=2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_conceal(silent)
  vim.opt.conceallevel = vim.opt.conceallevel:get() == 0 and 2 or 0
  ui_notify(silent, string.format("conceal %s", bool2str(vim.opt.conceallevel:get() == 2)))
end

--- Toggle laststatus=3|2|0
---@param silent? boolean if true then don't sent a notification
function M.toggle_statusline(silent)
  local laststatus = vim.opt.laststatus:get()
  local status
  if laststatus == 0 then
    vim.opt.laststatus = 2
    status = "local"
  elseif laststatus == 2 then
    vim.opt.laststatus = 3
    status = "global"
  elseif laststatus == 3 then
    vim.opt.laststatus = 0
    status = "off"
  end
  ui_notify(silent, string.format("statusline %s", status))
end

--- Toggle signcolumn="auto"|"no"
---@param silent? boolean if true then don't sent a notification
function M.toggle_signcolumn(silent)
  if vim.wo.signcolumn == "no" then
    vim.wo.signcolumn = "yes"
  elseif vim.wo.signcolumn == "yes" then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  ui_notify(silent, string.format("signcolumn=%s", vim.wo.signcolumn))
end

--- Set the indent and tab related numbers
---@param silent? boolean if true then don't sent a notification
function M.set_indent(silent)
  local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
  if input_avail then
    local indent = tonumber(input)
    if not indent or indent == 0 then
      return
    end
    vim.bo.expandtab = (indent > 0) -- local to buffer
    indent = math.abs(indent)
    vim.bo.tabstop = indent       -- local to buffer
    vim.bo.softtabstop = indent   -- local to buffer
    vim.bo.shiftwidth = indent    -- local to buffer
    ui_notify(silent, string.format("indent=%d %s", indent, vim.bo.expandtab and "expandtab" or "noexpandtab"))
  end
end

--- Change the number display modes
---@param silent? boolean if true then don't sent a notification
function M.change_number(silent)
  local number = vim.wo.number                -- local to window
  local relativenumber = vim.wo.relativenumber -- local to window
  if not number and not relativenumber then
    vim.wo.number = true
  elseif number and not relativenumber then
    vim.wo.relativenumber = true
  elseif number and relativenumber then
    vim.wo.number = false
  else -- not number and relativenumber
    vim.wo.relativenumber = false
  end
  ui_notify(
    silent,
    string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber))
  )
end

--- Toggle spell
---@param silent? boolean if true then don't sent a notification
function M.toggle_spell(silent)
  vim.wo.spell = not vim.wo.spell -- local to window
  ui_notify(silent, string.format("spell %s", bool2str(vim.wo.spell)))
end

--- Toggle paste
---@param silent? boolean if true then don't sent a notification
function M.toggle_paste(silent)
  vim.opt.paste = not vim.opt.paste:get() -- local to window
  ui_notify(silent, string.format("paste %s", bool2str(vim.opt.paste:get())))
end

--- Toggle wrap
---@param silent? boolean if true then don't sent a notification
function M.toggle_wrap(silent)
  vim.wo.wrap = not vim.wo.wrap -- local to window
  ui_notify(silent, string.format("wrap %s", bool2str(vim.wo.wrap)))
end

--- Toggle syntax highlighting and treesitter
---@param bufnr? number the buffer to toggle syntax on
---@param silent? boolean if true then don't sent a notification
function M.toggle_buffer_syntax(bufnr, silent)
  bufnr = (bufnr and bufnr ~= 0) and bufnr or vim.api.nvim_win_get_buf(0)
  local ts_avail, parsers = pcall(require, "nvim-treesitter.parsers")
  if vim.bo[bufnr].syntax == "off" then
    if ts_avail and parsers.has_parser() then
      vim.treesitter.start(bufnr)
    end
    vim.bo[bufnr].syntax = "on"
    if not vim.b[bufnr].semantic_tokens_enabled then
      M.toggle_buffer_semantic_tokens(bufnr, true)
    end
  else
    if ts_avail and parsers.has_parser() then
      vim.treesitter.stop(bufnr)
    end
    vim.bo[bufnr].syntax = "off"
    if vim.b[bufnr].semantic_tokens_enabled then
      M.toggle_buffer_semantic_tokens(bufnr, true)
    end
  end
  ui_notify(silent, string.format("syntax %s", vim.bo[bufnr].syntax))
end

M.toggle_syntax = M.toggle_buffer_syntax

local last_active_foldcolumn
--- Toggle foldcolumn=0|1
---@param silent? boolean if true then don't sent a notification
function M.toggle_foldcolumn(silent)
  local curr_foldcolumn = vim.wo.foldcolumn
  if curr_foldcolumn ~= "0" then
    last_active_foldcolumn = curr_foldcolumn
  end
  vim.wo.foldcolumn = curr_foldcolumn == "0" and (last_active_foldcolumn or "1") or "0"
  ui_notify(silent, string.format("foldcolumn=%s", vim.wo.foldcolumn))
end

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@return string icon
function M.get_icon(kind, padding)
  local icons = require("icons.nerd_font")
  local icon = icons and icons[kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

return M
