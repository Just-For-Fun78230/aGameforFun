extends KinematicBody2D


var velocity = Vector2()


var player_relative_position = Vector2()
var self_position = Vector2()

var can_attack = true
var should_attack = false

func _ready() -> void:
	$AnimationPlayer.play("Fly")


func _on_PlayerDetection_body_entered(body: Node) -> void:
	if body.name == "Player":
		should_attack = true

func _on_PlayerDetection_body_exited(body: Node) -> void:
	if body.name == "Player":
		should_attack = false

func _physics_process(delta: float) -> void:
	if should_attack:
		move_and_slide(player_relative_position)
	print(player_relative_position)
	
	get_attack_direction()






func get_attack_direction():
	self_position = self.get_position()
	player_relative_position.x = (Global.player_position_x - self_position.x)  * 10
	player_relative_position.y = (Global.player_position_y - self_position.y) * 10





