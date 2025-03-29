extends State
class_name Airborne

func enter() -> void:
    player.sprite.play("jump")

func check_landing(direction_state_name: String, idle_state_name: String = "idle") -> void:
    if player.is_on_floor():
        if Input.get_axis("move_left", "move_right"):
            request_state.emit(direction_state_name)
        else:
            request_state.emit(idle_state_name)

func physics_update(delta) -> void:

    super(delta)

    player.velocity += player.get_gravity() * delta
    
    ## it might be possible to fly if you jump on the same tick you hit the ground
    if Input.is_action_just_pressed("jump"):
        player.jump(false)
        request_state.emit("jump")

    if player.is_on_wall():
        request_state.emit("cling")

    check_landing("walk")
