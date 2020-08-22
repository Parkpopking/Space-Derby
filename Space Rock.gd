extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vel = Vector2(0, 0)
var init_speed
var init_angle
onready var rock = load("res://Space Rock.tscn")

func _ready():
	scale = scale.normalized()
	scale *= rand_range(1, 4)
	init_speed = rand_range(10, 20)
	init_angle = rand_range(0, 360)
	vel = Vector2(cos(init_angle)*init_speed, sin(init_angle)*init_speed)

func _physics_process(delta):
	rotate(vel.length() * PI / 720)
	var collision = move_and_collide(vel*delta)
	if collision:
		var reflect = collision.remainder.reflect(collision.normal)
		vel = vel.bounce(collision.normal)
		move_and_collide(reflect)
		if (collision.collider_velocity - vel).length() > 4:
			split()

func split():
	if scale.length() > 1:
		for i in range(1, 2):
			var offset = Vector2(cos(i * PI / 4), sin(i * PI / 4))
			var child = rock.instance()
			child.scale = scale/4
			child.position = position + offset * scale
			child.vel = vel + offset
			get_parent().add_child(child)
	get_parent().remove_child(self)




