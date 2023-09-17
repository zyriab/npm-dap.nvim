local table_contains = require("npm-dap.utils.table").table_contains
local get_index = require("npm-dap.utils.table").get_index

local DATA_PATH = vim.fn.stdpath("data") .. "/npm-dap.json"
local CONFIG_FILE = vim.fn.findfile(DATA_PATH)
local PROJECT_PATH = vim.fn.getcwd()

local M = {}

local function get_config()
    local contents = vim.fn.join(vim.fn.readfile(CONFIG_FILE), "")
    local config = vim.fn.json_decode(contents)

    return config
end

M.save_script = function(script)
    if CONFIG_FILE == "" then
        local empty_config = vim.fn.json_encode({
            projects = {
                [PROJECT_PATH] = {}
            }
        })

        local ok = pcall(vim.fn.writefile, { empty_config }, DATA_PATH)

        if not ok then
            vim.notify("npm-dap could not create configuration file", vim.log.levels.ERROR)
            return
        else
            CONFIG_FILE = DATA_PATH
        end
    end

    local config = get_config()

    if config == nil then
        vim.notify("npm-dap could not parse configuration file at " .. DATA_PATH, vim.log.levels.ERROR)
        return
    end

    if config.projects[PROJECT_PATH] == nil then
        config.projects[PROJECT_PATH] = {}
    end

    -- If the script already exists, we will move it on top of the list
    if table_contains(config.projects[PROJECT_PATH], script) then
        table.remove(config.projects[PROJECT_PATH],
            get_index(config.projects[PROJECT_PATH], script))
    end

    table.insert(config.projects[PROJECT_PATH], 1, script)

    local ok = pcall(vim.fn.writefile, { vim.fn.json_encode(config) }, DATA_PATH)

    if not ok then
        vim.notify("npm-dap could not save selected script to its configuration file", vim.log.levels.WARN)
    end
end

M.get_scripts = function()
    if CONFIG_FILE == "" then
        return {}
    end

    local config = get_config()

    if config == nil then
        vim.notify("npm-dap could not parse configuration file at " .. DATA_PATH, vim.log.levels.ERROR)
        return {}
    end

    if config.projects[PROJECT_PATH] == nil then
        return {}
    end

    return config.projects[PROJECT_PATH]
end

return M
