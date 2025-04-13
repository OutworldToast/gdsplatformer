extends Button
class_name LevelButton

signal selected(level_identifier: String)

@export var level_name: String:
    set(value):
        text = value

@export var level_identifier: String


func _on_pressed() -> void:
    selected.emit(level_identifier)

