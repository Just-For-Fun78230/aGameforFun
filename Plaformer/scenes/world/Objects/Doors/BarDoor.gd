extends KinematicBody2D



onready var timer = $Timer

func _ready() -> void:
	GlobalSignals.connect("button_pressed", self, "open_door")
	$Sprite.play("IdleClosed")
	#imer.set_wait_time(4/5)

func open_door():
	$CollisionShape2D.queue_free()
	timer.start()
	$Sprite.play("Opening")


func _on_Timer_timeout() -> void:
	
	$Sprite.play("IdleOpen")
