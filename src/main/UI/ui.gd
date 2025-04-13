extends Control
class_name UI

@onready var victory_label: Label = $Middle/VictoryLabel

func unpause() -> void:
	for child in get_tree().get_nodes_in_group("pauseable"):
		child.visible = true

		$Middle/PauseMenu.visible = false
		get_tree().paused = false

func handle_pause() -> void:

	if get_tree().paused:
		unpause()
	else:
		for child in get_tree().get_nodes_in_group("pauseable"):
			child.visible = false

		$Middle/PauseMenu.visible = true
		get_tree().paused = true

func set_eaten(new_value: int) -> void:
	$TopLeft/EatenLabel.text = "Food Eaten: " + str(new_value)

func set_left(new_value: int) -> void:
	$TopLeft/LeftLabel.text = "Food Left: " + str(new_value)

func set_victory_label(player_won: bool) -> void:
	if player_won:
		victory_label.text = "You won!"
	else:
		victory_label.text = "You died..."

	victory_label.visible = true

func _on_resume_button_pressed() -> void:
	unpause()
