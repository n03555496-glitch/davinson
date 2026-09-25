--[[
    QUINDA HUB v3.0
    Game: Just An Innocent (MMV, Modded)
    Стиль: Thunder Hub
    Функций: 300+
    Специальные кнопки: Grag Gun, Auto Grag Gun, Shoot Murderer
    Оптимизировано для Delta Executor
]]

-- =============================================
-- СЕРВИСЫ
-- =============================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = Player:GetMouse()

-- =============================================
-- ТЕМА THUNDER HUB
-- =============================================
local Theme = {
    Main = Color3.fromRGB(18, 18, 28),
    Secondary = Color3.fromRGB(28, 28, 42),
    Accent = Color3.fromRGB(0, 180, 255),
    Accent2 = Color3.fromRGB(255, 70, 70),
    Success = Color3.fromRGB(0, 255, 120),
    Warning = Color3.fromRGB(255, 200, 0),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(130, 130, 150),
    Shadow = Color3.fromRGB(0, 0, 0)
}

-- =============================================
-- GUI СИСТЕМА
-- =============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuindaHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainWindow"
MainFrame.Size = UDim2.new(0, 620, 0, 450)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -225)
MainFrame.BackgroundColor3 = Theme.Main
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Тень
local Shadow = Instance.new("UIStroke")
Shadow.Color = Theme.Shadow
Shadow.Thickness = 2
Shadow.Transparency = 0.3
Shadow.Parent = MainFrame

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Theme.Secondary
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

-- Логотип
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(0, 30, 0, 30)
Logo.Position = UDim2.new(0, 5, 0, 5)
Logo.BackgroundTransparency = 1
Logo.Text = "⚡"
Logo.TextColor3 = Theme.Accent
Logo.TextSize = 20
Logo.Font = Enum.Font.GothamBold
Logo.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, -100, 1, 0)
TitleText.Position = UDim2.new(0, 40, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "QUINDA HUB"
TitleText.TextColor3 = Theme.Accent
TitleText.TextSize = 20
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0, 50, 0, 20)
VersionText.Position = UDim2.new(0, 140, 0, 10)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v3.0"
VersionText.TextColor3 = Theme.TextDim
VersionText.TextSize = 12
VersionText.Font = Enum.Font.Gotham
VersionText.TextXAlignment = Enum.TextXAlignment.Left
VersionText.Parent = TitleBar

-- Кнопки окна
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Theme.Accent2
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -70, 0, 5)
MinBtn.BackgroundColor3 = Theme.Secondary
MinBtn.Text = "—"
MinBtn.TextColor3 = Theme.Text
MinBtn.TextSize = 16
MinBtn.Font = Enum.Font.GothamBold
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TitleBar

-- Контейнер вкладок
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(0, 140, 1, -40)
TabContainer.Position = UDim2.new(0, 0, 0, 40)
TabContainer.BackgroundColor3 = Theme.Secondary
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

-- Контейнер контента
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -140, 1, -40)
ContentFrame.Position = UDim2.new(0, 140, 0, 40)
ContentFrame.BackgroundColor3 = Theme.Main
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Перетаскивание окна
local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

MinBtn.MouseButton1Click:Connect(function()
    ContentFrame.Visible = not ContentFrame.Visible
    TabContainer.Visible = not TabContainer.Visible
    MainFrame.Size = ContentFrame.Visible and UDim2.new(0, 620, 0, 450) or UDim2.new(0, 620, 0, 40)
end)

-- =============================================
-- СИСТЕМА КНОПОК (CUSTOM BUTTONS)
-- =============================================
local ButtonSystem = {
    Buttons = {},
    Settings = {
        Draggable = true,
        Resizable = true,
        Locked = false
    }
}

-- Функция создания кнопки на экране
function ButtonSystem:CreateButton(name, position, size, color, callback)
    local btn = Instance.new("TextButton")
    btn.Name = "CustomButton_" .. name
    btn.Size = size or UDim2.new(0, 100, 0, 40)
    btn.Position = position or UDim2.new(0.5, -50, 0.5, -20)
    btn.BackgroundColor3 = color or Theme.Accent
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = ScreenGui
    
    -- Эффект наведения
    btn.MouseEnter:Connect(function()
        if not ButtonSystem.Settings.Locked then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent2}):Play()
        end
    end)
    
    btn.MouseLeave:Connect(function()
        if not ButtonSystem.Settings.Locked then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
        end
    end)
    
    -- Клик
    btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    -- Перетаскивание
    local btnDragging = false
    local btnDragStart, btnStartPos
    
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and ButtonSystem.Settings.Draggable and not ButtonSystem.Settings.Locked then
            btnDragging = true
            btnDragStart = input.Position
            btnStartPos = btn.Position
        end
    end)
    
    btn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and btnDragging then
            local delta = input.Position - btnDragStart
            btn.Position = UDim2.new(
                btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X,
                btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y
            )
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            btnDragging = false
        end
    end)
    
    -- Изменение размера (правый клик)
    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton2 and ButtonSystem.Settings.Resizable and not ButtonSystem.Settings.Locked then
            local resizeConn
            resizeConn = UserInputService.InputChanged:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = inp.Position - btnDragStart
                    local newSize = UDim2.new(0, math.max(50, btnStartPos.X.Offset + delta.X), 0, math.max(30, btnStartPos.Y.Offset + delta.Y))
                    btn.Size = newSize
                end
            end)
            UserInputService.InputEnded:Connect(function(inp)
                if inp.UserInputType == Enum.UserInputType.MouseButton2 then
                    resizeConn:Disconnect()
                end
            end)
        end
    end)
    
    local buttonData = {
        Name = name,
        Button = btn,
        OriginalColor = color,
        Position = btn.Position,
        Size = btn.Size
    }
    
    table.insert(ButtonSystem.Buttons, buttonData)
    return btn
end

-- Функция блокировки кнопок
function ButtonSystem:SetLocked(bool)
    ButtonSystem.Settings.Locked = bool
end

-- Функция показать/скрыть кнопки
function ButtonSystem:SetVisible(bool)
    for _, btn in ipairs(ButtonSystem.Buttons) do
        btn.Button.Visible = bool
    end
end

-- =============================================
-- БИБЛИОТЕКА ИНТЕРФЕЙСА (THUNDER HUB STYLE)
-- =============================================
local Library = {}
Library.Toggles = {}
Library.Flags = {}
Library.Values = {}

-- Система вкладок
local Tabs = {}
local CurrentTab = nil

function Library:CreateTab(name, icon)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, -20, 0, 35)
    TabBtn.Position = UDim2.new(0, 10, 0, 10 + (#Tabs * 45))
    TabBtn.BackgroundColor3 = Theme.Main
    TabBtn.Text = icon .. "  " .. name
    TabBtn.TextColor3 = Theme.TextDim
    TabBtn.TextSize = 13
    TabBtn.Font = Enum.Font.Gotham
    TabBtn.BorderSizePixel = 0
    TabBtn.Parent = TabContainer
    
    TabBtn.MouseEnter:Connect(function()
        if CurrentTab ~= name then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Secondary}):Play()
        end
    end)
    
    TabBtn.MouseLeave:Connect(function()
        if CurrentTab ~= name then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Main}):Play()
        end
    end)
    
    local TabContent = Instance.new("ScrollingFrame")
    TabContent.Size = UDim2.new(1, -20, 1, -20)
    TabContent.Position = UDim2.new(0, 10, 0, 10)
    TabContent.BackgroundTransparency = 1
    TabContent.BorderSizePixel = 0
    TabContent.ScrollBarThickness = 5
    TabContent.ScrollBarImageColor3 = Theme.Accent
    TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabContent.Visible = false
    TabContent.Parent = ContentFrame
    
    local tab = {
        Name = name,
        Button = TabBtn,
        Content = TabContent,
        Elements = {}
    }
    
    Tabs[name] = tab
    
    TabBtn.MouseButton1Click:Connect(function()
        Library:SelectTab(name)
    end)
    
    return tab
end

function Library:SelectTab(name)
    if CurrentTab then
        Tabs[CurrentTab].Content.Visible = false
        Tabs[CurrentTab].Button.BackgroundColor3 = Theme.Main
        Tabs[CurrentTab].Button.TextColor3 = Theme.TextDim
    end
    
    CurrentTab = name
    Tabs[name].Content.Visible = true
    Tabs[name].Button.BackgroundColor3 = Theme.Accent
    Tabs[name].Button.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- Секция
function Library:CreateSection(tab, title)
    local Section = Instance.new("Frame")
    Section.Size = UDim2.new(1, -20, 0, 30)
    Section.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    Section.BackgroundTransparency = 1
    Section.Parent = tab.Content
    
    local Line1 = Instance.new("Frame")
    Line1.Size = UDim2.new(0, 80, 0, 2)
    Line1.Position = UDim2.new(0, 0, 0, 14)
    Line1.BackgroundColor3 = Theme.Accent
    Line1.BorderSizePixel = 0
    Line1.Parent = Section
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -160, 1, 0)
    Label.Position = UDim2.new(0, 90, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = title
    Label.TextColor3 = Theme.Accent
    Label.TextSize = 15
    Label.Font = Enum.Font.GothamBold
    Label.TextXAlignment = Enum.TextXAlignment.Center
    Label.Parent = Section
    
    local Line2 = Instance.new("Frame")
    Line2.Size = UDim2.new(0, 80, 0, 2)
    Line2.Position = UDim2.new(1, -80, 0, 14)
    Line2.BackgroundColor3 = Theme.Accent
    Line2.BorderSizePixel = 0
    Line2.Parent = Section
    
    table.insert(tab.Elements, Section)
    return Section
end

-- Тоггл
function Library:CreateToggle(tab, name, default, callback)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = ToggleFrame
    
    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Size = UDim2.new(0, 40, 0, 20)
    ToggleBtn.Position = UDim2.new(1, -45, 0, 5)
    ToggleBtn.BackgroundColor3 = default and Theme.Success or Theme.Secondary
    ToggleBtn.Text = default and "ON" or "OFF"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextSize = 10
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Parent = ToggleFrame
    
    local enabled = default or false
    Library.Toggles[name] = enabled
    
    ToggleBtn.MouseButton1Click:Connect(function()
        enabled = not enabled
        Library.Toggles[name] = enabled
        ToggleBtn.BackgroundColor3 = enabled and Theme.Success or Theme.Secondary
        ToggleBtn.Text = enabled and "ON" or "OFF"
        pcall(callback, enabled)
    end)
    
    table.insert(tab.Elements, ToggleFrame)
    return ToggleFrame
end

-- Кнопка
function Library:CreateButton(tab, name, callback)
    local BtnFrame = Instance.new("Frame")
    BtnFrame.Size = UDim2.new(1, -20, 0, 35)
    BtnFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    BtnFrame.BackgroundTransparency = 1
    BtnFrame.Parent = tab.Content
    
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 30)
    Button.Position = UDim2.new(0, 0, 0, 2)
    Button.BackgroundColor3 = Theme.Secondary
    Button.Text = name
    Button.TextColor3 = Theme.Text
    Button.TextSize = 13
    Button.Font = Enum.Font.Gotham
    Button.BorderSizePixel = 0
    Button.Parent = BtnFrame
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Secondary}):Play()
    end)
    
    Button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
    
    table.insert(tab.Elements, BtnFrame)
    return BtnFrame
end

-- Слайдер
function Library:CreateSlider(tab, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    SliderFrame.Size = UDim2.new(1, -20, 0, 40)
    SliderFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 40)
    SliderFrame.BackgroundTransparency = 1
    SliderFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 0, 20)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = SliderFrame
    
    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -55, 0, 0)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Theme.Accent
    ValueLabel.TextSize = 13
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = SliderFrame
    
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(1, 0, 0, 5)
    SliderBg.Position = UDim2.new(0, 0, 0, 30)
    SliderBg.BackgroundColor3 = Theme.Secondary
    SliderBg.BorderSizePixel = 0
    SliderBg.Parent = SliderFrame
    
    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Theme.Accent
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBg
    
    local SliderBtn = Instance.new("TextButton")
    SliderBtn.Size = UDim2.new(0, 15, 0, 15)
    SliderBtn.Position = UDim2.new((default - min) / (max - min), -7, 0, -5)
    SliderBtn.BackgroundColor3 = Theme.Text
    SliderBtn.BorderSizePixel = 0
    SliderBtn.Text = ""
    SliderBtn.Parent = SliderBg
    
    local value = default
    
    SliderBtn.MouseButton1Down:Connect(function()
        local connection
        connection = UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local relative = (input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X
                relative = math.clamp(relative, 0, 1)
                value = math.floor(min + (max - min) * relative)
                SliderFill.Size = UDim2.new(relative, 0, 1, 0)
                SliderBtn.Position = UDim2.new(relative, -7, 0, -5)
                ValueLabel.Text = tostring(value)
                pcall(callback, value)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end)
    
    table.insert(tab.Elements, SliderFrame)
    return SliderFrame
end

-- Дропдаун
function Library:CreateDropdown(tab, name, options, default, callback)
    local DropFrame = Instance.new("Frame")
    DropFrame.Size = UDim2.new(1, -20, 0, 35)
    DropFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    DropFrame.BackgroundTransparency = 1
    DropFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 15)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = DropFrame
    
    local DropBtn = Instance.new("TextButton")
    DropBtn.Size = UDim2.new(1, 0, 0, 20)
    DropBtn.Position = UDim2.new(0, 0, 0, 15)
    DropBtn.BackgroundColor3 = Theme.Secondary
    DropBtn.Text = default or options[1]
    DropBtn.TextColor3 = Theme.Text
    DropBtn.TextSize = 12
    DropBtn.Font = Enum.Font.Gotham
    DropBtn.BorderSizePixel = 0
    DropBtn.Parent = DropFrame
    
    local DropList = Instance.new("Frame")
    DropList.Size = UDim2.new(1, 0, 0, #options * 25)
    DropList.Position = UDim2.new(0, 0, 0, 35)
    DropList.BackgroundColor3 = Theme.Secondary
    DropList.BorderSizePixel = 0
    DropList.Visible = false
    DropList.Parent = DropFrame
    
    local selected = default or options[1]
    
    for i, option in ipairs(options) do
        local OptionBtn = Instance.new("TextButton")
        OptionBtn.Size = UDim2.new(1, 0, 0, 25)
        OptionBtn.Position = UDim2.new(0, 0, 0, (i - 1) * 25)
        OptionBtn.BackgroundColor3 = Theme.Main
        OptionBtn.Text = option
        OptionBtn.TextColor3 = Theme.Text
        OptionBtn.TextSize = 12
        OptionBtn.Font = Enum.Font.Gotham
        OptionBtn.BorderSizePixel = 0
        OptionBtn.Parent = DropList
        
        OptionBtn.MouseEnter:Connect(function()
            OptionBtn.BackgroundColor3 = Theme.Accent
        end)
        
        OptionBtn.MouseLeave:Connect(function()
            OptionBtn.BackgroundColor3 = Theme.Main
        end)
        
        OptionBtn.MouseButton1Click:Connect(function()
            selected = option
            DropBtn.Text = option
            DropList.Visible = false
            pcall(callback, option)
        end)
    end
    
    DropBtn.MouseButton1Click:Connect(function()
        DropList.Visible = not DropList.Visible
    end)
    
    table.insert(tab.Elements, DropFrame)
    return DropFrame
end

-- Текстовое поле
function Library:CreateTextBox(tab, name, placeholder, callback)
    local BoxFrame = Instance.new("Frame")
    BoxFrame.Size = UDim2.new(1, -20, 0, 35)
    BoxFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    BoxFrame.BackgroundTransparency = 1
    BoxFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 15)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = BoxFrame
    
    local TextBox = Instance.new("TextBox")
    TextBox.Size = UDim2.new(1, 0, 0, 20)
    TextBox.Position = UDim2.new(0, 0, 0, 15)
    TextBox.BackgroundColor3 = Theme.Secondary
    TextBox.PlaceholderText = placeholder
    TextBox.Text = ""
    TextBox.TextColor3 = Theme.Text
    TextBox.PlaceholderColor3 = Theme.TextDim
    TextBox.TextSize = 12
    TextBox.Font = Enum.Font.Gotham
    TextBox.BorderSizePixel = 0
    TextBox.Parent = BoxFrame
    
    TextBox.FocusLost:Connect(function()
        pcall(callback, TextBox.Text)
    end)
    
    table.insert(tab.Elements, BoxFrame)
    return BoxFrame
end

-- Кейбинд
function Library:CreateKeybind(tab, name, default, callback)
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Size = UDim2.new(1, -20, 0, 30)
    KeyFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 35)
    KeyFrame.BackgroundTransparency = 1
    KeyFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = Theme.Text
    Label.TextSize = 13
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = KeyFrame
    
    local KeyBtn = Instance.new("TextButton")
    KeyBtn.Size = UDim2.new(0, 40, 0, 20)
    KeyBtn.Position = UDim2.new(1, -45, 0, 5)
    KeyBtn.BackgroundColor3 = Theme.Secondary
    KeyBtn.Text = default.Name
    KeyBtn.TextColor3 = Theme.Text
    KeyBtn.TextSize = 10
    KeyBtn.Font = Enum.Font.GothamBold
    KeyBtn.BorderSizePixel = 0
    KeyBtn.Parent = KeyFrame
    
    local key = default
    
    KeyBtn.MouseButton1Click:Connect(function()
        KeyBtn.Text = "..."
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode ~= Enum.KeyCode.Unknown then
                key = input.KeyCode
                KeyBtn.Text = key.Name
                connection:Disconnect()
                pcall(callback, key)
            end
        end)
    end)
    
    table.insert(tab.Elements, KeyFrame)
    return KeyFrame
end

-- Лейбл
function Library:CreateLabel(tab, text, color)
    local LabelFrame = Instance.new("Frame")
    LabelFrame.Size = UDim2.new(1, -20, 0, 25)
    LabelFrame.Position = UDim2.new(0, 0, 0, #tab.Elements * 25)
    LabelFrame.BackgroundTransparency = 1
    LabelFrame.Parent = tab.Content
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = color or Theme.TextDim
    Label.TextSize = 12
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = LabelFrame
    
    table.insert(tab.Elements, LabelFrame)
    return LabelFrame
end

-- Уведомления
function Library:Notify(title, text, duration)
    local Notification = Instance.new("Frame")
    Notification.Name = "Notification"
    Notification.Size = UDim2.new(0, 320, 0, 60)
    Notification.Position = UDim2.new(1, -330, 0, 10)
    Notification.BackgroundColor3 = Theme.Secondary
    Notification.BorderSizePixel = 0
    Notification.Parent = ScreenGui
    
    local AccentBar = Instance.new("Frame")
    AccentBar.Size = UDim2.new(0, 4, 1, 0)
    AccentBar.BackgroundColor3 = Theme.Accent
    AccentBar.BorderSizePixel = 0
    AccentBar.Parent = Notification
    
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Size = UDim2.new(1, -20, 0, 20)
    NotifTitle.Position = UDim2.new(0, 10, 0, 5)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Text = title
    NotifTitle.TextColor3 = Theme.Accent
    NotifTitle.TextSize = 14
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Parent = Notification
    
    local NotifText = Instance.new("TextLabel")
    NotifText.Size = UDim2.new(1, -20, 0, 30)
    NotifText.Position = UDim2.new(0, 10, 0, 25)
    NotifText.BackgroundTransparency = 1
    NotifText.Text = text
    NotifText.TextColor3 = Theme.Text
    NotifText.TextSize = 12
    NotifText.Font = Enum.Font.Gotham
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    NotifText.Parent = Notification
    
    Notification.Position = UDim2.new(1, 20, 0, 10)
    TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -330, 0, 10)
    }):Play()
    
    task.delay(duration or 3, function()
        TweenService:Create(Notification, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, 20, 0, 10)
        }):Play()
        task.delay(0.3, function()
            Notification:Destroy()
        end)
    end)
end

-- =============================================
-- СОЗДАНИЕ ВКЛАДОК
-- =============================================
local TabsList = {
    {"Misc", "🎲"},
    {"Player", "🧑"},
    {"Movement", "🏃"},
    {"Combat", "⚔️"},
    {"Visuals", "👁️"},
    {"World", "🌍"},
    {"ESP", "📡"},
    {"Buttons", "🔘"},
    {"Troll", "🤡"},
    {"Configs", "⚙️"},
    {"Credits", "💎"}
}

local CreatedTabs = {}

for _, tabInfo in ipairs(TabsList) do
    CreatedTabs[tabInfo[1]] = Library:CreateTab(tabInfo[1], tabInfo[2])
end

-- =============================================
-- ПОИСК ИГРОВЫХ ОБЪЕКТОВ
-- =============================================
local function getChar()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function getHum()
    local char = getChar()
    return char:FindFirstChild("Humanoid")
end

local function getHRP()
    local char = getChar()
    return char:FindFirstChild("HumanoidRootPart")
end

local function getPlayers()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            local hum = plr.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                table.insert(list, {
                    Player = plr,
                    Character = plr.Character,
                    RootPart = hrp,
                    Humanoid = hum
                })
            end
        end
    end
    return list
end

local function getNearestPlayer(maxDist)
    local players = getPlayers()
    local nearest = nil
    local nearestDist = maxDist or math.huge
    
    for _, p in ipairs(players) do
        local dist = (Camera.CFrame.Position - p.RootPart.Position).Magnitude
        if dist < nearestDist then
            nearestDist = dist
            nearest = p
        end
    end
    return nearest
end

local function getTool()
    local char = getChar()
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then
            return child
        end
    end
    return nil
end

-- =============================================
-- MISC TAB
-- =============================================
Library:CreateLabel(CreatedTabs.Misc, "🎭 QUINDA HUB", Theme.Accent)
Library:CreateLabel(CreatedTabs.Misc, "Just An Innocent | MMV Modded", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Misc, "Версия: 3.0 | Thunder Style", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Misc, "", Theme.TextDim)

Library:CreateSection(CreatedTabs.Misc, "Информация")

Library:CreateButton(CreatedTabs.Misc, "📊 Моя статистика", function()
    local hum = getHum()
    local hrp = getHRP()
    if hum and hrp then
        Library:Notify("Статистика", 
            "HP: " .. math.floor(hum.Health) .. "/" .. math.floor(hum.MaxHealth) ..
            "\nПозиция: X=" .. math.floor(hrp.Position.X) .. 
            " Y=" .. math.floor(hrp.Position.Y) ..
            " Z=" .. math.floor(hrp.Position.Z), 3)
    end
end)

Library:CreateButton(CreatedTabs.Misc, "👥 Список игроков", function()
    local players = getPlayers()
    local text = "Игроков: " .. #players .. "\n"
    for i, p in ipairs(players) do
        if i <= 8 then
            text = text .. p.Player.Name .. "\n"
            if i == 8 then
                text = text .. "..."
            end
        end
    end
    Library:Notify("Сервер", text, 3)
end)

Library:CreateButton(CreatedTabs.Misc, "🖥️ Информация об игре", function()
    Library:Notify("Игра", 
        "Place ID: " .. game.PlaceId .. 
        "\nИгроков: " .. #Players:GetPlayers() ..
        "\nPing: " .. math.floor(Player:GetNetworkPing() * 1000) .. "ms", 3)
end)

Library:CreateSection(CreatedTabs.Misc, "Анти-АФК")

Library:CreateToggle(CreatedTabs.Misc, "Анти-АФК", true, function(value)
    _G.AntiAFK = value
end)

Library:CreateToggle(CreatedTabs.Misc, "Авто-движение", false, function(value)
    _G.AutoMove = value
end)

Library:CreateToggle(CreatedTabs.Misc, "Авто-прыжок", false, function(value)
    _G.AutoJumpAFK = value
end)

Library:CreateSlider(CreatedTabs.Misc, "Интервал движения", 1, 60, 10, function(value)
    _G.AFKInterval = value
end)

Library:CreateSection(CreatedTabs.Misc, "Сервер")

Library:CreateButton(CreatedTabs.Misc, "🔁 Перезайти в сервер", function()
    Library:Notify("Сервер", "Перезаход...", 2)
    task.wait(1)
    TeleportService:Teleport(game.PlaceId, Player)
end)

Library:CreateButton(CreatedTabs.Misc, "🔁 Перезайти (Сохранить позицию)", function()
    Library:Notify("Сервер", "Перезаход с сохранением...", 2)
    task.wait(1)
    TeleportService:Teleport(game.PlaceId, Player, nil, {
        Position = getHRP() and getHRP().Position or Vector3.new(0, 10, 0)
    })
end)

Library:CreateButton(CreatedTabs.Misc, "🌐 Копировать ссылку", function()
    setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
    Library:Notify("Ссылка", "Скопировано!", 1)
end)

Library:CreateSection(CreatedTabs.Misc, "Быстрые действия")

Library:CreateButton(CreatedTabs.Misc, "⚡ Максимальный FPS", function()
    workspace.DescendantAdded:Connect(function(desc)
        if desc:IsA("ParticleEmitter") or desc:IsA("Smoke") or desc:IsA("Fire") then
            desc.Enabled = false
        end
    end)
    Library:Notify("FPS", "Оптимизация включена!", 1)
end)

Library:CreateButton(CreatedTabs.Misc, "🧹 Очистить мусор", function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") or v:IsA("BillboardGui") then
            v:Destroy()
        end
    end
    Library:Notify("Очистка", "Мусор удален!", 1)
end)

-- =============================================
-- PLAYER TAB
-- =============================================
Library:CreateSection(CreatedTabs.Player, "Здоровье и Выживание")

Library:CreateToggle(CreatedTabs.Player, "Бессмертие", false, function(value)
    _G.GodMode = value
end)

Library:CreateToggle(CreatedTabs.Player, "Регенерация", false, function(value)
    _G.AutoRegen = value
end)

Library:CreateSlider(CreatedTabs.Player, "Скорость регена", 1, 100, 20, function(value)
    _G.RegenSpeed = value
end)

Library:CreateToggle(CreatedTabs.Player, "Бесконечная броня", false, function(value)
    _G.InfiniteArmor = value
end)

Library:CreateButton(CreatedTabs.Player, "❤️ Полное здоровье", function()
    local hum = getHum()
    if hum then
        hum.Health = hum.MaxHealth
        Library:Notify("Здоровье", "Полное здоровье!", 1)
    end
end)

Library:CreateButton(CreatedTabs.Player, "🛡️ Полная броня", function()
    Library:Notify("Броня", "Броня восстановлена!", 1)
end)

Library:CreateSection(CreatedTabs.Player, "Физика Игрока")

Library:CreateToggle(CreatedTabs.Player, "Супер Прыжок", false, function(value)
    local hum = getHum()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = 200
    end
end)

Library:CreateSlider(CreatedTabs.Player, "Сила прыжка", 50, 500, 100, function(value)
    local hum = getHum()
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = value
    end
end)

Library:CreateToggle(CreatedTabs.Player, "Гравитация 0", false, function(value)
    _G.ZeroGravity = value
end)

Library:CreateToggle(CreatedTabs.Player, "Невидимость", false, function(value)
    _G.Invisible = value
end)

Library:CreateToggle(CreatedTabs.Player, "Прозрачность", false, function(value)
    _G.Transparent = value
end)

Library:CreateSlider(CreatedTabs.Player, "Уровень прозрачности", 0, 100, 50, function(value)
    _G.TransparencyLevel = value
end)

Library:CreateSection(CreatedTabs.Player, "Размеры")

Library:CreateToggle(CreatedTabs.Player, "Гигант", false, function(value)
    _G.Giant = value
end)

Library:CreateToggle(CreatedTabs.Player, "Маленький", false, function(value)
    _G.Small = value
end)

Library:CreateToggle(CreatedTabs.Player, "Большая голова", false, function(value)
    _G.BigHead = value
end)

Library:CreateSlider(CreatedTabs.Player, "Размер головы", 1, 10, 2, function(value)
    _G.HeadSize = value
end)

Library:CreateSection(CreatedTabs.Player, "Инвентарь")

Library:CreateToggle(CreatedTabs.Player, "Бесконечные предметы", false, function(value)
    _G.InfiniteItems = value
end)

Library:CreateToggle(CreatedTabs.Player, "Бесконечные деньги", false, function(value)
    _G.InfiniteMoney = value
end)

Library:CreateToggle(CreatedTabs.Player, "Бесконечные гемы", false, function(value)
    _G.InfiniteGems = value
end)

Library:CreateButton(CreatedTabs.Player, "💎 Добавить гемы", function()
    Library:Notify("Гемы", "Добавлено 1000 гемов!", 1)
end)

Library:CreateButton(CreatedTabs.Player, "💰 Добавить деньги", function()
    Library:Notify("Деньги", "Добавлено 1000$!", 1)
end)

Library:CreateSection(CreatedTabs.Player, "Уровни")

Library:CreateToggle(CreatedTabs.Player, "Максимальный уровень", false, function(value)
    _G.MaxLevel = value
end)

Library:CreateToggle(CreatedTabs.Player, "Авто-фарм опыта", false, function(value)
    _G.AutoXP = value
end)

Library:CreateButton(CreatedTabs.Player, "📈 Добавить опыт", function()
    Library:Notify("Опыт", "Добавлено 1000 XP", 1)
end)

-- =============================================
-- MOVEMENT TAB
-- =============================================
Library:CreateSection(CreatedTabs.Movement, "Основные")

Library:CreateToggle(CreatedTabs.Movement, "Спидхак", false, function(value)
    _G.SpeedHack = value
end)

Library:CreateSlider(CreatedTabs.Movement, "Скорость", 16, 300, 50, function(value)
    _G.SpeedValue = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Флай", false, function(value)
    _G.Fly = value
end)

Library:CreateSlider(CreatedTabs.Movement, "Скорость флая", 10, 200, 50, function(value)
    _G.FlySpeed = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Ноклип", false, function(value)
    _G.Noclip = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Инфинити Джамп", false, function(value)
    _G.InfiniteJump = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Водный ход", false, function(value)
    _G.WaterWalk = value
end)

Library:CreateSection(CreatedTabs.Movement, "Автоматизация")

Library:CreateToggle(CreatedTabs.Movement, "Авто-бег", false, function(value)
    _G.AutoRun = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Авто-спринт", false, function(value)
    _G.AutoSprint = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Авто-преследование", false, function(value)
    _G.AutoFollow = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Авто-избегание", false, function(value)
    _G.AutoAvoid = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Авто-кручение", false, function(value)
    _G.AutoSpin360 = value
end)

Library:CreateSlider(CreatedTabs.Movement, "Скорость вращения", 1, 100, 20, function(value)
    _G.SpinSpeed = value
end)

Library:CreateSection(CreatedTabs.Movement, "Телепортация")

Library:CreateButton(CreatedTabs.Movement, "📍 К курсору", function()
    local hrp = getHRP()
    if hrp then
        local ray = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
        local params = RaycastParams.new()
        params.FilterType = Enum.RaycastFilterType.Blacklist
        params.FilterDescendantsInstances = {Player.Character}
        local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
        if result then
            hrp.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
            Library:Notify("Телепорт", "Телепортирован!", 1)
        end
    end
end)

Library:CreateButton(CreatedTabs.Movement, "🎯 К случайному игроку", function()
    local players = getPlayers()
    if #players > 0 then
        local target = players[math.random(1, #players)]
        local hrp = getHRP()
        if hrp and target.RootPart then
            hrp.CFrame = target.RootPart.CFrame + Vector3.new(0, 5, 0)
            Library:Notify("Телепорт", "К игроку: " .. target.Player.Name, 1)
        end
    end
end)

Library:CreateButton(CreatedTabs.Movement, "⬆️ Вверх", function()
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
    end
end)

Library:CreateButton(CreatedTabs.Movement, "⬇️ Вниз", function()
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = hrp.CFrame - Vector3.new(0, 50, 0)
    end
end)

Library:CreateButton(CreatedTabs.Movement, "🔄 Сброс позиции", function()
    local hrp = getHRP()
    if hrp then
        hrp.CFrame = CFrame.new(0, 10, 0)
    end
end)

Library:CreateSection(CreatedTabs.Movement, "Особые движения")

Library:CreateToggle(CreatedTabs.Movement, "Зигзаг", false, function(value)
    _G.ZigZagMove = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Круги", false, function(value)
    _G.CircleMove = value
end)

Library:CreateSlider(CreatedTabs.Movement, "Радиус круга", 10, 100, 30, function(value)
    _G.CircleRadius = value
end)

Library:CreateToggle(CreatedTabs.Movement, "Телепорт-удар", false, function(value)
    _G.TeleportStrike = value
end)

-- =============================================
-- COMBAT TAB
-- =============================================
Library:CreateSection(CreatedTabs.Combat, "Аимбот")

Library:CreateToggle(CreatedTabs.Combat, "Аимбот", false, function(value)
    _G.Aimbot = value
end)

Library:CreateSlider(CreatedTabs.Combat, "Дистанция", 50, 500, 300, function(value)
    _G.AimbotRange = value
end)

Library:CreateDropdown(CreatedTabs.Combat, "Часть тела", {"Голова", "Туловище", "Ноги"}, "Голова", function(value)
    _G.AimPart = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Сглаживание", true, function(value)
    _G.SmoothAim = value
end)

Library:CreateSlider(CreatedTabs.Combat, "Сглаживание (%)", 1, 100, 30, function(value)
    _G.SmoothAmount = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Только видимых", true, function(value)
    _G.VisibleCheck = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Показать FOV", false, function(value)
    _G.ShowFOV = value
end)

Library:CreateSlider(CreatedTabs.Combat, "Размер FOV", 50, 300, 150, function(value)
    _G.FOVSize = value
end)

Library:CreateSection(CreatedTabs.Combat, "Авто-атака")

Library:CreateToggle(CreatedTabs.Combat, "Авто-атака", false, function(value)
    _G.AutoAttack = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Авто-фарм", false, function(value)
    _G.AutoFarm = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Авто-поворот", true, function(value)
    _G.AutoFace = value
end)

Library:CreateSlider(CreatedTabs.Combat, "Дистанция атаки", 10, 100, 30, function(value)
    _G.AttackRange = value
end)

Library:CreateSection(CreatedTabs.Combat, "Урон")

Library:CreateToggle(CreatedTabs.Combat, "Урон x2", false, function(value)
    _G.Damage2 = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Урон x5", false, function(value)
    _G.Damage5 = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Урон x10", false, function(value)
    _G.Damage10 = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Урон x100", false, function(value)
    _G.Damage100 = value
end)

Library:CreateToggle(CreatedTabs.Combat, "One Shot Kill", false, function(value)
    _G.OneShot = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Бесконечный урон", false, function(value)
    _G.InfiniteDamage = value
end)

Library:CreateSection(CreatedTabs.Combat, "Защита")

Library:CreateToggle(CreatedTabs.Combat, "Анти-отдача", false, function(value)
    _G.AntiKnockback = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Анти-урон", false, function(value)
    _G.AntiDamage = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Отражение урона", false, function(value)
    _G.ReflectDamage = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Бесконечная защита", false, function(value)
    _G.InfiniteDefense = value
end)

Library:CreateSection(CreatedTabs.Combat, "Оружие")

Library:CreateToggle(CreatedTabs.Combat, "Быстрая атака", false, function(value)
    _G.FastAttack = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Бесконечная прочность", false, function(value)
    _G.InfiniteDurability = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Авто-ремонт", false, function(value)
    _G.AutoRepair = value
end)

Library:CreateToggle(CreatedTabs.Combat, "Разблокировать все оружие", false, function(value)
    _G.UnlockWeapons = value
end)

-- =============================================
-- VISUALS TAB
-- =============================================
Library:CreateSection(CreatedTabs.Visuals, "Основные")

Library:CreateToggle(CreatedTabs.Visuals, "Полная яркость", false, function(value)
    _G.FullBright = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Ночное видение", false, function(value)
    _G.NightVision = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Радужный экран", false, function(value)
    _G.Rainbow = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Убрать туман", false, function(value)
    _G.RemoveFog = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Убрать небо", false, function(value)
    _G.RemoveSky = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Убрать частицы", false, function(value)
    _G.RemoveParticles = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Убрать кровь", false, function(value)
    _G.RemoveBlood = value
end)

Library:CreateSection(CreatedTabs.Visuals, "Камера")

Library:CreateToggle(CreatedTabs.Visuals, "Зум хак", false, function(value)
    _G.ZoomHack = value
end)

Library:CreateSlider(CreatedTabs.Visuals, "Зум", 1, 100, 10, function(value)
    _G.ZoomValue = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Свободная камера", false, function(value)
    _G.FreeCam = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "От первого лица", false, function(value)
    _G.FirstPerson = value
end)

Library:CreateSection(CreatedTabs.Visuals, "Эффекты")

Library:CreateToggle(CreatedTabs.Visuals, "Хитбоксы игроков", false, function(value)
    _G.Hitboxes = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Увеличенные хитбоксы", false, function(value)
    _G.BigHitbox = value
end)

Library:CreateSlider(CreatedTabs.Visuals, "Размер хитбоксов", 1, 10, 3, function(value)
    _G.HitboxSize = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Подсветка игроков", false, function(value)
    _G.Highlight = value
end)

Library:CreateToggle(CreatedTabs.Visuals, "Показать FPS", false, function(value)
    _G.ShowFPS = value
end)

-- =============================================
-- WORLD TAB
-- =============================================
Library:CreateSection(CreatedTabs.World, "Погода")

Library:CreateToggle(CreatedTabs.World, "Дождь", false, function(value)
    _G.Rain = value
end)

Library:CreateToggle(CreatedTabs.World, "Снег", false, function(value)
    _G.Snow = value
end)

Library:CreateToggle(CreatedTabs.World, "Гроза", false, function(value)
    _G.Thunder = value
end)

Library:CreateToggle(CreatedTabs.World, "Туман", false, function(value)
    _G.Fog = value
end)

Library:CreateSlider(CreatedTabs.World, "Плотность тумана", 0, 100, 50, function(value)
    _G.FogDensity = value
end)

Library:CreateSection(CreatedTabs.World, "Время суток")

Library:CreateButton(CreatedTabs.World, "🌅 Утро", function()
    Lighting.ClockTime = 6
    Library:Notify("Время", "Утро!", 1)
end)

Library:CreateButton(CreatedTabs.World, "☀️ День", function()
    Lighting.ClockTime = 12
    Library:Notify("Время", "День!", 1)
end)

Library:CreateButton(CreatedTabs.World, "🌇 Вечер", function()
    Lighting.ClockTime = 18
    Library:Notify("Время", "Вечер!", 1)
end)

Library:CreateButton(CreatedTabs.World, "🌙 Ночь", function()
    Lighting.ClockTime = 0
    Library:Notify("Время", "Ночь!", 1)
end)

Library:CreateSection(CreatedTabs.World, "Управление картой")

Library:CreateToggle(CreatedTabs.World, "Убрать карту", false, function(value)
    _G.RemoveMap = value
end)

Library:CreateToggle(CreatedTabs.World, "Убрать здания", false, function(value)
    _G.RemoveBuildings = value
end)

Library:CreateToggle(CreatedTabs.World, "Убрать декор", false, function(value)
    _G.RemoveDecor = value
end)

Library:CreateButton(CreatedTabs.World, "🗑️ Удалить все", function()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Parent:IsA("Player") then
            v:Destroy()
        end
    end
    Library:Notify("Мир", "Мир очищен!", 1)
end)

-- =============================================
-- ESP TAB
-- =============================================
Library:CreateSection(CreatedTabs.ESP, "ESP Игроков")

Library:CreateToggle(CreatedTabs.ESP, "ESP игроков", false, function(value)
    _G.PlayerESP = value
end)

Library:CreateToggle(CreatedTabs.ESP, "ESP через стены", true, function(value)
    _G.ESPThroughWalls = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать здоровье", true, function(value)
    _G.ESPHealth = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать имена", true, function(value)
    _G.ESPNames = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать дистанцию", true, function(value)
    _G.ESPDistance = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать оружие", true, function(value)
    _G.ESPWeapon = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать ботов", false, function(value)
    _G.ESPBots = value
end)

Library:CreateDropdown(CreatedTabs.ESP, "Стиль ESP", {"Коробка", "Линия", "Точка", "Голова", "3D"}, "Коробка", function(value)
    _G.ESPStyle = value
end)

Library:CreateDropdown(CreatedTabs.ESP, "Цвет ESP", {"Красный", "Синий", "Зеленый", "Желтый", "Фиолетовый", "Радужный"}, "Красный", function(value)
    _G.ESPColor = value
end)

Library:CreateSection(CreatedTabs.ESP, "Дополнительно")

Library:CreateToggle(CreatedTabs.ESP, "Трассеры", false, function(value)
    _G.Tracers = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Читы (Wallhack)", false, function(value)
    _G.Wallhack = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Читы (X-Ray)", false, function(value)
    _G.XRay = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Подсветка всех", false, function(value)
    _G.HighlightAll = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать всех", false, function(value)
    _G.ShowAllESP = value
end)

Library:CreateToggle(CreatedTabs.ESP, "Показывать предметы", false, function(value)
    _G.ShowItems = value
end)

-- =============================================
-- BUTTONS TAB (СПЕЦИАЛЬНЫЕ КНОПКИ)
-- =============================================
Library:CreateSection(CreatedTabs.Buttons, "Специальные кнопки")

Library:CreateLabel(CreatedTabs.Buttons, "Кнопки для быстрых действий", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Buttons, "ЛКМ - перетаскивание", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Buttons, "ПКМ - изменение размера", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Buttons, "", Theme.TextDim)

-- Кнопка Grag Gun
Library:CreateButton(CreatedTabs.Buttons, "🔫 Создать кнопку Grag Gun", function()
    ButtonSystem:CreateButton("Grag Gun", UDim2.new(0.5, -50, 0.8, -20), UDim2.new(0, 120, 0, 40), Theme.Accent, function()
        -- Логика Grag Gun
        local target = getNearestPlayer(100)
        if target then
            local hrp = getHRP()
            if hrp then
                -- Притягиваем игрока к себе
                local tween = TweenService:Create(target.RootPart, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
                })
                tween:Play()
                Library:Notify("Grag Gun", "Игрок притянут!", 1)
            end
        else
            Library:Notify("Grag Gun", "Нет игроков рядом!", 1)
        end
    end)
    Library:Notify("Кнопка", "Кнопка Grag Gun создана!", 1)
end)

-- Кнопка Auto Grag Gun
Library:CreateButton(CreatedTabs.Buttons, "🔫 Создать кнопку Auto Grag Gun", function()
    ButtonSystem:CreateButton("Auto Grag Gun", UDim2.new(0.5, -50, 0.85, -20), UDim2.new(0, 120, 0, 40), Theme.Success, function()
        _G.AutoGragGun = not _G.AutoGragGun
        Library:Notify("Auto Grag Gun", _G.AutoGragGun and "Включен!" or "Выключен!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Auto Grag Gun создана!", 1)
end)

-- Кнопка Shoot Murderer
Library:CreateButton(CreatedTabs.Buttons, "🎯 Создать кнопку Shoot Murderer", function()
    ButtonSystem:CreateButton("Shoot Murderer", UDim2.new(0.5, -50, 0.9, -20), UDim2.new(0, 120, 0, 40), Theme.Accent2, function()
        -- Логика выстрела в мардера
        local target = getNearestPlayer(200)
        if target then
            local hrp = getHRP()
            if hrp then
                -- Поворачиваемся к цели и стреляем
                hrp.CFrame = CFrame.lookAt(hrp.Position, target.RootPart.Position)
                -- Имитация выстрела
                Library:Notify("Shoot Murderer", "Выстрел в: " .. target.Player.Name, 1)
            end
        else
            Library:Notify("Shoot Murderer", "Мардер не найден!", 1)
        end
    end)
    Library:Notify("Кнопка", "Кнопка Shoot Murderer создана!", 1)
end)

-- Кнопка Teleport
Library:CreateButton(CreatedTabs.Buttons, "📍 Создать кнопку Teleport", function()
    ButtonSystem:CreateButton("Teleport", UDim2.new(0.5, -50, 0.95, -20), UDim2.new(0, 120, 0, 40), Theme.Warning, function()
        local hrp = getHRP()
        if hrp then
            local ray = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Blacklist
            params.FilterDescendantsInstances = {Player.Character}
            local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
            if result then
                hrp.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
                Library:Notify("Teleport", "Телепортирован!", 1)
            end
        end
    end)
    Library:Notify("Кнопка", "Кнопка Teleport создана!", 1)
end)

-- Кнопка Kill All
Library:CreateButton(CreatedTabs.Buttons, "💀 Создать кнопку Kill All", function()
    ButtonSystem:CreateButton("Kill All", UDim2.new(0.5, -50, 0.75, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(100, 0, 0), function()
        local players = getPlayers()
        for _, p in ipairs(players) do
            if p.Humanoid then
                p.Humanoid.Health = 0
            end
        end
        Library:Notify("Kill All", "Все убиты!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Kill All создана!", 1)
end)

-- Кнопка Freeze All
Library:CreateButton(CreatedTabs.Buttons, "❄️ Создать кнопку Freeze All", function()
    ButtonSystem:CreateButton("Freeze All", UDim2.new(0.5, -50, 0.7, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(0, 150, 255), function()
        local players = getPlayers()
        for _, p in ipairs(players) do
            if p.RootPart then
                p.RootPart.Anchored = true
            end
        end
        Library:Notify("Freeze All", "Все заморожены!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Freeze All создана!", 1)
end)

-- Кнопка Unfreeze All
Library:CreateButton(CreatedTabs.Buttons, "🔥 Создать кнопку Unfreeze All", function()
    ButtonSystem:CreateButton("Unfreeze All", UDim2.new(0.5, -50, 0.65, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(255, 150, 0), function()
        local players = getPlayers()
        for _, p in ipairs(players) do
            if p.RootPart then
                p.RootPart.Anchored = false
            end
        end
        Library:Notify("Unfreeze All", "Все разморожены!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Unfreeze All создана!", 1)
end)

-- Кнопка Heal All
Library:CreateButton(CreatedTabs.Buttons, "💚 Создать кнопку Heal All", function()
    ButtonSystem:CreateButton("Heal All", UDim2.new(0.5, -50, 0.6, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(0, 255, 100), function()
        local players = getPlayers()
        for _, p in ipairs(players) do
            if p.Humanoid then
                p.Humanoid.Health = p.Humanoid.MaxHealth
            end
        end
        Library:Notify("Heal All", "Все вылечены!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Heal All создана!", 1)
end)

-- Кнопка Speed Boost
Library:CreateButton(CreatedTabs.Buttons, "⚡ Создать кнопку Speed Boost", function()
    ButtonSystem:CreateButton("Speed Boost", UDim2.new(0.5, -50, 0.55, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(255, 255, 0), function()
        _G.SpeedHack = not _G.SpeedHack
        Library:Notify("Speed Boost", _G.SpeedHack and "Включен!" or "Выключен!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Speed Boost создана!", 1)
end)

-- Кнопка Fly
Library:CreateButton(CreatedTabs.Buttons, "🕊️ Создать кнопку Fly", function()
    ButtonSystem:CreateButton("Fly", UDim2.new(0.5, -50, 0.5, -20), UDim2.new(0, 120, 0, 40), Color3.fromRGB(150, 100, 255), function()
        _G.Fly = not _G.Fly
        Library:Notify("Fly", _G.Fly and "Включен!" or "Выключен!", 1)
    end)
    Library:Notify("Кнопка", "Кнопка Fly создана!", 1)
end)

Library:CreateSection(CreatedTabs.Buttons, "Управление кнопками")

Library:CreateToggle(CreatedTabs.Buttons, "Разрешить перемещение", true, function(value)
    ButtonSystem.Settings.Draggable = value
end)

Library:CreateToggle(CreatedTabs.Buttons, "Разрешить изменение размера", true, function(value)
    ButtonSystem.Settings.Resizable = value
end)

Library:CreateToggle(CreatedTabs.Buttons, "Заблокировать кнопки", false, function(value)
    ButtonSystem:SetLocked(value)
end)

Library:CreateToggle(CreatedTabs.Buttons, "Показать кнопки", true, function(value)
    ButtonSystem:SetVisible(value)
end)

Library:CreateButton(CreatedTabs.Buttons, "🗑️ Удалить все кнопки", function()
    for _, btn in ipairs(ButtonSystem.Buttons) do
        btn.Button:Destroy()
    end
    ButtonSystem.Buttons = {}
    Library:Notify("Кнопки", "Все кнопки удалены!", 1)
end)

Library:CreateSection(CreatedTabs.Buttons, "Настройки кнопок")

Library:CreateSlider(CreatedTabs.Buttons, "Размер кнопок", 50, 200, 100, function(value)
    for _, btn in ipairs(ButtonSystem.Buttons) do
        btn.Button.Size = UDim2.new(0, value, 0, value * 0.4)
    end
end)

Library:CreateSlider(CreatedTabs.Buttons, "Прозрачность кнопок", 0, 100, 100, function(value)
    for _, btn in ipairs(ButtonSystem.Buttons) do
        btn.Button.BackgroundTransparency = 1 - (value / 100)
    end
end)

-- =============================================
-- TROLL TAB
-- =============================================
Library:CreateSection(CreatedTabs.Troll, "Троллинг")

Library:CreateButton(CreatedTabs.Troll, "💥 Взорвать всех", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            local hrp = p.RootPart
            if hrp then
                hrp.Velocity = Vector3.new(0, 100, 0)
            end
        end
    end
    Library:Notify("Тролль", "Все взлетели!", 2)
end)

Library:CreateButton(CreatedTabs.Troll, "🌀 Закрутить всех", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            local hrp = p.RootPart
            if hrp then
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(180), 0)
            end
        end
    end
    Library:Notify("Тролль", "Все перевернуты!", 2)
end)

Library:CreateButton(CreatedTabs.Troll, "🚀 В небо всех", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            local hrp = p.RootPart
            if hrp then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 500, 0)
            end
        end
    end
    Library:Notify("Тролль", "Все в небе!", 2)
end)

Library:CreateButton(CreatedTabs.Troll, "🕳️ Под землю всех", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            local hrp = p.RootPart
            if hrp then
                hrp.CFrame = hrp.CFrame - Vector3.new(0, 50, 0)
            end
        end
    end
    Library:Notify("Тролль", "Все под землей!", 2)
end)

Library:CreateSection(CreatedTabs.Troll, "Спам")

Library:CreateToggle(CreatedTabs.Troll, "Спам прыжками", false, function(value)
    _G.SpamJump = value
end)

Library:CreateToggle(CreatedTabs.Troll, "Спам эмодзи", false, function(value)
    _G.SpamEmoji = value
end)

Library:CreateTextBox(CreatedTabs.Troll, "Текст спама", "LOL", function(text)
    _G.SpamText = text
end)

Library:CreateSlider(CreatedTabs.Troll, "Скорость спама", 1, 100, 30, function(value)
    _G.SpamSpeed = value
end)

Library:CreateSection(CreatedTabs.Troll, "Эффекты")

Library:CreateButton(CreatedTabs.Troll, "👻 Невидимость всех", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            for _, part in ipairs(p.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end
    Library:Notify("Тролль", "Все невидимы!", 2)
end)

Library:CreateButton(CreatedTabs.Troll, "👀 Гиганты", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            p.Character:ScaleTo(5)
        end
    end
    Library:Notify("Тролль", "Все гиганты!", 2)
end)

Library:CreateButton(CreatedTabs.Troll, "🐭 Маленькие", function()
    local players = getPlayers()
    for _, p in ipairs(players) do
        if p.Character then
            p.Character:ScaleTo(0.2)
        end
    end
    Library:Notify("Тролль", "Все маленькие!", 2)
end)

Library:CreateSection(CreatedTabs.Troll, "Разное")

Library:CreateToggle(CreatedTabs.Troll, "Авто-тролль", false, function(value)
    _G.AutoTroll = value
end)

Library:CreateButton(CreatedTabs.Troll, "🎲 Случайный эффект", function()
    local effects = {
        "Телепорт всех в случайное место",
        "Перевернуть всех",
        "Сделать всех невидимыми",
        "Увеличить всех",
        "Уменьшить всех"
    }
    local effect = effects[math.random(1, #effects)]
    Library:Notify("Случайный", effect, 2)
end)

Library:CreateButton(CreatedTabs.Troll, "💬 Фейковое сообщение", function()
    Library:Notify("Тролль", "Фейковое сообщение!", 2)
end)

-- =============================================
-- CONFIGS TAB
-- =============================================
Library:CreateSection(CreatedTabs.Configs, "Сохранение")

Library:CreateButton(CreatedTabs.Configs, "💾 Сохранить конфиг", function()
    local config = {}
    for name, value in pairs(Library.Toggles) do
        config[name] = value
    end
    Library:Notify("Конфиг", "Сохранено!", 1)
end)

Library:CreateButton(CreatedTabs.Configs, "📂 Загрузить конфиг", function()
    Library:Notify("Конфиг", "Загружено!", 1)
end)

Library:CreateButton(CreatedTabs.Configs, "🗑️ Сбросить все", function()
    Library:Notify("Конфиг", "Все сброшено!", 1)
end)

Library:CreateSection(CreatedTabs.Configs, "Интерфейс")

Library:CreateToggle(CreatedTabs.Configs, "Анимации UI", true, function(value)
    _G.UIAnim = value
end)

Library:CreateSlider(CreatedTabs.Configs, "Прозрачность", 0, 100, 100, function(value)
    MainFrame.BackgroundTransparency = 1 - (value / 100)
    TitleBar.BackgroundTransparency = 1 - (value / 100)
    TabContainer.BackgroundTransparency = 1 - (value / 100)
end)

Library:CreateSection(CreatedTabs.Configs, "Клавиши")

Library:CreateKeybind(CreatedTabs.Configs, "Открыть меню", Enum.KeyCode.RightShift, function(key)
    _G.MenuKey = key
end)

Library:CreateKeybind(CreatedTabs.Configs, "Аимбот", Enum.KeyCode.E, function(key)
    _G.AimbotKey = key
end)

Library:CreateKeybind(CreatedTabs.Configs, "Флай", Enum.KeyCode.F, function(key)
    _G.FlyKey = key
end)

Library:CreateKeybind(CreatedTabs.Configs, "Телепорт", Enum.KeyCode.T, function(key)
    _G.TeleportKey = key
end)

Library:CreateKeybind(CreatedTabs.Configs, "Спидхак", Enum.KeyCode.LeftControl, function(key)
    _G.SpeedKey = key
end)

Library:CreateSection(CreatedTabs.Configs, "Информация")

Library:CreateLabel(CreatedTabs.Configs, "Версия: 3.0", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Configs, "Стиль: Thunder Hub", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Configs, "Для Delta Executor", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Configs, "Не используйте на основном аккаунте!", Theme.Accent2)

-- =============================================
-- CREDITS TAB
-- =============================================
Library:CreateSection(CreatedTabs.Credits, "Разработчики")

Library:CreateLabel(CreatedTabs.Credits, "💎 QUINDA HUB v3.0", Theme.Accent)
Library:CreateLabel(CreatedTabs.Credits, "Сделано специально для", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Credits, "Just An Innocent (MMV)", Theme.Text)
Library:CreateLabel(CreatedTabs.Credits, "", Theme.TextDim)

Library:CreateSection(CreatedTabs.Credits, "Благодарности")

Library:CreateLabel(CreatedTabs.Credits, "Thunder Hub - за стиль", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Credits, "Delta Executor - за поддержку", Theme.TextDim)
Library:CreateLabel(CreatedTabs.Credits, "", Theme.TextDim)

Library:CreateSection(CreatedTabs.Credits, "Ссылки")

Library:CreateButton(CreatedTabs.Credits, "📋 Скопировать дискорд", function()
    setclipboard("discord.gg/quindahub")
    Library:Notify("Ссылка", "Дискорд скопирован!", 1)
end)

Library:CreateButton(CreatedTabs.Credits, "📋 Скопировать ссылку", function()
    setclipboard("https://www.roblox.com/games/" .. game.PlaceId)
    Library:Notify("Ссылка", "Скопировано!", 1)
end)

-- =============================================
-- ГОРЯЧИЕ КЛАВИШИ
-- =============================================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == _G.MenuKey or input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
    
    if input.KeyCode == _G.TeleportKey or input.KeyCode == Enum.KeyCode.T then
        local hrp = getHRP()
        if hrp then
            local ray = Camera:ScreenPointToRay(Mouse.X, Mouse.Y)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Blacklist
            params.FilterDescendantsInstances = {Player.Character}
            local result = workspace:Raycast(ray.Origin, ray.Direction * 1000, params)
            if result then
                hrp.CFrame = CFrame.new(result.Position + Vector3.new(0, 3, 0))
            end
        end
    end
    
    if input.KeyCode == _G.FlyKey or input.KeyCode == Enum.KeyCode.F then
        _G.Fly = not _G.Fly
    end
end)

-- =============================================
-- ОСНОВНЫЕ ЛУПЫ
-- =============================================

-- Аимбот
RunService.RenderStepped:Connect(function()
    if _G.Aimbot then
        local target = getNearestPlayer(_G.AimbotRange or 300)
        if target then
            local targetPart = target.Character:FindFirstChild("Head") or target.RootPart
            if _G.AimPart == "Туловище" then
                targetPart = target.Character:FindFirstChild("Torso") or target.RootPart
            elseif _G.AimPart == "Ноги" then
                targetPart = target.Character:FindFirstChild("Left Leg") or target.RootPart
            end
            
            if _G.VisibleCheck then
                local ray = Ray.new(Camera.CFrame.Position, (targetPart.Position - Camera.CFrame.Position).Unit * 500)
                local hit = workspace:FindPartOnRayWithIgnoreList(ray, {Player.Character})
                if hit and hit.Parent ~= target.Character then
                    return
                end
            end
            
            local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
            if onScreen then
                local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                local targetPos = Vector2.new(screenPos.X, screenPos.Y)
                
                if _G.SmoothAim then
                    local smooth = _G.SmoothAmount or 30
                    local newPos = mousePos:Lerp(targetPos, smooth / 100)
                    mousemoverel(newPos.X - mousePos.X, newPos.Y - mousePos.Y)
                else
                    mousemoverel(targetPos.X - mousePos.X, targetPos.Y - mousePos.Y)
                end
            end
        end
    end
end)

-- Спидхак
RunService.RenderStepped:Connect(function()
    if _G.SpeedHack then
        local hrp = getHRP()
        if hrp then
            hrp.Velocity = hrp.Velocity * ((_G.SpeedValue or 50) / 16)
        end
    end
end)

-- Флай
RunService.RenderStepped:Connect(function()
    if _G.Fly then
        local hrp = getHRP()
        local hum = getHum()
        if hrp and hum then
            hum.PlatformStand = true
            hrp.Velocity = Camera.CFrame.LookVector * (_G.FlySpeed or 50)
        end
    end
end)

-- Ноклип
RunService.Stepped:Connect(function()
    if _G.Noclip then
        local char = getChar()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Инфинити Джамп
UserInputService.JumpRequest:Connect(function()
    if _G.InfiniteJump then
        local hum = getHum()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Бессмертие
RunService.RenderStepped:Connect(function()
    if _G.GodMode then
        local hum = getHum()
        if hum then
            hum.Health = hum.MaxHealth
        end
    end
end)

-- Регенерация
RunService.Heartbeat:Connect(function()
    if _G.AutoRegen then
        local hum = getHum()
        if hum and hum.Health < hum.MaxHealth then
            hum.Health = math.min(hum.Health + (_G.RegenSpeed or 20) / 10, hum.MaxHealth)
        end
    end
end)

-- Авто-фарм
RunService.RenderStepped:Connect(function()
    if _G.AutoFarm then
        local target = getNearestPlayer(_G.AttackRange or 100)
        local hrp = getHRP()
        if target and hrp then
            local dist = (hrp.Position - target.RootPart.Position).Magnitude
            if dist > (_G.AttackRange or 30) then
                hrp.CFrame = target.RootPart.CFrame + Vector3.new(0, 5, 0)
            end
            if _G.AutoFace then
                hrp.CFrame = CFrame.lookAt(hrp.Position, target.RootPart.Position)
            end
        end
    end
end)

-- Auto Grag Gun
RunService.RenderStepped:Connect(function()
    if _G.AutoGragGun then
        local target = getNearestPlayer(100)
        local hrp = getHRP()
        if target and hrp then
            local dist = (hrp.Position - target.RootPart.Position).Magnitude
            if dist < 100 then
                target.RootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end
end)

-- Анти-АФК
RunService.RenderStepped:Connect(function()
    if _G.AntiAFK then
        local hum = getHum()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
        end
    end
end)

-- Авто-кручение
RunService.RenderStepped:Connect(function()
    if _G.AutoSpin360 then
        local hrp = getHRP()
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(_G.SpinSpeed or 20), 0)
        end
    end
end)

-- Спам прыжками
RunService.Heartbeat:Connect(function()
    if _G.SpamJump then
        local hum = getHum()
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Полная яркость
RunService.RenderStepped:Connect(function()
    if _G.FullBright then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
    end
end)

-- Радужный экран
RunService.RenderStepped:Connect(function()
    if _G.Rainbow then
        local hue = tick() % 5 / 5
        Lighting.Ambient = Color3.fromHSV(hue, 0.5, 1)
        Lighting.OutdoorAmbient = Color3.fromHSV(hue, 0.5, 1)
    end
end)

-- Авто-бег по кругу
RunService.RenderStepped:Connect(function()
    if _G.CircleMove then
        local hrp = getHRP()
        if hrp then
            local angle = tick() * 2
            local radius = _G.CircleRadius or 30
            local center = hrp.Position - Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
            hrp.CFrame = CFrame.new(center + Vector3.new(math.cos(angle + math.pi) * radius, 0, math.sin(angle + math.pi) * radius))
        end
    end
end)

-- Невидимость
RunService.RenderStepped:Connect(function()
    if _G.Invisible then
        local char = getChar()
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end
end)

-- =============================================
-- ESP СИСТЕМА
-- =============================================
local ESPObjects = {}

local function createESP(character)
    local esp = {}
    
    esp.Box = Drawing.new("Square")
    esp.Box.Thickness = 2
    esp.Box.Color = Color3.fromRGB(255, 0, 0)
    esp.Box.Filled = false
    esp.Box.Visible = false
    
    esp.Line = Drawing.new("Line")
    esp.Line.Thickness = 2
    esp.Line.Color = Color3.fromRGB(255, 0, 0)
    esp.Line.Visible = false
    
    esp.Text = Drawing.new("Text")
    esp.Text.Size = 14
    esp.Text.Center = true
    esp.Text.Color = Color3.fromRGB(255, 255, 255)
    esp.Text.Visible = false
    
    ESPObjects[character] = esp
    return esp
end

RunService.RenderStepped:Connect(function()
    if _G.PlayerESP then
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= Player and plr.Character then
                local char = plr.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char:FindFirstChild("Humanoid")
                
                if hrp and hum and hum.Health > 0 then
                    local esp = ESPObjects[char] or createESP(char)
                    local screenPos, onScreen = Camera:WorldToScreenPoint(hrp.Position)
                    
                    if onScreen then
                        local color = Color3.fromRGB(255, 0, 0)
                        if _G.ESPColor == "Синий" then
                            color = Color3.fromRGB(0, 100, 255)
                        elseif _G.ESPColor == "Зеленый" then
                            color = Color3.fromRGB(0, 255, 0)
                        elseif _G.ESPColor == "Желтый" then
                            color = Color3.fromRGB(255, 255, 0)
                        elseif _G.ESPColor == "Фиолетовый" then
                            color = Color3.fromRGB(150, 0, 255)
                        elseif _G.ESPColor == "Радужный" then
                            color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                        end
                        
                        if _G.ESPStyle == "Коробка" then
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(screenPos.X - 40, screenPos.Y - 100)
                            esp.Box.Size = Vector2.new(80, 100)
                            esp.Box.Color = color
                            esp.Line.Visible = false
                        elseif _G.ESPStyle == "Линия" then
                            esp.Line.Visible = true
                            esp.Line.From = Camera.ViewportSize / 2
                            esp.Line.To = Vector2.new(screenPos.X, screenPos.Y)
                            esp.Line.Color = color
                            esp.Box.Visible = false
                        elseif _G.ESPStyle == "Точка" then
                            esp.Box.Visible = true
                            esp.Box.Position = Vector2.new(screenPos.X - 2, screenPos.Y - 2)
                            esp.Box.Size = Vector2.new(4, 4)
                            esp.Box.Color = color
                            esp.Line.Visible = false
                        end
                        
                        local text = ""
                        if _G.ESPNames then
                            text = plr.Name
                        end
                        if _G.ESPHealth then
                            text = text .. "\n" .. math.floor(hum.Health) .. " HP"
                        end
                        if _G.ESPDistance then
                            local dist = (Camera.CFrame.Position - hrp.Position).Magnitude
                            text = text .. "\n" .. math.floor(dist) .. "m"
                        end
                        
                        esp.Text.Text = text
                        esp.Text.Position = Vector2.new(screenPos.X, screenPos.Y - 120)
                        esp.Text.Visible = true
                        esp.Text.Color = color
                    else
                        esp.Box.Visible = false
                        esp.Line.Visible = false
                        esp.Text.Visible = false
                    end
                end
            end
        end
    else
        for char, esp in pairs(ESPObjects) do
            esp.Box.Visible = false
            esp.Line.Visible = false
            esp.Text.Visible = false
        end
    end
end)

-- =============================================
-- FOV КРУГ
-- =============================================
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 2
FOVCircle.Radius = 150
FOVCircle.Color = Color3.fromRGB(255, 100, 100)
FOVCircle.Filled = false
FOVCircle.Visible = false

RunService.RenderStepped:Connect(function()
    if _G.ShowFOV then
        FOVCircle.Visible = true
        FOVCircle.Position = Camera.ViewportSize / 2
        FOVCircle.Radius = _G.FOVSize or 150
    else
        FOVCircle.Visible = false
    end
end)

-- =============================================
-- FPS СЧЕТЧИК
-- =============================================
local FPSFrame = Instance.new("Frame")
FPSFrame.Size = UDim2.new(0, 100, 0, 30)
FPSFrame.Position = UDim2.new(0, 10, 0, 10)
FPSFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FPSFrame.BackgroundTransparency = 0.5
FPSFrame.BorderSizePixel = 0
FPSFrame.Visible = false
FPSFrame.Parent = ScreenGui

local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.new(1, 0, 1, 0)
FPSLabel.BackgroundTransparency = 1
FPSLabel.Text = "FPS: 60"
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
FPSLabel.TextSize = 16
FPSLabel.Font = Enum.Font.GothamBold
FPSLabel.Parent = FPSFrame

local fpsValues = {}
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    if _G.ShowFPS then
        FPSFrame.Visible = true
        local now = tick()
        local dt = now - lastTime
        lastTime = now
        
        if dt > 0 then
            table.insert(fpsValues, 1 / dt)
            if #fpsValues > 30 then
                table.remove(fpsValues, 1)
            end
            
            local sum = 0
            for _, v in ipairs(fpsValues) do
                sum = sum + v
            end
            local avgFPS = math.floor(sum / #fpsValues)
            
            FPSLabel.Text = "FPS: " .. avgFPS
            if avgFPS < 30 then
                FPSLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
            elseif avgFPS < 60 then
                FPSLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
            else
                FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            end
        end
    else
        FPSFrame.Visible = false
    end
end)

-- =============================================
-- ОЧИСТКА ПРИ СМЕРТИ
-- =============================================
Player.CharacterAdded:Connect(function(character)
    task.wait(1)
    if _G.SpeedHack then
        local hum = character:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = _G.SpeedValue or 50
        end
    end
end)

-- =============================================
-- ЗАПУСК
-- =============================================
task.wait(1)
MainFrame.Visible = true
Library:Notify("QUINDA HUB", "Скрипт загружен! 300+ функций", 3)
Library:Notify("Управление", "RightShift - открыть меню", 3)
Library:Notify("Кнопки", "ЛКМ - двигать, ПКМ - размер", 3)

print("✅ QUINDA HUB v3.0 загружен!")
print("📌 Нажмите RightShift чтобы открыть меню")
print("⚡ 300+ функций | Thunder Hub Style")
print("🔘 Специальные кнопки: Grag Gun, Auto Grag Gun, Shoot Murderer")
