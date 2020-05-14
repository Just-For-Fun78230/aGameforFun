extends Node2D


var MINI_DAGGER_RIGHT = preload("res://scenes/weapons/Ennemys/Projectiles/MiniDaggers/MiniDaggerRight.tscn")

onready var mini_dagger_timer = $MiniDaggerTimer


var can_shoot = true
var should_shoot = false

func _ready() -> void:
	mini_dagger_timer.set_wait_time(1)
	
	
func _on_MiniDaggerTimer_timeout() -> void:
	can_shoot = true
	mini_dagger_timer.stop()


func _on_Scanner_body_entered(_body: Node) -> void:
	should_shoot = true

func _on_Scanner_body_exited(_body: Node) -> void:
	should_shoot = false

func _physics_process(delta: float) -> void:

	if can_shoot == true and should_shoot == true:
		mini_dagger_fire(delta)
		mini_dagger_timer.start()
		can_shoot = false
		

func mini_dagger_fire(delta):
	var mini_dagger_right = MINI_DAGGER_RIGHT.instance()
	get_parent().add_child(mini_dagger_right)
	mini_dagger_right.mini_dagger_velocity.x = mini_dagger_right.mini_dagger_speed * delta
	mini_dagger_right.position = $Body/MiniDaggerSpawner.global_position
