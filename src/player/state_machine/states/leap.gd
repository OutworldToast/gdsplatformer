extends State
class_name Leap

func enter() -> void:
    player.sprite.play("leap")

func physics_update(delta) -> void:

    player.velocity += player.get_gravity() * delta

    if Input.is_action_just_released("run"):
        state_machine.change_state("jump")

    if player.is_on_floor():
        if Input.get_axis("move_left", "move_right"):
            state_machine.change_state("run")
        else:
            state_machine.change_state("idle")