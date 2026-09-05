--[[
	    _   __                         __  ______   __    _ __                         
	   / | / /__  __  _________  __   / / / /  _/  / /   (_) /_  _________ ________  __
	  /  |/ / _ \/ / / / ___/ / / /  / / / // /   / /   / / __ \/ ___/ __ `/ ___/ / / /
	 / /|  /  __/ /_/ / /  / /_/ /  / /_/ // /   / /___/ / /_/ / /  / /_/ / /  / /_/ / 
	/_/ |_/\___/\__,_/_/   \__, /   \____/___/  /_____/_/_.___/_/   \__,_/_/   \__, /  
    	                  /____/                                              /____/   
	
	Made by iXayemiz
	Discord Username: 9amhd
	You can message me if you want to ask something or want me to make you a hub
--]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

local OWNER_IDS = {
	5641678614,
}

local TESTER_ID = {
	7900997577,
	5775360001,
}

local function IsOwner(userId)
	for _, id in ipairs(OWNER_IDS) do
		if id == userId then
			return true
		end
	end
	return false
end

local function IsTester(userId)
	for _, id in ipairs(TESTER_ID) do
		if id == userId then
			return true
		end
	end
	return false
end

local function GetRoleText(userId)
	if IsOwner(userId) then
		return "Owner"
	elseif IsTester(userId) then
		return "Tester"
	else
		return "Member"
	end
end

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
	MainFrame.Size = UDim2.new(0, 790, 0, 630)
	MainFrame.Position = UDim2.new(0.5, -380, 0.5, -300)
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
	Header.Size = UDim2.new(1, 0, 0, 54)
	Header.BackgroundTransparency = 1
	Header.Parent = MainFrame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(0, 400, 1, 0)
	TitleLabel.Position = UDim2.new(0, 18, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = hubName or "Neury | Core System"
	TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
	TitleLabel.TextSize = 14
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Header

	local HeaderDivider = Instance.new("Frame")
	HeaderDivider.Size = UDim2.new(1, 0, 0, 1)
	HeaderDivider.Position = UDim2.new(0, 0, 1, 0)
	HeaderDivider.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	HeaderDivider.BorderSizePixel = 0
	HeaderDivider.Parent = Header

	local ControlsContainer = Instance.new("Frame")
	ControlsContainer.Name = "ControlsContainer"
	ControlsContainer.Size = UDim2.new(0, 76, 0, 30)
	ControlsContainer.Position = UDim2.new(1, -88, 0.5, -15)
	ControlsContainer.BackgroundTransparency = 1
	ControlsContainer.Parent = Header

	local ControlsLayout = Instance.new("UIListLayout")
	ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
	ControlsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	ControlsLayout.Padding = UDim.new(0, 8)
	ControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ControlsLayout.Parent = ControlsContainer

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"
	Sidebar.Size = UDim2.new(0, 195, 1, -55)
	Sidebar.Position = UDim2.new(0, 0, 0, 55)
	Sidebar.BackgroundTransparency = 1
	Sidebar.Parent = MainFrame
	self.Sidebar = Sidebar

	local SidebarDivider = Instance.new("Frame")
	SidebarDivider.Size = UDim2.new(0, 1, 1, -55)
	SidebarDivider.Position = UDim2.new(0, 205, 0, 55)
	SidebarDivider.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.Parent = MainFrame

	local SlidingIndicator = Instance.new("Frame")
	SlidingIndicator.Name = "SlidingIndicator"
	SlidingIndicator.Size = UDim2.new(1, -22, 0, 38)
	SlidingIndicator.Position = UDim2.new(0, 11, 0, 11)
	SlidingIndicator.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
	SlidingIndicator.BorderSizePixel = 0
	SlidingIndicator.ZIndex = 1
	SlidingIndicator.Parent = Sidebar
	self.SlidingIndicator = SlidingIndicator

	local SlidingCorner = Instance.new("UICorner")
	SlidingCorner.CornerRadius = UDim.new(0, 7)
	SlidingCorner.Parent = SlidingIndicator

	local AccentBar = Instance.new("Frame")
	AccentBar.Size = UDim2.new(0, 3, 0, 16)
	AccentBar.Position = UDim2.new(0, 0, 0.5, -8)
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
	SidebarLayout.Padding = UDim.new(0, 5)
	SidebarLayout.Parent = SidebarItemsContainer

	local SidebarPadding = Instance.new("UIPadding")
	SidebarPadding.PaddingTop = UDim.new(0, 11)
	SidebarPadding.PaddingLeft = UDim.new(0, 11)
	SidebarPadding.PaddingRight = UDim.new(0, 11)
	SidebarPadding.Parent = SidebarItemsContainer

	self.SidebarItemsContainer = SidebarItemsContainer

	local PagesContainer = Instance.new("Frame")
	PagesContainer.Size = UDim2.new(1, -207, 1, -68)
	PagesContainer.Position = UDim2.new(0, 207, 0, 62)
	PagesContainer.BackgroundTransparency = 1
	PagesContainer.ClipsDescendants = true
	PagesContainer.Parent = MainFrame
	self.PagesContainer = PagesContainer

	self.Tabs = {}
	self.Pages = {}
	self.TabCount = 0

	local ProfileDivider = Instance.new("Frame")
	ProfileDivider.Name = "ProfileDivider"
	ProfileDivider.Size = UDim2.new(1, 0, 0, 1)
	ProfileDivider.Position = UDim2.new(0, 0, 1, -54)
	ProfileDivider.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	ProfileDivider.BorderSizePixel = 0
	ProfileDivider.Parent = Sidebar

	local ProfileContainer = Instance.new("Frame")
	ProfileContainer.Size = UDim2.new(1, -18, 0, 44)
	ProfileContainer.Position = UDim2.new(0, 9, 1, -54)
	ProfileContainer.BackgroundTransparency = 1
	ProfileContainer.Parent = Sidebar

	local AvatarThumb = Instance.new("ImageLabel")
	AvatarThumb.Size = UDim2.new(0, 32, 0, 32)
	AvatarThumb.Position = UDim2.new(0, 0, 0.5, -16)
	AvatarThumb.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	AvatarThumb.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
	AvatarThumb.Parent = ProfileContainer

	local AvatarCorner = Instance.new("UICorner")
	AvatarCorner.CornerRadius = UDim.new(1, 0)
	AvatarCorner.Parent = AvatarThumb

	local ProfileTextHolder = Instance.new("Frame")
	ProfileTextHolder.Size = UDim2.new(1, -42, 1, 0)
	ProfileTextHolder.Position = UDim2.new(0, 42, 0, 0)
	ProfileTextHolder.BackgroundTransparency = 1
	ProfileTextHolder.Parent = ProfileContainer

	local ProfileTextLayout = Instance.new("UIListLayout")
	ProfileTextLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	ProfileTextLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ProfileTextLayout.Padding = UDim.new(0, 1)
	ProfileTextLayout.Parent = ProfileTextHolder

	local RoleLabel = Instance.new("TextLabel")
	RoleLabel.Size = UDim2.new(1, 0, 0, 14)
	RoleLabel.BackgroundTransparency = 1
	RoleLabel.Font = Enum.Font.GothamBold
	RoleLabel.Text = GetRoleText(LocalPlayer.UserId)
	RoleLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
	RoleLabel.TextSize = 10
	RoleLabel.TextXAlignment = Enum.TextXAlignment.Left
	RoleLabel.LayoutOrder = 1
	RoleLabel.Parent = ProfileTextHolder

	local UsernameLabel = Instance.new("TextLabel")
	UsernameLabel.Size = UDim2.new(1, 0, 0, 16)
	UsernameLabel.BackgroundTransparency = 1
	UsernameLabel.Font = Enum.Font.GothamBold
	UsernameLabel.Text = LocalPlayer.Name
	UsernameLabel.TextColor3 = Color3.fromRGB(225, 225, 230)
	UsernameLabel.TextSize = 12
	UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
	UsernameLabel.TextTruncate = Enum.TextTruncate.AtEnd
	UsernameLabel.LayoutOrder = 2
	UsernameLabel.Parent = ProfileTextHolder

	self.ProfileContainer = ProfileContainer

	local MinButton = Instance.new("TextButton")
	MinButton.Size = UDim2.new(0, 30, 0, 30)
	MinButton.BackgroundTransparency = 1
	MinButton.AutoButtonColor = false
	MinButton.Font = Enum.Font.GothamBold
	MinButton.Text = "-"
	MinButton.TextColor3 = Color3.fromRGB(160, 160, 170)
	MinButton.TextSize = 21
	MinButton.LayoutOrder = 1
	MinButton.Parent = ControlsContainer

	local CloseButton = Instance.new("ImageButton")
	CloseButton.Size = UDim2.new(0, 23, 0, 23)
	CloseButton.BackgroundTransparency = 1
	CloseButton.AutoButtonColor = false
	CloseButton.Image = "rbxassetid://18503481771"
	CloseButton.ImageColor3 = Color3.fromRGB(160, 160, 170)
	CloseButton.LayoutOrder = 2
	CloseButton.Parent = ControlsContainer

	-- ============================================================
	-- Resize handle (bottom-right corner grip, like a Windows window)
	-- ============================================================
	local MIN_WIDTH, MIN_HEIGHT = 500, 380
	local MAX_WIDTH, MAX_HEIGHT = 1100, 850

	local ResizeHandle = Instance.new("TextButton")
	ResizeHandle.Name = "ResizeHandle"
	ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
	ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
	ResizeHandle.BackgroundTransparency = 1
	ResizeHandle.AutoButtonColor = false
	ResizeHandle.Text = ""
	ResizeHandle.ZIndex = 10
	ResizeHandle.Parent = MainFrame

	local gripDotPositions = {
		{15, 5}, {15, 11}, {15, 17},
		{9, 11}, {9, 17},
		{3, 17},
	}

	for _, dotPos in ipairs(gripDotPositions) do
		local Dot = Instance.new("Frame")
		Dot.Size = UDim2.new(0, 2, 0, 2)
		Dot.Position = UDim2.new(0, dotPos[1], 0, dotPos[2])
		Dot.BackgroundColor3 = Color3.fromRGB(90, 90, 100)
		Dot.BorderSizePixel = 0
		Dot.ZIndex = 10
		Dot.Parent = ResizeHandle
	end

	local minimized = false
	local lastExpandedHeight = MainFrame.Size.Y.Offset

	MinButton.MouseButton1Click:Connect(function()
		minimized = not minimized
		self.IsMinimized = minimized

		if minimized then
			lastExpandedHeight = MainFrame.Size.Y.Offset
		end

		local currentWidth = MainFrame.Size.X.Offset

		local targetSize = minimized
			and UDim2.new(0, currentWidth, 0, 54)
			or UDim2.new(0, currentWidth, 0, lastExpandedHeight)

		PagesContainer.Visible = not minimized
		Sidebar.Visible = not minimized
		SidebarDivider.Visible = not minimized
		HeaderDivider.Visible = not minimized
		ResizeHandle.Visible = not minimized

		TweenService:Create(
			MainFrame,
			TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
			{Size = targetSize}
		):Play()
	end)

	local isClosing = false

	CloseButton.MouseButton1Click:Connect(function()
		if isClosing then
			return
		end

		isClosing = true

		local tweenInfo = TweenInfo.new(
			0.2,
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out
		)

		local shrinkTween = TweenService:Create(MainFrame, tweenInfo, {
			Size = UDim2.new(0, 0, 0, 0),
			Position = MainFrame.Position + UDim2.new(
				0,
				MainFrame.AbsoluteSize.X / 2,
				0,
				MainFrame.AbsoluteSize.Y / 2
			)
		})

		shrinkTween:Play()

		shrinkTween.Completed:Connect(function()
			ScreenGui:Destroy()
		end)
	end)

	local draggingMain
	local dragStart
	local startPos

	Header.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			draggingMain = true
			dragStart = input.Position
			startPos = MainFrame.Position
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			draggingMain = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if draggingMain and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then

			local delta = input.Position - dragStart

			MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	local resizing = false
	local resizeStart
	local resizeStartSize

	ResizeHandle.InputBegan:Connect(function(input)
		if minimized then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			resizing = true
			resizeStart = input.Position
			resizeStartSize = MainFrame.Size
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then

			resizing = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if resizing and (
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		) then

			local delta = input.Position - resizeStart

			local newWidth = math.clamp(
				resizeStartSize.X.Offset + delta.X,
				MIN_WIDTH,
				MAX_WIDTH
			)

			local newHeight = math.clamp(
				resizeStartSize.Y.Offset + delta.Y,
				MIN_HEIGHT,
				MAX_HEIGHT
			)

			MainFrame.Size = UDim2.new(0, newWidth, 0, newHeight)
		end
	end)

	return self
end

function Library:AddTab(name, imageId)
	self.TabCount = self.TabCount + 1

	local layoutOrder = self.TabCount
	local isFirst = layoutOrder == 1

	local TabButton = Instance.new("TextButton")
	TabButton.Size = UDim2.new(1, 0, 0, 38)
	TabButton.BackgroundTransparency = 1
	TabButton.Font = Enum.Font.GothamMedium
	TabButton.Text = imageId and "            " .. name or "    " .. name
	TabButton.TextColor3 = isFirst
		and Color3.fromRGB(255, 255, 255)
		or Color3.fromRGB(160, 160, 175)
	TabButton.TextSize = 13
	TabButton.TextXAlignment = Enum.TextXAlignment.Left
	TabButton.AutoButtonColor = false
	TabButton.LayoutOrder = layoutOrder
	TabButton.ZIndex = 3
	TabButton.Parent = self.SidebarItemsContainer

	if imageId then
		local TabIcon = Instance.new("ImageLabel")
		TabIcon.Size = UDim2.new(0, 21, 0, 21)
		TabIcon.Position = UDim2.new(0, 6, 0.5, -10.5)
		TabIcon.BackgroundTransparency = 1
		TabIcon.Image = "rbxassetid://" .. tostring(imageId)
		TabIcon.ImageColor3 = TabButton.TextColor3
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
	Page.ScrollBarThickness = 4
	Page.ScrollBarImageColor3 = Color3.fromRGB(35, 35, 42)
	Page.Visible = isFirst
	Page.Parent = self.PagesContainer

	local PagePadding = Instance.new("UIPadding")
	PagePadding.PaddingRight = UDim.new(0, 6)
	PagePadding.PaddingBottom = UDim.new(0, 10)
	PagePadding.Parent = Page

	local PageLayout = Instance.new("UIListLayout")
	PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	PageLayout.Padding = UDim.new(0, 11)
	PageLayout.Parent = Page

	local libraryRef = self

	TabButton.MouseButton1Click:Connect(function()
		for _, p in pairs(libraryRef.Pages) do
			p.Visible = false
		end

		for _, t in pairs(libraryRef.Tabs) do
			TweenService:Create(
				t,
				TweenInfo.new(0.15),
				{TextColor3 = Color3.fromRGB(160, 160, 175)}
			):Play()
		end

		Page.Visible = true

		TweenService:Create(
			TabButton,
			TweenInfo.new(0.15),
			{TextColor3 = Color3.fromRGB(255, 255, 255)}
		):Play()

		local relativeY =
			TabButton.AbsolutePosition.Y
			- libraryRef.Sidebar.AbsolutePosition.Y

		TweenService:Create(
			libraryRef.SlidingIndicator,
			TweenInfo.new(
				0.15,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out
			),
			{
				Position = UDim2.new(0, 11, 0, relativeY)
			}
		):Play()
	end)

	table.insert(self.Tabs, TabButton)
	table.insert(self.Pages, Page)

	local TabObj = {}

	function TabObj:AddSectionHeader(text)
		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, 0, 0, 22)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamBold
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(100, 100, 110)
		Label.TextSize = 11
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = Page
	end

	function TabObj:AddLabel(text)
		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -10, 0, 30)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(170, 170, 180)
		Label.TextSize = 12
		Label.TextWrapped = true
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.TextYAlignment = Enum.TextYAlignment.Center
		Label.Parent = Page

		return Label
	end

	function TabObj:AddDivider()
		local Divider = Instance.new("Frame")
		Divider.Size = UDim2.new(1, -10, 0, 1)
		Divider.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
		Divider.BorderSizePixel = 0
		Divider.Parent = Page

		return Divider
	end

	function TabObj:AddParagraph(title, text)
		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(1, -10, 0, 78)
		Frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		Frame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = Frame

		local Title = Instance.new("TextLabel")
		Title.Size = UDim2.new(1, -24, 0, 24)
		Title.Position = UDim2.new(0, 12, 0, 7)
		Title.BackgroundTransparency = 1
		Title.Font = Enum.Font.GothamBold
		Title.Text = title
		Title.TextColor3 = Color3.fromRGB(220, 220, 230)
		Title.TextSize = 12
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.Parent = Frame

		local Description = Instance.new("TextLabel")
		Description.Size = UDim2.new(1, -24, 0, 40)
		Description.Position = UDim2.new(0, 12, 0, 31)
		Description.BackgroundTransparency = 1
		Description.Font = Enum.Font.GothamMedium
		Description.Text = text
		Description.TextColor3 = Color3.fromRGB(145, 145, 155)
		Description.TextSize = 11
		Description.TextWrapped = true
		Description.TextXAlignment = Enum.TextXAlignment.Left
		Description.TextYAlignment = Enum.TextYAlignment.Top
		Description.Parent = Frame

		return Frame
	end

	function TabObj:AddToggle(text, callback, defaultState)
		local ToggleFrame = Instance.new("Frame")
		ToggleFrame.Size = UDim2.new(1, -10, 0, 42)
		ToggleFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		ToggleFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = ToggleFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -70, 1, 0)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ToggleFrame

		local Pill = Instance.new("TextButton")
		Pill.Size = UDim2.new(0, 44, 0, 22)
		Pill.Position = UDim2.new(1, -56, 0.5, -11)
		Pill.BackgroundColor3 = defaultState
			and libraryRef.AccentColor
			or Color3.fromRGB(12, 12, 14)
		Pill.AutoButtonColor = false
		Pill.Text = ""
		Pill.Parent = ToggleFrame

		local PillCorner = Instance.new("UICorner")
		PillCorner.CornerRadius = UDim.new(1, 0)
		PillCorner.Parent = Pill

		local PillStroke = Instance.new("UIStroke")
		PillStroke.Color = Color3.fromRGB(255, 255, 255)
		PillStroke.Thickness = 1
		PillStroke.Transparency = 0.35
		PillStroke.Parent = Pill

		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 16, 0, 16)
		Circle.Position = defaultState
			and UDim2.new(1, -19, 0.5, -8)
			or UDim2.new(0, 3, 0.5, -8)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.Parent = Pill

		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = Circle

		local toggled = defaultState or false

		Pill.MouseButton1Click:Connect(function()
			toggled = not toggled

			local targetBg = toggled
				and libraryRef.AccentColor
				or Color3.fromRGB(12, 12, 14)

			local targetPos = toggled
				and UDim2.new(1, -19, 0.5, -8)
				or UDim2.new(0, 3, 0.5, -8)

			TweenService:Create(
				Pill,
				TweenInfo.new(0.15),
				{BackgroundColor3 = targetBg}
			):Play()

			TweenService:Create(
				Circle,
				TweenInfo.new(0.15),
				{Position = targetPos}
			):Play()

			if callback then
				callback(toggled)
			end
		end)

		return ToggleFrame
	end

	function TabObj:AddButton(text, callback)
		local ButtonFrame = Instance.new("TextButton")
		ButtonFrame.Size = UDim2.new(1, -10, 0, 42)
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		ButtonFrame.AutoButtonColor = false
		ButtonFrame.Text = ""
		ButtonFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = ButtonFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -26, 1, 0)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = ButtonFrame

		ButtonFrame.MouseEnter:Connect(function()
			TweenService:Create(
				ButtonFrame,
				TweenInfo.new(0.12),
				{BackgroundColor3 = Color3.fromRGB(22, 22, 28)}
			):Play()
		end)

		ButtonFrame.MouseLeave:Connect(function()
			TweenService:Create(
				ButtonFrame,
				TweenInfo.new(0.12),
				{BackgroundColor3 = Color3.fromRGB(16, 16, 20)}
			):Play()
		end)

		ButtonFrame.MouseButton1Click:Connect(function()
			if callback then
				callback()
			end
		end)

		return ButtonFrame
	end

	function TabObj:AddSlider(text, min, max, default, callback)
		local SliderFrame = Instance.new("Frame")
		SliderFrame.Size = UDim2.new(1, -10, 0, 56)
		SliderFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		SliderFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = SliderFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -30, 0, 23)
		Label.Position = UDim2.new(0, 13, 0, 5)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = SliderFrame

		local ValueLabel = Instance.new("TextLabel")
		ValueLabel.Size = UDim2.new(0, 60, 0, 23)
		ValueLabel.Position = UDim2.new(1, -73, 0, 5)
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.Font = Enum.Font.GothamMedium
		ValueLabel.Text = tostring(default)
		ValueLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
		ValueLabel.TextSize = 12
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		ValueLabel.Parent = SliderFrame

		local Track = Instance.new("Frame")
		Track.Size = UDim2.new(1, -26, 0, 5)
		Track.Position = UDim2.new(0, 13, 0, 39)
		Track.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
		Track.BorderSizePixel = 0
		Track.Parent = SliderFrame

		local TrackCorner = Instance.new("UICorner")
		TrackCorner.CornerRadius = UDim.new(1, 0)
		TrackCorner.Parent = Track

		local percent = math.clamp(
			(default - min) / (max - min),
			0,
			1
		)

		local Fill = Instance.new("Frame")
		Fill.Size = UDim2.new(percent, 0, 1, 0)
		Fill.BackgroundColor3 = libraryRef.AccentColor
		Fill.BorderSizePixel = 0
		Fill.Parent = Track

		local FillCorner = Instance.new("UICorner")
		FillCorner.CornerRadius = UDim.new(1, 0)
		FillCorner.Parent = Fill

		local Knob = Instance.new("TextButton")
		Knob.Size = UDim2.new(0, 14, 0, 14)
		Knob.Position = UDim2.new(1, -7, 0.5, -7)
		Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Knob.AutoButtonColor = false
		Knob.Text = ""
		Knob.Parent = Fill

		local KnobCorner = Instance.new("UICorner")
		KnobCorner.CornerRadius = UDim.new(1, 0)
		KnobCorner.Parent = Knob

		local dragging = false

		local function updateValue(input)
			local pos = math.clamp(
				(input.Position.X - Track.AbsolutePosition.X)
					/ Track.AbsoluteSize.X,
				0,
				1
			)

			local val = math.floor(
				min + ((max - min) * pos)
			)

			Fill.Size = UDim2.new(pos, 0, 1, 0)
			ValueLabel.Text = tostring(val)

			if callback then
				callback(val)
			end
		end

		Knob.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then

				dragging = true
			end
		end)

		Track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then

				dragging = true
				updateValue(input)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then

				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (
				input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch
			) then
				updateValue(input)
			end
		end)

		return SliderFrame
	end

	function TabObj:AddTextbox(text, placeholder, callback)
		local TextboxFrame = Instance.new("Frame")
		TextboxFrame.Size = UDim2.new(1, -10, 0, 42)
		TextboxFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		TextboxFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = TextboxFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -155, 1, 0)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = TextboxFrame

		local TextBoxContainer = Instance.new("Frame")
		TextBoxContainer.Size = UDim2.new(0, 125, 0, 27)
		TextBoxContainer.Position = UDim2.new(1, -138, 0.5, -13.5)
		TextBoxContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		TextBoxContainer.Parent = TextboxFrame

		local CornerBox = Instance.new("UICorner")
		CornerBox.CornerRadius = UDim.new(0, 5)
		CornerBox.Parent = TextBoxContainer

		local TextBox = Instance.new("TextBox")
		TextBox.Size = UDim2.new(1, -8, 1, 0)
		TextBox.Position = UDim2.new(0, 4, 0, 0)
		TextBox.BackgroundTransparency = 1
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = placeholder or "Value..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(200, 200, 210)
		TextBox.TextSize = 11
		TextBox.ClearTextOnFocus = false
		TextBox.Parent = TextBoxContainer

		TextBox.FocusLost:Connect(function(enterPressed)
			if callback then
				callback(TextBox.Text, enterPressed)
			end
		end)

		return TextBox
	end

	function TabObj:AddDropdown(text, options, defaultOption, callback)
		local DropdownOpen = false
		local selectedOption = defaultOption or options[1] or "Select..."

		local DropdownFrame = Instance.new("Frame")
		DropdownFrame.Size = UDim2.new(1, -10, 0, 42)
		DropdownFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		DropdownFrame.ClipsDescendants = true
		DropdownFrame.ZIndex = 5
		DropdownFrame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = DropdownFrame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -160, 0, 42)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.ZIndex = 5
		Label.Parent = DropdownFrame

		local DropButton = Instance.new("TextButton")
		DropButton.Size = UDim2.new(0, 135, 0, 27)
		DropButton.Position = UDim2.new(1, -148, 0, 8)
		DropButton.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		DropButton.AutoButtonColor = false
		DropButton.Text = tostring(selectedOption)
		DropButton.TextColor3 = Color3.fromRGB(180, 180, 190)
		DropButton.Font = Enum.Font.GothamMedium
		DropButton.TextSize = 11
		DropButton.ZIndex = 5
		DropButton.Parent = DropdownFrame

		local DropCorner = Instance.new("UICorner")
		DropCorner.CornerRadius = UDim.new(0, 5)
		DropCorner.Parent = DropButton

		local ListContainer = Instance.new("Frame")
		ListContainer.Size = UDim2.new(1, -26, 0, 0)
		ListContainer.Position = UDim2.new(0, 13, 0, 49)
		ListContainer.BackgroundTransparency = 1
		ListContainer.ZIndex = 5
		ListContainer.Parent = DropdownFrame

		local ListLayout = Instance.new("UIListLayout")
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Padding = UDim.new(0, 4)
		ListLayout.Parent = ListContainer

		local calcHeight = 42

		for _, opt in ipairs(options) do
			calcHeight = calcHeight + 29

			local OptionButton = Instance.new("TextButton")
			OptionButton.Size = UDim2.new(1, 0, 0, 25)
			OptionButton.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
			OptionButton.AutoButtonColor = false
			OptionButton.Text = tostring(opt)
			OptionButton.TextColor3 = opt == selectedOption
				and Color3.fromRGB(255, 255, 255)
				or Color3.fromRGB(140, 140, 150)
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

				TweenService:Create(
					DropdownFrame,
					TweenInfo.new(0.2),
					{Size = UDim2.new(1, -10, 0, 42)}
				):Play()

				for _, child in pairs(ListContainer:GetChildren()) do
					if child:IsA("TextButton") then
						child.TextColor3 =
							child.Text == tostring(selectedOption)
							and Color3.fromRGB(255, 255, 255)
							or Color3.fromRGB(140, 140, 150)
					end
				end

				if callback then
					callback(opt)
				end
			end)
		end

		DropButton.MouseButton1Click:Connect(function()
			DropdownOpen = not DropdownOpen

			local targetSize = DropdownOpen
				and UDim2.new(1, -10, 0, calcHeight)
				or UDim2.new(1, -10, 0, 42)

			TweenService:Create(
				DropdownFrame,
				TweenInfo.new(0.2),
				{Size = targetSize}
			):Play()
		end)

		return DropdownFrame
	end

	function TabObj:AddKeybind(text, defaultKey, callback)
		local currentKey = defaultKey or Enum.KeyCode.Unknown
		local listening = false

		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(1, -10, 0, 42)
		Frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		Frame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = Frame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -150, 1, 0)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.Parent = Frame

		local KeyButton = Instance.new("TextButton")
		KeyButton.Size = UDim2.new(0, 125, 0, 27)
		KeyButton.Position = UDim2.new(1, -138, 0.5, -13.5)
		KeyButton.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		KeyButton.AutoButtonColor = false
		KeyButton.Font = Enum.Font.GothamMedium
		KeyButton.TextColor3 = Color3.fromRGB(180, 180, 190)
		KeyButton.TextSize = 11
		KeyButton.Text = currentKey.Name
		KeyButton.Parent = Frame

		local KeyCorner = Instance.new("UICorner")
		KeyCorner.CornerRadius = UDim.new(0, 5)
		KeyCorner.Parent = KeyButton

		KeyButton.MouseButton1Click:Connect(function()
			listening = true
			KeyButton.Text = "Press key..."

			local connection
			connection = UserInputService.InputBegan:Connect(function(input, processed)
				if processed then
					return
				end

				if input.UserInputType == Enum.UserInputType.Keyboard then
					currentKey = input.KeyCode
					KeyButton.Text = currentKey.Name
					listening = false
					connection:Disconnect()
				end
			end)
		end)

		UserInputService.InputBegan:Connect(function(input, processed)
			if processed or listening then
				return
			end

			if input.UserInputType == Enum.UserInputType.Keyboard
				and input.KeyCode == currentKey then

				if callback then
					callback(currentKey)
				end
			end
		end)

		return Frame
	end

	-- ============================================================
	-- Real HSV Color Picker (hue strip + saturation/value box)
	-- ============================================================
	function TabObj:AddColorPicker(text, defaultColor, callback)
		defaultColor = defaultColor or libraryRef.AccentColor

		local h, s, v = Color3.toHSV(defaultColor)
		local pickerOpen = false
		local pickerHeight = 42
		local expandedHeight = 42 + 8 + 130 + 10 + 22 + 10

		local Frame = Instance.new("Frame")
		Frame.Size = UDim2.new(1, -10, 0, pickerHeight)
		Frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		Frame.ClipsDescendants = true
		Frame.ZIndex = 6
		Frame.Parent = Page

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 7)
		Corner.Parent = Frame

		local Label = Instance.new("TextLabel")
		Label.Size = UDim2.new(1, -80, 0, 42)
		Label.Position = UDim2.new(0, 13, 0, 0)
		Label.BackgroundTransparency = 1
		Label.Font = Enum.Font.GothamMedium
		Label.Text = text
		Label.TextColor3 = Color3.fromRGB(200, 200, 210)
		Label.TextSize = 12
		Label.TextXAlignment = Enum.TextXAlignment.Left
		Label.ZIndex = 6
		Label.Parent = Frame

		-- swatch button in the row (click to expand/collapse)
		local SwatchButton = Instance.new("TextButton")
		SwatchButton.Size = UDim2.new(0, 38, 0, 26)
		SwatchButton.Position = UDim2.new(1, -51, 0, 8)
		SwatchButton.BackgroundColor3 = defaultColor
		SwatchButton.AutoButtonColor = false
		SwatchButton.Text = ""
		SwatchButton.ZIndex = 6
		SwatchButton.Parent = Frame

		local SwatchCorner = Instance.new("UICorner")
		SwatchCorner.CornerRadius = UDim.new(0, 6)
		SwatchCorner.Parent = SwatchButton

		local SwatchStroke = Instance.new("UIStroke")
		SwatchStroke.Color = Color3.fromRGB(255, 255, 255)
		SwatchStroke.Transparency = 0.4
		SwatchStroke.Parent = SwatchButton

		-- ===== Expanded picker body =====
		local Body = Instance.new("Frame")
		Body.Size = UDim2.new(1, -26, 0, expandedHeight - 42)
		Body.Position = UDim2.new(0, 13, 0, 42)
		Body.BackgroundTransparency = 1
		Body.ZIndex = 6
		Body.Parent = Frame

		-- SV box
		local SVBox = Instance.new("Frame")
		SVBox.Size = UDim2.new(1, 0, 0, 130)
		SVBox.Position = UDim2.new(0, 0, 0, 8)
		SVBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
		SVBox.BorderSizePixel = 0
		SVBox.ClipsDescendants = true
		SVBox.ZIndex = 6
		SVBox.Parent = Body

		local SVCorner = Instance.new("UICorner")
		SVCorner.CornerRadius = UDim.new(0, 6)
		SVCorner.Parent = SVBox

		local SatGradient = Instance.new("Frame")
		SatGradient.Size = UDim2.new(1, 0, 1, 0)
		SatGradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SatGradient.BorderSizePixel = 0
		SatGradient.ZIndex = 6
		SatGradient.Parent = SVBox

		local SatUIGradient = Instance.new("UIGradient")
		SatUIGradient.Color = ColorSequence.new(
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(255, 255, 255)
		)
		SatUIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(1, 1),
		})
		SatUIGradient.Parent = SatGradient

		local ValGradient = Instance.new("Frame")
		ValGradient.Size = UDim2.new(1, 0, 1, 0)
		ValGradient.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		ValGradient.BorderSizePixel = 0
		ValGradient.ZIndex = 6
		ValGradient.Parent = SVBox

		local ValUIGradient = Instance.new("UIGradient")
		ValUIGradient.Rotation = 90
		ValUIGradient.Color = ColorSequence.new(
			Color3.fromRGB(0, 0, 0),
			Color3.fromRGB(0, 0, 0)
		)
		ValUIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(1, 0),
		})
		ValUIGradient.Parent = ValGradient

		local SVCursor = Instance.new("Frame")
		SVCursor.Size = UDim2.new(0, 12, 0, 12)
		SVCursor.AnchorPoint = Vector2.new(0.5, 0.5)
		SVCursor.Position = UDim2.new(s, 0, 1 - v, 0)
		SVCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SVCursor.BorderSizePixel = 0
		SVCursor.ZIndex = 7
		SVCursor.Parent = SVBox

		local SVCursorCorner = Instance.new("UICorner")
		SVCursorCorner.CornerRadius = UDim.new(1, 0)
		SVCursorCorner.Parent = SVCursor

		local SVCursorStroke = Instance.new("UIStroke")
		SVCursorStroke.Color = Color3.fromRGB(0, 0, 0)
		SVCursorStroke.Thickness = 1.5
		SVCursorStroke.Parent = SVCursor

		-- Hue strip
		local HueStrip = Instance.new("Frame")
		HueStrip.Size = UDim2.new(1, 0, 0, 16)
		HueStrip.Position = UDim2.new(0, 0, 0, 130 + 10)
		HueStrip.BorderSizePixel = 0
		HueStrip.ZIndex = 6
		HueStrip.Parent = Body

		local HueCorner = Instance.new("UICorner")
		HueCorner.CornerRadius = UDim.new(1, 0)
		HueCorner.Parent = HueStrip

		local HueGradient = Instance.new("UIGradient")
		HueGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.500, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(1.000, Color3.fromRGB(255, 0, 0)),
		})
		HueGradient.Parent = HueStrip

		local HueCursor = Instance.new("Frame")
		HueCursor.Size = UDim2.new(0, 6, 1, 4)
		HueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
		HueCursor.Position = UDim2.new(h, 0, 0.5, 0)
		HueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HueCursor.BorderSizePixel = 0
		HueCursor.ZIndex = 7
		HueCursor.Parent = HueStrip

		local HueCursorCorner = Instance.new("UICorner")
		HueCursorCorner.CornerRadius = UDim.new(1, 0)
		HueCursorCorner.Parent = HueCursor

		local HueCursorStroke = Instance.new("UIStroke")
		HueCursorStroke.Color = Color3.fromRGB(0, 0, 0)
		HueCursorStroke.Thickness = 1
		HueCursorStroke.Parent = HueCursor

		-- Preview + hex row
		local PreviewRow = Instance.new("Frame")
		PreviewRow.Size = UDim2.new(1, 0, 0, 22)
		PreviewRow.Position = UDim2.new(0, 0, 0, 130 + 10 + 16 + 10)
		PreviewRow.BackgroundTransparency = 1
		PreviewRow.ZIndex = 6
		PreviewRow.Parent = Body

		local PreviewSwatch = Instance.new("Frame")
		PreviewSwatch.Size = UDim2.new(0, 22, 0, 22)
		PreviewSwatch.BackgroundColor3 = defaultColor
		PreviewSwatch.BorderSizePixel = 0
		PreviewSwatch.ZIndex = 6
		PreviewSwatch.Parent = PreviewRow

		local PreviewCorner = Instance.new("UICorner")
		PreviewCorner.CornerRadius = UDim.new(0, 5)
		PreviewCorner.Parent = PreviewSwatch

		local HexLabel = Instance.new("TextLabel")
		HexLabel.Size = UDim2.new(1, -32, 1, 0)
		HexLabel.Position = UDim2.new(0, 30, 0, 0)
		HexLabel.BackgroundTransparency = 1
		HexLabel.Font = Enum.Font.GothamMedium
		HexLabel.Text = "#" .. defaultColor:ToHex():upper()
		HexLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		HexLabel.TextSize = 11
		HexLabel.TextXAlignment = Enum.TextXAlignment.Left
		HexLabel.ZIndex = 6
		HexLabel.Parent = PreviewRow

		local currentColor = defaultColor

		local function applyColor()
			currentColor = Color3.fromHSV(h, s, v)

			SVBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
			SwatchButton.BackgroundColor3 = currentColor
			PreviewSwatch.BackgroundColor3 = currentColor
			HexLabel.Text = "#" .. currentColor:ToHex():upper()

			if callback then
				callback(currentColor)
			end
		end

		local function setSV(input)
			local relX = math.clamp(
				(input.Position.X - SVBox.AbsolutePosition.X) / SVBox.AbsoluteSize.X,
				0,
				1
			)
			local relY = math.clamp(
				(input.Position.Y - SVBox.AbsolutePosition.Y) / SVBox.AbsoluteSize.Y,
				0,
				1
			)

			s = relX
			v = 1 - relY

			SVCursor.Position = UDim2.new(s, 0, 1 - v, 0)
			applyColor()
		end

		local function setHue(input)
			local relX = math.clamp(
				(input.Position.X - HueStrip.AbsolutePosition.X) / HueStrip.AbsoluteSize.X,
				0,
				1
			)

			h = relX
			HueCursor.Position = UDim2.new(h, 0, 0.5, 0)
			applyColor()
		end

		local draggingSV = false
		local draggingHue = false

		SVBox.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				draggingSV = true
				setSV(input)
			end
		end)

		HueStrip.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				draggingHue = true
				setHue(input)
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch then

				if draggingSV then
					setSV(input)
				elseif draggingHue then
					setHue(input)
				end
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				draggingSV = false
				draggingHue = false
			end
		end)

		SwatchButton.MouseButton1Click:Connect(function()
			pickerOpen = not pickerOpen

			local targetSize = pickerOpen
				and UDim2.new(1, -10, 0, expandedHeight)
				or UDim2.new(1, -10, 0, pickerHeight)

			TweenService:Create(
				Frame,
				TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{Size = targetSize}
			):Play()
		end)

		return Frame
	end

	function TabObj:AddTextboxToggle(config)
		config = config or {}

		local name = config.Name or "Configure Control"
		local textBoxText = config.TextBoxText or ""
		local placeholder = config.Placeholder or "Enter value..."
		local defaultToggle = config.DefaultState or false
		local onTextBoxChanged = config.OnTextBoxChanged
		local onToggleChanged = config.OnToggleChanged

		local MainCompFrame = Instance.new("Frame")
		MainCompFrame.Size = UDim2.new(1, -10, 0, 104)
		MainCompFrame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
		MainCompFrame.Parent = Page

		local CompCorner = Instance.new("UICorner")
		CompCorner.CornerRadius = UDim.new(0, 7)
		CompCorner.Parent = MainCompFrame

		local TopLabel = Instance.new("TextLabel")
		TopLabel.Size = UDim2.new(1, -26, 0, 25)
		TopLabel.Position = UDim2.new(0, 13, 0, 8)
		TopLabel.BackgroundTransparency = 1
		TopLabel.Font = Enum.Font.GothamBold
		TopLabel.Text = name
		TopLabel.TextColor3 = Color3.fromRGB(220, 220, 230)
		TopLabel.TextSize = 12
		TopLabel.TextXAlignment = Enum.TextXAlignment.Left
		TopLabel.Parent = MainCompFrame

		local TextBoxContainer = Instance.new("Frame")
		TextBoxContainer.Size = UDim2.new(1, -26, 0, 27)
		TextBoxContainer.Position = UDim2.new(0, 13, 0, 38)
		TextBoxContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
		TextBoxContainer.Parent = MainCompFrame

		local TBContainerCorner = Instance.new("UICorner")
		TBContainerCorner.CornerRadius = UDim.new(0, 5)
		TBContainerCorner.Parent = TextBoxContainer

		local TextBox = Instance.new("TextBox")
		TextBox.Size = UDim2.new(1, -12, 1, 0)
		TextBox.Position = UDim2.new(0, 6, 0, 0)
		TextBox.BackgroundTransparency = 1
		TextBox.Font = Enum.Font.GothamMedium
		TextBox.PlaceholderText = placeholder
		TextBox.Text = textBoxText
		TextBox.TextColor3 = Color3.fromRGB(200, 200, 210)
		TextBox.TextSize = 11
		TextBox.ClearTextOnFocus = false
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		TextBox.Parent = TextBoxContainer

		TextBox.FocusLost:Connect(function(enterPressed)
			if onTextBoxChanged then
				onTextBoxChanged(TextBox.Text, enterPressed)
			end
		end)

		local ToggleContainer = Instance.new("Frame")
		ToggleContainer.Size = UDim2.new(1, -26, 0, 25)
		ToggleContainer.Position = UDim2.new(0, 13, 0, 72)
		ToggleContainer.BackgroundTransparency = 1
		ToggleContainer.Parent = MainCompFrame

		local ToggleStatusLabel = Instance.new("TextLabel")
		ToggleStatusLabel.Size = UDim2.new(1, -55, 1, 0)
		ToggleStatusLabel.BackgroundTransparency = 1
		ToggleStatusLabel.Font = Enum.Font.GothamMedium
		ToggleStatusLabel.Text = "Active Status"
		ToggleStatusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
		ToggleStatusLabel.TextSize = 11
		ToggleStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
		ToggleStatusLabel.Parent = ToggleContainer

		local Pill = Instance.new("TextButton")
		Pill.Size = UDim2.new(0, 40, 0, 20)
		Pill.Position = UDim2.new(1, -40, 0.5, -10)
		Pill.BackgroundColor3 = defaultToggle
			and libraryRef.AccentColor
			or Color3.fromRGB(12, 12, 14)
		Pill.AutoButtonColor = false
		Pill.Text = ""
		Pill.Parent = ToggleContainer

		local PillCorner = Instance.new("UICorner")
		PillCorner.CornerRadius = UDim.new(1, 0)
		PillCorner.Parent = Pill

		local PillStroke = Instance.new("UIStroke")
		PillStroke.Color = Color3.fromRGB(255, 255, 255)
		PillStroke.Thickness = 1
		PillStroke.Transparency = 0.35
		PillStroke.Parent = Pill

		local Circle = Instance.new("Frame")
		Circle.Size = UDim2.new(0, 14, 0, 14)
		Circle.Position = defaultToggle
			and UDim2.new(1, -17, 0.5, -7)
			or UDim2.new(0, 3, 0.5, -7)
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.Parent = Pill

		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = Circle

		local toggled = defaultToggle

		Pill.MouseButton1Click:Connect(function()
			toggled = not toggled

			local targetBg = toggled
				and libraryRef.AccentColor
				or Color3.fromRGB(12, 12, 14)

			local targetPos = toggled
				and UDim2.new(1, -17, 0.5, -7)
				or UDim2.new(0, 3, 0.5, -7)

			TweenService:Create(
				Pill,
				TweenInfo.new(0.15),
				{BackgroundColor3 = targetBg}
			):Play()

			TweenService:Create(
				Circle,
				TweenInfo.new(0.15),
				{Position = targetPos}
			):Play()

			if onToggleChanged then
				onToggleChanged(toggled)
			end
		end)

		return MainCompFrame
	end

	return TabObj
end

return Library
