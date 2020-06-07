extends KinematicBody2D




func _ready() -> void:
	$AnimationPlayer.play("Fly")



func _physics_process(delta: float) -> void:
	move_and_slide(Vector2(20,0))




