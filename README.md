# Utils.nvim

Useful utility functions to setup and manage NeoVim's environment with ease.

## Installation

**lazy.nvim**

```lua
return {
  "snuffish/utils.nvim",
}
```

## Configuration

```lua

return {
  "snuffish/utils.nvim",
  config = function()
    -- To get `vim.tools.[...]`
    require("utils").setup("tools")
  end
}
```

## Usage

```lua
-- WIP

vim.utils.map(modes, maps, action, opts?)
vim.utils.remove_map(modes, maps)

vim.utils.trigger_keys(keys)
vim.utils.trigger_keys_fn(keys)

vim.utils.get_current_bufnr()
vim.utils.get_all_buffers()
vim.utils.get_all_buffers_content()
```
