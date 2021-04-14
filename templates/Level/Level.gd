extends Node2D


onready var left_wall := $LeftWall
onready var foreground := $ForegroundObjects
onready var player := foreground.get_node("Player")
onready var gui := $GUI
onready var spawn_tiles := $SpawnTiles

var Coin = preload("res://objects/Coin/Coin.tscn")
var CoinBag = preload("res://objects/CoinBag/CoinBag.tscn")
var Diamond = preload("res://objects/Diamond/Diamond.tscn")
var Food = preload("res://objects/Food/Food.tscn")


func _physics_process(_delta):
	left_wall.position.x = foreground.get_node("Player/Camera2D").limit_left


func _ready():
	if G.hp <= 0:
		G.hp = int(G.hp_max / 2)
		player.emit_changed_stats()
	
	for tile_pos in spawn_tiles.get_used_cells():
		var node
		
		if spawn_tiles.get_cellv(tile_pos) == Pickup.TYPES.COIN:
			node = Coin.instance()
		elif spawn_tiles.get_cellv(tile_pos) == Pickup.TYPES.COIN_BAG:
			node = CoinBag.instance()
		elif spawn_tiles.get_cellv(tile_pos) == Pickup.TYPES.DIAMOND:
			node = Diamond.instance()
		elif spawn_tiles.get_cellv(tile_pos) == Pickup.TYPES.LEEK: # food
			node = Food.instance()
		
		
		node.position = spawn_tiles.map_to_world(tile_pos) + Vector2(8, 8)
		foreground.add_child(node)
		spawn_tiles.set_cellv(tile_pos, -1)
