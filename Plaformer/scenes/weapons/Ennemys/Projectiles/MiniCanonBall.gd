extends Area2D


var ball_speed = 200
var ball_velocity = Vector2()
var dammage = 10



func _on_MiniCanonBall_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_MiniCanonBall_body_entered(_body: Node) -> void:
	queue_free()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	translate(ball_velocity)







