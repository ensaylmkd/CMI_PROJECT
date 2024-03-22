extends RigidBody2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func target(t):
	var direction = (t.global_position - self.global_position)
	var angle = self.transform.x.angle_to(direction)
	self.rotate(sign(angle)*min(0.17*10, abs(angle))) # delta ~= 0.17

#func reset_rotation(default_rotation):
#	self.rotation = default_rotation
