extends CharacterBody2D

@onready var anim_tree := $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")

@export var move_speed : float = 125.0

var starting_direction := Vector2.DOWN


func _ready() -> void:
	update_antimation(starting_direction)


func _physics_process(delta: float) -> void:
	var input_direction := Vector2.ZERO
	input_direction.x = Input.get_axis("move_left", "move_right")
	input_direction.y = Input.get_axis("move_up", "move_down")
	if input_direction.length() > 1.0:
		input_direction = input_direction.normalized()
		
	# Update animation based on input
	update_antimation(input_direction)
	
	velocity = input_direction * move_speed
	
	pick_new_state()
	
	move_and_slide()


func update_antimation(move_input : Vector2) -> void:
	# don't change animation if there is no input.
	if move_input != Vector2.ZERO:
		anim_tree.set("parameters/walk/blend_position", move_input)
		anim_tree.set("parameters/idle/blend_position", move_input)


func pick_new_state() -> void:
	if velocity != Vector2.ZERO:
		state_machine.travel("walk")
	else:
		state_machine.travel("idle")
