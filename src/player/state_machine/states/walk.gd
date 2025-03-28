extends State
class_name Walk

func enter() -> void:
    player.sprite.play("walk")

func physics_update(_delta):

    super(_delta)

    if Input.is_key_pressed(KEY_SHIFT):
        state_machine.change_state("run")

    if not get_direction():
        state_machine.change_state("idle")