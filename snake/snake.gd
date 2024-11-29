extends CharacterBody2D
class_name Snake

@export var num_segments: int
@export var segment_distance : float
@onready var health_component : HealthComponent = $HealthComponent
var segments : Array[SnakeSegment]
var segment_scene = preload("res://snake/snake_segment.tscn")

func _ready():
	for i in num_segments:
		var segment : SnakeSegment = segment_scene.instantiate()
		add_child(segment)
		segment.position = Vector2((i+1) * 50, (i+1) * 50) 
		segment.hurtbox.health_component = health_component
