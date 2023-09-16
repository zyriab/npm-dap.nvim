local found, dap           = pcall(require, "dap")
local prompt_script_select = require("npm-dap.utils.prompt_script_select")
local is_dap_setup         = require("npm-dap.utils.is_dap_setup")

local M                    = {}

if found and is_dap_setup() then
    M.setup = function(opts)
        for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
            if dap.configurations[language] == nil then
                goto continue
            end
            table.insert(
                dap.configurations[language],
                1,
                {
                    name = "Run npm script",
                    type = "pwa-node",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    -- FIXME: debug the weird sourcemaps jumps
                    -- outFiles = { "${workspaceFolder}/dist/**/*.js" },
                    runtimeExecutable = "npm",
                    runtimeArgs = {
                        "run-script",
                        prompt_script_select
                    }
                }
            )

            ::continue::
        end
    end
end

return M
