extends KinematicBody2D




func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		if body.key == true:
			body.key = false
			queue_free()


