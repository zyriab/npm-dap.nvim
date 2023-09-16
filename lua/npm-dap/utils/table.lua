local M = {}


M.is_table_empty = function(table)
    return next(table) == nil
end

M.get_keys = function(table)
    local keys = {}

    for k in pairs(table) do
        keys[#keys + 1] = k
    end

    return keys
end

return M
