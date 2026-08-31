--[
  Listen i got lazy so i just decided to make a seperate script, anyway link it if you want to.
--]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local Notification = {}

local ScreenGui = CoreGui:FindFirstChild("NeuryNotificationUI")

if not ScreenGui then
	ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "NeuryNotificationUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.Parent = CoreGui
end

local Container = ScreenGui:FindFirstChild("NotificationContainer")

if not Container then
	Container = Instance.new("Frame")
	Container.Name = "NotificationContainer"
	Container.Size = UDim2.new(0, 340, 1, -20)
	Container.Position = UDim2.new(1, -360, 0, 10)
	Container.BackgroundTransparency = 1
	Container.Parent = ScreenGui

	local Layout = Instance.new("UIListLayout")
	Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	Layout.SortOrder = Enum.SortOrder.LayoutOrder
	Layout.Padding = UDim.new(0, 8)
	Layout.Parent = Container
end

function Notification.new(title, message, duration)
	duration = tonumber(duration) or 5

	local Frame = Instance.new("Frame")
	Frame.Name = "Notification"
	Frame.Size = UDim2.new(0, 330, 0, 82)
	Frame.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
	Frame.BorderSizePixel = 0
	Frame.ClipsDescendants = true
	Frame.Position = UDim2.new(1, 350, 0, 0)
	Frame.Parent = Container

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = Frame

	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Color3.fromRGB(30, 30, 40)
	Stroke.Thickness = 1
	Stroke.Parent = Frame

	local Accent = Instance.new("Frame")
	Accent.Size = UDim2.new(0, 3, 1, -24)
	Accent.Position = UDim2.new(0, 8, 0, 12)
	Accent.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
	Accent.BorderSizePixel = 0
	Accent.Parent = Frame

	local AccentCorner = Instance.new("UICorner")
	AccentCorner.CornerRadius = UDim.new(1, 0)
	AccentCorner.Parent = Accent

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -65, 0, 22)
	Title.Position = UDim2.new(0, 22, 0, 10)
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.GothamBold
	Title.Text = tostring(title or "Notification")
	Title.TextColor3 = Color3.fromRGB(220, 220, 230)
	Title.TextSize = 13
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Frame

	local Message = Instance.new("TextLabel")
	Message.Size = UDim2.new(1, -45, 0, 38)
	Message.Position = UDim2.new(0, 22, 0, 32)
	Message.BackgroundTransparency = 1
	Message.Font = Enum.Font.GothamMedium
	Message.Text = tostring(message or "")
	Message.TextColor3 = Color3.fromRGB(145, 145, 155)
	Message.TextSize = 11
	Message.TextWrapped = true
	Message.TextXAlignment = Enum.TextXAlignment.Left
	Message.TextYAlignment = Enum.TextYAlignment.Top
	Message.Parent = Frame

	local CloseButton = Instance.new("ImageButton")
	CloseButton.Size = UDim2.new(0, 23, 0, 23)
	CloseButton.Position = UDim2.new(1, -32, 0, 10)
	CloseButton.BackgroundTransparency = 1
	CloseButton.AutoButtonColor = false
	CloseButton.Image = "rbxassetid://18503481771"
	CloseButton.ImageColor3 = Color3.fromRGB(160, 160, 170)
	CloseButton.Parent = Frame

	CloseButton.MouseEnter:Connect(function()
		TweenService:Create(
			CloseButton,
			TweenInfo.new(0.12),
			{ImageColor3 = Color3.fromRGB(255, 255, 255)}
		):Play()
	end)

	CloseButton.MouseLeave:Connect(function()
		TweenService:Create(
			CloseButton,
			TweenInfo.new(0.12),
			{ImageColor3 = Color3.fromRGB(160, 160, 170)}
		):Play()
	end)

	local closed = false

	local function Close()
		if closed then
			return
		end

		closed = true

		local Tween = TweenService:Create(
			Frame,
			TweenInfo.new(
				0.2,
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.In
			),
			{
				Position = UDim2.new(1, 350, 0, 0),
				Size = UDim2.new(0, 330, 0, 0)
			}
		)

		Tween:Play()

		Tween.Completed:Connect(function()
			Frame:Destroy()
		end)
	end

	CloseButton.MouseButton1Click:Connect(Close)

	local SlideIn = TweenService:Create(
		Frame,
		TweenInfo.new(
			0.35,
			Enum.EasingStyle.Quint,
			Enum.EasingDirection.Out
		),
		{
			Position = UDim2.new(0, 0, 0, 0)
		}
	)

	SlideIn:Play()

	task.delay(duration, function()
		if not closed then
			Close()
		end
	end)

	return {
		Frame = Frame,
		Close = Close
	}
end

setmetatable(Notification, {
	__call = function(_, title, message, duration)
		return Notification.new(title, message, duration)
	end
})

return Notification
