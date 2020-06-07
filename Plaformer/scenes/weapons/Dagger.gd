extends Area2D


var dagger_speed = 200
var dagger_velocity = Vector2()
var dammage = 20


func _on_VisibilityEnabler2D_screen_exited() -> void:
	queue_free()


func _on_Dagger_area_entered(_area: Area2D) -> void:
	queue_free()


func _on_Dagger_body_entered(_body: Node) -> void:
	queue_free()
	



func _physics_process(delta: float) -> void:
	if dagger_velocity.x < 0:
		$Sprite.flip_h = true
	dagger_velocity.x =  dagger_speed * delta 
	translate(dagger_velocity)





