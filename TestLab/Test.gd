extends Node2D



var start_p := false
var players : Array[String]
var player_games := ["Driver","Killer"]

func _input(event):
	
	if event is InputEventKey and event.is_released():
		if event.is_action_released("Enter") and players.size() < 2:
			if not players.has("Keyboard"):
				players.append("Keyboard")
				$CanvasLayer/MainMenu/RichTextLabel.add_text("\nPlayer "+"Keyboard"+" is a "+player_games[players.find("Keyboard")])
	if event is InputEventJoypadButton and event.is_released():
		
		if event.button_index == 6 and players.size() < 2:
			if not players.has(str(event.device)):
				players.append(str(event.device))
				$CanvasLayer/MainMenu/RichTextLabel.add_text("\nPlayer "+str(event.device)+" is a "+player_games[players.find(str(event.device))])
		


func _on_start_pressed():
	$Players/BaseShip.assigned_device = players[0]
	#$Players/BaseTurret.assigned_device = players[0]
	%Players.visible = true
	#$EnemySpawner.active = true
	$EnemySpawner.spawn_enemy()
	$CanvasLayer/MainMenu.visible = false

