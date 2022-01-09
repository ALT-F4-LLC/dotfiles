local function init()
  local map = vim.api.nvim_set_keymap

  local options = { noremap = true }

  vim.api.nvim_exec([[
    autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
  ]], false)

  -- Keymaps
  map('n', '<leader>fm', '<CMD>CodeActionMenu<CR>', options)
end

return {
  init = init
}
