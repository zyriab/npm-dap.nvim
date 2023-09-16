local found, dap           = pcall(require, "dap")
local prompt_script_select = require("dap-npm.utils.prompt_script_select")
local is_dap_setup         = require("dap-npm.utils.is_dap_setup")

local M                    = {
    setup = function()
        vim.notify(
            "dap-npm could not find nvim-dap, make sure it is installed and that you setup this plugin after nvim-dap.",
            vim.log.levels.ERROR)
    end
}

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

M.setup()


return M
