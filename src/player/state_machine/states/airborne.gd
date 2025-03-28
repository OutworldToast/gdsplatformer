extends State
class_name Airborne

func enter() -> void:
    player.sprite.play("jump")

func check_land(_direction_state_name: String, _idle_state_name: String) -> void:
    pass

func physics_update(delta) -> void:

    super(delta)

    player.velocity += player.get_gravity() * delta

    if player.is_on_floor():
        if Input.get_axis("move_left", "move_right"):
            state_machine.change_state("walk")
        else:
            state_machine.change_state("idle")