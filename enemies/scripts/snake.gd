extends Node2D
class_name Snake

@export var num_segments: int
@export var segment_distance : float

@export var head_texture : Texture2D
@export var body_texture : Texture2D
@export var tail_texture : Texture2D

@onready var head : Segment = $Head
@onready var health_component : HealthComponent = $HealthComponent
@onready var nav_agent : NavigationAgent2D = $Head/NavigationAgent2D

@export var lerp_speed : float

var segments : Array[Segment]
var segment_scene = preload("res://enemies/segment.tscn")

func _ready():
	head.hurtbox.health_component = health_component
	head.sprite.texture = head_texture
	health_component.sprites.append(head.sprite)
	for i in num_segments:
		var segment : Segment = segment_scene.instantiate()
		segments.append(segment)
		add_child(segment)
		if i == num_segments-1: segment.sprite.texture = tail_texture
		else: segment.sprite.texture = body_texture
		segment.position = Vector2((i+1) * segment_distance, (i+1) * segment_distance)
		segment.hurtbox.health_component = health_component
		health_component.sprites.append(segment.sprite)

func _process(_delta):
	head.transform = head.transform.interpolate_with(head.transform.looking_at(head.position+nav_agent.velocity), lerp_speed)
	for i in num_segments:
		var segment = segments[i]
		var ahead : Node2D
		if i == 0: ahead = head 
		else: ahead = segments[i-1]
		segment.transform = segment.transform.interpolate_with(segment.transform.looking_at(ahead.position), lerp_speed)
		segment.position = ahead.position - (segment.position.direction_to(ahead.position) * segment_distance)
