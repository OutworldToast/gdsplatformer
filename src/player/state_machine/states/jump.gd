extends State
class_name Jump

func enter() -> void:
    player.sprite.play("jump")

func physics_update(delta) -> void:

    super(delta)

    player.velocity += player.get_gravity() * delta

    if player.is_on_floor():
        if Input.get_axis("move_left", "move_right"):
            state_machine.change_state("run")
        else:
            state_machine.change_state("idle")