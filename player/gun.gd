extends Node2D

@export var bullet_scene = preload("res://player/bullet.tscn")
@export var speed : float
@onready var muzzle = $Sprite2D/Marker2D

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		var bullet : Bullet = bullet_scene.instantiate()
		print(muzzle.global_position)
		bullet.speed = speed
		bullet.direction = muzzle.global_position.direction_to(get_global_mouse_position())
		add_sibling(bullet)
		bullet.global_position = muzzle.global_position
