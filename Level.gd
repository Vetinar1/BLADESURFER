extends Node2D

var live_pieces = []
var pieces

func _ready():
	# load level pieces
	var sp1 = preload("res://StraightPiece1.tscn")
	var sp2 = preload("res://StraightPiece2.tscn")
	var lp1 = preload("res://LongPiece1.tscn")
	var wp1 = preload("res://WidePiece1.tscn")
	var zp1 = preload("res://Zpiece1.tscn")
	
	pieces = [sp1, sp2, lp1, wp1,  zp1]
	
	# load first
	pieces.shuffle()
	
	live_pieces.append(pieces[0].instance())
	add_child(live_pieces[0])
	
	
	
func load_new():
	pieces.shuffle()
		
	live_pieces.append(pieces[0].instance())
	live_pieces[-1].position += live_pieces[-2].get_node("Exit").position + live_pieces[-2].position
	call_deferred("add_child", live_pieces[-1])
	

func unload_old():
	if len(live_pieces) > 4:
		live_pieces[0].queue_free()
		live_pieces.remove(0)
	
