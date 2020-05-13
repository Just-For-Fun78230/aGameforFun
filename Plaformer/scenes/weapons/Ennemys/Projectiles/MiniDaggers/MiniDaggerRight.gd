extends Area2D




var mini_dagger_speed = 200

var mini_dagger_velocity = Vector2()
var dammage = 20

func _on_MiniDagger_body_entered(_body: Node) -> void:
	die()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	die()


func _physics_process(_delta: float) -> void:
	
	translate(mini_dagger_velocity)
	





func die():
	queue_free()
