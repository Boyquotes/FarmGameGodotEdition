extends CharacterBody2D

enum COW_STATE {
	IDLE,
	WALK,
	EAT_GRASS,
	SLEEP,
	LAYDOWN
}

@onready var anim_tree := $AnimationTree
@onready var state_machine = anim_tree.get("parameters/playback")

@export var move_speed : float = 35.0

var move_dir :Vector2 = Vector2.ZERO
var current_state : COW_STATE = COW_STATE.IDLE

func _ready() -> void:
	pass
	

func _physics_process(delta: float) -> void:
	velocity = move_dir * move_speed
	move_and_slide()


func select_new_direction() -> void:
	# Randomly generated move direction on both x and y axis
	move_dir = Vector2(randi_range(-1, 1), randi_range(-1, 1))
