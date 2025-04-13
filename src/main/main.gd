extends Node2D

@onready var ingame_ui: UI = $CanvasLayer/IngameUI
@onready var victory_label: Label = $CanvasLayer/IngameUI/Middle/VictoryLabel

@onready var level_select_menu: Control = $CanvasLayer/LevelSelectMenu

var level_button_prefab: PackedScene = preload("res://src/main/UI/level_button.tscn")

var levels: Dictionary[String, PackedScene] = {
	"level_1" = preload("uid://yan650d4vg3r"),
	"level_2" = preload("uid://bd7r0rjngqs3k"),
}

var current_level: Level:
	set(value):
		unload_current_level()

		current_level = value
		current_level.beaten.connect(_on_level_beaten)
		current_level.food_eaten_updated.connect(_on_level_food_eaten_updated)
		current_level.player_died.connect(_on_player_died)
		add_child(current_level)
		set_ui_values(0, current_level.total_food)

var current_level_name: String
var last_level_name: String


## probably should have something like a 'CurrentMenu' variable to handle which menu is active
## weirdly could be a good place for a state machine

func _ready() -> void:

	last_level_name = "level_2"

	for level_name in levels:
		var level_button = level_button_prefab.instantiate() as LevelButton
		level_button.level_name = level_name
		level_button.level_identifier = level_name

		level_button.selected.connect(_on_level_selected)
		$CanvasLayer/LevelSelectMenu/Levels.add_child(level_button)

func unload_current_level() -> void:
	if current_level:
		current_level.beaten.disconnect(_on_level_beaten)
		current_level.food_eaten_updated.disconnect(_on_level_food_eaten_updated)
		current_level.player_died.disconnect(_on_player_died)
		current_level.queue_free()

		last_level_name = current_level_name

func select_level(level_name: String) -> void:
	if level_name in levels:
		ingame_ui.unpause()
		level_select_menu.visible = false
		load_level(level_name)

		victory_label.text = ""
		ingame_ui.visible = true

func load_level(level_name: String) -> void:
	current_level = levels[level_name].instantiate()
	current_level_name = level_name

func reload_level() -> void:
	if current_level:
		load_level(current_level_name)

func set_ui_values(eaten: int, left: int) -> void:
	ingame_ui.set_eaten(eaten)
	ingame_ui.set_left(left)

func show_level_select_menu() -> void:
	$CanvasLayer/LevelSelectMenu/RetryButton.visible = current_level != null

	$CanvasLayer/MainMenu.visible = false
	ingame_ui.visible = false
	level_select_menu.visible = true


#region Signals

## having all these in a single script is not a good idea

func _on_player_died() -> void:
	## show_level_select_menu will make the ingame_ui invisible
	## this means the victory label will not be visible
	## should be fixed
	ingame_ui.set_victory_label(false)
	show_level_select_menu()

func _on_level_beaten() -> void:
	ingame_ui.set_victory_label(true)
	show_level_select_menu()

func _on_level_food_eaten_updated(new_amount: int, total: int) -> void:
	var food_left = total - new_amount

	set_ui_values(new_amount, food_left)

func _on_level_selected(level_identifier: String) -> void:
	select_level(level_identifier)

func _on_level_select_button_pressed() -> void:
	show_level_select_menu()

func _on_main_menu_button_pressed() -> void:

	unload_current_level()

	$CanvasLayer/MainMenu.visible = true
	ingame_ui.visible = false
	level_select_menu.visible = false

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_retry_button_pressed() -> void:
	level_select_menu.visible = false
	reload_level()

func _on_settings_button_pressed() -> void:
	ingame_ui.visible = false
	$CanvasLayer/MainMenu.visible = false
	$CanvasLayer/SettingsMenu.visible = true

func _on_continue_button_pressed() -> void:
	$CanvasLayer/MainMenu.visible = false
	select_level(last_level_name)

func _on_start_button_pressed() -> void:
	$CanvasLayer/MainMenu.visible = false
	select_level("level_1")


#endregion Signals


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		reload_level()

	# only handle input if not in main menu
	if Input.is_action_just_pressed("pause") and not $CanvasLayer/MainMenu.visible:

		# remove overlay if there is one
		if $CanvasLayer/SettingsMenu.visible:
			$CanvasLayer/SettingsMenu.visible = false
		elif $CanvasLayer/LevelSelectMenu.visible and current_level:
			$CanvasLayer/LevelSelectMenu.visible = false

		ingame_ui.handle_pause()
