extends Actors


var FIREBALL = preload("res://scenes/weapons/Ennemys/Projectiles/Fireball.tscn")

onready var fireball_timer = $FireballTimer


var ennemy_health := 50
var can_shoot := true
var should_shoot := false
var player_position
var magier_max_speed = Vector2(50,0)
var player_in_front : bool


func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -magier_max_speed.x
	fireball_timer.set_wait_time(0.5)




func _on_KillDetector_area_entered(area: Area2D):
	ennemy_health -= area.dammage



func _on_Detection_body_entered(body: Node) -> void:
	should_shoot = true

func _on_Detection_body_exited(_body: Node) -> void:
	should_shoot = false
	fireball_timer.stop()
	can_shoot = true


func _on_FireballTimer_timeout() -> void:
	can_shoot = true



func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		_velocity *= -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	#sprite
	if _velocity.x < 0:
		$Body.scale.x = 1
	elif _velocity.x > 0:
		$Body.scale.x = -1

	$HealthBar.value = ennemy_health
	ennemy_health = $HealthBar.value 
	if ennemy_health == 0:
		queue_free()
	
	if can_shoot == true and should_shoot == true:
		fireball_fire(delta)
		fireball_timer.start()
		can_shoot = false





func fireball_fire(delta):
	var fireball = FIREBALL.instance()
	get_parent().add_child(fireball)
	if $Body.scale.x == -1:
		fireball.fireball_velocity.x = 200 * delta
	else:
		fireball.fireball_velocity.x = -200 * delta
	if $Body.scale.x == 1:
		fireball.fireball_speed *= -1
	fireball.position = $FireballSpawner.global_position






