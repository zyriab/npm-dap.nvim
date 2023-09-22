# npm-dap.nvim
Run your npm scripts from the debugger dialog

**🚧 Work in progress 🚧**

## How to use 
Simply call the `setup` function somewhere after your DAP's JS/TS configurations.

```lua
for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
    require("dap").configurations[language] = {
        -- Your configs
    }
end

require("npm-dap").setup()
```
This will add a new configuration on top of your existing ones, giving you the possibility to now choose a script present in your `package.json`.
Once the script has been chosen, it will show in the DAP action selector (you currently have to restart Neovim).
It's project dependent so no polluting from other projects :)

If you want to remove a script or project altogheter, all your scripts choices are stored in `$HOME/.local/share/nvim/npm-dap.json` (on Linux, Mac OS too, probably... if you are on Windows, why the hell are you programming on that terriible OS? Do you like to suffer? Do you program in CodeBlocks with the worst light mode ever? Do you actually enjoy the fact that the number of days since a new JavaScript framework was released is 0 every single time? Or maybe you are a game dev... in any case, I can't help you).

## TODO
- [x] Save already selected scripts and show them next time
- [ ] Reload the config after choosing a script so that it shows without having to reload Neovim
- [ ] Kill process on session end <-- seems to be a bug from `vscode-js-debugger`
- [x] Debug the sourcemaps jumps/messages
- [ ] Prevent debugger from starting if no script was chosen
- [ ] Add tests (͠≖ ͜ʖ͠≖)
- [ ] Make sure it works well with JS as well (seems good)
- [ ] See if it can work with other Node.js adapters
