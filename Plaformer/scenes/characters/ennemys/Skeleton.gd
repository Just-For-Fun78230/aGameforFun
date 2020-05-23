extends Actors




var skeleton_max_speed = Vector2(30,0)

onready var raycasts = $Raycasts

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	if on_wall():
		skeleton_max_speed.x = -5
		self.scale.x *= -1
	skeleton_max_speed.y = gravity * delta
	skeleton_max_speed = move_and_slide(skeleton_max_speed, FLOOR_NORMAL)
	

func on_wall():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false


