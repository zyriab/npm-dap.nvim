local table_utils = require("npm-dap.utils.table")
local is_table_empty = table_utils.is_table_empty
local get_keys = table_utils.get_keys

return function()
    local path = vim.fs.find("package.json", { type = "file" })

    if is_table_empty(path) then
        return {}
    end

    local contents = vim.fn.join(vim.fn.readfile(path[1]), "")
    local parsed_contents = vim.json.decode(contents)

    if parsed_contents == nil or parsed_contents.scripts == nil then
        return {}
    end

    return get_keys(parsed_contents.scripts)
end
