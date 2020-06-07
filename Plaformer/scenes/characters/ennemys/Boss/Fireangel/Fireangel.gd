extends KinematicBody2D

var FIREBALL = preload("res://scenes/weapons/Ennemys/Projectiles/Fireball.tscn")

onready var change_direction_timer = $Timers/ChangeDirectionTimer
onready var fire_every_direction_timer = $Timers/FireEveryDirectionTimer


var can_change_direction = true
var can_fire_every_direction = false

var fire_every_direction_speed = 100
var fire_every_direction_fire_speed = 2

var movement = Vector2()
var movement_speed = 100
var state = 1
#0 = nothing, 1 = up, 2 = down, 3 = left, 4 = right, 5 = up_left, 6 = up_right, 7 = down_left, 8 = down_right


var ennemy_health = 1000

func _ready() -> void:
	change_direction_timer.set_wait_time(1)
	fire_every_direction_timer.set_wait_time(2)
	fire_every_direction_timer.start()



func _on_ChangeDirectionTimer_timeout() -> void:
	can_change_direction = true


func _on_FireEveryDirectionTimer_timeout() -> void:
	can_fire_every_direction = true



func _on_KillDetector_area_entered(area: Area2D) -> void:
	ennemy_health -= area.dammage



func _physics_process(delta: float) -> void:
	
	direction()
	movement_do()
	move_and_slide(movement)
	fire(delta)
	heath()

func direction():
	if can_change_direction or is_on_wall() or is_on_ceiling() or is_on_floor():
		movement_speed = rand_range(50,300)
		if is_on_ceiling():
			state = floor(rand_range(7,8))
		elif is_on_floor():
			state = floor(rand_range(3,6))
		else:
			state = floor(rand_range(0,8))
		can_change_direction = false
		change_direction_timer.start()

func movement_do():
	if state == 0:
		movement.x = 0
		movement.y = 0
	elif state == 1:
		movement.x = 0
		movement.y = -100
	elif state == 2:
		movement.x = 0
		movement.y = 100
	elif state == 3:
		movement.x = -100
		movement.y = 0
	elif state == 4:
		movement.x = 100
		movement.y = 0
	elif state == 5:
		movement.x = -100
		movement.y = 100
	elif state == 6:
		movement.x = 100
		movement.y = 100
	elif state == 7:
		movement.x = -100
		movement.y = -100
	elif state == 8:
		movement.x = 100
		movement.y = 100

func fire(delta):
	if can_fire_every_direction:
		fire_every_direction(delta)


func fire_every_direction(delta):
	fire_every_direction_speed = rand_range(50,200)
	can_fire_every_direction = false
	fire_every_direction_fire_speed = rand_range(.5,3)
	fire_every_direction_timer.set_wait_time(fire_every_direction_fire_speed)
	fire_every_direction_timer.start()
	
	var fireball_right = FIREBALL.instance()
	get_parent().add_child(fireball_right)
	fireball_right.fireball_velocity.x = fire_every_direction_speed * delta
	fireball_right.fireball_velocity.y = 0 * delta
	fireball_right.position = $FireballSpawner.global_position
	
	var fireball_left = FIREBALL.instance()
	get_parent().add_child(fireball_left)
	fireball_left.fireball_velocity.x = -fire_every_direction_speed * delta
	fireball_left.fireball_velocity.y = 0 * delta
	fireball_left.position = $FireballSpawner.global_position
	
	var fireball_up = FIREBALL.instance()
	get_parent().add_child(fireball_up)
	fireball_up.fireball_velocity.x = 0 * delta
	fireball_up.fireball_velocity.y = -fire_every_direction_speed * delta
	fireball_up.position = $FireballSpawner.global_position
	
	var fireball_down = FIREBALL.instance()
	get_parent().add_child(fireball_down)
	fireball_down.fireball_velocity.x = 0 * delta
	fireball_down.fireball_velocity.y = fire_every_direction_speed * delta
	fireball_down.position = $FireballSpawner.global_position


func heath():
	$HealthBar.value = ennemy_health
	ennemy_health = $HealthBar.value 
	if ennemy_health == 0:
		queue_free()
