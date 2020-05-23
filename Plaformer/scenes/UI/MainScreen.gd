extends Control



func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://scenes/levels/Tutorial.tscn")


func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_LevelMap_pressed() -> void:
	get_tree().change_scene("res://scenes/UI/LevelMap.tscn")
