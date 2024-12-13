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
	nav_agent.velocity_computed.connect(_on_velocity_computed)
	head.hurtbox.health_component = health_component
	head.sprite.texture = head_texture
	health_component.sprites.append(head.sprite)
	for i in num_segments:
		var segment : Segment = segment_scene.instantiate()
		segments.append(segment)
		body.add_child(segment)
		if i == num_segments-1: segment.sprite.texture = tail_texture
		else: segment.sprite.texture = body_texture
		segment.hurtbox.health_component = health_component
		health_component.sprites.append(segment.sprite)
		segment.scale *= scale_curve.sample_baked(i/float(num_segments))
		
func _on_velocity_computed(safe_velocity):
	head.velocity = head.velocity.move_toward(safe_velocity, $StateMachine/Wandering.speed)
	head.move_and_slide()

func _process(_delta):
	head.global_rotation = lerp_angle(head.global_rotation, head.velocity.angle(), lerp_speed)
	for i in num_segments:
		var segment = segments[i]
		var ahead : Node2D
		if i == 0: ahead = head 
		else: ahead = segments[i-1]
		segment.global_rotation = lerp_angle(segment.global_rotation, segment.position.angle_to_point(ahead.position), 1)
		var scaled_distance = segment_distance*scale_curve.sample_baked(i/float(num_segments))
		segment.position = ahead.position - (segment.position.direction_to(ahead.position) * scaled_distance)
	#queue_redraw()
#
#@onready var wandering = $StateMachine/Wandering
#
#func make_path():
	#var theta = wandering.view_curve.sample_baked(randf()) + nav_agent.velocity.angle() - wandering.view_curve.max_value / 2
	#var r = sqrt(randf()) * wandering.dist_range + wandering.dist_min
	#return head.position + Vector2(r*cos(theta), r*sin(theta))
#
#func _draw():
	#for i in 10:
		#draw_circle(make_path(), 10, Color.WHITE)
