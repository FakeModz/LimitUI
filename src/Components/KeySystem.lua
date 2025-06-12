local KeySystem = {}


local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween

local UIComponent = require("./UI")
local CreateButton = UIComponent.Button
local CreateInput = UIComponent.Input 

function KeySystem.new(Config, Filename, func)
    local KeyDialogInit = require("./Dialog").Init(Config.WindUI.ScreenGui.KeySystem)
    local KeyDialog = KeyDialogInit.Create(true)
    
    
    local EnteredKey
    
    local ThumbnailSize = 200
    
    local UISize = 430
    if Config.KeySystem.Thumbnail and Config.KeySystem.Thumbnail.Image then
        UISize = 430+(ThumbnailSize/2)
    end
    
    KeyDialog.UIElements.Main.AutomaticSize = "Y"
    KeyDialog.UIElements.Main.Size = UDim2.new(0,UISize,0,0)
    
    local IconFrame
    
    if Config.Icon then
        -- local themetag = { ImageColor3 = "Text" }
        
        -- if string.find(Config.Icon, "rbxassetid://") or not Creator.Icon(tostring(Config.Icon))[1] then
        --     themetag = nil
        -- end
        -- IconFrame = New("ImageLabel", {
        --     Size = UDim2.new(0,24,0,24),
        --     BackgroundTransparency = 1,
        --     LayoutOrder = -1,
        --     ThemeTag = themetag
        -- })
        -- if string.find(Config.Icon, "rbxassetid://") or string.find(Config.Icon, "http://www.roblox.com/asset/?id=") then
        --     IconFrame.Image = Config.Icon
        -- elseif string.find(Config.Icon,"http") then
        --     local success, response = pcall(function()
        --         if not isfile("WindUI/" .. Window.Folder .. "/Assets/.Icon.png") then
        --             local response = request({
        --                 Url = Config.Icon,
        --                 Method = "GET",
        --             }).Body
        --             writefile("WindUI/" .. Window.Folder .. "/Assets/.Icon.png", response)
        --         end
        --         IconFrame.Image = getcustomasset("WindUI/" .. Window.Folder .. "/Assets/.Icon.png")
        --     end)
        --     if not success then
        --         IconFrame:Destroy()
                
        --         warn("[ WindUI ]  '" .. identifyexecutor() .. "' doesnt support the URL Images. Error: " .. response)
        --     end
        -- else
        --     if Creator.Icon(tostring(Config.Icon))[1] then
        --         IconFrame.Image = Creator.Icon(Config.Icon)[1]
        --         IconFrame.ImageRectOffset = Creator.Icon(Config.Icon)[2].ImageRectPosition
        --         IconFrame.ImageRectSize = Creator.Icon(Config.Icon)[2].ImageRectSize
        --     end
        -- end
        
        IconFrame = Creator.Image(
            Config.Icon,
            Config.Title .. ":" .. Config.Icon,
            0,
            Config.WindUI.Window,
            "KeySystem",
            Config.IconThemed
        )
        IconFrame.Size = UDim2.new(0,24,0,24)
        IconFrame.LayoutOrder = -1
    end
    
    local Title = New("TextLabel", {
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        Text = Config.Title,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
        ThemeTag = {
            TextColor3 = "Text",
        },
        TextSize = 20
    })
    local KeySystemTitle = New("TextLabel", {
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        Text = "Key System",
        AnchorPoint = Vector2.new(1,0.5),
        Position = UDim2.new(1,0,0.5,0),
        TextTransparency = 1, -- .4 -- hidden
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
        ThemeTag = {
            TextColor3 = "Text",
        },
        TextSize = 16
    })
    
    local IconAndTitleContainer = New("Frame", {
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
    }, {
        New("UIListLayout", {
            Padding = UDim.new(0,14),
            FillDirection = "Horizontal",
            VerticalAlignment = "Center"
        }),
        IconFrame, Title
    })
    
    local TitleContainer = New("Frame", {
        AutomaticSize = "Y",
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
    }, {
        -- New("UIListLayout", {
        --     Padding = UDim.new(0,9),
        --     FillDirection = "Horizontal",
        --     VerticalAlignment = "Bottom"
        -- }),
        IconAndTitleContainer, KeySystemTitle,
    })
    
    local InputFrame = CreateInput("Enter Key", "key", nil, nil, function(k)
        EnteredKey = k
    end)
    
    local NoteText
    if Config.KeySystem.Note and Config.KeySystem.Note ~= "" then
        NoteText = New("TextLabel", {
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            TextXAlignment = "Left",
            Text = Config.KeySystem.Note,
            TextSize = 18,
            TextTransparency = .4,
            ThemeTag = {
                TextColor3 = "Text",
            },
            BackgroundTransparency = 1,
            RichText = true
        })
    end

    local ButtonsContainer = New("Frame", {
        Size = UDim2.new(1,0,0,42),
        BackgroundTransparency = 1,
    }, {
        New("Frame", {
            BackgroundTransparency = 1,
            AutomaticSize = "X",
            Size = UDim2.new(0,0,1,0),
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,18/2),
                FillDirection = "Horizontal",
            })
        })
    })
    
    
    local ThumbnailFrame
    if Config.KeySystem.Thumbnail and Config.KeySystem.Thumbnail.Image then
        local ThumbnailTitle
        if Config.KeySystem.Thumbnail.Title then
            ThumbnailTitle = New("TextLabel", {
                Text = Config.KeySystem.Thumbnail.Title,
                ThemeTag = {
                    TextColor3 = "Text",
                },
                TextSize = 18,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                BackgroundTransparency = 1,
                AutomaticSize = "XY",
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
            })
        end
        ThumbnailFrame = New("ImageLabel", {
            Image = Config.KeySystem.Thumbnail.Image,
            BackgroundTransparency = 1,
            Size = UDim2.new(0,ThumbnailSize,1,0),
            Parent = KeyDialog.UIElements.Main,
            ScaleType = "Crop"
        }, {
            ThumbnailTitle,
            New("UICorner", {
                CornerRadius = UDim.new(0,0),
            })
        })
    end
    
    local MainFrame = New("Frame", {
        --AutomaticSize = "XY",
        Size = UDim2.new(1, ThumbnailFrame and -ThumbnailSize or 0,1,0),
        Position = UDim2.new(0, ThumbnailFrame and ThumbnailSize or 0,0,0),
        BackgroundTransparency = 1,
        Parent = KeyDialog.UIElements.Main
    }, {
        New("Frame", {
            --AutomaticSize = "XY",
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,18),
                FillDirection = "Vertical",
            }),
            TitleContainer,
            NoteText,
            InputFrame,
            ButtonsContainer,
            New("UIPadding", {
                PaddingTop = UDim.new(0,16),
                PaddingLeft = UDim.new(0,16),
                PaddingRight = UDim.new(0,16),
                PaddingBottom = UDim.new(0,16),
            })
        }),
    })
    
    -- for _, values in next, KeySystemButtons do
    --     CreateButton(values.Title, values.Icon, values.Callback, values.Variant)
    -- end
    
    local ExitButton = CreateButton("Exit", "log-out", function()
        KeyDialog:Close()()
    end, "Tertiary", ButtonsContainer.Frame)
    
    if ThumbnailFrame then
        ExitButton.Parent = ThumbnailFrame
        ExitButton.Size = UDim2.new(0,0,0,42)
        ExitButton.Position = UDim2.new(0,16,1,-16)
        ExitButton.AnchorPoint = Vector2.new(0,1)
    end
    
    if Config.KeySystem.URL then
        CreateButton("Get key", "key", function()
            setclipboard(Config.KeySystem.URL)
        end, "Secondary", ButtonsContainer.Frame)
    end
    
    local SubmitButton = CreateButton("Submit", "arrow-right", function()
        local Key = EnteredKey
        local isKey
        if type(Config.KeySystem.Key) == "table" then
            isKey = table.find(Config.KeySystem.Key, tostring(Key))
        else
            isKey = tostring(Config.KeySystem.Key) == tostring(Key)
        end
        
        if isKey then
            KeyDialog:Close()()
            
            if Config.KeySystem.SaveKey then
                local folder = Config.Folder or Config.Title
                writefile(folder .. "/" .. Filename .. ".key", tostring(Key))
            end
            
            task.wait(.4)
            func(true)
        end
    end, "Primary", ButtonsContainer)
    
    SubmitButton.AnchorPoint = Vector2.new(1,0.5)
    SubmitButton.Position = UDim2.new(1,0,0.5,0)
    
    -- TitleContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    --     KeyDialog.UIElements.Main.Size = UDim2.new(
    --         0,
    --         TitleContainer.AbsoluteSize.X +24+24+24+24+9,
    --         0,
    --         0
    --     )
    -- end)
    
    KeyDialog:Open()
end

return KeySystem