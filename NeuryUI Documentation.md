# Neury UI Library

This is a guide to assembling and using the Neury UI Library.

---

# Booting The Library

```lua
local NeuryUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/iXayemiz/Neury-Roblox-Library/refs/heads/main/NeuryLib.lua"))()
```

---

# Creating The UI Library Window

```lua
local NeuryWindow = NeuryUI.new(
	"Neury UI Testing",
	Color3.fromRGB(0, 120, 255)
)
```

The first argument is the window title.

The second argument is the main accent color.

---

# Creating Tabs

```lua
local ShowcaseTab = NeuryWindow:AddTab("Showcase Tab", nil)
```

The first argument is the tab name.

The second argument is where you can put an image ID.

Example:

```lua
local HomeTab = NeuryWindow:AddTab(
	"Home",
	"rbxassetid://123456789"
)
```

---

# Section Headers

```lua
ShowcaseTab:AddSectionHeader("LABELS & TEXT")
```

Section headers are used to organize controls into different categories.

Example:

```lua
ShowcaseTab:AddSectionHeader("PLAYER")
```

---

# Labels

```lua
ShowcaseTab:AddLabel(
	"This is a simple label used for plain text."
)
```

Labels are useful for displaying short pieces of information.

---

# Paragraphs

```lua
ShowcaseTab:AddParagraph(
	"Paragraph Example",
	"This is a paragraph block. It has a bold title and a longer wrapped description underneath."
)
```

The first argument is the paragraph title.

The second argument is the paragraph description.

---

# Dividers

```lua
ShowcaseTab:AddDivider()
```

Dividers create a visual separation between different sections or controls.

Example:

```lua
ShowcaseTab:AddSectionHeader("PLAYER")

ShowcaseTab:AddButton("Example", function()
	print("Clicked!")
end)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("SETTINGS")
```

---

# Buttons

```lua
ShowcaseTab:AddButton("Click Me", function()
	print("Button clicked!")
end)
```

The callback runs whenever the button is clicked.

---

# Toggles

```lua
ShowcaseTab:AddToggle("Enable Feature", function(state)
	print("Toggle state:", state)
end, false)
```

The first argument is the toggle name.

The second argument is the callback.

The callback receives `true` or `false`.

The third argument is the default state.

Example with the toggle enabled by default:

```lua
ShowcaseTab:AddToggle("Enable Feature", function(state)
	if state then
		print("Feature enabled")
	else
		print("Feature disabled")
	end
end, true)
```

---

# Sliders

```lua
ShowcaseTab:AddSlider(
	"Walk Speed",
	0,
	100,
	16,
	function(value)
		print("Slider value:", value)
	end
)
```

Arguments:

```text
Name
Minimum value
Maximum value
Default value
Callback
```

Example:

```lua
ShowcaseTab:AddSlider(
	"Volume",
	0,
	100,
	50,
	function(value)
		print("Volume:", value)
	end
)
```

---

# Textboxes

```lua
ShowcaseTab:AddTextbox(
	"Username",
	"Enter a name...",
	function(text, enterPressed)
		print(
			"Textbox text:",
			text,
			"| Enter pressed:",
			enterPressed
		)
	end
)
```

Arguments:

```text
Name
Placeholder text
Callback
```

The callback receives:

```lua
text
enterPressed
```

Example:

```lua
ShowcaseTab:AddTextbox(
	"Player Name",
	"Enter username...",
	function(text, enterPressed)
		print("Player:", text)

		if enterPressed then
			print("Enter was pressed!")
		end
	end
)
```

---

# Dropdowns

```lua
ShowcaseTab:AddDropdown(
	"Select Mode",
	{
		"Easy",
		"Normal",
		"Hard"
	},
	"Normal",
	function(selected)
		print("Selected:", selected)
	end
)
```

Arguments:

```text
Name
Options
Default option
Callback
```

Example:

```lua
ShowcaseTab:AddDropdown(
	"Theme",
	{
		"Dark",
		"Light",
		"Blue"
	},
	"Dark",
	function(selected)
		print("Theme selected:", selected)
	end
)
```

---

# Keybinds

```lua
ShowcaseTab:AddKeybind(
	"Toggle UI",
	Enum.KeyCode.RightShift,
	function(key)
		print("Keybind pressed:", key.Name)
	end
)
```

The first argument is the keybind name.

The second argument is the default key.

The callback receives the pressed key.

Example:

```lua
ShowcaseTab:AddKeybind(
	"Test Key",
	Enum.KeyCode.F,
	function(key)
		print("Pressed:", key.Name)
	end
)
```

---

# Color Pickers

```lua
ShowcaseTab:AddColorPicker(
	"Accent Color",
	Color3.fromRGB(0, 120, 255),
	function(color)
		print("Color picked:", color)
	end
)
```

Arguments:

```text
Name
Default Color
Callback
```

The callback receives a `Color3`.

Example:

```lua
ShowcaseTab:AddColorPicker(
	"Player Color",
	Color3.fromRGB(255, 0, 0),
	function(color)
		print("New color:", color)
	end
)
```

---

# Textbox + Toggle Combo

```lua
ShowcaseTab:AddTextboxToggle({
	Name = "Webhook Config",
	TextBoxText = "",
	Placeholder = "Enter webhook URL...",
	DefaultState = false,

	OnTextBoxChanged = function(text, enterPressed)
		print(
			"Webhook text:",
			text,
			"| Enter pressed:",
			enterPressed
		)
	end,

	OnToggleChanged = function(state)
		print("Webhook enabled:", state)
	end,
})
```

This component combines a textbox and toggle into one control.

Available options:

```lua
{
	Name = "Control Name",

	TextBoxText = "",

	Placeholder = "Textbox placeholder...",

	DefaultState = false,

	OnTextBoxChanged = function(text, enterPressed)
		-- Textbox callback
	end,

	OnToggleChanged = function(state)
		-- Toggle callback
	end,
}
```

---

# Progress Bars

```lua
local SpeedBar = ShowcaseTab:AddProgressBar(
	"Loading Speed",
	0,
	100,
	40
)
```

Arguments:

```text
Name
Minimum value
Maximum value
Default value
```

This is a read-only bar, so it has no callback. Instead, it returns an object with a `:Set()` method you can call whenever you want to update its value.

Example:

```lua
local XPBar = ShowcaseTab:AddProgressBar(
	"XP Progress",
	0,
	100,
	0
)

XPBar:Set(65)
```

---

# Images

```lua
ShowcaseTab:AddImage(
	"rbxassetid://123456789",
	140
)
```

The first argument is the image (accepts either a raw asset ID number or a full image string).

The second argument is the height of the image frame in pixels (optional, defaults to `140`).

Example:

```lua
ShowcaseTab:AddImage(123456789, 180)
```

---

# Multi-Select Dropdowns

```lua
ShowcaseTab:AddMultiDropdown(
	"Enabled Modules",
	{
		"ESP",
		"Aimbot",
		"Speed Boost"
	},
	{
		"ESP"
	},
	function(selected)
		print("Selected modules:", table.concat(selected, ", "))
	end
)
```

Arguments:

```text
Name
Options
Default selected options (table)
Callback
```

Unlike a normal dropdown, more than one option can be checked at once. The callback receives a table containing every currently selected option, in the order they appear in the `options` list.

Example:

```lua
ShowcaseTab:AddMultiDropdown(
	"Visible Players",
	{
		"Team A",
		"Team B",
		"Spectators"
	},
	{
		"Team A",
		"Team B"
	},
	function(selected)
		for _, option in ipairs(selected) do
			print("Showing:", option)
		end
	end
)
```

---

# Button Groups

```lua
ShowcaseTab:AddButtonGroup({
	{
		Text = "Enable All",
		Callback = function()
			print("Enabled all")
		end,
	},
	{
		Text = "Disable All",
		Callback = function()
			print("Disabled all")
		end,
	},
})
```

Takes a single table of button definitions, each with `Text` and `Callback`, and lays them out as equal-width buttons in one row.

Example with three buttons:

```lua
ShowcaseTab:AddButtonGroup({
	{
		Text = "Low",
		Callback = function()
			print("Low selected")
		end,
	},
	{
		Text = "Medium",
		Callback = function()
			print("Medium selected")
		end,
	},
	{
		Text = "High",
		Callback = function()
			print("High selected")
		end,
	},
})
```

---

# Notifications

```lua
NeuryWindow:Notify(
	"Saved",
	"Your settings have been saved successfully.",
	3.5
)
```

Arguments:

```text
Title
Text
Duration (seconds, optional, defaults to 3.5)
```

Unlike the other controls, this is called on the **window** rather than a tab, since notifications aren't tied to any single page.

Example:

```lua
NeuryWindow:Notify(
	"Warning",
	"Webhook URL is invalid.",
	5
)
```

---

# Complete Example

```lua
local NeuryUI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/iXayemiz/Neury-Roblox-Library/refs/heads/main/NeuryLib.lua"
))()

local NeuryWindow = NeuryUI.new(
	"Neury UI Testing",
	Color3.fromRGB(0, 120, 255)
)

local ShowcaseTab = NeuryWindow:AddTab(
	"Showcase Tab",
	nil
)

ShowcaseTab:AddSectionHeader("LABELS & TEXT")

ShowcaseTab:AddLabel(
	"This is a simple label used for plain text."
)

ShowcaseTab:AddParagraph(
	"Paragraph Example",
	"This is a paragraph block. It has a bold title and a longer wrapped description underneath."
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("BUTTONS & TOGGLES")

ShowcaseTab:AddButton("Click Me", function()
	print("Button clicked!")
end)

ShowcaseTab:AddToggle("Enable Feature", function(state)
	print("Toggle:", state)
end, false)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("SLIDER")

ShowcaseTab:AddSlider(
	"Walk Speed",
	0,
	100,
	16,
	function(value)
		print("Slider:", value)
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("TEXTBOX")

ShowcaseTab:AddTextbox(
	"Username",
	"Enter a name...",
	function(text, enterPressed)
		print("Text:", text)
		print("Enter pressed:", enterPressed)
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("DROPDOWN")

ShowcaseTab:AddDropdown(
	"Select Mode",
	{
		"Easy",
		"Normal",
		"Hard"
	},
	"Normal",
	function(selected)
		print("Selected:", selected)
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("MULTI-SELECT DROPDOWN")

ShowcaseTab:AddMultiDropdown(
	"Enabled Modules",
	{
		"ESP",
		"Aimbot",
		"Speed Boost"
	},
	{
		"ESP"
	},
	function(selected)
		print("Selected modules:", table.concat(selected, ", "))
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("KEYBIND")

ShowcaseTab:AddKeybind(
	"Toggle UI",
	Enum.KeyCode.RightShift,
	function(key)
		print("Pressed:", key.Name)
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("COLOR PICKER")

ShowcaseTab:AddColorPicker(
	"Accent Color",
	Color3.fromRGB(0, 120, 255),
	function(color)
		print("Color:", color)
	end
)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("PROGRESS BAR")

local XPBar = ShowcaseTab:AddProgressBar(
	"XP Progress",
	0,
	100,
	0
)

XPBar:Set(65)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("IMAGE")

ShowcaseTab:AddImage(123456789, 140)

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("BUTTON GROUP")

ShowcaseTab:AddButtonGroup({
	{
		Text = "Enable All",
		Callback = function()
			print("Enabled all")
		end,
	},
	{
		Text = "Disable All",
		Callback = function()
			print("Disabled all")
		end,
	},
})

ShowcaseTab:AddDivider()

ShowcaseTab:AddSectionHeader("TEXTBOX + TOGGLE COMBO")

ShowcaseTab:AddTextboxToggle({
	Name = "Webhook Config",

	TextBoxText = "",

	Placeholder = "Enter webhook URL...",

	DefaultState = false,

	OnTextBoxChanged = function(text, enterPressed)
		print("Webhook:", text)
	end,

	OnToggleChanged = function(state)
		print("Webhook enabled:", state)
	end,
})

NeuryWindow:Notify(
	"Ready",
	"The showcase tab has finished loading.",
	3.5
)
```

---

# Available Functions

The current Neury UI Library API includes:

* `NeuryUI.new()`
* `Window:AddTab()`
* `Window:Notify()`
* `Tab:AddSectionHeader()`
* `Tab:AddLabel()`
* `Tab:AddParagraph()`
* `Tab:AddDivider()`
* `Tab:AddButton()`
* `Tab:AddToggle()`
* `Tab:AddSlider()`
* `Tab:AddTextbox()`
* `Tab:AddDropdown()`
* `Tab:AddKeybind()`
* `Tab:AddColorPicker()`
* `Tab:AddTextboxToggle()`
* `Tab:AddProgressBar()`
* `Tab:AddImage()`
* `Tab:AddMultiDropdown()`
* `Tab:AddButtonGroup()`
