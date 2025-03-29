extends Node
class_name State

@warning_ignore("unused_signal")
signal request_state(new_state_name: String)

var player: Player

func enter() -> void:
    pass

func exit():
    pass

func get_input_direction() -> float:
    return Input.get_axis("move_left", "move_right")

func move(direction: float, modifier := 1.0) -> void:

    if direction:
        player.velocity.x = direction * player.SPEED * modifier
        flip(direction)
    else:
        player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED * modifier)

func flip(direction: float) -> void:
    if direction < 0:
        player.sprite.flip_h = true
    else:
        player.sprite.flip_h = false

func physics_update(_delta) -> void:

    move(get_input_direction())