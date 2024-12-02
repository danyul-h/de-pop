extends Node2D
class_name Snake

@export var num_segments: int
@export var segment_distance : float

@onready var head : Node2D = $Head
@onready var health_component : HealthComponent = $HealthComponent
var segments : Array[SnakeSegment]
var segment_scene = preload("res://snake/snake_segment.tscn")

func _ready():
	for i in num_segments:
		var segment : SnakeSegment = segment_scene.instantiate()
		segments.append(segment)
		add_child(segment)
		segment.position = Vector2((i+1) * segment_distance, (i+1) * segment_distance) 
		segment.hurtbox.health_component = health_component

func _process(delta):
	head.global_position = get_global_mouse_position()
	for i in num_segments:
		var segment = segments[i]
		var ahead : Node2D
		if i == 0: ahead = head 
		else: ahead = segments[i-1]
		segment.position = ahead.position - (segment.position.direction_to(ahead.position) * segment_distance)
		segment.look_at(ahead.position)
