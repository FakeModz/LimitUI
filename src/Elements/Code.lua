local Creator = require("../Creator")
local New = Creator.New

-- local Highlighter = require("../Highlighter")
local UI = require("../Components/UI")

local Element = {}

function Element:New(Config)
    local Code = {
        __type = "Code",
        Title = Config.Title,
        Code = Config.Code,
        UIElements = {}
    }
    
    local CanCallback = not Code.Locked
    
    -- Code.CodeFrame = require("../Components/Element")({
    --     Title = Code.Title,
    --     Desc = Code.Code,
    --     Parent = Config.Parent,
    --     TextOffset = 40,
    --     Hover = false,
    -- })
    
    -- Code.CodeFrame.UIElements.Main.Title.Desc:Destroy()
    
    local CodeElement = UI.Code(Code.Code, Code.Title, Config.Parent, function()
        if CanCallback then
            local NewTitle = Code.Title or "code"
            local success, result = pcall(function()
                toclipboard(Code.Code)
            end)
            if success then
                Config.WindUI:Notify({
                    Title = "Success",
                    Content = "The " .. NewTitle .. " copied to your clipboard.",
                    Icon = "check",
                    Duration = 5,
                })
            else
                Config.WindUI:Notify({
                    Title = "Error",
                    Content = "The " .. NewTitle .. " is not copied. Error: " .. result,
                    Icon = "x",
                    Duration = 5,
                })
            end
        end
    end)
    
    function Code:SetCode(code)
        CodeElement.Set(code)
    end
    
    return Code.__type, Code
end

return Element