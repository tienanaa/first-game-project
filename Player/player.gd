extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
@onready var anim=get_node("Container/AnimatedSprite2D")
@onready var container=get_node("Container")

func _physics_process(delta: float) -> void:
	# Add the gravity - Roi do trong luc.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction == 1 or direction==-1:
		velocity.x = direction * SPEED
		container.scale.x=direction	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Xu ly chuyen dong
	if not is_on_floor():
		anim.play("Jump")
	elif direction == 1 or direction==-1:
		anim.play("Run")
	else: 
		anim.play("Idle")
	move_and_slide()
