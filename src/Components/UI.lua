local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local Highlighter = require("../Highlighter")
local UIComponents = {}

local Creator = require("../Creator")
local New = Creator.New
local Tween = Creator.Tween

function UIComponents.Button(Title, Icon, Callback, Variant, Parent, Dialog)
    Variant = Variant or "Primary"
    local Radius = 10
    local IconButtonFrame
    if Icon and Icon ~= "" then
        IconButtonFrame = New("ImageLabel", {
            Image = Creator.Icon(Icon)[1],
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            Size = UDim2.new(0,24-3,0,24-3),
            BackgroundTransparency = 1,
            ThemeTag = {
                ImageColor3 = "Icon",
            }
        })
    end
    
    local ButtonFrame = New("TextButton", {
        Size = UDim2.new(0,0,1,0),
        AutomaticSize = "X",
        Parent = Parent,
        BackgroundTransparency = 1
    }, {
        Creator.NewRoundFrame(Radius, "Squircle", {
            ThemeTag = {
                ImageColor3 = Variant ~= "White" and "Button" or nil,
            },
            ImageColor3 = Variant == "White" and Color3.new(1,1,1) or nil,
            Size = UDim2.new(1,0,1,0),
            Name = "Squircle",
            ImageTransparency = Variant == "Primary" and 0 or Variant == "White" and 0 or 1
        }),
    
        Creator.NewRoundFrame(Radius, "Squircle", {
            -- ThemeTag = {
            --     ImageColor3 = "Layer",
            -- },
            ImageColor3 = Color3.new(1,1,1),
            Size = UDim2.new(1,0,1,0),
            Name = "Special",
            ImageTransparency = Variant == "Secondary" and 0.95 or 1
        }),
    
        Creator.NewRoundFrame(Radius, "Shadow-sm", {
            -- ThemeTag = {
            --     ImageColor3 = "Layer",
            -- },
            ImageColor3 = Color3.new(0,0,0),
            Size = UDim2.new(1,3,1,3),
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Name = "Shadow",
            ImageTransparency = Variant == "Secondary" and 0 or 1
        }),
    
        Creator.NewRoundFrame(Radius, "SquircleOutline", {
            ThemeTag = {
                ImageColor3 = Variant ~= "White" and "Outline" or nil,
            },
            Size = UDim2.new(1,0,1,0),
            ImageColor3 = Variant == "White" and Color3.new(0,0,0) or nil,
            ImageTransparency = Variant == "Primary" and .95 or .85,
        }),
    
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            Name = "Frame",
            ThemeTag = {
                ImageColor3 = Variant ~= "White" and "Text" or nil
            },
            ImageColor3 = Variant == "White" and Color3.new(0,0,0) or nil,
            ImageTransparency = 1 -- .95
        }, {
            New("UIPadding", {
                PaddingLeft = UDim.new(0,12),
                PaddingRight = UDim.new(0,12),
            }),
            New("UIListLayout", {
                FillDirection = "Horizontal",
                Padding = UDim.new(0,8),
                VerticalAlignment = "Center",
                HorizontalAlignment = "Center",
            }),
            IconButtonFrame,
            New("TextLabel", {
                BackgroundTransparency = 1,
                FontFace = Font.new(Creator.Font, Enum.FontWeight.SemiBold),
                Text = Title or "Button",
                ThemeTag = {
                    TextColor3 = (Variant ~= "Primary" and Variant ~= "White") and "Text",
                },
                TextColor3 = Variant == "Primary" and Color3.new(1,1,1) or Variant == "White" and Color3.new(0,0,0) or nil,
                AutomaticSize = "XY",
                TextSize = 18,
            })
        })
    })
    
    Creator.AddSignal(ButtonFrame.MouseEnter, function()
        Tween(ButtonFrame.Frame, .047, {ImageTransparency = .95}):Play()
    end)
    Creator.AddSignal(ButtonFrame.MouseLeave, function()
        Tween(ButtonFrame.Frame, .047, {ImageTransparency = 1}):Play()
    end)
    Creator.AddSignal(ButtonFrame.MouseButton1Up, function()
        if Dialog then
            Dialog:Close()()
        end
        if Callback then
            Creator.SafeCallback(Callback)
        end
    end)
    
    return ButtonFrame
end

function UIComponents.Input(Placeholder, Icon, Parent, Type, Callback)
    Type = Type or "Input"
    local Radius = 10
    local IconInputFrame
    if Icon and Icon ~= "" then
        IconInputFrame = New("ImageLabel", {
            Image = Creator.Icon(Icon)[1],
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            Size = UDim2.new(0,24-3,0,24-3),
            BackgroundTransparency = 1,
            ThemeTag = {
                ImageColor3 = "Icon",
            }
        })
    end
    
    local TextBox = New("TextBox", {
        BackgroundTransparency = 1,
        TextSize = 16,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
        Size = UDim2.new(1,IconInputFrame and -29 or 0,1,0),
        PlaceholderText = Placeholder,
        ClearTextOnFocus = false,
        ClipsDescendants = true,
        MultiLine = Type == "Input" and false or true,
        TextWrapped = Type == "Input" and false or true,
        TextXAlignment = "Left",
        TextYAlignment = Type == "Input" and "Center" or "Top",
        --AutomaticSize = "XY",
        ThemeTag = {
            PlaceholderColor3 = "PlaceholderText",
            TextColor3 = "Text",
        },
    })
    
    local InputFrame = New("Frame", {
        Size = UDim2.new(1,0,0,42),
        Parent = Parent,
        BackgroundTransparency = 1
    }, {
        New("Frame", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            Creator.NewRoundFrame(Radius, "Squircle", {
                ThemeTag = {
                    ImageColor3 = "Accent",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .45,
            }),
            Creator.NewRoundFrame(Radius, "SquircleOutline", {
                ThemeTag = {
                    ImageColor3 = "Outline",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .9,
            }),
            Creator.NewRoundFrame(Radius, "Squircle", {
                Size = UDim2.new(1,0,1,0),
                Name = "Frame",
                ImageColor3 = Color3.new(1,1,1),
                ImageTransparency = .95
            }, {
                New("UIPadding", {
                    PaddingTop = UDim.new(0,Type == "Input" and 0 or 12),
                    PaddingLeft = UDim.new(0,12),
                    PaddingRight = UDim.new(0,12),
                    PaddingBottom = UDim.new(0,Type == "Input" and 0 or 12),
                }),
                New("UIListLayout", {
                    FillDirection = "Horizontal",
                    Padding = UDim.new(0,8),
                    VerticalAlignment = Type == "Input" and "Center" or "Top",
                    HorizontalAlignment = "Left",
                }),
                IconInputFrame,
                TextBox,
            })
        })
    })
    
    -- InputFrame:GetPropertyChangedSignal("AbsoluteSize"), function()
    --     TextBox.Size = UDim2.new(
    --         0,
    --         IconInputFrame and InputFrame.AbsoluteSize.X -29-12 or InputFrame.AbsoluteSize.X-12,
    --         1,
    --         0
    --     )
    -- end)
    
    Creator.AddSignal(TextBox.FocusLost, function()
        if Callback then
            Creator.SafeCallback(Callback, TextBox.Text)
        end
    end)
    
    return InputFrame
end

function UIComponents.Label(Text, Icon, Parent)
    local Radius = 10
    local IconLabelFrame
    if Icon and Icon ~= "" then
        IconLabelFrame = New("ImageLabel", {
            Image = Creator.Icon(Icon)[1],
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            Size = UDim2.new(0,24-3,0,24-3),
            BackgroundTransparency = 1,
            ThemeTag = {
                ImageColor3 = "Icon",
            }
        })
    end
    
    local TextLabel = New("TextLabel", {
        BackgroundTransparency = 1,
        TextSize = 16,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Regular),
        Size = UDim2.new(1,IconLabelFrame and -29 or 0,1,0),
        TextXAlignment = "Left",
        ThemeTag = {
            TextColor3 = "Text",
        },
        Text = Text,
    })
    
    local LabelFrame = New("TextButton", {
        Size = UDim2.new(1,0,0,42),
        Parent = Parent,
        BackgroundTransparency = 1,
        Text = "",
    }, {
        New("Frame", {
            Size = UDim2.new(1,0,1,0),
            BackgroundTransparency = 1,
        }, {
            Creator.NewRoundFrame(Radius, "Squircle", {
                ThemeTag = {
                    ImageColor3 = "Accent",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .45,
            }),
            Creator.NewRoundFrame(Radius, "SquircleOutline", {
                ThemeTag = {
                    ImageColor3 = "Outline",
                },
                Size = UDim2.new(1,0,1,0),
                ImageTransparency = .9,
            }),
            Creator.NewRoundFrame(Radius, "Squircle", {
                Size = UDim2.new(1,0,1,0),
                Name = "Frame",
                ImageColor3 = Color3.new(1,1,1),
                ImageTransparency = .95
            }, {
                New("UIPadding", {
                    PaddingLeft = UDim.new(0,12),
                    PaddingRight = UDim.new(0,12),
                }),
                New("UIListLayout", {
                    FillDirection = "Horizontal",
                    Padding = UDim.new(0,8),
                    VerticalAlignment = "Center",
                    HorizontalAlignment = "Left",
                }),
                IconLabelFrame,
                TextLabel,
            })
        })
    })
    
    return LabelFrame
end

function UIComponents.Toggle(Value, Icon, Parent, Callback)
    local Toggle = {}
    
    
    local Radius = 26/2
    local IconToggleFrame
    if Icon and Icon ~= "" then
        IconToggleFrame = New("ImageLabel", {
            Size = UDim2.new(1,-7,1,-7),
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Image = Creator.Icon(Icon)[1],
            ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
            ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
            ImageTransparency = 1,
            ImageColor3 = Color3.new(0,0,0),
        })
    end
    
    local ToggleFrame = Creator.NewRoundFrame(Radius, "Squircle",{
        ImageTransparency = .95,
        ThemeTag = {
            ImageColor3 = "Text"
        },
        Parent = Parent,
        Size = UDim2.new(0,20*2.1,0,26),
    }, {
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            Name = "Layer",
            ThemeTag = {
                ImageColor3 = "Button",
            },
            ImageTransparency = 1, -- 0
        }),
        Creator.NewRoundFrame(Radius, "SquircleOutline", {
            Size = UDim2.new(1,0,1,0),
            Name = "Stroke",
            ImageColor3 = Color3.new(1,1,1),
            ImageTransparency = 1, -- .95
        }, {
            New("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                })
            })
        }),
        
        --bar
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(0,18,0,18),
            Position = UDim2.new(0,3,0.5,0),
            AnchorPoint = Vector2.new(0,0.5),
            ImageTransparency = 0,
            ImageColor3 =  Color3.new(1,1,1),
            Name = "Frame",
        }, {
            IconToggleFrame,
        })
    })
    
    function Toggle:Set(Toggled)
        if Toggled then
            Tween(ToggleFrame.Frame, 0.1, {
                Position = UDim2.new(1, -18 - 4, 0.5, 0),
                --Size = UDim2.new(0,20,0,20),
            }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 0,
            }):Play()
            Tween(ToggleFrame.Stroke, 0.1, {
                ImageTransparency = 0.95,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 0,
                }):Play()
            end
        else
            Tween(ToggleFrame.Frame, 0.1, {
                Position = UDim2.new(0, 4, 0.5, 0),
                Size = UDim2.new(0,18,0,18),
            }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
            Tween(ToggleFrame.Layer, 0.1, {
                ImageTransparency = 1,
            }):Play()
            Tween(ToggleFrame.Stroke, 0.1, {
                ImageTransparency = 1,
            }):Play()
        
            if IconToggleFrame then 
                Tween(IconToggleFrame, 0.1, {
                    ImageTransparency = 1,
                }):Play()
            end
        end

        task.spawn(function()
            if Callback then
                Creator.SafeCallback(Callback, Toggled)
            end
        end)
        
        --Toggled = not Toggled
    end
    
    return ToggleFrame, Toggle
end

function UIComponents.Checkbox(Value, Icon, Parent, Callback)
    local Checkbox = {}
    
    Icon = Icon or "check"
    
    local Radius = 10
    local IconCheckboxFrame = New("ImageLabel", {
        Size = UDim2.new(1,-10,1,-10),
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5,0.5),
        Position = UDim2.new(0.5,0,0.5,0),
        Image = Creator.Icon(Icon)[1],
        ImageRectOffset = Creator.Icon(Icon)[2].ImageRectPosition,
        ImageRectSize = Creator.Icon(Icon)[2].ImageRectSize,
        ImageTransparency = 1,
        ImageColor3 = Color3.new(1,1,1),
    })
    
    local CheckboxFrame = Creator.NewRoundFrame(Radius, "Squircle",{
        ImageTransparency = .95, -- 0
        ThemeTag = {
            ImageColor3 = "Text"
        },
        Parent = Parent,
        Size = UDim2.new(0,27,0,27),
    }, {
        Creator.NewRoundFrame(Radius, "Squircle", {
            Size = UDim2.new(1,0,1,0),
            Name = "Layer",
            ThemeTag = {
                ImageColor3 = "Button",
            },
            ImageTransparency = 1, -- 0
        }),
        Creator.NewRoundFrame(Radius, "SquircleOutline", {
            Size = UDim2.new(1,0,1,0),
            Name = "Stroke",
            ImageColor3 = Color3.new(1,1,1),
            ImageTransparency = 1, -- .95
        }, {
            New("UIGradient", {
                Rotation = 90,
                Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                })
            })
        }),
        
        IconCheckboxFrame,
    })
    
    function Checkbox:Set(Toggled)
        if Toggled then
            Tween(CheckboxFrame.Layer, 0.06, {
                ImageTransparency = 0,
            }):Play()
            Tween(CheckboxFrame.Stroke, 0.06, {
                ImageTransparency = 0.95,
            }):Play()
            Tween(IconCheckboxFrame, 0.06, {
                ImageTransparency = 0,
            }):Play()
        else
            Tween(CheckboxFrame.Layer, 0.05, {
                ImageTransparency = 1,
            }):Play()
            Tween(CheckboxFrame.Stroke, 0.05, {
                ImageTransparency = 1,
            }):Play()
            Tween(IconCheckboxFrame, 0.06, {
                ImageTransparency = 1,
            }):Play()
        end

        task.spawn(function()
            if Callback then
                Creator.SafeCallback(Callback, Toggled)
            end
        end)
    end
    
    return CheckboxFrame, Checkbox
end

function UIComponents.ScrollSlider(ScrollingFrame, Parent, Window, Thickness)

    local Slider = New("Frame", {
        Size = UDim2.new(0, Thickness, 1,0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        Parent = Parent,
        ZIndex = 999,
        Active = true,
    })

    local Thumb = Creator.NewRoundFrame(Thickness/2, "Squircle", {
        Size = UDim2.new(1, 0, 0, 0),
        ImageTransparency = 0.85,
        ThemeTag = { ImageColor3 = "Text" },
        Parent = Slider,
    })

    local Hitbox = New("Frame", {
        Size = UDim2.new(1, 12, 1, 12),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Active = true,
        ZIndex = 999,
        Parent = Thumb,
    })

    local isDragging = false
    local dragOffset = 0

    local function updateSliderSize()
        local container = ScrollingFrame
        local canvasSize = container.AbsoluteCanvasSize.Y
        local windowSize = container.AbsoluteWindowSize.Y

        if canvasSize <= windowSize then
            Thumb.Visible = false
            return
        end

        local visibleRatio = math.clamp(windowSize / canvasSize, 0.1, 1)
        Thumb.Size = UDim2.new(1, 0, visibleRatio, 0)
        Thumb.Visible = true
    end

    local function updateScrollingFramePosition()        
        local thumbPositionY = Thumb.Position.Y.Scale
        local canvasSize = ScrollingFrame.AbsoluteCanvasSize.Y
        local windowSize = ScrollingFrame.AbsoluteWindowSize.Y
        local maxScroll = math.max(canvasSize - windowSize, 0)
        
        if maxScroll <= 0 then return end
        
        local maxThumbPos = math.max(1 - Thumb.Size.Y.Scale, 0)
        if maxThumbPos <= 0 then return end
        
        local scrollRatio = thumbPositionY / maxThumbPos
        
        ScrollingFrame.CanvasPosition = Vector2.new(
            ScrollingFrame.CanvasPosition.X,
            scrollRatio * maxScroll
        )
    end

    local function updateThumbPosition()
        if isDragging then return end 
        
        local canvasPosition = ScrollingFrame.CanvasPosition.Y
        local canvasSize = ScrollingFrame.AbsoluteCanvasSize.Y
        local windowSize = ScrollingFrame.AbsoluteWindowSize.Y
        local maxScroll = math.max(canvasSize - windowSize, 0)
        
        if maxScroll <= 0 then
            Thumb.Position = UDim2.new(0, 0, 0, 0)
            return
        end
        
        local scrollRatio = canvasPosition / maxScroll
        local maxThumbPos = math.max(1 - Thumb.Size.Y.Scale, 0)
        local newThumbPosition = math.clamp(scrollRatio * maxThumbPos, 0, maxThumbPos)

        Thumb.Position = UDim2.new(0, 0, newThumbPosition, 0)
    end

    Creator.AddSignal(Slider.InputBegan, function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            local thumbTop = Thumb.AbsolutePosition.Y
            local thumbBottom = thumbTop + Thumb.AbsoluteSize.Y
            
            if not (input.Position.Y >= thumbTop and input.Position.Y <= thumbBottom) then
                local sliderTop = Slider.AbsolutePosition.Y
                local sliderHeight = Slider.AbsoluteSize.Y
                local thumbHeight = Thumb.AbsoluteSize.Y
                
                local targetY = input.Position.Y - sliderTop - thumbHeight / 2
                local maxThumbPos = sliderHeight - thumbHeight
                
                local newThumbPosScale = math.clamp(targetY / maxThumbPos, 0, 1 - Thumb.Size.Y.Scale)
                
                Thumb.Position = UDim2.new(0, 0, newThumbPosScale, 0)
                updateScrollingFramePosition()
            end
        end
    end)

    Creator.AddSignal(Hitbox.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            dragOffset = input.Position.Y - Thumb.AbsolutePosition.Y
            
            local moveConnection
            local releaseConnection

            moveConnection = UserInputService.InputChanged:Connect(function(changedInput)
                if changedInput.UserInputType == Enum.UserInputType.MouseMovement or changedInput.UserInputType == Enum.UserInputType.Touch then
                    local sliderTop = Slider.AbsolutePosition.Y
                    local sliderHeight = Slider.AbsoluteSize.Y
                    local thumbHeight = Thumb.AbsoluteSize.Y
                    
                    local newY = changedInput.Position.Y - sliderTop - dragOffset
                    local maxThumbPos = sliderHeight - thumbHeight
                    
                    local newThumbPosScale = math.clamp(newY / maxThumbPos, 0, 1 - Thumb.Size.Y.Scale)
                    
                    Thumb.Position = UDim2.new(0, 0, newThumbPosScale, 0)
                    updateScrollingFramePosition()
                end
            end)

            releaseConnection = UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
                    isDragging = false
                    if moveConnection then moveConnection:Disconnect() end
                    if releaseConnection then releaseConnection:Disconnect() end
                end
            end)
        end
    end)

    Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("AbsoluteWindowSize"), function()
        updateSliderSize()
        updateThumbPosition()
    end)
    
    Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("AbsoluteCanvasSize"), function()
        updateSliderSize()
        updateThumbPosition()
    end)

    Creator.AddSignal(ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"), function()
        if not isDragging then
            updateThumbPosition()
        end
    end)

    updateSliderSize()
    updateThumbPosition()

    return Slider
end

function UIComponents.ToolTip(Title, Parent)
    local ToolTipModule = {
        Container = nil,
        ToolTipSize = 16,
    }
    
    local ToolTipTitle = New("TextLabel", {
        AutomaticSize = "XY",
        TextWrapped = true,
        BackgroundTransparency = 1,
        FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
        Text = Title,
        TextSize = 17,
        ThemeTag = {
            TextColor3 = "Text",
        }
    })
    
    local UIScale = New("UIScale", {
        Scale = .9 -- 1
    })
    
    local Container = New("CanvasGroup", {
        AnchorPoint = Vector2.new(0.5,0),
        AutomaticSize = "XY",
        BackgroundTransparency = 1,
        Parent = Parent,
        GroupTransparency = 1, -- 0
        Visible = false -- true
    }, {
        New("UISizeConstraint", {
            MaxSize = Vector2.new(400, math.huge)
        }),
        New("Frame", {
            AutomaticSize = "XY",
            BackgroundTransparency = 1,
            LayoutOrder = 99,
            Visible = false
        }, {
            New("ImageLabel", {
                Size = UDim2.new(0,ToolTipModule.ToolTipSize,0,ToolTipModule.ToolTipSize/2),
                BackgroundTransparency = 1,
                Rotation = 180,
                Image = "rbxassetid://89524607682719",
                ThemeTag = {
                    ImageColor3 = "Accent",
                },
            }, {
                New("ImageLabel", {
                    Size = UDim2.new(0,ToolTipModule.ToolTipSize,0,ToolTipModule.ToolTipSize/2),
                    BackgroundTransparency = 1,
                    LayoutOrder = 99,
                    ImageTransparency = .9,
                    Image = "rbxassetid://89524607682719",
                    ThemeTag = {
                        ImageColor3 = "Text",
                    },
                }),
            }),
        }),
        New("Frame", {
            AutomaticSize = "XY",
            ThemeTag = {
                BackgroundColor3 = "Accent",
            },
            
        }, {
            New("UICorner", {
                CornerRadius = UDim.new(0,16),
            }),
            New("Frame", {
                ThemeTag = {
                    BackgroundColor3 = "Text",
                },
                AutomaticSize = "XY",
                BackgroundTransparency = .9,
            }, {
                New("UICorner", {
                    CornerRadius = UDim.new(0,16),
                }),
                New("UIListLayout", {
                    Padding = UDim.new(0,12),
                    FillDirection = "Horizontal",
                    VerticalAlignment = "Center"
                }),
                --ToolTipIcon, 
                ToolTipTitle,
                New("UIPadding", {
                    PaddingTop = UDim.new(0,12),
                    PaddingLeft = UDim.new(0,12),
                    PaddingRight = UDim.new(0,12),
                    PaddingBottom = UDim.new(0,12),
                }),
            })
        }),
        UIScale,
        New("UIListLayout", {
            Padding = UDim.new(0,0),
            FillDirection = "Vertical",
            VerticalAlignment = "Center",
            HorizontalAlignment = "Center",
        }),
    })
    ToolTipModule.Container = Container
    
    function ToolTipModule:Open() 
        Container.Visible = true
        
        Tween(Container, .16, { GroupTransparency = 0 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(UIScale, .18, { Scale = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
    end
    
    function ToolTipModule:Close() 
        Tween(Container, .2, { GroupTransparency = 1 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        Tween(UIScale, .2, { Scale = .9 }, Enum.EasingStyle.Quint, Enum.EasingDirection.Out):Play()
        
        task.wait(.25)
        
        Container.Visible = false
        Container:Destroy()
    end
    
    return ToolTipModule
end

function UIComponents.Code(Code, Title, Parent, Callback)
    local CodeModule = {
        Radius = 12,
        Padding = 10
    }

    local TextLabel = New("TextLabel", {
        Text = "",
        TextColor3 = Color3.fromHex("#CDD6F4"),
        TextTransparency = 0,
        TextSize = 14,
        TextWrapped = false,
        LineHeight = 1.15,
        RichText = true,
        TextXAlignment = "Left",
        Size = UDim2.new(0,0,0,0),
        BackgroundTransparency = 1,
        AutomaticSize = "XY",
    }, {
        New("UIPadding", {
            PaddingTop = UDim.new(0,CodeModule.Padding+3),
            PaddingLeft = UDim.new(0,CodeModule.Padding+3),
            PaddingRight = UDim.new(0,CodeModule.Padding+3),
            PaddingBottom = UDim.new(0,CodeModule.Padding+3),
        })
    })
    TextLabel.Font = "Code"
    
    local ScrollingFrame = New("ScrollingFrame", {
        Size = UDim2.new(1,0,0,0),
        BackgroundTransparency = 1,
        AutomaticCanvasSize = "X",
        ScrollingDirection = "X",
        ElasticBehavior = "Never",
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 0,
    }, {
        TextLabel
    })
    
    local CopyButton = New("TextButton", {
        BackgroundTransparency = 1,
        Size = UDim2.new(0,30,0,30),
        Position = UDim2.new(1,-CodeModule.Padding/2,0,CodeModule.Padding/2),
        AnchorPoint = Vector2.new(1,0),
        Visible = Callback and true or false,
    }, {
        Creator.NewRoundFrame(CodeModule.Radius-4, "Squircle", {
            -- ThemeTag = {
            --     ImageColor3 = "Text",
            -- },
            ImageColor3 = Color3.fromHex("#ffffff"),
            ImageTransparency = 1, -- .95
            Size = UDim2.new(1,0,1,0),
            AnchorPoint = Vector2.new(0.5,0.5),
            Position = UDim2.new(0.5,0,0.5,0),
            Name = "Button",
        }, {
            New("UIScale", {
                Scale = 1, -- .9
            }),
            New("ImageLabel", {
                Image = Creator.Icon("copy")[1],
                ImageRectSize = Creator.Icon("copy")[2].ImageRectSize,
                ImageRectOffset = Creator.Icon("copy")[2].ImageRectPosition,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0.5,0.5),
                Position = UDim2.new(0.5,0,0.5,0),
                Size = UDim2.new(0,12,0,12),
                -- ThemeTag = {
                --     ImageColor3 = "Icon",
                -- }, 
                ImageColor3 = Color3.fromHex("#ffffff"),
                ImageTransparency = .1,
            })
        })
    })
    
    Creator.AddSignal(CopyButton.MouseEnter, function()
        Tween(CopyButton.Button, .05, {ImageTransparency = .95}):Play()
        Tween(CopyButton.Button.UIScale, .05, {Scale = .9}):Play()
    end)
    Creator.AddSignal(CopyButton.InputEnded, function()
        Tween(CopyButton.Button, .08, {ImageTransparency = 1}):Play()
        Tween(CopyButton.Button.UIScale, .08, {Scale = 1}):Play()
    end)
    
    local CodeFrame = Creator.NewRoundFrame(CodeModule.Radius, "Squircle", {
        -- ThemeTag = {
        --     ImageColor3 = "Text"
        -- },
        ImageColor3 = Color3.fromHex("#212121"),
        ImageTransparency = .035,
        Size = UDim2.new(1,0,0,20+(CodeModule.Padding*2)),
        AutomaticSize = "Y",
        Parent = Parent,
    }, {
        Creator.NewRoundFrame(CodeModule.Radius, "SquircleOutline", {
            Size = UDim2.new(1,0,1,0),
            -- ThemeTag = {
            --     ImageColor3 = "Text"
            -- },
            ImageColor3 = Color3.fromHex("#ffffff"),
            ImageTransparency = .955,
        }),
        New("Frame", {
            BackgroundTransparency = 1,
            Size = UDim2.new(1,0,0,0),
            AutomaticSize = "Y",
        }, {
            Creator.NewRoundFrame(CodeModule.Radius, "Squircle-TL-TR", {
                -- ThemeTag = {
                --     ImageColor3 = "Text"
                -- },
                ImageColor3 = Color3.fromHex("#ffffff"),
                ImageTransparency = .96,
                Size = UDim2.new(1,0,0,20+(CodeModule.Padding*2)),
                Visible = Title and true or false
            }, {
                New("ImageLabel", {
                    Size = UDim2.new(0,18,0,18),
                    BackgroundTransparency = 1,
                    Image = "rbxassetid://132464694294269", -- luau logo
                    -- ThemeTag = {
                    --     ImageColor3 = "Icon",
                    -- },
                    ImageColor3 = Color3.fromHex("#ffffff"),
                    ImageTransparency = .2,
                }),
                New("TextLabel", {
                    Text = Title,
                    -- ThemeTag = {
                    --     TextColor3 = "Icon",
                    -- },
                    TextColor3 = Color3.fromHex("#ffffff"),
                    TextTransparency = .2,
                    TextSize = 16,
                    AutomaticSize = "Y",
                    FontFace = Font.new(Creator.Font, Enum.FontWeight.Medium),
                    TextXAlignment = "Left",
                    BackgroundTransparency = 1,
                    TextTruncate = "AtEnd",
                    Size = UDim2.new(1,CopyButton and -20-(CodeModule.Padding*2),0,0)
                }),
                New("UIPadding", {
                    --PaddingTop = UDim.new(0,CodeModule.Padding),
                    PaddingLeft = UDim.new(0,CodeModule.Padding+3),
                    PaddingRight = UDim.new(0,CodeModule.Padding+3),
                    --PaddingBottom = UDim.new(0,CodeModule.Padding),
                }),
                New("UIListLayout", {
                    Padding = UDim.new(0,CodeModule.Padding),
                    FillDirection = "Horizontal",
                    VerticalAlignment = "Center",
                })
            }),
            ScrollingFrame,
            New("UIListLayout", {
                Padding = UDim.new(0,0),
                FillDirection = "Vertical",
            })
        }),
        CopyButton,
    })
    
    Creator.AddSignal(TextLabel:GetPropertyChangedSignal("TextBounds"), function()
        ScrollingFrame.Size = UDim2.new(1,0,0,TextLabel.TextBounds.Y + ((CodeModule.Padding+3)*2))
    end)
    
    function CodeModule.Set(code)
        TextLabel.Text = Highlighter.run(code)
    end
    
    CodeModule.Set(Code)

    Creator.AddSignal(CopyButton.MouseButton1Click, function()
        if Callback then
            Callback()
            local CheckIcon = Creator.Icon("check")
            CopyButton.Button.ImageLabel.Image = CheckIcon[1]
            CopyButton.Button.ImageLabel.ImageRectSize = CheckIcon[2].ImageRectSize
            CopyButton.Button.ImageLabel.ImageRectOffset = CheckIcon[2].ImageRectPosition
        end
    end)
    return CodeModule
end

return UIComponents