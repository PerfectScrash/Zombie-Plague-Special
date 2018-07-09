#include <amxmodx>
#include <amxmisc>
#include <fakemeta>
#include <zombie_plague_special>
#include <hamsandwich>
#include <fakemeta_util>

#define PLUGIN "Nowy Plugin"
#define VERSION "1.0"
#define AUTHOR "F1xed"

new const NADE_TYPE_ANTIDOTEBOMB = 6969
new const Float:RADIUS = 200.0
new const sprite_grenade_trail[] = "sprites/laserbeam.spr"
new const sprite_grenade_ring[] = "sprites/shockwave.spr"
new const model_grenade_infect[] = "models/zombie_plague/v_holybomb.mdl"

new has_bomb[33]
new cvar_enabled, cvar_fragsinfect, cvar_ammoinfect, cvar_humanbonushp, cvar_flaregrenades
new g_trailSpr, g_exploSpr, g_msgScoreInfo, g_msgDeathMsg, g_msgScoreAttrib

public plugin_init() 
{
	register_plugin(PLUGIN, VERSION, AUTHOR)
	
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	
	register_forward(FM_SetModel, "fw_SetModel")   
	
	register_message(get_user_msgid("CurWeapon"), "message_cur_weapon")
	
	cvar_enabled = register_cvar("zp_antidote_bomb","1")
	cvar_fragsinfect = get_cvar_pointer("zp_zombie_frags_for_infect")
	cvar_ammoinfect = get_cvar_pointer("zp_zombie_infect_reward")
	cvar_humanbonushp = register_cvar("zp_antidote_bomb_extra_hp","60")   
	cvar_flaregrenades = get_cvar_pointer("zp_flare_grenades")
	
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	g_msgScoreAttrib = get_user_msgid("ScoreAttrib")
}

public plugin_precache()
{
	g_trailSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_trail)
	g_exploSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_ring)
	
	engfunc(EngFunc_PrecacheModel, model_grenade_infect)
}

public client_disconnect(id)
{
	has_bomb[id] = 0
}

public zp_user_humanized_pre(player, padre)
{
	if(zp_get_user_padre(player) && get_pcvar_num(cvar_enabled))
	{
		has_bomb[player] = 1   
		fm_strip_user_gun(player,9)
		fm_give_item(player,"weapon_smokegrenade")
	}
}

public zp_user_humanized_post(player, padre)
{
	if(zp_get_user_padre(player) && get_pcvar_num(cvar_enabled))
	{
		has_bomb[player] = 1   
		fm_strip_user_gun(player,9)
		fm_give_item(player,"weapon_smokegrenade")
	}
}

public fw_PlayerKilled(victim, attacker, shouldgib) has_bomb[victim] = 0;

public fw_ThinkGrenade(entity)
{   
	if(!pev_valid(entity)) return HAM_IGNORED;
	
	static Float:dmgtime; pev(entity, pev_dmgtime, dmgtime)
	
	if (dmgtime > get_gametime()) return HAM_IGNORED;
	
	if(pev(entity, pev_flTimeStepSound) == NADE_TYPE_ANTIDOTEBOMB) antidote_explode(entity);
	
	return HAM_SUPERCEDE
}

public fw_SetModel(entity, const model[])
{
	if(!get_pcvar_num(cvar_enabled)) return   
	
	static Float:dmgtime; pev(entity, pev_dmgtime, dmgtime)
	
	if (dmgtime == 0.0) return;
	
	if (equal(model[7], "w_sm", 4))
	{      
		new owner = pev(entity, pev_owner)      
		
		if(!zp_get_user_zombie(owner) && has_bomb[owner]) 
		{
			set_pcvar_num(cvar_flaregrenades,0)         
			
			fm_set_rendering(entity, kRenderFxGlowShell, 255, 128, 0, kRenderNormal, 16)
			
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
			write_byte(TE_BEAMFOLLOW) // TE id
			write_short(entity) // entity
			write_short(g_trailSpr) // sprite
			write_byte(10) // life
			write_byte(10) // width
			write_byte(100) // red
			write_byte(100) // green
			write_byte(255) // blue
			write_byte(200) // brightness
			message_end()
			
			set_pev(entity, pev_flTimeStepSound, NADE_TYPE_ANTIDOTEBOMB)
		}
	}
	
}


public antidote_explode(ent)
{
	if (!zp_has_round_started()) return
	
	set_pcvar_num(cvar_flaregrenades,1)
	
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	create_blast(originF)   
	
	static attacker
	attacker = pev(ent, pev_owner)
	
	has_bomb[attacker] = 0
	
	static victim
	victim = -1
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, RADIUS)) != 0)
	{
		if (!is_user_alive(victim) || !zp_get_user_zombie(victim) || zp_get_user_nemesis(victim) || zp_get_user_first_zombie(victim) || zp_get_user_last_zombie(victim))
			continue
		
		SendDeathMsg(attacker, victim)
		FixDeadAttrib(victim)
		UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragsinfect), 1, 1)
		zp_disinfect_user(victim)
		zp_set_user_ammo_packs(attacker,zp_get_user_ammo_packs(attacker) + get_pcvar_num(cvar_ammoinfect))
		fm_set_user_health(attacker, pev(attacker, pev_health)+get_pcvar_num(cvar_humanbonushp))
		
	}
	
	engfunc(EngFunc_RemoveEntity, ent)
}

public create_blast(const Float:originF[3])
{
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+385.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(100) // red
	write_byte(100) // green
	write_byte(255) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+470.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(100) // red
	write_byte(100) // green
	write_byte(255) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_BEAMCYLINDER) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	engfunc(EngFunc_WriteCoord, originF[0]) // x axis
	engfunc(EngFunc_WriteCoord, originF[1]) // y axis
	engfunc(EngFunc_WriteCoord, originF[2]+555.0) // z axis
	write_short(g_exploSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(4) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(100) // red
	write_byte(100) // green
	write_byte(255) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

public UpdateFrags(attacker, victim, frags, deaths, scoreboard)
{
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) + frags))
	
	fm_set_user_deaths(victim, fm_get_user_deaths(victim) + deaths)
	
	if (scoreboard)
	{   
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(attacker) // id
		write_short(pev(attacker, pev_frags)) // frags
		write_short(fm_get_user_deaths(attacker)) // deaths
		write_short(0) // class?
		write_short(fm_get_user_team(attacker)) // team
		message_end()
		
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(victim) // id
		write_short(pev(victim, pev_frags)) // frags
		write_short(fm_get_user_deaths(victim)) // deaths
		write_short(0) // class?
		write_short(fm_get_user_team(victim)) // team
		message_end()
	}
}

stock fm_set_user_deaths(id, value)
	set_pdata_int(id, 444, value, 5)

stock fm_get_user_deaths(id)
	return get_pdata_int(id, 444, 5)



stock fm_get_user_team(id)
	return get_pdata_int(id, 114, 5)


public SendDeathMsg(attacker, victim)
{
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
	write_byte(attacker) // killer
	write_byte(victim) // victim
	write_byte(1) // headshot flag
	write_string("grenade") // killer's weapon
	message_end()
}

public FixDeadAttrib(id)
{
	message_begin(MSG_BROADCAST, g_msgScoreAttrib)
	write_byte(id) // id
	write_byte(0) // attrib
	message_end()
}

public replace_models(id)
{
	if (!is_user_alive(id)) return;
	
	if(get_user_weapon(id) == CSW_SMOKEGRENADE && has_bomb[id]) set_pev(id, pev_viewmodel2, model_grenade_infect);
	
}

public message_cur_weapon(msg_id, msg_dest, msg_entity)  replace_models(msg_entity);

