extends Node2D
class_name Level

signal beaten()
signal food_eaten_updated(new_amount: int, total: int)

var total_food := 0
var food_eaten := 0:
	set(value):
		food_eaten = value
		food_eaten_updated.emit(food_eaten, total_food)
		
		if food_eaten == total_food:
			win()

func win() -> void:
	print("You won!")
	beaten.emit()


func _ready() -> void:

	## could also be done with a check on size of get_children
	for child in $Foodstuffs.get_children():
		## should validate if child is actually food
		total_food += 1

func _on_player_eaten_food() -> void:
	food_eaten += 1
