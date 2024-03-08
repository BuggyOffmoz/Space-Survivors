extends Node2D

var old_node_pol : CollisionPolygon2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if old_node_pol != null:
		old_node_pol.queue_free()
	
	$Line2D.set_point_position(1,get_global_mouse_position()) 
	
	
	var li : Line2D = $Line2D
	var line_poly = Geometry2D.offset_polyline(li.points,li.width/2)

	for po in line_poly:
		var new_poly : CollisionPolygon2D = CollisionPolygon2D.new()
		new_poly.polygon = po
		old_node_pol = new_poly
		add_child(new_poly)
	
