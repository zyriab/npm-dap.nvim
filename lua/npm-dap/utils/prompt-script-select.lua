local get_scripts = require("npm-dap.utils.get-scripts")
local config_manager = require("npm-dap.utils.config-manager")

return function()
    return coroutine.create(function(coro)
        vim.ui.select(
            get_scripts(),
            {
                prompt = "Select a script:",
                format_item = function(item)
                    return "npm run " .. item
                end
            },
            function(selection)
                if selection ~= nil then
                    config_manager.save_script(selection)
                end

                coroutine.resume(coro, selection)
            end)
        return true
    end
    )
end
