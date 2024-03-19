extends Node

enum SOUND{
	BEEP,
	PEEP,
	PLOP,
	POP,
}


var SOUNDS = {
	SOUND.BEEP : preload("res://assets/soundeffects/ping_pong_8bit_beeep.ogg"),
	SOUND.PEEP : preload("res://assets/soundeffects/ping_pong_8bit_peeeeeep.ogg"),
	SOUND.PLOP : preload("res://assets/soundeffects/ping_pong_8bit_plop.ogg"),
	SOUND.POP : preload("res://assets/soundeffects/pop.ogg"),
}


func play_clip(player: AudioStreamPlayer2D, clip_key: SOUND):
	if not SOUNDS.has(clip_key):
		return
	player.stream = SOUNDS[clip_key]
	player.play()
