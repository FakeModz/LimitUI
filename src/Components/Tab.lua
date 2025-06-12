local UserInputService = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()

local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween

local UI = require("./UI")
local CreateButton = UI.Button
local CreateScrollSlider = UI.ScrollSlider


local TabModule = {
    Window = nil,
    WindUI = nil,
    Tabs = {}, 
    Containers = {},
    SelectedTab = nil,
    TabCount = 0,
    ToolTipParent = nil,
    TabHighlight = nil,
    
    OnChangeFunc = function(v) end
}

function TabModule.Init(Window, WindUI, ToolTipParent, TabHighlight)
    TabModule.Window = Window
    TabModule.WindUI = WindUI
    TabModule.ToolTipParent = ToolTipParent
    TabModule.TabHighlight = TabHighlight
    return TabModule
end

function TabModule.New(Config)
    local Tab = {
        __type = "Tab",
        Title = Config.Title or "Tab",
        Desc = Config.Desc,
        Icon = Config.Icon,
        IconThemed = Config.IconThemed,
        Locked = Config.Locked,
        ShowTabTitle = Config.ShowTabTitle,
        Selected = false,
        Index = nil,
        Parent = Config.Parent,
        UIElements = {},
        Elements = {},
        ContainerFrame = nil,
    }
    
    local Window = TabModule.Window
    local WindUI = TabModule.WindUI
    
    TabModule.TabCount = TabModule.TabCount + 1
	local TabIndex = TabModule.TabCount
	Tab.Index = TabIndex
	
    Tab.UIElements.Main = New("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1,-7,0,0),
        AutomaticSize = "Y",
        Parent = Config.Parent
    }, {
        New("UIListLayout", {
            SortOrder = "LayoutOrder",
            Padding = UDim.new(0,10),
            FillDirection = "Horizontal",
            VerticalAlignment = "Center",
        }),
        New("TextLabel", {
            Text = Tab.Title,
            ThemeTag = {
                TextColor3 = "Text"
            },
            TextTransparency = not Tab.Locked and 0.4 or .7,
            TextSize = 15,
            Size = UDim2.new(1,0,0,0),
            FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            TextWrapped = true,
            RichText = true,
            AutomaticSize = "Y",
            LayoutOrder = 2,
            TextXAlignment = "Left",
            BackgroundTransparency = 1,
        }),
        New("UIPadding", {
            PaddingTop = UDim.new(0,6),
            PaddingBottom = UDim.new(0,6),
        })
    })
	
	local TextOffset = 0
	local Icon

--	Tab.UIElements.Main.TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
--	    Tab.UIElements.Main.TextLabel.Size = UDim2.new(1,0,0,Tab.UIElements.Main.TextLabel.TextBounds.Y)
--	    Tab.UIElements.Main.Size = UDim2.new(1,TextOffset,0,Tab.UIElements.Main.TextLabel.TextBounds.Y+6+6)
--	end)
  	
  	if Tab.Icon then
        Icon = Creator.Image(
            Tab.Icon,
            Tab.Icon .. ":" .. Tab.Title,
            0,
            TabModule.Window.Folder,
            Tab.__type,
            true,
            Tab.IconThemed
        )
        Icon.Size = UDim2.new(0,18,0,18)
        Icon.Parent = Tab.UIElements.Main
        Icon.ImageLabel.ImageTransparency = not Tab.Locked and 0 or .7
        Tab.UIElements.Main.TextLabel.Size = UDim2.new(1,-30,0,0)
        TextOffset = -30
        
        Tab.UIElements.Icon = Icon
	end
	
	Tab.UIElements.ContainerFrame = New("ScrollingFrame", {
        Size = UDim2.new(1,0,1,Tab.ShowTabTitle and -((Window.UIPadding*2.4)+12) or 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        ElasticBehavior = "Never",
        CanvasSize = UDim2.new(0,0,0,0),
        AnchorPoint = Vector2.new(0,1),
        Position = UDim2.new(0,0,1,0),
        AutomaticCanvasSize = "Y",
        --Visible = false,
        ScrollingDirection = "Y",
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,Window.UIPadding*1.2),
            PaddingLeft = UDim.new(0,Window.UIPadding*1.2),
            PaddingRight = UDim.new(0,Window.UIPadding*1.2),
            PaddingBottom = UDim.new(0,Window.UIPadding*1.2),
        }),
        New("UIListLayout", {
            SortOrder = "LayoutOrder",
            Padding = UDim.new(0,6),
            HorizontalAlignment = "Center",
        })
    })

    -- Tab.UIElements.ContainerFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    --     Tab.UIElements.ContainerFrame.CanvasSize = UDim2.new(0,0,0,Tab.UIElements.ContainerFrame.UIListLayout.AbsoluteContentSize.Y+Window.UIPadding*2)
    -- end)
    
    Tab.UIElements.ContainerFrameCanvas = New("Frame", {
        Size = UDim2.new(1,0,1,0),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = Window.UIElements.MainBar,
        ZIndex = 5,
    }, {
        Tab.UIElements.ContainerFrame,
        New("Frame", {
            Size = UDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
            BackgroundTransparency = 1,
            Visible = Tab.ShowTabTitle or false,
            Name = "TabTitle"
        }, {
            Icon and Icon:Clone(),
            New("TextLabel", {
                Text = Tab.Title,
                ThemeTag = {
                    TextColor3 = "Text"
                },
                TextSize = 20,
                TextTransparency = .1,
                Size = UDim2.new(1,0,1,0),
                FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
                TextTruncate = "AtEnd",
                RichText = true,
                LayoutOrder = 2,
                TextXAlignment = "Left",
                BackgroundTransparency = 1,
            }),
            New("UIPadding", {
                PaddingTop = UDim.new(0,Window.UIPadding*1.2),
                PaddingLeft = UDim.new(0,Window.UIPadding*1.2),
                PaddingRight = UDim.new(0,Window.UIPadding*1.2),
                PaddingBottom = UDim.new(0,Window.UIPadding*1.2),
            }),
            New("UIListLayout", {
                SortOrder = "LayoutOrder",
                Padding = UDim.new(0,10),
                FillDirection = "Horizontal",
                VerticalAlignment = "Center",
            })
        }),
        New("Frame", {
            Size = UDim2.new(1,0,0,1),
            BackgroundTransparency = .9,
            ThemeTag = {
                BackgroundColor3 = "Text"
            },
            Position = UDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
            Visible = Tab.ShowTabTitle or false,
        })
    })
    
    TabModule.Containers[TabIndex] = Tab.UIElements.ContainerFrameCanvas
	TabModule.Tabs[TabIndex] = Tab
	
	Tab.ContainerFrame = ContainerFrameCanvas
	
	Creator.AddSignal(Tab.UIElements.Main.MouseButton1Click, function()
	    if not Tab.Locked then
	        TabModule:SelectTab(TabIndex)
	    end
	end)
	
    -- soon
    CreateScrollSlider(Tab.UIElements.ContainerFrame, Tab.UIElements.ContainerFrameCanvas, Window, 3)

	
	-- ToolTip
    if Tab.Desc then
        local ToolTip
        local hoverTimer
        local MouseConn
        local IsHovering = false
        
        local function removeToolTip()
            IsHovering = false
            if hoverTimer then
                task.cancel(hoverTimer)
                hoverTimer = nil
            end
            if MouseConn then
                MouseConn:Disconnect()
                MouseConn = nil
            end
            if ToolTip then
                ToolTip:Close()
                ToolTip = nil
            end
        end
        
        Creator.AddSignal(Tab.UIElements.Main.InputBegan, function()
            IsHovering = true
            hoverTimer = task.spawn(function()
                task.wait(0.35)
                if IsHovering and not ToolTip then
                    ToolTip = UI.ToolTip(Tab.Desc, TabModule.ToolTipParent)
        
                    local function updatePosition()
                        if ToolTip then
                            ToolTip.Container.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y - 20)
                        end
                    end
        
                    updatePosition()
                    MouseConn = Mouse.Move:Connect(updatePosition)
                    ToolTip:Open()
                end
            end)
        end)
        
        Creator.AddSignal(Tab.UIElements.Main.InputEnded, removeToolTip)
    end
	-- WTF
	
    local Elements = {
        Button      = require("../Elements/Button"),
        Toggle      = require("../Elements/Toggle"),
        Slider      = require("../Elements/Slider"),
        Keybind     = require("../Elements/Keybind"),
        Input       = require("../Elements/Input"),
        Dropdown    = require("../Elements/Dropdown"),
        Code        = require("../Elements/Code"),
        Colorpicker = require("../Elements/Colorpicker"),
        Section     = require("../Elements/Section"),
    }
    
    function Tab:Divider()
        local Divider = New("Frame", {
            Size = UDim2.new(1,0,0,1),
            Position = UDim2.new(0.5,0,0.5,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            BackgroundTransparency = .9,
            ThemeTag = {
                BackgroundColor3 = "Text"
            }
        })
        local MainDivider = New("Frame", {
            Parent = Tab.UIElements.ContainerFrame,
            Size = UDim2.new(1,-7,0,5),
            BackgroundTransparency = 1,
        }, {
            Divider
        })
        
        return MainDivider
    end
    
    function Tab:Paragraph(ElementConfig)  
        ElementConfig.Parent = Tab.UIElements.ContainerFrame  
        ElementConfig.Window = Window  
        ElementConfig.Hover = false  
        --ElementConfig.Color = ElementConfig.Color  
        ElementConfig.TextOffset = 0  
        ElementConfig.IsButtons = ElementConfig.Buttons and #ElementConfig.Buttons > 0 and true or false  
          
        local ParagraphModule = {  
            __type = "Paragraph",  
            Title = ElementConfig.Title or "Paragraph",  
            Desc = ElementConfig.Desc or nil,  
            --Color = ElementConfig.Color,  
            Locked = ElementConfig.Locked or false,  
        }  
        local Paragraph = require("../Components/Element")(ElementConfig)  
          
        ParagraphModule.ParagraphFrame = Paragraph  
        if ElementConfig.Buttons and #ElementConfig.Buttons > 0 then  
            local ButtonsContainer = New("Frame", {  
                Size = UDim2.new(0,0,0,38),  
                BackgroundTransparency = 1,  
                AutomaticSize = "Y",
                Parent = Paragraph.UIElements.Container
            }, {  
                New("UIListLayout", {  
                    Padding = UDim.new(0,10),  
                    FillDirection = "Vertical",  
                })  
            })  
              
  
            for _,Button in next, ElementConfig.Buttons do  
                local ButtonFrame = CreateButton(Button.Title, Button.Icon, Button.Callback, "White", ButtonsContainer)  
                ButtonFrame.Size = UDim2.new(0,0,0,38)  
                ButtonFrame.AutomaticSize = "X"  
            end
        end  
          
        function ParagraphModule:SetTitle(Title)  
            ParagraphModule.ParagraphFrame:SetTitle(Title)  
        end  
        function ParagraphModule:SetDesc(Title)  
            ParagraphModule.ParagraphFrame:SetDesc(Title)  
        end  
        function ParagraphModule:Destroy()  
            ParagraphModule.ParagraphFrame:Destroy()  
        end  
          
        table.insert(Tab.Elements, ParagraphModule)  
        return ParagraphModule  
    end  
    
    for name, module in pairs(Elements) do
        Tab[name] = function(self, config)
            config.Parent = self.UIElements.ContainerFrame
            config.Window = Window
            config.WindUI = WindUI
    
            local elementInstance, content = module:New(config)
            table.insert(self.Elements, content)
    
            local frame
            for key, value in pairs(content) do
                if typeof(value) == "table" and key:match("Frame$") then
                    frame = value
                    break
                end
            end
            
            if frame then
                function content:SetTitle(title)
                    frame:SetTitle(title)
                end
                function content:SetDesc(desc)
                    frame:SetDesc(desc)
                end
                function content:Destroy()
                    frame:Destroy()
                end
            end
            return content
        end
    end

	
	task.spawn(function()
        local Empty = New("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
            Parent = Tab.UIElements.ContainerFrame
        }, {
            New("UIListLayout", {
                Padding = UDim.new(0,8),
                SortOrder = "LayoutOrder",
                VerticalAlignment = "Center",
                HorizontalAlignment = "Center",
                FillDirection = "Vertical",
            }), 
            New("ImageLabel", {
                Size = UDim2.new(0,48,0,48),
                Image = Creator.Icon("frown")[1],
                ImageRectOffset = Creator.Icon("frown")[2].ImageRectPosition,
                ImageRectSize = Creator.Icon("frown")[2].ImageRectSize,
                ThemeTag = {
                    ImageColor3 = "Icon"
                },
                BackgroundTransparency = 1,
                ImageTransparency = .6,
            }),
            New("TextLabel", {
                AutomaticSize = "XY",
                Text = "This tab is empty",
                ThemeTag = {
                    TextColor3 = "Text"
                },
                TextSize = 18,
                TextTransparency = .5,
                BackgroundTransparency = 1,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
            })
        })
        
        -- Empty.TextLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
        --     Empty.TextLabel.Size = UDim2.new(0,Empty.TextLabel.TextBounds.X,0,Empty.TextLabel.TextBounds.Y)
        -- end)
        
        Creator.AddSignal(Tab.UIElements.ContainerFrame.ChildAdded, function()
            Empty.Visible = false
        end)
	end)
	
	return Tab
end

function TabModule:OnChange(func)
    TabModule.OnChangeFunc = func
end

function TabModule:SelectTab(TabIndex)
    if not TabModule.Tabs[TabIndex].Locked then
        TabModule.SelectedTab = TabIndex
        
        for _, TabObject in next, TabModule.Tabs do
            if not TabObject.Locked then
                Tween(TabObject.UIElements.Main.TextLabel, 0.15, {TextTransparency = 0.45}):Play()
                if TabObject.UIElements.Icon then
                    Tween(TabObject.UIElements.Icon.ImageLabel, 0.15, {ImageTransparency = 0.5}):Play()
                end
                TabObject.Selected = false
            end
        end
        Tween(TabModule.Tabs[TabIndex].UIElements.Main.TextLabel, 0.15, {TextTransparency = 0}):Play()
        if TabModule.Tabs[TabIndex].UIElements.Icon then
            Tween(TabModule.Tabs[TabIndex].UIElements.Icon.ImageLabel, 0.15, {ImageTransparency = 0.15}):Play()
        end
        TabModule.Tabs[TabIndex].Selected = true
        
        Tween(TabModule.TabHighlight, .25, {Position = UDim2.new(
            0,
            0,
            0,
            TabModule.Tabs[TabIndex].UIElements.Main.AbsolutePosition.Y - TabModule.Tabs[TabIndex].Parent.AbsolutePosition.Y
            ), 
            Size = UDim2.new(1,-7,0,TabModule.Tabs[TabIndex].UIElements.Main.AbsoluteSize.Y)
        }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
    
        task.spawn(function()
            for _, ContainerObject in next, TabModule.Containers do
                ContainerObject.AnchorPoint = Vector2.new(0,0.05)
                ContainerObject.Visible = false
            end
            TabModule.Containers[TabIndex].Visible = true
            Tween(TabModule.Containers[TabIndex], 0.15, {AnchorPoint = Vector2.new(0,0)}, Enum.EasingStyle.Quart, Enum.EasingDirection.Out):Play()
        end)
        
        TabModule.OnChangeFunc(TabIndex)
    end
end

return TabModule