extends Node


var state = "Idle"

var idle = true
var run
var jump
var attack
var fall
var on_wall


func _process(_delta: float) -> void:
	change_state()
	set_state()

func change_state():
	if idle == true:
		if get_parent().player_velocity.y != 0 and get_parent().check_on_wall() == false and !get_parent().is_grounded:
			return "Jump" 
		elif (get_parent().player_velocity.x > 3 or get_parent().player_velocity.x < -3) and get_parent().is_grounded:
			return "Run"
		elif Input.is_action_just_pressed("left mouse button") and get_parent().weapon_choice == 1:
			return "Attack"
		elif get_parent().check_on_wall() and get_parent().is_grounded == false:
			return "On Wall"
	elif run == true:
		if !get_parent().is_grounded and get_parent().check_on_wall() == false and get_parent().player_velocity.y != 0:
			return "Jump" 
		elif get_parent().player_velocity.x <= 3 and get_parent().player_velocity.x >= -3 and get_parent().player_velocity.y == 0:
			return "Idle"
		elif Input.is_action_just_pressed("left mouse button") and get_parent().weapon_choice == 1:
			return "Attack"
		elif get_parent().check_on_wall() and get_parent().is_grounded == false:
			return "On Wall"
	elif jump == true:
		if get_parent().is_grounded and get_parent().player_velocity.x <= 3 and get_parent().player_velocity.x >= -3:
			return "Idle" 
		elif (get_parent().player_velocity.x > 3 or get_parent().player_velocity.x < -3) and get_parent().is_grounded:
			return "Run"
		elif Input.is_action_just_pressed("left mouse button") and get_parent().weapon_choice == 1:
			return "Attack"
		elif get_parent().check_on_wall() and get_parent().is_grounded == false:
			return "On Wall"
		elif get_parent().is_grounded:
			return "Idle"
	elif attack == true:
		if Input.is_action_just_released("left mouse button"):
			return "Idle"
	elif on_wall == true:
		if get_parent().player_velocity.y != 0 and get_parent().check_on_wall() == false:
			return "Jump" 
		elif (get_parent().player_velocity.x > 3 or get_parent().player_velocity.x < -3) and get_parent().is_grounded:
			return "Run"
		elif Input.is_action_just_pressed("left mouse button") and get_parent().weapon_choice == 1:
			return "Attack"
		elif get_parent().player_velocity.y == 0 and get_parent().player_velocity.x == 0:
			return "Idle" 
	else :
		return null

func set_state():
	if change_state() == "Idle":
		idle = true
		jump = false
		run = false
		attack = false
		on_wall = false
		print("idle")
		state = "Idle"
	elif change_state() == "Run":
		run = true
		jump = false
		idle = false
		attack = false
		on_wall = false
		print("run")
		state = "Run"
	elif change_state() == "Jump":
		jump = true
		idle = false
		run = false
		attack = false
		on_wall = false
		print("jump")
		state = "Jump"
	elif change_state() == "Attack":
		attack = true
		jump = false
		idle = false
		run = false
		on_wall = false
		print("attack")
		state = "Attack"
	elif change_state() == "On Wall":
		attack = false
		jump = false
		idle = false
		run = false
		on_wall = true
		print("on wall")
		state = "On Wall"
