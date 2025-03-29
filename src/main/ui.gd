extends Control

func set_eaten(new_value: int) -> void:
    $TopLeft/EatenLabel.text = "Food Eaten: " + str(new_value)

func set_left(new_value: int) -> void:
    $TopLeft/LeftLabel.text = "Food Left: " + str(new_value)
