local M = {}

local stringToChars = function(modes)
  local arr = {}
  for c in modes:gmatch(".") do
    arr[#arr + 1] = c
  end

  return arr
end

--- Add new keymap bindings
---
---@param modes string|string[]
---@param maps string|string[]
---@param action string|function
---@param opts? vim.keymap.set.Opts
M.map = function(modes, maps, action, opts)
  modes = stringToChars(modes)

  if type(maps) == "string" then
    maps = { maps }
  end

  for _, mode in ipairs(modes) do
    for _, map in ipairs(maps) do
      vim.keymap.set(mode, map, action, opts)
    end
  end
end

--- Remove keymap bindings
---
---@param modes string|string[]
---@param maps string|string[]
M.remove_map = function(modes, maps)
  modes = stringToChars(modes)

  if type(maps) == "string" then
    maps = { maps }
  end

  for _, mode in ipairs(modes) do
    for _, map in ipairs(maps) do
      if vim.fn.maparg(map, mode) ~= "" then
        vim.keymap.del(mode, map)
      end
    end
  end
end

--- Simulate actual physical keypress-actions
---
---@param keys string
M.trigger_keys = function(keys)
  local api = vim.api
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), "m", true)
end

--- Simulate actual physical keypress-actions
--- also retruns an high-order function for keymap triggers
---
---@param keys string
---@return function
M.trigger_keys_fn = function(keys)
  return function()
    M.trigger_keys(keys)
  end
end

M.find_function_by_address = function(address)
  for _, keymap in ipairs(vim.api.nvim_get_keymap("n")) do
    if keymap.callback then
      local func = keymap.callback
      if tostring(func):find(address) then
        return func
      end
    end
  end
  return nil
end

--- Setup the util on a desired namespace for easy access
---
---@param namespace? string|'utils'
M.setup = function(namespace)
  namespace = namespace or "utils"
  vim[namespace] = M
end

M.get_current_bufnr = function()
  return vim.api.nvim_get_current_buf()
end

M.get_all_buffers = function()
  return vim.api.nvim_list_bufs()
end

M.get_all_buffers_content = function()
  local buffers = vim.api.nvim_list_bufs()
  local buffers_content = {}

  for _, buf in ipairs(buffers) do
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    table.insert(buffers_content, { buf = buf, content = lines })
  end

  return buffers_content
end

return M
