extends KinematicBody2D


onready var change_direction_timer = $ChangeDirectionTimer

var can_change_direction = true
var state = 1
#0 = nothing, 1 = up, 2 = down, 3 = left, 4 = right, 5 = up_left, 6 = up_right, 7 = down_left, 8 = down_right

var movement = Vector2()

func _ready() -> void:
	change_direction_timer.set_wait_time(1)



func _on_ChangeDirectionTimer_timeout() -> void:
	can_change_direction = true



func _physics_process(delta: float) -> void:
	
	if can_change_direction or is_on_wall() or is_on_ceiling() or is_on_floor():
		if is_on_ceiling():
			state = floor(rand_range(7,8))
		elif is_on_floor():
			state = floor(rand_range(3,6))
		else:
			state = floor(rand_range(0,8))
		can_change_direction = false
		change_direction_timer.start()
	
	movement_do()
	
	
	move_and_slide(movement)





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



