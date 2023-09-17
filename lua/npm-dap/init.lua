local found, dap           = pcall(require, "dap")
local prompt_script_select = require("npm-dap.utils.prompt-script-select")
local config_manager       = require("npm-dap.utils.config-manager")

local M                    = {
    setup = function()
        vim.notify("could not setup npm-dap, no installation of dap could be found", vim.log.levels.ERROR)
    end
}

if found then
    M.setup = function(opts)
        for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
            if dap.configurations[language] == nil then
                goto continue
            end

            local i = 2

            table.insert(
                dap.configurations[language],
                1,
                {
                    name = "Run npm script",
                    type = "pwa-node",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    rootPath = "${workspaceFolder}",
                    sourceMaps = true,
                    skilpFiles = { "<node_internals>/**" },
                    protocol = "inspector",
                    console = "integratedTerminal",
                    runtimeArgs = {
                        "run-script",
                        prompt_script_select
                    }
                }
            )

            -- TODO: reload this everytime the user opens the debugger select
            for _, script in ipairs(config_manager.get_scripts()) do
                table.insert(
                    dap.configurations[language],
                    i,
                    {
                        name = "Run script: " .. script,
                        type = "pwa-node",
                        request = "launch",
                        cwd = "${workspaceFolder}",
                        rootPath = "${workspaceFolder}",
                        sourceMaps = true,
                        skilpFiles = { "<node_internals>/**" },
                        protocol = "inspector",
                        console = "integratedTerminal",
                        runtimeExecutable = "npm",
                        runtimeArgs = {
                            "run-script",
                            function()
                                -- Moving the script on top of the list
                                config_manager.save_script(script)
                                return script
                            end
                        }
                    }
                )

                i = i + 1
            end


            ::continue::
        end
    end
end

return M
