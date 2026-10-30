--[[
    VantaUI Interface Suite
    A modern, high-performance, glassmorphic UI library for Roblox Luau.
    Inspired by Rayfield, Fluent, Linoria, and Orion.
    Built for smooth 60fps animations, rich controls, dynamic theming, and clean ergonomics.
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local Vanta = {
	Version = "1.0.0",
	Windows = {},
	Flags = {},
	CurrentWindow = nil,
	ScreenGui = nil,
	Overlay = nil,
	NotificationContainer = nil,
	Open = true,
	ToggleKey = Enum.KeyCode.RightControl,
}

-- [1] THEME ENGINE
local Theme = {
	Current = {},
	Listeners = {},
	Presets = {
		Obsidian = {
			Accent = Color3.fromRGB(0, 168, 255),
			AccentDim = Color3.fromRGB(0, 115, 180),
			AccentGlow = Color3.fromRGB(0, 168, 255),
			Background = Color3.fromRGB(13, 14, 18),
			Sidebar = Color3.fromRGB(17, 18, 23),
			Topbar = Color3.fromRGB(15, 16, 21),
			Card = Color3.fromRGB(21, 23, 29),
			CardHover = Color3.fromRGB(26, 29, 37),
			CardHeader = Color3.fromRGB(24, 27, 34),
			Border = Color3.fromRGB(36, 40, 52),
			BorderLight = Color3.fromRGB(50, 56, 72),
			Input = Color3.fromRGB(16, 17, 22),
			InputHover = Color3.fromRGB(20, 22, 28),
			ToggleOff = Color3.fromRGB(34, 38, 48),
			ToggleKnob = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(240, 243, 248),
			TextMuted = Color3.fromRGB(145, 153, 168),
			TextDark = Color3.fromRGB(88, 94, 108),
			Success = Color3.fromRGB(46, 204, 113),
			Warning = Color3.fromRGB(241, 196, 15),
			Error = Color3.fromRGB(231, 76, 60),
			Info = Color3.fromRGB(52, 152, 219),
		},
		Emerald = {
			Accent = Color3.fromRGB(16, 185, 129),
			AccentDim = Color3.fromRGB(11, 135, 94),
			AccentGlow = Color3.fromRGB(16, 185, 129),
			Background = Color3.fromRGB(12, 16, 14),
			Sidebar = Color3.fromRGB(15, 20, 17),
			Topbar = Color3.fromRGB(14, 19, 16),
			Card = Color3.fromRGB(19, 26, 22),
			CardHover = Color3.fromRGB(24, 33, 28),
			CardHeader = Color3.fromRGB(22, 30, 25),
			Border = Color3.fromRGB(30, 44, 36),
			BorderLight = Color3.fromRGB(42, 60, 50),
			Input = Color3.fromRGB(14, 19, 16),
			InputHover = Color3.fromRGB(18, 24, 20),
			ToggleOff = Color3.fromRGB(30, 41, 35),
			ToggleKnob = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(238, 245, 241),
			TextMuted = Color3.fromRGB(138, 156, 147),
			TextDark = Color3.fromRGB(82, 98, 90),
			Success = Color3.fromRGB(16, 185, 129),
			Warning = Color3.fromRGB(245, 158, 11),
			Error = Color3.fromRGB(239, 68, 68),
			Info = Color3.fromRGB(59, 130, 246),
		},
		Amethyst = {
			Accent = Color3.fromRGB(168, 85, 247),
			AccentDim = Color3.fromRGB(120, 55, 180),
			AccentGlow = Color3.fromRGB(168, 85, 247),
			Background = Color3.fromRGB(15, 12, 19),
			Sidebar = Color3.fromRGB(19, 15, 25),
			Topbar = Color3.fromRGB(17, 14, 22),
			Card = Color3.fromRGB(24, 19, 32),
			CardHover = Color3.fromRGB(30, 24, 40),
			CardHeader = Color3.fromRGB(27, 22, 36),
			Border = Color3.fromRGB(43, 33, 58),
			BorderLight = Color3.fromRGB(62, 48, 82),
			Input = Color3.fromRGB(17, 13, 22),
			InputHover = Color3.fromRGB(22, 18, 29),
			ToggleOff = Color3.fromRGB(38, 30, 50),
			ToggleKnob = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(245, 240, 250),
			TextMuted = Color3.fromRGB(158, 145, 172),
			TextDark = Color3.fromRGB(100, 90, 115),
			Success = Color3.fromRGB(52, 211, 153),
			Warning = Color3.fromRGB(251, 191, 36),
			Error = Color3.fromRGB(248, 113, 113),
			Info = Color3.fromRGB(129, 140, 248),
		},
		Rose = {
			Accent = Color3.fromRGB(244, 63, 94),
			AccentDim = Color3.fromRGB(180, 40, 65),
			AccentGlow = Color3.fromRGB(244, 63, 94),
			Background = Color3.fromRGB(17, 13, 14),
			Sidebar = Color3.fromRGB(22, 16, 18),
			Topbar = Color3.fromRGB(20, 14, 16),
			Card = Color3.fromRGB(28, 20, 23),
			CardHover = Color3.fromRGB(35, 25, 29),
			CardHeader = Color3.fromRGB(32, 23, 26),
			Border = Color3.fromRGB(50, 35, 41),
			BorderLight = Color3.fromRGB(72, 49, 57),
			Input = Color3.fromRGB(19, 13, 15),
			InputHover = Color3.fromRGB(25, 18, 20),
			ToggleOff = Color3.fromRGB(44, 31, 36),
			ToggleKnob = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(250, 241, 243),
			TextMuted = Color3.fromRGB(172, 146, 153),
			TextDark = Color3.fromRGB(112, 92, 98),
			Success = Color3.fromRGB(52, 211, 153),
			Warning = Color3.fromRGB(251, 191, 36),
			Error = Color3.fromRGB(244, 63, 94),
			Info = Color3.fromRGB(96, 165, 250),
		},
		Midnight = {
			Accent = Color3.fromRGB(99, 102, 241),
			AccentDim = Color3.fromRGB(70, 72, 175),
			AccentGlow = Color3.fromRGB(99, 102, 241),
			Background = Color3.fromRGB(10, 12, 19),
			Sidebar = Color3.fromRGB(13, 16, 25),
			Topbar = Color3.fromRGB(12, 14, 22),
			Card = Color3.fromRGB(17, 21, 33),
			CardHover = Color3.fromRGB(22, 27, 42),
			CardHeader = Color3.fromRGB(20, 24, 38),
			Border = Color3.fromRGB(31, 38, 59),
			BorderLight = Color3.fromRGB(45, 55, 85),
			Input = Color3.fromRGB(12, 15, 24),
			InputHover = Color3.fromRGB(16, 20, 31),
			ToggleOff = Color3.fromRGB(28, 34, 53),
			ToggleKnob = Color3.fromRGB(255, 255, 255),
			Text = Color3.fromRGB(240, 243, 252),
			TextMuted = Color3.fromRGB(142, 151, 176),
			TextDark = Color3.fromRGB(86, 94, 115),
			Success = Color3.fromRGB(52, 211, 153),
			Warning = Color3.fromRGB(251, 191, 36),
			Error = Color3.fromRGB(248, 113, 113),
			Info = Color3.fromRGB(99, 102, 241),
		}
	}
}

for k, v in pairs(Theme.Presets.Obsidian) do
	Theme.Current[k] = v
end

function Theme:Bind(instance, property, themeKey)
	local entry = { Instance = instance, Property = property, Key = themeKey }
	table.insert(self.Listeners, entry)
	if self.Current[themeKey] then
		pcall(function() instance[property] = self.Current[themeKey] end)
	end
	return entry
end

function Theme:SetTheme(themeNameOrTable)
	local palette = type(themeNameOrTable) == "string" and self.Presets[themeNameOrTable] or themeNameOrTable
	if not palette then return end
	for k, v in pairs(palette) do
		self.Current[k] = v
	end
	self:Refresh()
end

function Theme:SetAccent(color)
	if typeof(color) ~= "Color3" then return end
	self.Current.Accent = color
	self.Current.AccentGlow = color
	local h, s, v = color:ToHSV()
	self.Current.AccentDim = Color3.fromHSV(h, s * 0.9, v * 0.7)
	self:Refresh()
end

function Theme:Refresh()
	for i = #self.Listeners, 1, -1 do
		local listener = self.Listeners[i]
		if listener.Instance and listener.Instance.Parent then
			local val = self.Current[listener.Key]
			if val then
				pcall(function() listener.Instance[listener.Property] = val end)
			end
		else
			table.remove(self.Listeners, i)
		end
	end
end

Vanta.Theme = Theme

-- [2] ICONS SYSTEM
local Icons = {
	Map = {
		["home"] = "rbxassetid://10709778201",
		["settings"] = "rbxassetid://10734950309",
		["sliders"] = "rbxassetid://10734950020",
		["layers"] = "rbxassetid://10723415766",
		["sword"] = "rbxassetid://10734951391",
		["shield"] = "rbxassetid://10734950384",
		["crosshair"] = "rbxassetid://10709769841",
		["target"] = "rbxassetid://10734951847",
		["zap"] = "rbxassetid://10734984929",
		["eye"] = "rbxassetid://10723387084",
		["eye-off"] = "rbxassetid://10723386959",
		["search"] = "rbxassetid://10734950117",
		["check"] = "rbxassetid://10709790644",
		["x"] = "rbxassetid://10709791437",
		["chevron-down"] = "rbxassetid://10709790948",
		["chevron-up"] = "rbxassetid://10709791523",
		["chevron-right"] = "rbxassetid://10709791166",
		["refresh-cw"] = "rbxassetid://10734950069",
		["copy"] = "rbxassetid://10709778550",
		["trash"] = "rbxassetid://10734952219",
		["save"] = "rbxassetid://10734950186",
		["download"] = "rbxassetid://10709778887",
		["info"] = "rbxassetid://10723415903",
		["alert-triangle"] = "rbxassetid://10709752996",
		["bell"] = "rbxassetid://10709778789",
		["user"] = "rbxassetid://10734952861",
		["terminal"] = "rbxassetid://10734951978",
		["palette"] = "rbxassetid://10734950886",
		["key"] = "rbxassetid://10723416280",
		["folder"] = "rbxassetid://10723387563",
		["file"] = "rbxassetid://10723374641",
	}
}

function Icons:Get(idOrName)
	if not idOrName or idOrName == "" then return "" end
	if string.sub(idOrName, 1, 13) == "rbxassetid://" or string.sub(idOrName, 1, 4) == "http" then
		return idOrName
	end
	if tonumber(idOrName) then
		return "rbxassetid://" .. tostring(idOrName)
	end
	local lower = string.lower(tostring(idOrName))
	return self.Map[lower] or "rbxassetid://10709769186"
end

Vanta.Icons = Icons

-- [3] UTILITY & HELPERS
local function Create(className, properties, children)
	local inst = Instance.new(className)
	for prop, val in pairs(properties or {}) do
		if prop ~= "Parent" then
			pcall(function() inst[prop] = val end)
		end
	end
	for _, child in ipairs(children or {}) do
		if typeof(child) == "Instance" then
			child.Parent = inst
		end
	end
	if properties and properties.Parent then
		inst.Parent = properties.Parent
	end
	return inst
end

local function Tween(instance, properties, duration, style, direction)
	duration = duration or 0.2
	style = style or Enum.EasingStyle.Quad
	direction = direction or Enum.EasingDirection.Out
	local tween = TweenService:Create(instance, TweenInfo.new(duration, style, direction), properties)
	tween:Play()
	return tween
end

local function AddCorner(instance, radius)
	return Create("UICorner", { CornerRadius = UDim.new(0, radius or 8), Parent = instance })
end

local function AddStroke(instance, colorKey, thickness, transparency)
	local stroke = Create("UIStroke", {
		Color = Theme.Current[colorKey] or Color3.fromRGB(40, 45, 55),
		Thickness = thickness or 1,
		Transparency = transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = instance,
	})
	if colorKey then
		Theme:Bind(stroke, "Color", colorKey)
	end
	return stroke
end

local function AddShadow(instance, elevation)
	elevation = elevation or 14
	return Create("ImageLabel", {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "rbxassetid://6015897843",
		ImageColor3 = Color3.fromRGB(0, 0, 0),
		ImageTransparency = 0.45,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(49, 49, 450, 450),
		Position = UDim2.new(0, -elevation, 0, -elevation),
		Size = UDim2.new(1, elevation * 2, 1, elevation * 2),
		ZIndex = math.max(1, instance.ZIndex - 1),
		Parent = instance,
	})
end

local function MakeDraggable(dragHandle, targetFrame)
	local dragging = false
	local dragInput = nil
	local dragStart = nil
	local startPos = nil
	
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = targetFrame.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			Tween(targetFrame, {
				Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			}, 0.06, Enum.EasingStyle.Sine)
		end
	end)
end

-- ScreenGui Parent Resolution
local function GetGuiParent()
	if gethui then
		local s, r = pcall(gethui)
		if s and r then return r end
	end
	local s, cg = pcall(function() return CoreGui:FindFirstChild("RobloxGui") or CoreGui end)
	if s and cg then return cg end
	if LocalPlayer then
		local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		if pg then return pg end
	end
	return CoreGui
end

-- Initialize Root Gui Container
function Vanta:InitRoot()
	if self.ScreenGui and self.ScreenGui.Parent then return end
	
	-- Remove old instances if running again
	local existing = GetGuiParent():FindFirstChild("VantaUI_Container")
	if existing then existing:Destroy() end
	
	local screenGui = Create("ScreenGui", {
		Name = "VantaUI_Container",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 9999,
		Parent = GetGuiParent(),
	})
	
	if syn and syn.protect_gui then
		pcall(syn.protect_gui, screenGui)
	elseif typeof(protectgui) == "function" then
		pcall(protectgui, screenGui)
	end
	
	-- Notification toast stack container (bottom-right)
	local notifContainer = Create("Frame", {
		Name = "Notifications",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -330, 1, -20),
		AnchorPoint = Vector2.new(0, 1),
		Size = UDim2.new(0, 310, 1, -40),
		ZIndex = 1000,
		Parent = screenGui,
	})
	
	local notifLayout = Create("UIListLayout", {
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Bottom,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 10),
		Parent = notifContainer,
	})
	
	-- Global Overlay container (for dropdowns, colorpicker popups, tooltips)
	local overlay = Create("Frame", {
		Name = "OverlayLayer",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 500,
		Parent = screenGui,
	})
	
	self.ScreenGui = screenGui
	self.NotificationContainer = notifContainer
	self.Overlay = overlay
	
	-- Global Keybind listener to toggle visibility
	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == self.ToggleKey then
			self:Toggle()
		end
	end)
end

function Vanta:Toggle()
	self.Open = not self.Open
	if self.CurrentWindow and self.CurrentWindow.MainFrame then
		local frame = self.CurrentWindow.MainFrame
		if self.Open then
			frame.Visible = true
			Tween(frame, { Size = self.CurrentWindow.DefaultSize }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
			Tween(frame, { BackgroundTransparency = 0 }, 0.2)
		else
			local shrink = Tween(frame, { Size = UDim2.new(0, self.CurrentWindow.DefaultSize.X.Offset * 0.95, 0, self.CurrentWindow.DefaultSize.Y.Offset * 0.95) }, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			shrink.Completed:Connect(function()
				if not self.Open then
					frame.Visible = false
				end
			end)
		end
	end
end

-- [4] NOTIFICATIONS
function Vanta:Notify(config)
	self:InitRoot()
	config = config or {}
	local title = config.Title or "Notification"
	local content = config.Content or ""
	local duration = config.Duration or 4
	local notifType = config.Type or "Info" -- Info, Success, Warning, Error
	local icon = config.Icon or (notifType == "Success" and "check" or notifType == "Warning" and "alert-triangle" or notifType == "Error" and "x" or "info")
	
	local accentColor = Theme.Current[notifType] or Theme.Current.Accent
	
	local card = Create("Frame", {
		Name = "Toast",
		BackgroundColor3 = Theme.Current.Card,
		Size = UDim2.new(1, 0, 0, 0),
		ClipsDescendants = true,
		Parent = self.NotificationContainer,
	})
	AddCorner(card, 8)
	local stroke = AddStroke(card, "Border", 1)
	AddShadow(card, 10)
	
	local contentHolder = Create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 10),
		Size = UDim2.new(1, -24, 1, -24),
		Parent = card,
	})
	
	local iconImg = Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = Icons:Get(icon),
		ImageColor3 = accentColor,
		Size = UDim2.new(0, 20, 0, 20),
		Position = UDim2.new(0, 0, 0, 2),
		Parent = contentHolder,
	})
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 28, 0, 2),
		Size = UDim2.new(1, -30, 0, 18),
		Parent = contentHolder,
	})
	
	local bodyLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = content,
		TextColor3 = Theme.Current.TextMuted,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 28, 0, 24),
		Size = UDim2.new(1, -30, 0, 32),
		Parent = contentHolder,
	})
	
	-- Progress bar
	local progBg = Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(35, 40, 50),
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -3),
		Size = UDim2.new(1, 0, 0, 3),
		Parent = card,
	})
	
	local progFill = Create("Frame", {
		BackgroundColor3 = accentColor,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Parent = progBg,
	})
	
	-- Animate In
	Tween(card, { Size = UDim2.new(1, 0, 0, 72) }, 0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
	Tween(progFill, { Size = UDim2.new(0, 0, 1, 0) }, duration, Enum.EasingStyle.Linear)
	
	-- Dismiss
	task.delay(duration, function()
		if card and card.Parent then
			local close = Tween(card, { Size = UDim2.new(1, 0, 0, 0) }, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			close.Completed:Connect(function()
				card:Destroy()
			end)
		end
	end)
end

-- [5] WINDOW CLASS
local Window = {}
Window.__index = Window

function Vanta:CreateWindow(config)
	self:InitRoot()
	config = config or {}
	local title = config.Title or "VANTA UI"
	local subTitle = config.SubTitle or "HUB INTERFACE"
	local size = config.Size or UDim2.new(0, 680, 0, 440)
	local toggleKey = config.ToggleKey or Enum.KeyCode.RightControl
	self.ToggleKey = toggleKey
	
	local win = setmetatable({
		Title = title,
		SubTitle = subTitle,
		DefaultSize = size,
		Tabs = {},
		ActiveTab = nil,
		Flags = self.Flags,
	}, Window)
	
	-- Main Window Frame
	local main = Create("Frame", {
		Name = "VantaWindow",
		BackgroundColor3 = Theme.Current.Background,
		Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2),
		Size = size,
		ClipsDescendants = false,
		Parent = self.ScreenGui,
	})
	AddCorner(main, 10)
	local border = AddStroke(main, "Border", 1)
	AddShadow(main, 18)
	Theme:Bind(main, "BackgroundColor3", "Background")
	
	win.MainFrame = main
	self.CurrentWindow = win
	
	-- Topbar Header
	local topbar = Create("Frame", {
		Name = "Topbar",
		BackgroundColor3 = Theme.Current.Topbar,
		Size = UDim2.new(1, 0, 0, 48),
		Parent = main,
	})
	AddCorner(topbar, 10)
	Theme:Bind(topbar, "BackgroundColor3", "Topbar")
	
	-- Fix bottom corner radius of topbar
	local topbarCover = Create("Frame", {
		BackgroundColor3 = Theme.Current.Topbar,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -8),
		Size = UDim2.new(1, 0, 0, 8),
		Parent = topbar,
	})
	Theme:Bind(topbarCover, "BackgroundColor3", "Topbar")
	
	-- Window Title & Subtitle
	local titleLabel = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = string.upper(title),
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 8),
		Size = UDim2.new(0, 300, 0, 18),
		Parent = topbar,
	})
	Theme:Bind(titleLabel, "TextColor3", "Text")
	
	local subLabel = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = string.upper(subTitle),
		TextColor3 = Theme.Current.Accent,
		Font = Enum.Font.GothamBold,
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 16, 0, 26),
		Size = UDim2.new(0, 300, 0, 14),
		Parent = topbar,
	})
	Theme:Bind(subLabel, "TextColor3", "Accent")
	
	-- Window Action Controls (Minimize, Close)
	local actionsHolder = Create("Frame", {
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(0, 60, 0, 28),
		Parent = topbar,
	})
	
	local closeBtn = Create("TextButton", {
		Text = "",
		BackgroundColor3 = Color3.fromRGB(30, 34, 44),
		Size = UDim2.new(0, 26, 0, 26),
		Position = UDim2.new(1, -26, 0, 1),
		Parent = actionsHolder,
	})
	AddCorner(closeBtn, 6)
	local closeIcon = Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = Icons:Get("x"),
		ImageColor3 = Theme.Current.TextMuted,
		Size = UDim2.new(0, 14, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Parent = closeBtn,
	})
	closeBtn.MouseButton1Click:Connect(function()
		Vanta:Toggle()
	end)
	
	MakeDraggable(topbar, main)
	
	-- Sidebar (Tab List Container)
	local sidebar = Create("Frame", {
		Name = "Sidebar",
		BackgroundColor3 = Theme.Current.Sidebar,
		Position = UDim2.new(0, 0, 0, 48),
		Size = UDim2.new(0, 175, 1, -48),
		Parent = main,
	})
	AddCorner(sidebar, 10)
	Theme:Bind(sidebar, "BackgroundColor3", "Sidebar")
	
	-- Cover right corners of sidebar
	local sidebarCover = Create("Frame", {
		BackgroundColor3 = Theme.Current.Sidebar,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -8, 0, 0),
		Size = UDim2.new(0, 8, 1, 0),
		Parent = sidebar,
	})
	Theme:Bind(sidebarCover, "BackgroundColor3", "Sidebar")
	
	local sidebarDivider = Create("Frame", {
		BackgroundColor3 = Theme.Current.Border,
		BorderSizePixel = 0,
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(0, 1, 1, 0),
		Parent = sidebar,
	})
	Theme:Bind(sidebarDivider, "BackgroundColor3", "Border")
	
	local tabScroll = Create("ScrollingFrame", {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Current.BorderLight,
		Position = UDim2.new(0, 8, 0, 10),
		Size = UDim2.new(1, -16, 1, -20),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = sidebar,
	})
	
	local tabLayout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 6),
		Parent = tabScroll,
	})
	
	win.TabScroll = tabScroll
	
	-- Content Container
	local content = Create("Frame", {
		Name = "ContentContainer",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 185, 0, 56),
		Size = UDim2.new(1, -195, 1, -66),
		ClipsDescendants = true,
		Parent = main,
	})
	win.ContentContainer = content
	
	return win
end

-- [6] TAB CLASS
local Tab = {}
Tab.__index = Tab

function Window:CreateTab(config)
	config = config or {}
	local title = config.Title or config.Name or "Tab"
	local icon = config.Icon or "folder"
	
	local tab = setmetatable({
		Title = title,
		Icon = icon,
		Window = self,
		Sections = {},
	}, Tab)
	
	-- Tab Button in Sidebar
	local tabButton = Create("TextButton", {
		Name = "Tab_" .. title,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 36),
		Text = "",
		AutoButtonColor = false,
		Parent = self.TabScroll,
	})
	AddCorner(tabButton, 6)
	
	local tabIcon = Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = Icons:Get(icon),
		ImageColor3 = Theme.Current.TextMuted,
		Size = UDim2.new(0, 18, 0, 18),
		Position = UDim2.new(0, 10, 0.5, -9),
		Parent = tabButton,
	})
	
	local tabLabel = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.TextMuted,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 36, 0, 0),
		Size = UDim2.new(1, -40, 1, 0),
		Parent = tabButton,
	})
	
	-- Active Indicator Pill
	local indicator = Create("Frame", {
		BackgroundColor3 = Theme.Current.Accent,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 0.2, 0),
		Size = UDim2.new(0, 3, 0.6, 0),
		Visible = false,
		Parent = tabButton,
	})
	AddCorner(indicator, 2)
	Theme:Bind(indicator, "BackgroundColor3", "Accent")
	
	tab.Button = tabButton
	tab.Label = tabLabel
	tab.IconImg = tabIcon
	tab.Indicator = indicator
	
	-- Tab Content Page (Scrollable)
	local page = Create("ScrollingFrame", {
		Name = "Page_" .. title,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Current.BorderLight,
		Size = UDim2.new(1, 0, 1, 0),
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = false,
		Parent = self.ContentContainer,
	})
	
	local pageLayout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 12),
		Parent = page,
	})
	
	local pagePadding = Create("UIPadding", {
		PaddingRight = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 12),
		Parent = page,
	})
	
	tab.Page = page
	
	tabButton.MouseButton1Click:Connect(function()
		self:SelectTab(tab)
	end)
	
	table.insert(self.Tabs, tab)
	
	if #self.Tabs == 1 then
		self:SelectTab(tab)
	end
	
	return tab
end

function Window:SelectTab(selectedTab)
	for _, t in ipairs(self.Tabs) do
		local active = (t == selectedTab)
		t.Page.Visible = active
		t.Indicator.Visible = active
		
		if active then
			Tween(t.Button, { BackgroundTransparency = 0.85, BackgroundColor3 = Theme.Current.Accent }, 0.2)
			Tween(t.Label, { TextColor3 = Theme.Current.Text }, 0.2)
			Tween(t.IconImg, { ImageColor3 = Theme.Current.Accent }, 0.2)
		else
			Tween(t.Button, { BackgroundTransparency = 1 }, 0.2)
			Tween(t.Label, { TextColor3 = Theme.Current.TextMuted }, 0.2)
			Tween(t.IconImg, { ImageColor3 = Theme.Current.TextMuted }, 0.2)
		end
	end
	self.ActiveTab = selectedTab
end

-- [7] SECTION / GROUPBOX
local Section = {}
Section.__index = Section

function Tab:CreateSection(title)
	local section = setmetatable({
		Title = title,
		Tab = self,
	}, Section)
	
	local card = Create("Frame", {
		Name = "Section_" .. title,
		BackgroundColor3 = Theme.Current.Card,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = self.Page,
	})
	AddCorner(card, 8)
	local border = AddStroke(card, "Border", 1)
	Theme:Bind(card, "BackgroundColor3", "Card")
	
	local header = Create("Frame", {
		BackgroundColor3 = Theme.Current.CardHeader,
		Size = UDim2.new(1, 0, 0, 32),
		Parent = card,
	})
	AddCorner(header, 8)
	Theme:Bind(header, "BackgroundColor3", "CardHeader")
	
	local headerCover = Create("Frame", {
		BackgroundColor3 = Theme.Current.CardHeader,
		BorderSizePixel = 0,
		Position = UDim2.new(0, 0, 1, -6),
		Size = UDim2.new(1, 0, 0, 6),
		Parent = header,
	})
	Theme:Bind(headerCover, "BackgroundColor3", "CardHeader")
	
	local titleLabel = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(1, -24, 1, 0),
		Parent = header,
	})
	Theme:Bind(titleLabel, "TextColor3", "Text")
	
	local body = Create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 32),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = card,
	})
	
	local bodyLayout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
		Parent = body,
	})
	
	local bodyPadding = Create("UIPadding", {
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent = body,
	})
	
	section.Container = body
	table.insert(self.Sections, section)
	return section
end

-- [8] CONTROLS IMPLEMENTATION

-- BUTTON
function Section:CreateButton(config)
	config = config or {}
	local title = config.Title or "Button"
	local desc = config.Description
	local icon = config.Icon
	local callback = config.Callback or function() end
	
	local h = desc and 44 or 34
	local btn = Create("TextButton", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, h),
		Text = "",
		AutoButtonColor = false,
		Parent = self.Container,
	})
	AddCorner(btn, 6)
	AddStroke(btn, "Border", 1)
	Theme:Bind(btn, "BackgroundColor3", "Input")
	
	local titleX = icon and 34 or 12
	if icon then
		Create("ImageLabel", {
			BackgroundTransparency = 1,
			Image = Icons:Get(icon),
			ImageColor3 = Theme.Current.Accent,
			Size = UDim2.new(0, 16, 0, 16),
			Position = UDim2.new(0, 10, 0.5, -8),
			Parent = btn,
		})
	end
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, titleX, 0, desc and 6 or 0),
		Size = UDim2.new(1, -titleX - 10, 0, desc and 16 or h),
		Parent = btn,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	if desc then
		Create("TextLabel", {
			BackgroundTransparency = 1,
			Text = desc,
			TextColor3 = Theme.Current.TextMuted,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.new(0, titleX, 0, 22),
			Size = UDim2.new(1, -titleX - 10, 0, 16),
			Parent = btn,
		})
	end
	
	btn.MouseEnter:Connect(function()
		Tween(btn, { BackgroundColor3 = Theme.Current.InputHover }, 0.15)
	end)
	btn.MouseLeave:Connect(function()
		Tween(btn, { BackgroundColor3 = Theme.Current.Input }, 0.15)
	end)
	btn.MouseButton1Down:Connect(function()
		Tween(btn, { BackgroundColor3 = Theme.Current.AccentDim }, 0.1)
	end)
	btn.MouseButton1Up:Connect(function()
		Tween(btn, { BackgroundColor3 = Theme.Current.InputHover }, 0.1)
		task.spawn(callback)
	end)
	
	return btn
end

-- TOGGLE
function Section:CreateToggle(config)
	config = config or {}
	local title = config.Title or "Toggle"
	local desc = config.Description
	local default = config.Default or false
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local toggleState = default
	local h = desc and 44 or 34
	
	local toggleFrame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, h),
		Parent = self.Container,
	})
	AddCorner(toggleFrame, 6)
	AddStroke(toggleFrame, "Border", 1)
	Theme:Bind(toggleFrame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, desc and 6 or 0),
		Size = UDim2.new(1, -64, 0, desc and 16 or h),
		Parent = toggleFrame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	if desc then
		Create("TextLabel", {
			BackgroundTransparency = 1,
			Text = desc,
			TextColor3 = Theme.Current.TextMuted,
			Font = Enum.Font.Gotham,
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			Position = UDim2.new(0, 12, 0, 22),
			Size = UDim2.new(1, -64, 0, 16),
			Parent = toggleFrame,
		})
	end
	
	-- Switch Track
	local switch = Create("TextButton", {
		Text = "",
		BackgroundColor3 = toggleState and Theme.Current.Accent or Theme.Current.ToggleOff,
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		Size = UDim2.new(0, 40, 0, 20),
		AutoButtonColor = false,
		Parent = toggleFrame,
	})
	AddCorner(switch, 10)
	
	-- Switch Knob
	local knob = Create("Frame", {
		BackgroundColor3 = Theme.Current.ToggleKnob,
		Size = UDim2.new(0, 16, 0, 16),
		Position = toggleState and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
		Parent = switch,
	})
	AddCorner(knob, 8)
	
	local toggleObj = {
		Type = "Toggle",
		Value = toggleState,
	}
	
	function toggleObj:Set(val)
		toggleState = val
		self.Value = val
		if toggleState then
			Tween(switch, { BackgroundColor3 = Theme.Current.Accent }, 0.2)
			Tween(knob, { Position = UDim2.new(1, -18, 0.5, -8) }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		else
			Tween(switch, { BackgroundColor3 = Theme.Current.ToggleOff }, 0.2)
			Tween(knob, { Position = UDim2.new(0, 2, 0.5, -8) }, 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		end
		task.spawn(callback, toggleState)
	end
	
	switch.MouseButton1Click:Connect(function()
		toggleObj:Set(not toggleState)
	end)
	
	-- Register flag
	if flag then
		Vanta.Flags[flag] = toggleObj
	end
	
	return toggleObj
end

-- SLIDER
function Section:CreateSlider(config)
	config = config or {}
	local title = config.Title or "Slider"
	local min = config.Min or 0
	local max = config.Max or 100
	local default = config.Default or min
	local step = config.Step or 1
	local suffix = config.Suffix or ""
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local currentVal = default
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 48),
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 6),
		Size = UDim2.new(1, -80, 0, 16),
		Parent = frame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	local valLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = tostring(currentVal) .. suffix,
		TextColor3 = Theme.Current.Accent,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Right,
		Position = UDim2.new(1, -80, 0, 6),
		Size = UDim2.new(0, 68, 0, 16),
		Parent = frame,
	})
	Theme:Bind(valLbl, "TextColor3", "Accent")
	
	-- Slider Bar
	local track = Create("TextButton", {
		Text = "",
		AutoButtonColor = false,
		BackgroundColor3 = Theme.Current.ToggleOff,
		Position = UDim2.new(0, 12, 0, 30),
		Size = UDim2.new(1, -24, 0, 6),
		Parent = frame,
	})
	AddCorner(track, 3)
	
	local fill = Create("Frame", {
		BackgroundColor3 = Theme.Current.Accent,
		Size = UDim2.new(math.clamp((currentVal - min) / (max - min), 0, 1), 0, 1, 0),
		Parent = track,
	})
	AddCorner(fill, 3)
	Theme:Bind(fill, "BackgroundColor3", "Accent")
	
	local sliderObj = {
		Type = "Slider",
		Value = currentVal,
	}
	
	local function updateSlider(inputPos)
		local barWidth = track.AbsoluteSize.X
		local relX = math.clamp(inputPos.X - track.AbsolutePosition.X, 0, barWidth)
		local percent = relX / barWidth
		local rawVal = min + (max - min) * percent
		local steppedVal = math.floor((rawVal / step) + 0.5) * step
		steppedVal = math.clamp(steppedVal, min, max)
		
		sliderObj:Set(steppedVal)
	end
	
	function sliderObj:Set(val)
		val = math.clamp(val, min, max)
		currentVal = val
		self.Value = val
		valLbl.Text = tostring(val) .. suffix
		local p = (val - min) / (max - min)
		Tween(fill, { Size = UDim2.new(p, 0, 1, 0) }, 0.08)
		task.spawn(callback, val)
	end
	
	local dragging = false
	track.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			updateSlider(input.Position)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			updateSlider(input.Position)
		end
	end)
	
	if flag then
		Vanta.Flags[flag] = sliderObj
	end
	
	return sliderObj
end

-- DROPDOWN
function Section:CreateDropdown(config)
	config = config or {}
	local title = config.Title or "Dropdown"
	local options = config.Options or {}
	local default = config.Default or options[1]
	local multi = config.Multi or false
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local isOpen = false
	local selected = multi and (type(default) == "table" and default or {default}) or default
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 40),
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(0.5, 0, 1, 0),
		Parent = frame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	local valButton = Create("TextButton", {
		BackgroundColor3 = Color3.fromRGB(24, 28, 36),
		Size = UDim2.new(0.45, 0, 0, 26),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Text = "",
		AutoButtonColor = false,
		Parent = frame,
	})
	AddCorner(valButton, 4)
	AddStroke(valButton, "Border", 1)
	
	local displayVal = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = multi and table.concat(selected, ", ") or tostring(selected or "None"),
		TextColor3 = Theme.Current.TextMuted,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -26, 1, 0),
		Parent = valButton,
	})
	
	local chevron = Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = Icons:Get("chevron-down"),
		ImageColor3 = Theme.Current.TextMuted,
		Size = UDim2.new(0, 14, 0, 14),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0),
		Parent = valButton,
	})
	
	-- Floating Dropdown Menu in Overlay container
	local menu = Create("ScrollingFrame", {
		Name = "DropdownMenu",
		BackgroundColor3 = Theme.Current.Card,
		BorderSizePixel = 0,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Current.BorderLight,
		Size = UDim2.new(0, 180, 0, 0),
		Visible = false,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = Vanta.Overlay,
	})
	AddCorner(menu, 6)
	AddStroke(menu, "Border", 1)
	AddShadow(menu, 10)
	Theme:Bind(menu, "BackgroundColor3", "Card")
	
	local menuLayout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
		Parent = menu,
	})
	Create("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		PaddingBottom = UDim.new(0, 6),
		PaddingLeft = UDim.new(0, 6),
		PaddingRight = UDim.new(0, 6),
		Parent = menu,
	})
	
	local dropdownObj = {
		Type = "Dropdown",
		Value = selected,
		Options = options,
	}
	
	local function updateDisplay()
		if multi then
			displayVal.Text = #selected > 0 and table.concat(selected, ", ") or "None"
		else
			displayVal.Text = tostring(selected or "None")
		end
	end
	
	function dropdownObj:Set(newVal)
		selected = newVal
		self.Value = newVal
		updateDisplay()
		task.spawn(callback, newVal)
	end
	
	function dropdownObj:SetOptions(newOptions)
		self.Options = newOptions
		options = newOptions
		self:Rebuild()
	end
	
	function dropdownObj:Rebuild()
		for _, child in ipairs(menu:GetChildren()) do
			if child:IsA("TextButton") then child:Destroy() end
		end
		for _, opt in ipairs(options) do
			local optBtn = Create("TextButton", {
				Text = opt,
				TextColor3 = Theme.Current.TextMuted,
				Font = Enum.Font.Gotham,
				TextSize = 12,
				BackgroundColor3 = Color3.fromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 26),
				AutoButtonColor = false,
				Parent = menu,
			})
			AddCorner(optBtn, 4)
			
			optBtn.MouseEnter:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 0.8, BackgroundColor3 = Theme.Current.Accent, TextColor3 = Theme.Current.Text }, 0.1)
			end)
			optBtn.MouseLeave:Connect(function()
				Tween(optBtn, { BackgroundTransparency = 1, TextColor3 = Theme.Current.TextMuted }, 0.1)
			end)
			
			optBtn.MouseButton1Click:Connect(function()
				if multi then
					local idx = table.find(selected, opt)
					if idx then table.remove(selected, idx) else table.insert(selected, opt) end
					dropdownObj:Set(selected)
				else
					dropdownObj:Set(opt)
					isOpen = false
					menu.Visible = false
					Tween(chevron, { Rotation = 0 }, 0.2)
				end
			end)
		end
	end
	
	dropdownObj:Rebuild()
	
	valButton.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then
			local absPos = valButton.AbsolutePosition
			local absSize = valButton.AbsoluteSize
			menu.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
			menu.Size = UDim2.new(0, absSize.X, 0, math.min(#options * 30 + 12, 160))
			menu.Visible = true
			Tween(chevron, { Rotation = 180 }, 0.2)
		else
			menu.Visible = false
			Tween(chevron, { Rotation = 0 }, 0.2)
		end
	end)
	
	if flag then
		Vanta.Flags[flag] = dropdownObj
	end
	
	return dropdownObj
end

-- COLORPICKER
function Section:CreateColorPicker(config)
	config = config or {}
	local title = config.Title or "Color Picker"
	local default = config.Default or Color3.fromRGB(255, 255, 255)
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local currentColor = default
	local isOpen = false
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 36),
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(1, -60, 1, 0),
		Parent = frame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	-- Swatch Button
	local swatch = Create("TextButton", {
		Text = "",
		BackgroundColor3 = currentColor,
		Size = UDim2.new(0, 30, 0, 20),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		AutoButtonColor = false,
		Parent = frame,
	})
	AddCorner(swatch, 4)
	AddStroke(swatch, "Border", 1)
	
	-- Palette Window (Overlay)
	local palette = Create("Frame", {
		BackgroundColor3 = Theme.Current.Card,
		Size = UDim2.new(0, 180, 0, 140),
		Visible = false,
		Parent = Vanta.Overlay,
	})
	AddCorner(palette, 8)
	AddStroke(palette, "Border", 1)
	AddShadow(palette, 12)
	Theme:Bind(palette, "BackgroundColor3", "Card")
	
	-- Preset Color Row
	local presets = {
		Color3.fromRGB(255, 75, 75),
		Color3.fromRGB(255, 165, 0),
		Color3.fromRGB(255, 235, 59),
		Color3.fromRGB(76, 175, 80),
		Color3.fromRGB(0, 168, 255),
		Color3.fromRGB(156, 39, 176),
		Color3.fromRGB(255, 255, 255),
		Color3.fromRGB(30, 30, 30),
	}
	
	local presetHolder = Create("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 10),
		Size = UDim2.new(1, -20, 0, 50),
		Parent = palette,
	})
	
	local grid = Create("UIGridLayout", {
		CellSize = UDim2.new(0, 32, 0, 22),
		CellPadding = UDim2.new(0, 8, 0, 6),
		Parent = presetHolder,
	})
	
	local colorObj = {
		Type = "ColorPicker",
		Value = currentColor,
	}
	
	function colorObj:Set(c)
		currentColor = c
		self.Value = c
		swatch.BackgroundColor3 = c
		task.spawn(callback, c)
	end
	
	for _, c in ipairs(presets) do
		local pBtn = Create("TextButton", {
			Text = "",
			BackgroundColor3 = c,
			AutoButtonColor = false,
			Parent = presetHolder,
		})
		AddCorner(pBtn, 4)
		pBtn.MouseButton1Click:Connect(function()
			colorObj:Set(c)
		end)
	end
	
	swatch.MouseButton1Click:Connect(function()
		isOpen = not isOpen
		if isOpen then
			local absPos = swatch.AbsolutePosition
			palette.Position = UDim2.new(0, absPos.X - 140, 0, absPos.Y + 28)
			palette.Visible = true
		else
			palette.Visible = false
		end
	end)
	
	if flag then
		Vanta.Flags[flag] = colorObj
	end
	
	return colorObj
end

-- KEYBIND
function Section:CreateKeybind(config)
	config = config or {}
	local title = config.Title or "Keybind"
	local default = config.Default or Enum.KeyCode.E
	local mode = config.Mode or "Toggle" -- Toggle, Hold, Always
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local currentKey = default
	local listening = false
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 36),
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(1, -80, 1, 0),
		Parent = frame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	local bindBtn = Create("TextButton", {
		Text = currentKey and "[" .. currentKey.Name .. "]" or "[None]",
		TextColor3 = Theme.Current.Accent,
		Font = Enum.Font.GothamBold,
		TextSize = 12,
		BackgroundColor3 = Color3.fromRGB(24, 28, 36),
		Size = UDim2.new(0, 60, 0, 22),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -12, 0.5, 0),
		AutoButtonColor = false,
		Parent = frame,
	})
	AddCorner(bindBtn, 4)
	AddStroke(bindBtn, "Border", 1)
	Theme:Bind(bindBtn, "TextColor3", "Accent")
	
	local keybindObj = {
		Type = "Keybind",
		Value = currentKey,
		Mode = mode,
	}
	
	function keybindObj:SetKey(keyCode)
		currentKey = keyCode
		self.Value = keyCode
		bindBtn.Text = keyCode and "[" .. keyCode.Name .. "]" or "[None]"
	end
	
	bindBtn.MouseButton1Click:Connect(function()
		listening = true
		bindBtn.Text = "[...]"
	end)
	
	UserInputService.InputBegan:Connect(function(input, gpe)
		if listening and input.UserInputType == Enum.UserInputType.Keyboard then
			listening = false
			if input.KeyCode == Enum.KeyCode.Escape then
				keybindObj:SetKey(nil)
			else
				keybindObj:SetKey(input.KeyCode)
			end
			return
		end
		
		if not gpe and currentKey and input.KeyCode == currentKey then
			task.spawn(callback, true)
		end
	end)
	
	UserInputService.InputEnded:Connect(function(input, gpe)
		if not gpe and mode == "Hold" and currentKey and input.KeyCode == currentKey then
			task.spawn(callback, false)
		end
	end)
	
	if flag then
		Vanta.Flags[flag] = keybindObj
	end
	
	return keybindObj
end

-- INPUT / TEXTBOX
function Section:CreateInput(config)
	config = config or {}
	local title = config.Title or "Input"
	local placeholder = config.Placeholder or "Type here..."
	local default = config.Default or ""
	local flag = config.Flag
	local callback = config.Callback or function() end
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 40),
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local titleLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamMedium,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Position = UDim2.new(0, 12, 0, 0),
		Size = UDim2.new(0.4, 0, 1, 0),
		Parent = frame,
	})
	Theme:Bind(titleLbl, "TextColor3", "Text")
	
	local boxBg = Create("Frame", {
		BackgroundColor3 = Color3.fromRGB(24, 28, 36),
		Size = UDim2.new(0.55, 0, 0, 26),
		AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -10, 0.5, 0),
		Parent = frame,
	})
	AddCorner(boxBg, 4)
	AddStroke(boxBg, "Border", 1)
	
	local tb = Create("TextBox", {
		BackgroundTransparency = 1,
		Text = default,
		PlaceholderText = placeholder,
		PlaceholderColor3 = Theme.Current.TextDark,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		ClearTextOnFocus = false,
		Position = UDim2.new(0, 8, 0, 0),
		Size = UDim2.new(1, -16, 1, 0),
		Parent = boxBg,
	})
	
	local inputObj = {
		Type = "Input",
		Value = default,
	}
	
	function inputObj:Set(val)
		tb.Text = tostring(val)
		self.Value = val
		task.spawn(callback, val)
	end
	
	tb.FocusLost:Connect(function(enterPressed)
		inputObj.Value = tb.Text
		task.spawn(callback, tb.Text)
	end)
	
	if flag then
		Vanta.Flags[flag] = inputObj
	end
	
	return inputObj
end

-- PARAGRAPH
function Section:CreateParagraph(config)
	config = config or {}
	local title = config.Title or "Paragraph"
	local content = config.Content or ""
	
	local frame = Create("Frame", {
		BackgroundColor3 = Theme.Current.Input,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = self.Container,
	})
	AddCorner(frame, 6)
	AddStroke(frame, "Border", 1)
	Theme:Bind(frame, "BackgroundColor3", "Input")
	
	local padding = Create("UIPadding", {
		PaddingTop = UDim.new(0, 8),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 10),
		PaddingRight = UDim.new(0, 10),
		Parent = frame,
	})
	
	local layout = Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 4),
		Parent = frame,
	})
	
	local tLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = title,
		TextColor3 = Theme.Current.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 16),
		Parent = frame,
	})
	Theme:Bind(tLbl, "TextColor3", "Text")
	
	local cLbl = Create("TextLabel", {
		BackgroundTransparency = 1,
		Text = content,
		TextColor3 = Theme.Current.TextMuted,
		Font = Enum.Font.Gotham,
		TextSize = 12,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		Parent = frame,
	})
	Theme:Bind(cLbl, "TextColor3", "TextMuted")
	
	return {
		Set = function(_, newTitle, newContent)
			if newTitle then tLbl.Text = newTitle end
			if newContent then cLbl.Text = newContent end
		end
	}
end

-- DIVIDER
function Section:CreateDivider()
	local divider = Create("Frame", {
		BackgroundColor3 = Theme.Current.Border,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 1),
		Parent = self.Container,
	})
	Theme:Bind(divider, "BackgroundColor3", "Border")
	return divider
end

-- Built-in Theme Picker Section Helper
function Vanta:BuildThemeSection(tabOrSection)
	local sec = tabOrSection.CreateSection and tabOrSection:CreateSection("Theme Customization") or tabOrSection
	
	local presetList = {}
	for name, _ in pairs(Theme.Presets) do
		table.insert(presetList, name)
	end
	
	sec:CreateDropdown({
		Title = "Theme Preset",
		Options = presetList,
		Default = "Obsidian",
		Callback = function(themeName)
			Theme:SetTheme(themeName)
		end
	})
	
	sec:CreateColorPicker({
		Title = "Accent Color",
		Default = Theme.Current.Accent,
		Callback = function(c)
			Theme:SetAccent(c)
		end
	})
	
	return sec
end

return Vanta
