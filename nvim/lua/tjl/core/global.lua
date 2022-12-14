_G.safe_require = function(module)
  local ok, result = pcall(require, module)
  if not ok then
    vim.notify(string.format('Error requiring: %s', module), vim.log.levels.ERROR)
    return ok
  end
  return result
end

_G.tjl_require = function(module)
  return safe_require('tjl/' .. module)
end
