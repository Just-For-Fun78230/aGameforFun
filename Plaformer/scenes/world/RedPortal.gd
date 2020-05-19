extends Area2D

export(String, FILE, "*.tscn") var world_scene


func _on_RedPortal_body_entered(body: Node) -> void:
	if body.name == "Player":
		$Label.show()



func _on_RedPortal_body_exited(body: Node) -> void:
	$Label.hide()

func _physics_process(_delta: float) -> void:
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			if Input.is_action_just_pressed("F"):
				get_tree().change_scene(world_scene)





