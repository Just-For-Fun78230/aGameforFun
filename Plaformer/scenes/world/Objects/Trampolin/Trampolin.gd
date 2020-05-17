extends Area2D

onready var timer = $Timer

export var trampolin_hight_x = 0
export var trampolin_hight_y = -250

func _ready() -> void:
	$AnimatedSprite.play("Idle")
	timer.set_wait_time(.5)

func _on_Trampolin_area_entered(_area: Area2D) -> void:
	$AnimatedSprite.play("InUse")
	timer.start()


func _on_Timer_timeout() -> void:
	$AnimatedSprite.play("Idle")
