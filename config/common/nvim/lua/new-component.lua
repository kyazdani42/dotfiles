local Tools = {}

local patterns = {
  tsx = [[import { React } from 'react';

  interface Props {
  }

  export const C: React.FC<Props> = () => {
  return (
  <div></div>
  )
  };
  ]],
  jsx = [[import { React } from 'react';

  export const C = () => {
  return (
  <div></div>
  )
  }
  ]]
}

function Tools.NewComponent()
  local ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), 'ft')
  if ft == "javascript" or ft == "javascriptreact" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(patterns.jsx, '\n'))
  elseif ft == "typescriptreact" then
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(patterns.tsx, '\n'))
  else
    return
  end
  vim.cmd"Format"
end

vim.cmd "command! -nargs=0 NewComponent :lua require'new-component'.NewComponent()<CR>"

return Tools
