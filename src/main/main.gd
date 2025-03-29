extends Node2D


var levels: Dictionary[String, PackedScene] = {
	"level_1" = preload("uid://yan650d4vg3r")
}

var current_level: Level:
	set(value):
		if current_level:
			current_level.beaten.disconnect(_on_level_beaten)
			current_level.food_eaten_updated.disconnect(_on_level_food_eaten_updated)
			current_level.queue_free()

		current_level = value
		current_level.beaten.connect(_on_level_beaten)
		current_level.food_eaten_updated.connect(_on_level_food_eaten_updated)
		add_child(current_level)
		set_ui_values(0, current_level.total_food)
var current_level_name: String

func _ready() -> void:
	load_level("level_1")

func load_level(level_name: String) -> void:
	current_level = levels[level_name].instantiate()
	current_level_name = level_name

func set_ui_values(eaten: int, left: int) -> void:
	$CanvasLayer/UI.set_eaten(eaten)
	$CanvasLayer/UI.set_left(left)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		load_level(current_level_name)


func _on_level_beaten() -> void:
	$CanvasLayer/UI/Middle/VictoryLabel.visible = true

func _on_level_food_eaten_updated(new_amount: int, total: int) -> void:
	var food_left = total - new_amount

	set_ui_values(new_amount, food_left)
