extends VBoxContainer

# resolution and window mode made using:
# https://github.com/godotengine/godot-demo-projects/blob/c3b0331d8a06a2b8def14e745db9e24d0f387c80/gui/multiple_resolutions/main.gd#L90-L134
# DisplayServer functionality found using ChatGPT

var base_window_size := Vector2(
		ProjectSettings.get_setting("display/window/size/viewport_width"),
		ProjectSettings.get_setting("display/window/size/viewport_height")
)

var resolution_list: Array[String] = [
	"648x648 (1:1)",
	"640x480 (4:3)",
	"720x480 (3:2)",
	"800x600 (4:3)",
	"1152x648 (16:9)",
	"1280x720 (16:9)",
	"1280x800 (16:10)",
	"1680x720 (21:9)",
	"1920x1080 (16:9)"
]

var window_list: Array[String] = [
	"Windowed",
	"Fullscreen",
	"Borderless"
]

func _ready() -> void:
	# should override exported list
	$SettingsContainer/WindowContainer/ResolutionSelector.set_items(resolution_list)
	$SettingsContainer/WindowContainer/WindowSelector.set_items(window_list)
	$SettingsContainer/WindowContainer/VSyncButton.button_pressed = DisplayServer.window_get_vsync_mode() == DisplayServer.VSYNC_ENABLED


# when pressing any of the bottom buttons, the menu will close
func _on_exit_button_pressed() -> void:
	visible = false

func _on_window_selector_item_selected(index:int) -> void:
	match index:
		0:  # windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:  # fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		2:  # borderless
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


func _on_resolution_selector_item_selected(index:int) -> void:
	match index:
		0:  # 648×648 (1:1)
			base_window_size = Vector2(648, 648)
		1:  # 640×480 (4:3)
			base_window_size = Vector2(640, 480)
		2:  # 720×480 (3:2)
			base_window_size = Vector2(720, 480)
		3:  # 800×600 (4:3)
			base_window_size = Vector2(800, 600)
		4:  # 1152×648 (16:9)
			base_window_size = Vector2(1152, 648)
		5:  # 1280×720 (16:9)
			base_window_size = Vector2(1280, 720)
		6:  # 1280×800 (16:10)
			base_window_size = Vector2(1280, 800)
		7:  # 1680×720 (21:9)
			base_window_size = Vector2(1680, 720)
		8:  # 1920×1080 (16:9)
			base_window_size = Vector2(1920, 1080)

	DisplayServer.window_set_size(base_window_size)

func _on_vsync_button_toggled(toggled_on: bool) -> void:
	var mode = DisplayServer.VSYNC_ENABLED if toggled_on else DisplayServer.VSYNC_DISABLED
	DisplayServer.window_set_vsync_mode(mode)
	print("VSync: %s" % DisplayServer.window_get_vsync_mode())


## exit logic here would make more sense, but this would probably use a generic Menu class
## for now, this logic will stay in main
# func _process(_delta: float) -> void:

# 	if Input.is_action_just_pressed("pause"):
# 		visible = false
