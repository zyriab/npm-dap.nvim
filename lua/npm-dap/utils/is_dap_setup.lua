local dap = require("dap")
local is_table_empty = require("dap-npm.utils.table").is_table_empty

return function()
    return is_table_empty(dap.configurations) == false
end
