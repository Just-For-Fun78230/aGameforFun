extends Control



func _on_Level1_pressed() -> void:
	get_tree().change_scene("res://scenes/levels/Level1.tscn")



func _on_Level2_pressed() -> void:
	get_tree().change_scene("res://scenes/levels/Level2.tscn")


func _on_Main_Menu_pressed() -> void:
	get_tree().change_scene("res://scenes/UI/MainScreen.tscn")


func _on_Test_level_pressed() -> void:
	get_tree().change_scene("res://scenes/levels/TestLevel.tscn")
