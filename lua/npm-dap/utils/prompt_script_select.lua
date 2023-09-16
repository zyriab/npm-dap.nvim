local get_scripts = require("dap-npm.utils.get_scripts")

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
                coroutine.resume(coro, selection)
            end)
        return true
    end
    )
end
