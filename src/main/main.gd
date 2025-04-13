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

func _ready() -> void:

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

func load_level(level_name: String) -> void:
	current_level = levels[level_name].instantiate()
	current_level_name = level_name

func set_ui_values(eaten: int, left: int) -> void:
	ingame_ui.set_eaten(eaten)
	ingame_ui.set_left(left)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		load_level(current_level_name)
		victory_label.text = ""

	if Input.is_action_just_pressed("pause"):
		ingame_ui.handle_pause()

func _on_level_selected(level_identifier: String) -> void:
	if level_identifier in levels:
		ingame_ui.unpause()
		level_select_menu.visible = false
		load_level(level_identifier)
		victory_label.text = ""
		ingame_ui.visible = true

func _on_player_died() -> void:
	ingame_ui.set_victory_label(false)

func _on_level_beaten() -> void:
	ingame_ui.set_victory_label(true)
	level_select_menu.visible = true


func _on_level_food_eaten_updated(new_amount: int, total: int) -> void:
	var food_left = total - new_amount

	set_ui_values(new_amount, food_left)


func _on_level_select_button_pressed() -> void:
	ingame_ui.visible = false
	level_select_menu.visible = true
