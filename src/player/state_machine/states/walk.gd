extends State
class_name Walk

func enter() -> void:
    player.sprite.play("walk")

func physics_update(_delta):

    super(_delta)

    if Input.is_key_pressed(KEY_SHIFT):
        request_state.emit("run")

    if not get_input_direction():
        request_state.emit("idle")

    if Input.is_action_just_pressed("jump"):
        player.jump(false)
        request_state.emit("jump")

    if not player.is_on_floor():
        request_state.emit("airborne")