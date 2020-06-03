extends Actors

onready var raycasts = $Raycasts
onready var attack_timer = $AttackTimer
onready var dead_timer = $DeadTimer

var skeleton_max_speed = Vector2(20,0)
var states = "Walk"
var stop_attack = true
var should_stop_attack
var see_player = false

var health = 200


func _ready():
	attack_timer.set_wait_time(1.8)
	dead_timer.set_wait_time(1)


func _on_PlayerDetect_body_entered(body: Node) -> void:
	if body.name == "Player":
		states = "Attack"
		attack_timer.start()
		stop_attack = false
		should_stop_attack = false
		see_player = true



func _on_PlayerDetect_body_exited(body: Node) -> void:
	if body.name == "Player":
		should_stop_attack = true


func _on_KillDetector_area_exited(area: Area2D) -> void:
	health -= area.dammage


func _on_AttackTimer_timeout() -> void:
	stop_attack = true


func _on_DeadTimer_timeout() -> void:
	die()


func _on_VisibilityEnabler2D_screen_exited() -> void:
	states = "Walk"


func _physics_process(delta: float) -> void:
	skeleton_max_speed.y = gravity * delta
	_do(delta)
	change_state()
	_health()
	#print(states)

func _do(delta):

	if states == "Walk":
		$AnimationPlayer.play("Walk")
		show_walk()
		on_wall()
		skeleton_max_speed.y = move_and_slide(skeleton_max_speed, FLOOR_NORMAL).y
		
	elif states == "Idle":
		$AnimationPlayer.play("Idle")
		show_idle()
	elif states == "Attack":
		$AnimationPlayer.play("Attack")
		if $AttackSprite.frame == 7:
			$Dammage/CollisionShape2D.disabled = false
		elif $AttackSprite.frame == 13:
			$Dammage/CollisionShape2D.disabled = true
		show_attack()
	elif states == "Dead":
		$AnimationPlayer.play("Dead")
		show_dead()
		if $DeadSprite.frame == 14:
			$AnimationPlayer.stop()
			dead_timer.start()
	elif states == "Follow":
		var old_speed
		$AnimationPlayer.play("Walk")
		show_walk()
		if Global.player_position_x > self.get_position().x:
			old_speed = skeleton_max_speed.x
			skeleton_max_speed.x = 20
			if old_speed != skeleton_max_speed.x:
				self.scale.x *= -1
		elif Global.player_position_x < self.get_position().x:
			old_speed = skeleton_max_speed.x
			skeleton_max_speed.x = -20
			if old_speed != skeleton_max_speed.x:
				self.scale.x *= -1
		skeleton_max_speed.y = move_and_slide(skeleton_max_speed, FLOOR_NORMAL).y

func on_wall():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			self.scale.x *= -1
			skeleton_max_speed.x = -skeleton_max_speed.x

func change_state():
	if states == "Attack":
		if should_stop_attack and stop_attack:
			states = "Walk"
	elif states == "Walk":
		if see_player:
			states = "Follow"


func show_idle():
	$IdleSprite.show()
	$AttackSprite.hide()
	$Dammage/CollisionShape2D.disabled = true
	$WalkSprite.hide()

func show_walk():
	$IdleSprite.hide()
	$AttackSprite.hide()
	$Dammage/CollisionShape2D.disabled = true
	$WalkSprite.show()

func show_attack():
	$IdleSprite.hide()
	$AttackSprite.show()
	$WalkSprite.hide()

func show_dead():
	$IdleSprite.hide()
	$AttackSprite.hide()
	$WalkSprite.hide()
	$DeadSprite.show()
	$CollisionShape2D.disabled = true
	$PlayerDetect/CollisionShape2D.disabled = true
	$KillDetector/CollisionShape2D.disabled = true
	$Dammage/CollisionShape2D.disabled = true
	$HealthBar.hide()

func _health():
	$HealthBar.value = health
	health = $HealthBar.value
	if health == 0:
		states = "Dead"


func die():
	queue_free()




