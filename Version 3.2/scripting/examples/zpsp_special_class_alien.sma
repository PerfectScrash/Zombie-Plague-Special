/* 
	Custom Zombie Special Class Example 
	
	See The Code for creating more specials zombies with powers 
*/


#include <amxmodx>
#include <hamsandwich>
#include <zombie_plague_special>
#include <amx_settings_api>

#if ZPS_INC_VERSION < 30
	#assert Zombie Plague Special 3.0 or Higher Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

new const ZP_CUSTOMIZATION_FILE[] = "zombie_plague_special.ini"

new Array:g_sound_alien, g_ambience_sounds, Array:g_sound_amb_alien_dur, Array: g_sound_ambience_alien

// Default Sounds
new const sound_alien[][] = { "zombie_plague/nemesis1.wav" }
new const ambience_alien_sound[][] = { "zombie_plague/ambience.wav" } 
new const ambience_alien_dur[][] = { "17" }

new const sp_name[] = "Alien"
new const sp_model[] = "zombie_source"
new const sp_knifemodel[] = "models/zombie_plague/v_knife_zombie.mdl"
new const sp_painsound[] = "zombie_plague/nemesis_pain1.wav"
new const sp_hp = 50000
new const sp_speed = 300
new const Float:sp_gravity = 0.5
new const sp_aura_size = 25
new const Float:sp_knockback = 0.25
new const sp_allow_glow = 1
new const sp_color_r =  255
new const sp_color_g = 0
new const sp_color_b = 0
new acess_flags[2]

// Variables
new g_gameid, g_msg_sync, cvar_minplayers, cvar_alien_damage, g_speciald
new const g_chance = 50

// Ambience sounds task
#define TASK_AMB 3256

public plugin_init()
{
	// Plugin registeration.
	register_plugin("[ZP] Class Alien","1.0", "[P]erfec[T] [S]cr[@]s[H]")
	
	cvar_minplayers = register_cvar("zp_alien_minplayers", "2")
	cvar_alien_damage = register_cvar("zp_alien_damage", "500")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	
	g_msg_sync = CreateHudSyncObj()
}


// Game modes MUST be registered in plugin precache ONLY
public plugin_precache()
{
	// Read the access flag
	new user_access[40]
	if(!amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE ALIEN", user_access, charsmax(user_access)))
	{
		amx_save_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE ALIEN", "a")
		formatex(user_access, charsmax(user_access), "a")
	}
	
	acess_flags[0] = read_flags(user_access)
	
	if(!amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE ALIEN", user_access, charsmax(user_access)))
	{
		amx_save_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE ALIEN", "a")
		formatex(user_access, charsmax(user_access), "a")
	}
	
	acess_flags[1] = read_flags(user_access)
	new i
	
	g_sound_alien = ArrayCreate(64, 1)
	g_sound_ambience_alien = ArrayCreate(64, 1)
	g_sound_amb_alien_dur = ArrayCreate(64, 1)
	
	// Load from external file
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND ALIEN", g_sound_alien)
	
	// Precache the play sounds
	if (ArraySize(g_sound_alien) == 0)
	{
		for (i = 0; i < sizeof g_sound_alien; i++)
			ArrayPushString(g_sound_alien, sound_alien[i])
		
		// Save to external file
		amx_save_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND ALIEN", g_sound_alien)
	}
	
	// Precache sounds
	new sound[100]
	for (i = 0; i < ArraySize(g_sound_alien); i++)
	{
		ArrayGetString(g_sound_alien, i, sound, charsmax(sound))
		if (equal(sound[strlen(sound)-4], ".mp3"))
		{
			format(sound, charsmax(sound), "sound/%s", sound)
			precache_generic(sound)
		}
		else precache_sound(sound)
	}
	
	// Ambience Sounds
	g_ambience_sounds = 0
	if(!amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN ENABLE", g_ambience_sounds))
		amx_save_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN ENABLE", g_ambience_sounds)
	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN SOUNDS", g_sound_ambience_alien)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN DURATIONS", g_sound_amb_alien_dur)
	
	
	// Save to external file
	if (ArraySize(g_sound_ambience_alien) == 0)
	{
		for (i = 0; i < sizeof ambience_alien_sound; i++)
			ArrayPushString(g_sound_ambience_alien, ambience_alien_sound[i])
		
		amx_save_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN SOUNDS", g_sound_ambience_alien)
	}
	
	if (ArraySize(g_sound_amb_alien_dur) == 0)
	{
		for (i = 0; i < sizeof g_sound_amb_alien_dur; i++)
			ArrayPushString(g_sound_amb_alien_dur, ambience_alien_dur[i])
		
		amx_save_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ALIEN DURATIONS", g_sound_amb_alien_dur)
	}
	
	// Ambience Sounds
	new buffer[250]
	if (g_ambience_sounds) {
		for (i = 0; i < ArraySize(g_sound_ambience_alien); i++) {
			ArrayGetString(g_sound_ambience_alien, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3")) {
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				precache_generic(buffer)
			}
			else precache_sound(buffer)
		}
	}
	
	// Register Special Class and Game mod
	g_gameid = zp_register_game_mode(sp_name, acess_flags[0], g_chance, 0, 0)
	g_speciald = zp_register_zombie_special(sp_name, sp_model, sp_knifemodel, sp_painsound, sp_hp, sp_speed, sp_gravity, acess_flags[1], sp_knockback, sp_aura_size, sp_allow_glow, sp_color_r, sp_color_g, sp_color_b)
}

public plugin_natives()
{
	// Register Natives
	register_native("zp_get_user_alien", "native_get_user_alien", 1)
	register_native("zp_make_user_alien", "native_make_user_alien", 1)
	register_native("zp_get_alien_count", "native_get_alien_count", 1)
	register_native("zp_is_alien_round", "native_is_alien_round", 1)
}

// Block Showing Extra Itens
public zp_extra_item_selected_pre(id, itemid) {
	if(zp_get_zombie_special_class(id) == g_speciald)
		return ZP_PLUGIN_SUPERCEDE
	
	return PLUGIN_CONTINUE
}

// Attack Damage
public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	if(inflictor == attacker && zp_get_zombie_special_class(attacker) == g_speciald)
		SetHamParamFloat(4, get_pcvar_float(cvar_alien_damage))
}

// Player spawn post
public zp_player_spawn_post(id)
{
	// Check for current mode
	if(zp_get_current_mode() == g_gameid)
		zp_disinfect_user(id)
}

public zp_round_started_pre(game)
{
	// Check if it is our game mode
	if(game == g_gameid)
	{
		// Check for min players
		if(zp_get_alive_players() < get_pcvar_num(cvar_minplayers))
			return ZP_PLUGIN_HANDLED

		// Start our new mode
		start_alien_mode()
	}
	return PLUGIN_CONTINUE
}

public zp_round_started(game, id)
{
	// Check if it is our game mode
	if(game == g_gameid)
	{
		// Play the starting sound
		new sound[100]
		ArrayGetString(g_sound_alien, random_num(0, ArraySize(g_sound_alien) - 1), sound, charsmax(sound))
		PlaySoundToClients(sound)
		
		// Remove ambience task affects
		remove_task(TASK_AMB)
		
		// Set task to start ambience sounds
		set_task(2.0, "start_ambience_sounds", TASK_AMB)
	}
}

// Plays a sound on clients
PlaySoundToClients(const sound[])
{
	if (equal(sound[strlen(sound)-4], ".mp3"))
		client_cmd(0, "mp3 play ^"sound/%s^"", sound)
	else
		client_cmd(0, "spk ^"%s^"", sound)
}

public zp_game_mode_selected(gameid, id)
{
	// Check if our game mode was called
	if(gameid == g_gameid)
		start_alien_mode()
	
	// Make the compiler happy again =)
	return PLUGIN_CONTINUE
}

// This function contains the whole code behind this game mode
start_alien_mode()
{
	new id, i,  has_alien
	has_alien = false
	for (i = 1; i <= get_maxplayers(); i++) {
		if(zp_get_zombie_special_class(i) == g_speciald) {
			id = i						// Get Alien Index
			has_alien = true
		}
	}

	if(!has_alien) {
		id = zp_get_random_alive()
		zp_make_user_special(id, g_speciald, 1)
	}
	
	new name[32]; get_user_name(id, name, 31);
	set_hudmessage(sp_color_r, sp_color_g, sp_color_b, -1.0, 0.17, 1, 0.0, 5.0, 1.0, 1.0, -1)
	ShowSyncHudMsg(0, g_msg_sync, "%s is an %s", name, sp_name)
		
	// Turn the remaining players into zombies
	for (id = 1; id <= get_maxplayers(); id++)
	{
		// Not alive
		if(!is_user_alive(id))
			continue;
			
		ScreenFade(id, 5, sp_color_r, sp_color_g, sp_color_b, 255)
	}

}

public start_ambience_sounds()
{
	if (!g_ambience_sounds)
		return;
	
	// Variables
	static amb_sound[64], sound,  str_dur[20]
	
	// Select our ambience sound
	sound = random_num(0, ArraySize(g_sound_ambience_alien)-1)

	ArrayGetString(g_sound_ambience_alien, sound, amb_sound, charsmax(amb_sound))
	ArrayGetString(g_sound_amb_alien_dur, sound, str_dur, charsmax(str_dur))
	
	PlaySoundToClients(amb_sound)
	
	// Start the ambience sounds
	set_task(str_to_float(str_dur), "start_ambience_sounds", TASK_AMB)
}
public zp_round_ended() {
	remove_task(TASK_AMB)
}

public zp_user_infected_post(id)
{
	if(zp_get_zombie_special_class(id) == g_speciald) 
	{
		if(!zp_has_round_started())
			zp_set_custom_game_mod(g_gameid)	// Force Start Alien Round
	}
}

stock client_printcolor(const id,const input[], any:...)
{
	new msg[191], players[32], count = 1; vformat(msg,190,input,3);
	replace_all(msg,190,"!g","^4");    // green
	replace_all(msg,190,"!y","^1");    // normal
	replace_all(msg,190,"!t","^3");    // team
	
	if (id) players[0] = id; else get_players(players,count,"ch");
	
	for (new i=0;i<count;i++)
	{
		if (is_user_connected(players[i]))
		{
			message_begin(MSG_ONE_UNRELIABLE,get_user_msgid("SayText"),_,players[i]);
			write_byte(players[i]);
			write_string(msg);
			message_end();
		}
	}
} 

stock zp_get_random_alive()
{
	static players[32],num,id
	get_players(players, num, "a")
	id = players[random(num)]
	
	return id
}

stock ScreenFade(id, Timer, r, g ,b, Alpha) 
{	
	if(!is_user_connected(id)) return;
	
	message_begin(MSG_ONE_UNRELIABLE, get_user_msgid("ScreenFade"), _, id);
	write_short((1<<12) * Timer)
	write_short(1<<12)
	write_short(0)
	write_byte(r)
	write_byte(g)
	write_byte(b)
	write_byte(Alpha)
	message_end()
}


public native_get_user_alien(id)
	return (zp_get_zombie_special_class(id) == g_speciald)
	
public native_make_user_alien(id)
	return (zp_make_user_special(id, g_speciald, 1))
	
public native_get_alien_count()
	return zp_get_special_count(1, g_speciald)
	
public native_is_alien_round()
	return (zp_get_current_mode() == g_gameid)
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1046\\ f0\\ fs16 \n\\ par }
*/
