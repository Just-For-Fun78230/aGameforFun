extends Area2D



func _on_MetalButton_area_entered(area: Area2D) -> void:
	if area.name == "Dagger":
		GlobalSignals.emit_signal("button_pressed")
		$Sprite.play("Pressed")
		$CollisionShape2D.queue_free()
