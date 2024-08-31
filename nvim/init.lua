require("config.lazy")
vim.cmd('source ./init.vim')
if vim.g.vscode then
    local vscode = require('vscode')
    -- VSCode extension
    -- Change color based on mode
    vim.api.nvim_create_autocmd({"ModeChanged"}, {
        pattern = {"*:*"},
        callback = function(ev)
            local normal_bg = 'default'
            local insert_bg = '#190d1c'
            local visual_bg = '#000010'
    
            local mode = string.match(ev.match, ":(%a+)")
            local value = {}
    
            if mode == 'n' then
                value["editor.background"] = normal_bg
                vscode.update_config({"workbench.colorCustomizations"}, { value }
                , "workspace")
            elseif mode == 'i' then
                value["editor.background"] = insert_bg
                vscode.update_config({"workbench.colorCustomizations"}, { value }
                , "workspace")
            elseif mode == 'V' then
                value["editor.background"] = visual_bg
                vscode.update_config({"workbench.colorCustomizations"}, { value }
                , "workspace")
            end
        end
    })
else
    -- ordinary Neovim
    -- Change color based on mode
    vim.api.nvim_create_autocmd({"ModeChanged"}, {
        pattern = {"*:*"},
        callback = function(ev)
            local normal_bg = '#100000'
            local insert_bg = '#001000'
            local visual_bg = '#000010'
    
            local mode = string.match(ev.match, ":(%a+)")
    
            if mode == 'n' then
                vim.api.nvim_command('hi Normal guibg=' .. normal_bg)
            elseif mode == 'i' then
                vim.api.nvim_command('hi Normal guibg=' .. insert_bg)
            elseif mode == 'V' then
                vim.api.nvim_command('hi Normal guibg=' .. visual_bg)
            end
        end
    })
end