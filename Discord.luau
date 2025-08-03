local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local guiName = "DiscordV1"
local old = playerGui:FindFirstChild(guiName)
if old then old:Destroy() end

local DISCORD_INVITE_CODE = "SyBSpfCpUf"
local LOGO_ASSET_ID = "rbxassetid://98132073663470"

local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local screenGui = Instance.new("ScreenGui")
screenGui.Name = guiName
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.Parent = playerGui

local backdropFrame = Instance.new("Frame")
backdropFrame.Name = "BackdropFrame"
backdropFrame.Size = UDim2.new(1, 0, 1, 0)
backdropFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
backdropFrame.BackgroundTransparency = 1
backdropFrame.BorderSizePixel = 0
backdropFrame.Visible = false
backdropFrame.ZIndex = 1
backdropFrame.Parent = screenGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = isMobile and UDim2.fromOffset(340, 250) or UDim2.fromOffset(440, 290)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundTransparency = 1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 2
mainFrame.Parent = screenGui

local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(34,36,45)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 23, 29))
})
grad.Rotation = 135
grad.Parent = mainFrame

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Color = Color3.fromRGB(88, 101, 242)
mainStroke.Thickness = 1.7
mainStroke.Transparency = 0.7
mainStroke.Parent = mainFrame

local headerFrame = Instance.new("TextButton")
headerFrame.Name = "HeaderFrame"
headerFrame.Size = UDim2.new(1, 0, 0, 90)
headerFrame.BackgroundTransparency = 1
headerFrame.ZIndex = 3
headerFrame.Text = ""
headerFrame.AutoButtonColor = false
headerFrame.Parent = mainFrame

local logoImage = Instance.new("ImageLabel")
logoImage.Name = "LogoImage"
logoImage.Size = UDim2.fromOffset(52, 52)
logoImage.Position = UDim2.new(0, 30, 0.5, 0)
logoImage.AnchorPoint = Vector2.new(0, 0.5)
logoImage.BackgroundTransparency = 1
logoImage.Image = LOGO_ASSET_ID
logoImage.ImageColor3 = Color3.fromRGB(255, 255, 255)
logoImage.ZIndex = 4
logoImage.Parent = headerFrame

local logoAspect = Instance.new("UIAspectRatioConstraint")
logoAspect.AspectRatio = 1
logoAspect.Parent = logoImage

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -160, 0, 30)
titleLabel.Position = UDim2.new(0, 100, 0, 28)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Join Our Community"
titleLabel.TextColor3 = Color3.fromRGB(250, 250, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 24
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.ZIndex = 4
titleLabel.Parent = headerFrame

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Name = "SubtitleLabel"
subtitleLabel.Size = UDim2.new(1, -160, 0, 20)
subtitleLabel.Position = UDim2.new(0, 100, 0, 54)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Join Discord For More Update!"
subtitleLabel.TextColor3 = Color3.fromRGB(168, 170, 189)
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextSize = 15
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.ZIndex = 4
subtitleLabel.Parent = headerFrame

local descLabel = Instance.new("TextLabel")
descLabel.Name = "DescriptionLabel"
descLabel.Size = UDim2.new(1, -60, 0, 80)
descLabel.Position = UDim2.new(0.5, 0, 0, 100)
descLabel.AnchorPoint = Vector2.new(0.5, 0)
descLabel.BackgroundTransparency = 1
descLabel.Text = "Get access to new updates, events, giveaways, and chat with other players in our official Discord server."
descLabel.TextColor3 = Color3.fromRGB(200, 202, 221)
descLabel.Font = Enum.Font.Gotham
descLabel.TextSize = 16
descLabel.TextWrapped = true
descLabel.TextXAlignment = Enum.TextXAlignment.Left
descLabel.TextYAlignment = Enum.TextYAlignment.Top
descLabel.LineHeight = 1.2
descLabel.ZIndex = 3
descLabel.Parent = mainFrame

local joinButton = Instance.new("TextButton")
joinButton.Name = "JoinButton"
joinButton.Size = UDim2.new(1, -60, 0, 50)
joinButton.Position = UDim2.new(0.5, 0, 1, -30)
joinButton.AnchorPoint = Vector2.new(0.5, 1)
joinButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
joinButton.BorderSizePixel = 0
joinButton.Text = "Copy Invite & Join"
joinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
joinButton.Font = Enum.Font.GothamBold
joinButton.TextSize = 18
joinButton.ZIndex = 3
joinButton.AutoButtonColor = false
joinButton.Parent = mainFrame

local joinCorner = Instance.new("UICorner")
joinCorner.CornerRadius = UDim.new(0, 10)
joinCorner.Parent = joinButton

local isAnimating = false
local guiVisible = false
local tweenInfoEnter = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfoExit = TweenInfo.new(0.33, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenInfoHover = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local mainFrameTween

local function setGuiVisible(visible)
    if isAnimating or guiVisible == visible then return end
    isAnimating = true
    guiVisible = visible

    local tweenInfo = visible and tweenInfoEnter or tweenInfoExit
    if visible then
        backdropFrame.Visible = true
        mainFrame.Visible = true
        mainFrame.Position = UDim2.new(0.5, 0, 0.55, 0)
        mainFrame.Rotation = -4
    end

    local mainPos = visible and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.47, 0)
    local mainRot = visible and 0 or 4
    local bgTrans = visible and 0.65 or 1
    local frameTrans = visible and 0.09 or 1

    local backdropTween = TweenService:Create(backdropFrame, tweenInfo, { BackgroundTransparency = bgTrans })
    mainFrameTween = TweenService:Create(mainFrame, tweenInfo, {
        Position = mainPos,
        Rotation = mainRot,
        BackgroundTransparency = frameTrans
    })
    
    backdropTween:Play()
    mainFrameTween:Play()
    mainFrameTween.Completed:Connect(function()
        if not visible then
            backdropFrame.Visible = false
            mainFrame.Visible = false
        end
        isAnimating = false
    end)
end

do
    local dragActive = false
    local dragInput, dragStart, startPos, lastPos

    headerFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragActive = true
            dragInput = input
            dragStart = input.Position
            local absPos = mainFrame.AbsolutePosition
            startPos = Vector2.new(absPos.X, absPos.Y)
            lastPos = dragStart

            TweenService:Create(mainStroke, tweenInfoHover, { Thickness = 3, Transparency = 0.45 }):Play()
        end
    end)

    headerFrame.InputEnded:Connect(function(input)
        if input == dragInput then
            dragActive = false
            dragInput = nil
            TweenService:Create(mainFrame, tweenInfoHover, { Rotation = 0 }):Play()
            TweenService:Create(mainStroke, tweenInfoHover, { Thickness = 1.7, Transparency = 0.7 }):Play()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragActive and input == dragInput then
            local delta = input.Position - dragStart
            local parentAbsSize = screenGui.AbsoluteSize
            local frameSize = mainFrame.AbsoluteSize
            local newX = math.clamp(startPos.X + delta.X, 0, parentAbsSize.X - frameSize.X)
            local newY = math.clamp(startPos.Y + delta.Y, 0, parentAbsSize.Y - frameSize.Y)
            mainFrame.Position = UDim2.fromOffset(newX, newY)
            local velocity = (input.Position - lastPos) * 0.17
            lastPos = input.Position
            mainFrame.Rotation = math.clamp(velocity.X, -5, 5)
        end
    end)
end

do
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil
    local lastPos = nil

    local function isOverButton(guiObj)
        return guiObj == joinButton or guiObj == closeButton
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            local target = input.UserInputType == Enum.UserInputType.Touch and UserInputService:GetFocusedTextBox() or game:GetService("UserInputService"):GetMouseLocation()
            if UserInputService:GetFocusedTextBox() then return end
            local mouse = UserInputService:GetMouseLocation()
            if joinButton.AbsolutePosition.X <= mouse.X and mouse.X <= joinButton.AbsolutePosition.X + joinButton.AbsoluteSize.X and
                joinButton.AbsolutePosition.Y <= mouse.Y and mouse.Y <= joinButton.AbsolutePosition.Y + joinButton.AbsoluteSize.Y then
                return
            end
            if closeButton.AbsolutePosition.X <= mouse.X and mouse.X <= closeButton.AbsolutePosition.X + closeButton.AbsoluteSize.X and
                closeButton.AbsolutePosition.Y <= mouse.Y and mouse.Y <= closeButton.AbsolutePosition.Y + closeButton.AbsoluteSize.Y then
                return
            end

            dragging = true
            dragInput = input
            dragStart = input.Position
            startPos = mainFrame.AbsolutePosition
            lastPos = dragStart
            TweenService:Create(mainStroke, tweenInfoHover, { Thickness = 3, Transparency = 0.45 }):Play()
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - dragStart
            local sz = screenGui.AbsoluteSize
            local frameSz = mainFrame.AbsoluteSize
            local newX = math.clamp(startPos.X + delta.X, 0, sz.X - frameSz.X)
            local newY = math.clamp(startPos.Y + delta.Y, 0, sz.Y - frameSz.Y)
            mainFrame.Position = UDim2.fromOffset(newX, newY)
            local velocity = (input.Position - lastPos) * 0.15
            lastPos = input.Position
            mainFrame.Rotation = math.clamp(velocity.X, -5, 5)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if dragging and input == dragInput then
            dragging = false
            dragInput = nil
            TweenService:Create(mainFrame, tweenInfoHover, { Rotation = 0 }):Play()
            TweenService:Create(mainStroke, tweenInfoHover, { Thickness = 1.7, Transparency = 0.7 }):Play()
        end
    end)
end

joinButton.MouseEnter:Connect(function()
    TweenService:Create(joinButton, tweenInfoHover, { BackgroundColor3 = Color3.fromRGB(108, 121, 252) }):Play()
end)
joinButton.MouseLeave:Connect(function()
    TweenService:Create(joinButton, tweenInfoHover, { BackgroundColor3 = Color3.fromRGB(88, 101, 242) }):Play()
end)

local isCopied = false
joinButton.MouseButton1Click:Connect(function()
    if isCopied then return end
    isCopied = true

    if setclipboard then
        setclipboard("https://discord.gg/" .. DISCORD_INVITE_CODE)
    end

    local originalText = joinButton.Text
    local originalColor = joinButton.BackgroundColor3
    
    joinButton.Text = "Copied to Clipboard"
    joinButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96)
    task.delay(2, function()
        joinButton.Text = originalText
        TweenService:Create(joinButton, tweenInfoHover, { BackgroundColor3 = originalColor }):Play()
        isCopied = false
    end)
end)

local function autoScale()
    local sz = screenGui.AbsoluteSize
    if sz.X < 350 then
        mainFrame.Size = UDim2.fromOffset(math.max(240, sz.X-10), 220)
        descLabel.TextSize = 13
        titleLabel.TextSize = 18
    end
end
screenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(autoScale)
autoScale()

task.wait(0.38)
setGuiVisible(true)
task.wait(5)
setGuiVisible(false)
task.wait(tweenInfoExit.Time)
if screenGui and screenGui.Parent then screenGui:Destroy() end
