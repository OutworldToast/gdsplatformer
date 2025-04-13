extends Node2D
class_name Level

signal beaten()
signal player_died()
signal food_eaten_updated(new_amount: int, total: int)

@onready var player: Player = $Player

var total_food := 0
var food_eaten := 0:
	set(value):
		food_eaten = value
		food_eaten_updated.emit(food_eaten, total_food)
		
		if food_eaten == total_food:
			win()

func win() -> void:
	beaten.emit()
	player.celebrate()

func lose() -> void:
	player_died.emit()

func _ready() -> void:

	## could also be done with a check on size of get_children
	for child in $Foodstuffs.get_children():
		## should validate if child is actually food
		total_food += 1

func _on_player_eaten_food() -> void:
	food_eaten += 1

func _on_boundary_body_entered(body:Node2D) -> void:
	if body is Player:
		var player_ = body as Player
		player_.die()
		lose()