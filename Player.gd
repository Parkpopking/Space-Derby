extends KinematicBody2D
export (int, 0, 200) var push = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(0, 0)
var speed = 100
var angle = 0
var turn_speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func input():
	if Input.is_action_pressed("Left"):
		angle -= sin(turn_speed * PI / 360)
	if Input.is_action_pressed("Right"):
		angle += sin(turn_speed * PI / 360)
	if Input.is_action_pressed("Forward") or Input.is_action_pressed("Back"):
		vel += Vector2(0, -speed*(Input.get_action_strength("Forward") - Input.get_action_strength("Back"))).rotated(angle)
	if position.y + vel.y <= -500:
		vel = vel.slide(Vector2(0, 1))
	elif position.y + vel.y >= 500:
		vel = vel.slide(Vector2(0, -1))
	if position.x + vel.x <= -750:
		vel = vel.slide(Vector2(1, 0))
	elif position.x + vel.x >= 750:
		vel = vel.slide(Vector2(-1, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input()
	vel = vel.clamped(speed)
	get_node("AnimatedSprite").rotation = angle
	vel = move_and_slide(vel)
#	pass
