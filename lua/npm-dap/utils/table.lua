local M = {}


M.is_table_empty = function(t)
    return next(t) == nil
end

M.get_keys = function(t)
    local keys = {}

    for k in pairs(t) do
        keys[#keys + 1] = k
    end

    return keys
end

M.table_contains = function(t, value)
    for i = 1, #t do
        if (t[i] == value) then
            return true
        end
    end

    return false
end

M.get_index = function(t, value)
    local index = {}

    for k, v in pairs(t) do
        index[v] = k
    end

    return index[value]
end

return M
