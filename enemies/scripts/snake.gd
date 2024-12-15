extends Node2D
class_name Snake

@export var num_segments: int
@export var segment_distance : float
@export var scale_curve : Curve

@export var head_texture : Texture2D
@export var body_texture : Texture2D
@export var tail_texture : Texture2D


@onready var head : Segment = $Head
@onready var health_component : HealthComponent = $HealthComponent
@onready var nav_agent : NavigationAgent2D = $Head/NavigationAgent2D
@onready var body : Node2D = $Body

@export var lerp_speed : float

var segments : Array[Segment]
var segment_scene = preload("res://enemies/segment.tscn")

func _ready():
	#help nav agent avoid other nav agents
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	
	#init head
	head.hurtbox.health_component = health_component
	head.sprite.texture = head_texture
	health_component.sprites.append(head.sprite)
	
	#init segments
	for i in num_segments:
		var segment : Segment = segment_scene.instantiate()
		segments.append(segment)
		body.add_child(segment)
		
		#segment texture
		if i == num_segments-1: segment.sprite.texture = tail_texture
		else: segment.sprite.texture = body_texture
		
		#segment health
		segment.hurtbox.health_component = health_component
		health_component.sprites.append(segment.sprite)
		
		#segment distances + positions
		segment.scale *= scale_curve.sample_baked(i/float(num_segments))
		var ahead : Node2D
		if i == 0: ahead = head 
		else: ahead = segments[i-1]
		var scaled_distance = segment_distance*scale_curve.sample_baked(i/float(num_segments))
		segment.position = ahead.position + Vector2(1,1) * scaled_distance
		
func _on_velocity_computed(safe_velocity):
	head.velocity = head.velocity.move_toward(safe_velocity, $StateMachine/Wandering.speed)
	head.move_and_slide()

func _process(_delta):
	#head rotation animation
	if nav_agent.velocity: head.global_rotation = lerp_angle(head.global_rotation, head.velocity.angle(), lerp_speed)
	else: head.global_rotation = segments[0].position.angle_to_point(head.position)
	#segment rotation animation
	for i in num_segments:
		var segment = segments[i]
		var ahead : Node2D
		if i == 0: ahead = head 
		else: ahead = segments[i-1]
		segment.global_rotation = lerp_angle(segment.global_rotation, segment.position.angle_to_point(ahead.position), 1)
		var scaled_distance = segment_distance*scale_curve.sample_baked(i/float(num_segments))
		segment.position = ahead.position - (segment.position.direction_to(ahead.position) * scaled_distance)
