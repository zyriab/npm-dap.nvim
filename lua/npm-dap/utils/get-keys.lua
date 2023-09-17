local M = {}

M.is_table_empty = function(table)
    return next(table) == nil
end

return M
