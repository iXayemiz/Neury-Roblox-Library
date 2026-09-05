local NeuryUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/iXayemiz/Neury-Roblox-Library/refs/heads/main/NeuryLib.lua"))()

local NeuryWindow = NeuryUI.new("Neury UI Testing", Color3.fromRGB(0, 120, 255))

local ShowcaseTab = NeuryWindow:AddTab("Showcase Tab", nil)

ShowcaseTab:AddSectionHeader("LABELS & TEXT")

ShowcaseTab:AddLabel("This is a simple label used for plain text.")

ShowcaseTab:AddParagraph(
	"Paragraph Example",
	"This is a paragraph block. It has a bold title and a longer wrapped description underneath, useful for explaining a feature."
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("BUTTONS & TOGGLES")

ShowcaseTab:AddButton("Click Me", function()
	print("Button clicked!")
end)

ShowcaseTab:AddToggle("Enable Feature", function(state)
	print("Toggle set to:", state)
end, false)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("SLIDER")

ShowcaseTab:AddSlider("Walk Speed", 0, 100, 16, function(value)
	print("Slider value:", value)
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("TEXTBOX")

ShowcaseTab:AddTextbox("Username", "Enter a name...", function(text, enterPressed)
	print("Textbox text:", text, "| Enter pressed:", enterPressed)
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("DROPDOWN")

ShowcaseTab:AddDropdown("Select Mode", {"Easy", "Normal", "Hard"}, "Normal", function(selected)
	print("Dropdown selected:", selected)
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("KEYBIND")

ShowcaseTab:AddKeybind("Toggle UI", Enum.KeyCode.RightShift, function(key)
	print("Keybind pressed:", key.Name)
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("COLOR PICKER")

ShowcaseTab:AddColorPicker("Accent Color", Color3.fromRGB(0, 120, 255), function(color)
	print("Color picked:", color)
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("TEXTBOX + TOGGLE COMBO")

ShowcaseTab:AddTextboxToggle({
	Name = "Webhook Config",
	TextBoxText = "",
	Placeholder = "Enter webhook URL...",
	DefaultState = false,
	OnTextBoxChanged = function(text, enterPressed)
		print("Webhook text:", text, "| Enter pressed:", enterPressed)
	end,
	OnToggleChanged = function(state)
		print("Webhook enabled:", state)
	end,
})
