extends Actors





var ennemy_health := 50

var should_run := false
var mean_boar_max_speed = Vector2(50,0)



func _ready() -> void:
	set_physics_process(false)
	





func _on_KillDetector_area_entered(area: Area2D):
	ennemy_health -= area.dammage
	


func _on_Detection_body_entered(_body: Node) -> void:
	should_run = true

func _on_Detection_body_exited(_body: Node) -> void:
	should_run = false








func _physics_process(delta: float) -> void:
	if $Body.scale.x == 1:
		_velocity.x = -mean_boar_max_speed.x
	elif $Body.scale.x == -1:
		_velocity.x = mean_boar_max_speed.x
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
	
	_run()


func _run():
	if should_run == true:
		mean_boar_max_speed.x += 10
	elif should_run == false:
		mean_boar_max_speed.x = 50 


