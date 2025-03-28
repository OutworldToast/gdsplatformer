extends Node2D

var food_eaten := 0

func _on_player_eaten_food() -> void:
	food_eaten += 1
	print('THE DINO HAS EATEN THE FOOD: ', food_eaten)
