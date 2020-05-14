extends Area2D


func _on_PickUpDagger_area_entered(area: Area2D) -> void:
	if area.get_parent().dagger_number != 10:
		queue_free()
