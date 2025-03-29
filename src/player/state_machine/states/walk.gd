extends State
class_name Walk

func enter() -> void:
    player.sprite.play("walk")

func physics_update(_delta):

    super(_delta)

    if Input.is_key_pressed(KEY_SHIFT):
        state_machine.change_state("run")

    if not get_input_direction():
        state_machine.change_state("idle")

    if Input.is_action_just_pressed("jump"):
        player.jump(false)
        state_machine.change_state("jump")

    if not player.is_on_floor():
        state_machine.change_state("airborne")