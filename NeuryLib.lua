-- Neury Library Refactored & Enhanced (C++ Style Architecture)
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Library = {}
Library.__index = Library

function Library.new(hubName, accentColor)
	local self = setmetatable({}, Library)
	self.AccentColor = accentColor or Color3.fromRGB(0, 120, 255)
	self.IsMinimized = false
	
	if CoreGui:FindFirstChild("NeuryLibraryUI") then
		CoreGui.NeuryLibraryUI:Destroy()
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NeuryLibraryUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = CoreGui
	self.ScreenGui = ScreenGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Size = UDim2.new(0, 580, 0, 460)
	MainFrame.Position = UDim2.new(0.5, -290, 0.5, -230)
	MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = false
	MainFrame.Parent = ScreenGui
	self.MainFrame = MainFrame

	local MainCorner = Instance.new("UICorner")
	MainCorner.CornerRadius = UDim.new(0, 16)
	MainCorner.Parent = MainFrame

	local MainStroke = Instance.new("UIStroke")
	MainStroke.Color = Color3.fromRGB(30, 30, 40)
	MainStroke.Thickness = 1
	MainStroke.Parent = MainFrame

	local Header = Instance.new("Frame")
	Header.Name = "Header"
	Header.Size = UDim2.new(1, 0, 0, 50)
	Header.BackgroundTransparency = 1
	Header.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(0, 350, 1, 0)
	TitleLabel.Position = UDim2.new(0, 16, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = hubName or "Neury | Core System"
	TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Header

	local HeaderDivider = Instance.new("Frame")
	HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
	HeaderDivider.Position = UDim2.new(0, 0, 1, 0)
	HeaderDivider.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	HeaderDivider.BorderSizePixel = 0
	HeaderDivider.Parent = Header

	-- Window Control Buttons (X and Minimize [-])
	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 28, 0, 28)
	CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
	CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	CloseBtn.AutoButtonColor = false
	CloseBtn.Text = "×"
	CloseBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 16
	CloseBtn.Parent = Header

	local CloseCorner = Instance.new("UICorner")
	CloseCorner.CornerRadius = UDim.new(0, 6)
	CloseCorner.Parent = CloseBtn

	CloseBtn.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	local MinBtn = Instance.new("TextButton")
	MinBtn.Size = UDim2.new(0, 28, 0, 28)
	MinBtn.Position = UDim2.new(1, -70, 0.5, -14)
	MinBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
	MinBtn.AutoButtonColor = false
	MinBtn.Text = "-"
	MinBtn.TextColor3 = Color3.fromRGB(180, 180, 190)
	MinBtn.Font = Enum.Font.GothamBold
	MinBtn.TextSize = 16
	MinBtn.Parent = Header

	local MinCorner = Instance.new("UICorner")
	MinCorner.CornerRadius = UDim.new(0, 6)
	MinCorner.Parent = MinBtn

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 150, 1, -51)
	Sidebar.Position = UDim2.new(0, 0, 0, 51)
	Sidebar.BackgroundTransparency = 1
	Sidebar.Parent = MainFrame
	self.Sidebar = Sidebar

	local SidebarDivider = Instance.new("Frame")
	SidebarDivider.Size = UDim2.new(0, 1, 1, -51)
	SidebarDivider.Position = UDim2.new(0, 150, 0, 51)
	SidebarDivider.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.Parent = MainFrame

	local SlidingIndicator = Instance.new("Frame")
	SlidingIndicator.Name = "SlidingIndicator"
	SlidingIndicator.Size = UDim2.new(1, -20, 0, 34)
	SlidingIndicator.Position = UDim2.new(0, 10, 0, 10)
	SlidingIndicator.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	SlidingIndicator.BorderSizePixel = 0
	SlidingIndicator.ZIndex = 1
	SlidingIndicator.Parent = Sidebar
	self.SlidingIndicator = SlidingIndicator

	local SlidingCorner = Instance.new("UICorner")
	SlidingCorner.CornerRadius = UDim.new(0, 6)
	SlidingCorner.Parent = SlidingIndicator

	local AccentBar = Instance.new("Frame")
	AccentBar.Size = UDim2.new(0, 3, 0, 14)
	AccentBar.Position = UDim2.new(0, 0, 0.5, -7)
	AccentBar.BackgroundColor3 = self.AccentColor
	AccentBar.BorderSizePixel = 0
	AccentBar.Parent = SlidingIndicator

	local AccentBarCorner = Instance.new("UICorner")
	AccentBarCorner.CornerRadius = UDim.new(1, 0)
	AccentBarCorner.Parent = AccentBar

	local SidebarItemsContainer = Instance.new("Frame")
	SidebarItemsContainer.Size = UDim2.new(1, 0, 1, -10)
	SidebarItemsContainer.BackgroundTransparency = 1
	SidebarItemsContainer.ZIndex = 2
	SidebarItemsContainer.Parent = Sidebar

	local SidebarLayout = Instance.new("UIListLayout")
	SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SidebarLayout.Padding = UDim.new(0, 4)
	SidebarLayout.Parent = SidebarItemsContainer

	local SidebarPadding = Instance.new("UIPadding")
	SidebarPadding.PaddingTop = UDim.new(0, 10)
	SidebarPadding.PaddingLeft = UDim.new(0, 10)
	SidebarPadding.PaddingRight = UDim.new(0, 10)
	SidebarPadding.Parent = SidebarItemsContainer
	self.SidebarItemsContainer = SidebarItemsContainer

	local PagesContainer = Instance.new("Frame")
	PagesContainer.Size = UDim2.new(1, -161, 1, -62)
	PagesContainer.Position = UDim2.new(0, 160, 0, 57)
	PagesContainer.BackgroundTransparency = 1
	PagesContainer.ClipsDescendants = true
	PagesContainer.Parent = MainFrame
	self.PagesContainer = PagesContainer

	self.Tabs = {}
	self.Pages = {}
	self.TabCount = 0

	-- Minimize Functionality
	MinBtn.MouseButton1Click:Connect(function()
		self.IsMinimized = not self.IsMinimized
		local targetSize = self.IsMinimized and UDim2.new(0, 580, 0, 50) or UDim2.new(0, 580, 0, 460)
		Sidebar.Visible = not self.IsMinimized
		SidebarDivider.Visible = not self.IsMinimized
		PagesContainer.Visible = not self.IsMinimized
		TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
	end)

	-- Draggable functionality
	local draggingMain, dragStart, startPos
	MainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingMain = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingMain = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingMain = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if draggingMain and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	return self
end

function Library:AddTab(name, imageId)
	self.TabCount = self.TabCount + 1
	local layoutOrder = self.TabCount
	local isFirst = (layoutOrder == 1)

	local TabButton = Instance.new("TextButton")
	TabButton.Size = UDim2.new(1, 0, 0, 34)
	TabButton.BackgroundTransparency = 1
	TabButton.Font = Enum.Font.GothamMedium
	TabButton.Text = imageId and "            " .. name or "    " .. name
	TabButton.TextColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175)
	TabButton.TextSize = 13
	TabButton.TextXAlignment = Enum.TextXAlignment.Left
	TabButton.AutoButtonColor = false
	TabButton.LayoutOrder = layoutOrder
	TabButton.ZIndex = 3
	TabButton.Parent = self.SidebarItemsContainer

	if imageId then
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Size = UDim2.new(0, 20, 0, 20)
		TabIcon.Position = UDim2.new(0, 6, 0.5, -10)
		TabIcon.BackgroundTransparency = 1
		TabIcon.Image = "rbxassetid://" .. tostring(imageId)
		TabIcon.ImageColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 175)
		TabIcon.ZIndex = 3
		TabIcon.Parent = TabButton
		
		TabButton:GetPropertyChangedSignal("TextColor3"):Connect(function()
			TabIcon.ImageColor3 = TabButton.TextColor3
		end)
	end

	local Page = Instance.new("ScrollingFrame")
	Page.Size = UDim2.new(1, 0, 1, 0)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.CanvasSize = UDim2.new(0, 0, 0, 0)
	Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	Page.ScrollBarThickness = 3
	Page.ScrollBarImageColor3 = Color3.fromRGB(35, 35, 42)
	Page.Visible = isFirst
	Page.Parent = self.PagesContainer

	local PageLayout = Instance.new("UIListLayout")
	PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PageLayout.Padding = UDim.new(0, 10)
	PageLayout.Parent = Page

	local libraryRef = self
	TabButton.MouseButton1Click:Connect(function()
		for _, p in pairs(libraryRef.Pages) do p.Visible = false end
		for _, t in pairs(libraryRef.Tabs) do
			TweenService:Create(t, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(160, 160, 175)}):Play()
		end
		Page.Visible = true
		TweenService:Create(TabButton, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()

		local relativeY = TabButton.AbsolutePosition.Y - libraryRef.Sidebar.AbsolutePosition.Y
		TweenService:Create(libraryRef.SlidingIndicator, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Position = UDim2.new(0, 10, 0, relativeY)
		}):Play()
	end)

	table.insert(self.Tabs, TabButton)
	table.insert(self.Pages, Page)

	local TabObj = {}

	function TabObj:AddSectionHeader(text)
		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, 0, 0, 20)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamBold
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(100, 100, 110)
		Label.TextSize = 11
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = Page
	end

	function TabObj:AddToggle(text, callback, defaultState)
		local ToggleFrame = Instance.new("Frame")
		ToggleFrame.Size = UDim2.new(1, -10, 0, 38)
		ToggleFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		ToggleFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = ToggleFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -60, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ToggleFrame

		local Pill = Instance.new("TextButton")
		Pill.Size = UDim2.new(0, 40, 0, 20)
		Pill.Position = UDim2.new(1, -52, 0.5, -10)
		Pill.BackgroundColor3 = defaultState and libraryRef.AccentColor or Color3.fromRGB(12, 12, 14)
		Pill.AutoButtonColor = false
		Pill.Text = ""
		Pill.Parent = ToggleFrame

		local PillCorner = Instance.new("UICorner")
		PillCorner.CornerRadius = UDim.new(1, 0)
		PillCorner.Parent = Pill

		local PillStroke = Instance.new("UIStroke")
		PillStroke.Color = Color3.fromRGB(255, 255, 255)
		PillStroke.Thickness = 1
		PillStroke.Parent = Pill

		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 14, 0, 14)
		Circle.Position = defaultState and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.Parent = Pill

		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = Circle

		local toggled = defaultState or false
		Pill.MouseButton1Click:Connect(function()
			toggled = not toggled
			local targetBg = toggled and libraryRef.AccentColor or Color3.fromRGB(12, 12, 14)
			local targetPos = toggled and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)

			TweenService:Create(Pill, TweenInfo.new(0.15), {BackgroundColor3 = targetBg}):Play()
			TweenService:Create(Circle, TweenInfo.new(0.15), {Position = targetPos}):Play()

			if callback then callback(toggled) end
		end)
	end

	function TabObj:AddButton(text, callback)
		local ButtonFrame = Instance.new("TextButton")
		ButtonFrame.Size = UDim2.new(1, -10, 0, 38)
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		ButtonFrame.AutoButtonColor = false
		ButtonFrame.Text = ""
		ButtonFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = ButtonFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -24, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ButtonFrame

		ButtonFrame.MouseButton1Click:Connect(function()
			if callback then callback() end
		end)
	end

	function TabObj:AddSlider(text, min, max, default, callback)
		local SliderFrame = Instance.new("Frame")
		SliderFrame.Size = UDim2.new(1, -10, 0, 50)
		SliderFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		SliderFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = SliderFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -30, 0, 22)
		Label.Position = UDim2.new(0, 12, 0, 4)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = SliderFrame

		local ValueLabel = Instance.new("TextLabel")
		ValueLabel.Size = UDim2.new(0, 50, 0, 22)
		ValueLabel.Position = UDim2.new(1, -62, 0, 4)
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = tostring(default)
		ValueLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
		ValueLabel.TextSize = 12
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		ValueLabel.Parent = SliderFrame

		local Track = Instance.new("Frame")
		Track.Size = UDim2.new(1, -24, 0, 4)
		Track.Position = UDim2.new(0, 12, 0, 34)
		Track.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
		Track.BorderSizePixel = 0
		Track.Parent = SliderFrame

		local TrackCorner = Instance.new("UICorner")
		TrackCorner.CornerRadius = UDim.new(1, 0)
		TrackCorner.Parent = Track

		local Fill = Instance.new("Frame")
		Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
		Fill.BackgroundColor3 = libraryRef.AccentColor
		Fill.BorderSizePixel = 0
		Fill.Parent = Track

		local FillCorner = Instance.new("UICorner")
		FillCorner.CornerRadius = UDim.new(1, 0)
		FillCorner.Parent = Fill

		local Knob = Instance.new("TextButton")
		Knob.Size = UDim2.new(0, 12, 0, 12)
		Knob.Position = UDim2.new(1, -6, 0.5, -6)
		Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Knob.AutoButtonColor = false
		Knob.Text = ""
		Knob.Parent = Fill

		local KnobCorner = Instance.new("UICorner")
		KnobCorner.CornerRadius = UDim.new(1, 0)
		KnobCorner.Parent = Knob

		local dragging = false

		local function updateValue(input)
			local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
			local val = math.floor(min + ((max - min) * pos))
			Fill.Size = UDim2.new(pos, 0, 1, 0)
			ValueLabel.Text = tostring(val)
			if callback then callback(val) end
		end

		Knob.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
			end
		end)

		Track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateValue(input)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateValue(input)
			end
		end)
	end

	function TabObj:AddTextbox(text, placeholder, callback)
		local TextboxFrame = Instance.new("Frame")
		TextboxFrame.Size = UDim2.new(1, -10, 0, 38)
		TextboxFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		TextboxFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = TextboxFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -140, 1, 0)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = TextboxFrame

		local TextBoxContainer = Instance.new("Frame")
		TextBoxContainer.Size = UDim2.new(0, 110, 0, 24)
		TextBoxContainer.Position = UDim2.new(1, -120, 0.5, -12)
		TextBoxContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		TextBoxContainer.Parent = TextboxFrame

		local CornerBox = Instance.new("UICorner")
		CornerBox.CornerRadius = UDim.new(0, 4)
		CornerBox.Parent = TextBoxContainer

		local TextBox = Instance.new("TextBox")
		TextBox.Size = UDim2.new(1, -6, 1, 0)
		TextBox.Position = UDim2.new(0, 3, 0, 0)
		TextBox.BackgroundTransparency = 1
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = placeholder or "Value..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(200, 200, 210)
		TextBox.TextSize = 10
		TextBox.ClearTextOnFocus = false
		TextBox.Parent = TextBoxContainer

		TextBox.FocusLost:Connect(function(enterPressed)
			if callback then callback(TextBox.Text, enterPressed) end
		end)
	end

	function TabObj:AddDropdown(text, options, defaultOption, callback)
		local DropdownOpen = false
		local selectedOption = defaultOption or options[1] or "Select..."

		local DropdownFrame = Instance.new("Frame")
		DropdownFrame.Size = UDim2.new(1, -10, 0, 38)
		DropdownFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		DropdownFrame.ClipsDescendants = true
		DropdownFrame.ZIndex = 5
		DropdownFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 6)
		Corner.Parent = DropdownFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -140, 0, 38)
		Label.Position = UDim2.new(0, 12, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.ZIndex = 5
		Label.Parent = DropdownFrame

		local DropButton = Instance.new("TextButton")
		DropButton.Size = UDim2.new(0, 120, 0, 24)
		DropButton.Position = UDim2.new(1, -130, 0, 7)
		DropButton.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		DropButton.AutoButtonColor = false
		DropButton.Text = tostring(selectedOption)
		DropButton.TextColor3 = Color3.fromRGB(180, 180, 190)
		DropButton.Font = Enum.Font.GothamMedium
		DropButton.TextSize = 10
		DropButton.ZIndex = 5
		DropButton.Parent = DropdownFrame

		local DropCorner = Instance.new("UICorner")
		DropCorner.CornerRadius = UDim.new(0, 4)
		DropCorner.Parent = DropButton

		local ListContainer = Instance.new("Frame")
		ListContainer.Size = UDim2.new(1, -24, 0, 0)
		ListContainer.Position = UDim2.new(0, 12, 0, 44)
		ListContainer.BackgroundTransparency = 1
		ListContainer.ZIndex = 5
		ListContainer.Parent = DropdownFrame

		local ListLayout = Instance.new("UIListLayout")
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Padding = UDim.new(0, 4)
		ListLayout.Parent = ListContainer

		local calcHeight = 38
		for _, opt in ipairs(options) do
			calcHeight = calcHeight + 28
			local OptionButton = Instance.new("TextButton")
			OptionButton.Size = UDim2.new(1, 0, 0, 24)
			OptionButton.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
			OptionButton.AutoButtonColor = false
			OptionButton.Text = tostring(opt)
			OptionButton.TextColor3 = (opt == selectedOption) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 150)
			OptionButton.Font = Enum.Font.GothamMedium
			OptionButton.TextSize = 10
			OptionButton.ZIndex = 5
			OptionButton.Parent = ListContainer

			local OptCorner = Instance.new("UICorner")
			OptCorner.CornerRadius = UDim.new(0, 4)
			OptCorner.Parent = OptionButton

			OptionButton.MouseButton1Click:Connect(function()
				selectedOption = opt
				DropButton.Text = tostring(opt)
				DropdownOpen = false
				TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 38)}):Play()
				
				for _, child in pairs(ListContainer:GetChildren()) do
					if child:IsA("TextButton") then
						child.TextColor3 = (child.Text == tostring(selectedOption)) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(140, 140, 150)
					end
				end

				if callback then callback(opt) end
			end)
		end

		DropButton.MouseButton1Click:Connect(function()
			DropdownOpen = not DropdownOpen
			local targetSize = DropdownOpen and UDim2.new(1, -10, 0, calcHeight) or UDim2.new(1, -10, 0, 38)
			TweenService:Create(DropdownFrame, TweenInfo.new(0.2), {Size = targetSize}):Play()
		end)
	end

	-- Added Feature: AddTextboxToggle (Composite UI Element: Button appearance at top, vertical offset, TextBox, then Toggle underneath)
	function TabObj:AddTextboxToggle(config)
		local name = config.Name or "Configure Control"
		local textBoxText = config.TextBoxText or ""
		local placeholder = config.Placeholder or "Enter value..."
		local defaultToggle = config.DefaultState or false
		local onTextBoxChanged = config.OnTextBoxChanged
		local onToggleChanged = config.OnToggleChanged

		local MainCompFrame = Instance.new("Frame")
		MainCompFrame.Size = UDim2.new(1, -10, 0, 94)
		MainCompFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		MainCompFrame.Parent = Page

		local CompCorner = Instance.new("UICorner")
		CompCorner.CornerRadius = UDim.new(0, 6)
		CompCorner.Parent = MainCompFrame

		-- Top Label (Button Styled Header)
		local TopLabel = Instance.new("TextLabel")
		TopLabel.Size = UDim2.new(1, -24, 0, 24)
		TopLabel.Position = UDim2.new(0, 12, 0, 8)
		TopLabel.BackgroundTransparency = 1
		TopLabel.Font = Enum.Font.GothamBold
		TopLabel.Text = name
		TopLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
		TopLabel.TextSize = 12
		TopLabel.TextXAlignment = Enum.TextXAlignment.Left
		TopLabel.Parent = MainCompFrame

		-- Middle Textbox (Spaced down)
		local TextBoxContainer = Instance.new("Frame")
		TextBoxContainer.Size = UDim2.new(1, -24, 0, 24)
		TextBoxContainer.Position = UDim2.new(0, 12, 0, 36)
		TextBoxContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		TextBoxContainer.Parent = MainCompFrame

		local TBContainerCorner = Instance.new("UICorner")
		TBContainerCorner.CornerRadius = UDim.new(0, 4)
		TBContainerCorner.Parent = TextBoxContainer

		local TextBox = Instance.new("TextBox")
		TextBox.Size = UDim2.new(1, -10, 1, 0)
		TextBox.Position = UDim2.new(0, 5, 0, 0)
		TextBox.BackgroundTransparency = 1
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = placeholder
		TextBox.Text = textBoxText
		TextBox.TextColor3 = Color3.fromRGB(200, 200, 210)
		TextBox.TextSize = 10
		TextBox.ClearTextOnFocus = false
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		TextBox.Parent = TextBoxContainer

		TextBox.FocusLost:Connect(function(enterPressed)
			if onTextBoxChanged then onTextBoxChanged(TextBox.Text, enterPressed) end
		end)

		-- Bottom Toggle Component
		local ToggleContainer = Instance.new("Frame")
		ToggleContainer.Size = UDim2.new(1, -24, 0, 24)
		ToggleContainer.Position = UDim2.new(0, 12, 0, 64)
		ToggleContainer.BackgroundTransparency = 1
		ToggleContainer.Parent = MainCompFrame

		local ToggleStatusLabel = Instance.new("TextLabel")
		ToggleStatusLabel.Size = UDim2.new(1, -50, 1, 0)
		ToggleStatusLabel.BackgroundTransparency = 1
		ToggleStatusLabel.Font = Enum.Font.GothamMedium
		ToggleStatusLabel.Text = "Active Status"
		ToggleStatusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		ToggleStatusLabel.TextSize = 11
		ToggleStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
		ToggleStatusLabel.Parent = ToggleContainer

		local Pill = Instance.new("TextButton")
		Pill.Size = UDim2.new(0, 36, 0, 18)
		Pill.Position = UDim2.new(1, -36, 0.5, -9)
		Pill.BackgroundColor3 = defaultToggle and libraryRef.AccentColor or Color3.fromRGB(12, 12, 14)
		Pill.AutoButtonColor = false
		Pill.Text = ""
		Pill.Parent = ToggleContainer

		local PillCorner = Instance.new("UICorner")
		PillCorner.CornerRadius = UDim.new(1, 0)
		PillCorner.Parent = Pill

		local PillStroke = Instance.new("UIStroke")
		PillStroke.Color = Color3.fromRGB(255, 255, 255)
		PillStroke.Thickness = 1
		PillStroke.Parent = Pill

		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 12, 0, 12)
		Circle.Position = defaultToggle and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.Parent = Pill

		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = Circle

		local toggled = defaultToggle
		Pill.MouseButton1Click:Connect(function()
			toggled = not toggled
			local targetBg = toggled and libraryRef.AccentColor or Color3.fromRGB(12, 12, 14)
			local targetPos = toggled and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)

			TweenService:Create(Pill, TweenInfo.new(0.15), {BackgroundColor3 = targetBg}):Play()
			TweenService:Create(Circle, TweenInfo.new(0.15), {Position = targetPos}):Play()

			if onToggleChanged then onToggleChanged(toggled) end
		end)
	end

	return TabObj
end

return Library
