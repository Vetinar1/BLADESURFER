extends Node2D

var live_pieces = []
var pieces

var count = 0

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
	print("loading", count)
	count += 1
	print(pieces)
	pieces.shuffle()
	print(pieces)
	#live_pieces.append()
	var new_piece = pieces[0].instance()
	new_piece.name = "piece" + str(count)
	print("live", live_pieces)
	call_deferred("add_child", new_piece)
	live_pieces.append(new_piece)
	live_pieces[-1].position += live_pieces[-2].get_node("Exit").position + live_pieces[-2].position
	
	print(live_pieces[-1].position, $Spaceship.position)
	

func unload_old():
	print("unloading")
	print(live_pieces)
	if len(live_pieces) > 4:
		live_pieces[0].queue_free()
		print("-",live_pieces)
		live_pieces.remove(0)
		print("--",live_pieces)
	
