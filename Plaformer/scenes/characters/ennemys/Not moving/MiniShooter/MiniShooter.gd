extends Node2D


var BALL = preload("res://scenes/weapons/Ennemys/Projectiles/MiniCanonBall.tscn")

onready var mini_ball_timer = $MiniBallTimer


var can_shoot = true
var should_shoot = false

export var ball_speed_x := 0
export var ball_speed_y := 0

export var ball_scale_x := .5
export var ball_scale_y := .5

export var ball_time := 1.0

func _ready() -> void:
	mini_ball_timer.set_wait_time(ball_time)
	
	
func _on_MiniDaggerTimer_timeout() -> void:
	can_shoot = true
	mini_ball_timer.stop()


func _on_Scanner_body_entered(_body: Node) -> void:
	should_shoot = true

func _on_Scanner_body_exited(_body: Node) -> void:
	should_shoot = false

func _physics_process(delta: float) -> void:

	if can_shoot == true and should_shoot == true:
		mini_dagger_fire(delta)
		mini_ball_timer.start()
		can_shoot = false
		

func mini_dagger_fire(delta):
	var mini_ball = BALL.instance()
	get_parent().add_child(mini_ball)
	mini_ball.scale.x = ball_scale_x
	mini_ball.scale.y = ball_scale_y
	mini_ball.ball_velocity.x = ball_speed_x * delta
	mini_ball.ball_velocity.y = ball_speed_y * delta
	mini_ball.position = $Body/MiniBallSpawner.global_position
