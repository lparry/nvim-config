_G.__KeymapStore = _G.__KeymapStore or {}
local K = {}

---Keymap factory
---@param mode string
---@param defaults table
local make_mapper = function(mode, defaults)
  ---@param lhs string
  ---@param rhs string|function
  ---@param opts? table
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("keep", defaults, opts or {})
    local buffer = opts.buffer
    opts.buffer = nil

    rhs = K(buffer or 0, mode):make_rhs(rhs, opts)
    if rhs then
      if buffer then
        vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
      else
        vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
      end
    end
  end
end

local M = {
  nmap = make_mapper("n", { noremap = false }),
  nnoremap = make_mapper("n", { noremap = true }),

  imap = make_mapper("i", { noremap = false }),
  inoremap = make_mapper("i", { noremap = true }),

  vmap = make_mapper("v", { noremap = false }),
  vnoremap = make_mapper("v", { noremap = true }),

  tmap = make_mapper("t", { noremap = false }),
  tnoremap = make_mapper("t", { noremap = true }),

  smap = make_mapper("s", { noremap = false }),
  snoremap = make_mapper("s", { noremap = true }),

  xmap = make_mapper("x", { noremap = false }),
  xnoremap = make_mapper("x", { noremap = true }),

  omap = make_mapper("o", { noremap = false }),
  onoremap = make_mapper("o", { noremap = true }),

  lmap = make_mapper("l", { noremap = false }),
  lnoremap = make_mapper("l", { noremap = true }),

  cmap = make_mapper("c", { noremap = false }),
  cnoremap = make_mapper("c", { noremap = true }),

  termcodes = function(key)
    return vim.api.nvim_replace_termcodes(key, true, true, true)
  end,
}

return setmetatable(K, {
  __index = function(_, key)
    return function(...)
      return M[key](...)
    end
  end,
  __call = function(_, buffer, mode)
    buffer = tostring(buffer)
    __KeymapStore[buffer] = __KeymapStore[buffer] or {}
    __KeymapStore[buffer][mode] = __KeymapStore[buffer][mode] or {}

    local idx = vim.tbl_count(__KeymapStore[buffer][mode]) + 1

    return setmetatable({
      _insert = function(_, rhs)
        if rawget(__KeymapStore[buffer][mode], idx) then
          print(
            (
              "mapping for { mode = '%s', idx = '%s', buffer = %s\n } already exists!\n"
            ):format(mode, idx, buffer)
          )
          return false
        end
        return rawset(__KeymapStore[buffer][mode], idx, rhs) and true or false
      end,
      _lua_fn = function()
        return ([[<cmd>lua require("util.keymap")(%d, %q)[%d]()<cr>]]):format(
          buffer,
          mode,
          idx
        )
      end,
      _vim_expr = function()
        return (
          [[eval(luaeval('require("util.keymap").termcodes(require("util.keymap")(%d, %q)[%d]())'))]]
        ):format(buffer, mode, idx)
      end,

      make_rhs = function(self, rhs, opts)
        if self:_insert(rhs) then
          if type(rhs) == "function" then
            rhs = opts.expr and self._vim_expr() or self._lua_fn()
          end
          return rhs
        end
        return nil
      end,
    }, {
      __index = __KeymapStore[buffer][mode],
      __newindex = function(self, _, rhs)
        self:_insert(rhs)
      end,
    })
  end,
})
