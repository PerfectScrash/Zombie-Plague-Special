/*==================================================================
////////////////////////////////////////////////////////////////////
////////////////////// ZOMBIE PLAGUE SPECIAL //////////////////////
//////////////////////////////////////////////////////////////////
===============================================================*/
/**************************************************************/
/*                           [2015]                          */
/************************************************************/
/*================================================================================
 [Plugin Customization]
=================================================================================*/
new const ZP_CUSTOMIZATION_FILE[] = "zombie_plague_special.ini"

// Limiters for stuff not worth making dynamic arrays out of (increase if needed)
const MAX_CSDM_SPAWNS = 128
const MAX_STATS_SAVED = 64

/*================================================================================
 Customization ends here! Yes, that's it. Editing anything beyond
 here is not officially supported. Proceed at your own risk...
=================================================================================*/

#include <amxmodx>
#include <amxmisc>
#include <cstrike>
#include <fakemeta>
#include <hamsandwich>
#include <xs>

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/
new g_Mode
new const mode_names[][] =
{
	"T-Virus a Solta!",
	"Modo: Infection",
	"Modo: Nemesis",
	"Modo: Assasino",
	"Modo: Predator",
	"Modo: Bombardier",
	"Modo: Survivor",
	"Modo: Sniper",
	"Modo: Berserker",
	"Modo: Wesker",
	"Modo: Swarm",
	"Modo: Multi-Infection",
	"Modo: Plague",
	"Modo: Armagedom",
	"Modo: Indefinido"
}

// Access flags
enum
{
	ACCESS_ADMIN_MENU = 0,
	ACCESS_ADMIN_MENU2,
	ACCESS_ADMIN_MENU3,
	ACCESS_MODE_INFECTION,
	ACCESS_MODE_NEMESIS,
	ACCESS_MODE_SURVIVOR,
	ACCESS_MODE_SWARM,
	ACCESS_MODE_MULTI,
	ACCESS_MODE_PLAGUE,
	ACCESS_MAKE_ZOMBIE,
	ACCESS_MAKE_HUMAN,
	ACCESS_MAKE_NEMESIS,
	ACCESS_MAKE_SURVIVOR,
	ACCESS_RESPAWN_PLAYERS,
	ACCESS_ADMIN_MODELS,
	ACCESS_VIP_MODELS,
	ACCESS_MODE_SNIPER,
	ACCESS_MAKE_SNIPER,
	ACCESS_MODE_ASSASSIN,
	ACCESS_MAKE_ASSASSIN,
	ACCESS_MODE_BERSERKER,
	ACCESS_MAKE_BERSERKER,
	ACCESS_MODE_PREDATOR,
	ACCESS_MAKE_PREDATOR,
	ACCESS_MODE_WESKER,
	ACCESS_MAKE_WESKER,
	ACCESS_MODE_BOMBARDIER,
	ACCESS_MAKE_BOMBARDIER,
	ACCESS_MODE_LNJ,
	MAX_ACCESS_FLAGS
}

// Task offsets
enum (+= 100)
{
	TASK_MODEL = 2000,
	TASK_TEAM,
	TASK_SPAWN,
	TASK_BLOOD,
	TASK_AURA,
	TASK_BURN,
	TASK_NVISION,
	TASK_FLASH,
	TASK_CHARGE,
	TASK_SHOWHUD,
	TASK_MAKEZOMBIE,
	TASK_WELCOMEMSG,
	TASK_THUNDER_PRE,
	TASK_THUNDER,
	TASK_AMBIENCESOUNDS
}

// IDs inside tasks
#define ID_MODEL (taskid - TASK_MODEL)
#define ID_TEAM (taskid - TASK_TEAM)
#define ID_SPAWN (taskid - TASK_SPAWN)
#define ID_BLOOD (taskid - TASK_BLOOD)
#define ID_AURA (taskid - TASK_AURA)
#define ID_BURN (taskid - TASK_BURN)
#define ID_NVISION (taskid - TASK_NVISION)
#define ID_FLASH (taskid - TASK_FLASH)
#define ID_CHARGE (taskid - TASK_CHARGE)
#define ID_SHOWHUD (taskid - TASK_SHOWHUD)

// BP Ammo Refill task
#define REFILL_WEAPONID args[0]

// For weapon buy menu handlers
#define WPN_STARTID g_menu_data[id][1]
#define WPN_MAXIDS ArraySize(g_primary_items)
#define WPN_SELECTION (g_menu_data[id][1]+key)
#define WPN_AUTO_ON g_menu_data[id][2]
#define WPN_AUTO_PRI g_menu_data[id][3]
#define WPN_AUTO_SEC g_menu_data[id][4]

// For player list menu handlers
#define PL_ACTION g_menu_data[id][0]

// For extra items menu handlers
#define EXTRAS_CUSTOM_STARTID (EXTRA_WEAPONS_STARTID + ArraySize(g_extraweapon_names))

// Menu selections
const MENU_KEY_AUTOSELECT = 7
const MENU_KEY_BACK = 7
const MENU_KEY_NEXT = 8
const MENU_KEY_EXIT = 9

// Hard coded extra items
enum
{
	EXTRA_NVISION = 0,
	EXTRA_ANTIDOTE,
	EXTRA_MADNESS,
	EXTRA_INFBOMB,
	EXTRA_WEAPONS_STARTID
}

// Game mode settings
new const MODE_SET = 1

// Game modes
enum
{
	MODE_NONE = 0,
	MODE_INFECTION,
	MODE_NEMESIS,
	MODE_ASSASSIN,
	MODE_PREDATOR,
	MODE_BOMBARDIER,
	MODE_SURVIVOR,
	MODE_SNIPER,
	MODE_BERSERKER,
	MODE_WESKER,
	MODE_SWARM,
	MODE_MULTI,
	MODE_PLAGUE,
	MODE_LNJ,
	MAX_GAME_MODES
}

// ZP Teams
const ZP_TEAM_NO_ONE = 0
const ZP_TEAM_ANY = 0
const ZP_TEAM_ZOMBIE = (1<<0) 	// 1
const ZP_TEAM_HUMAN = (1<<1) 	// 2
const ZP_TEAM_NEMESIS = (1<<2)	// 4
const ZP_TEAM_SURVIVOR = (1<<3) // 8
const ZP_TEAM_SNIPER = (1<<4) 	// 16
const ZP_TEAM_ASSASSIN = (1<<5) // 32
const ZP_TEAM_BERSERKER = (1<<6)    // 64
const ZP_TEAM_PREDATOR = (1<<7) // 128
const ZP_TEAM_WESKER = (1<<8) // 256
const ZP_TEAM_BOMBARDIER = (1<<9) // 512

// Zombie classes
const ZCLASS_NONE = -1

// HUD messages
const Float:HUD_EVENT_X = -1.0
const Float:HUD_EVENT_Y = 0.17
const Float:HUD_INFECT_X = 0.05
const Float:HUD_INFECT_Y = 0.45
const Float:HUD_SPECT_X = -1.0
const Float:HUD_SPECT_Y = 0.8
const Float:HUD_STATS_X = 0.78
const Float:HUD_STATS_Y = 0.18

// CS Player PData Offsets (win32)
const OFFSET_PAINSHOCK = 108 // ConnorMcLeod
const OFFSET_CSTEAMS = 114
const OFFSET_CSMONEY = 115
const OFFSET_FLASHLIGHT_BATTERY = 244
const OFFSET_CSDEATHS = 444
const OFFSET_MODELINDEX = 491 // Orangutanz

// CS Player CBase Offsets (win32)
const OFFSET_ACTIVE_ITEM = 373

// CS Weapon CBase Offsets (win32)
const OFFSET_WEAPONOWNER = 41

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

// CS Teams
enum
{
	FM_CS_TEAM_UNASSIGNED = 0,
	FM_CS_TEAM_T,
	FM_CS_TEAM_CT,
	FM_CS_TEAM_SPECTATOR
}
new const CS_TEAM_NAMES[][] = { "UNASSIGNED", "TERRORIST", "CT", "SPECTATOR" }

// Some constants
const HIDE_MONEY = (1<<5)
const UNIT_SECOND = (1<<12)
const DMG_HEGRENADE = (1<<24)
const IMPULSE_FLASHLIGHT = 100
const USE_USING = 2
const USE_STOPPED = 0
const STEPTIME_SILENT = 999
const BREAK_GLASS = 0x01
const FFADE_IN = 0x0000
const FFADE_STAYOUT = 0x0004
const PEV_SPEC_TARGET = pev_iuser2

// Max BP ammo for weapons
new const MAXBPAMMO[] = { -1, 52, -1, 90, 1, 32, 1, 100, 90, 1, 120, 100, 100, 90, 90, 90, 100, 120, 30, 120, 200, 32, 90, 120, 90, 2, 35, 90, 90, -1, 100 }

// Max Clip for weapons
new const MAXCLIP[] = { -1, 13, -1, 10, -1, 7, -1, 30, 30, -1, 30, 20, 25, 30, 35, 25, 12, 20, 10, 30, 100, 8, 30, 30, 20, -1, 7, 30, 30, -1, 50 }

// Amount of ammo to give when buying additional clips for weapons
new const BUYAMMO[] = { -1, 13, -1, 30, -1, 8, -1, 12, 30, -1, 30, 50, 12, 30, 30, 30, 12, 30, 10, 30, 30, 8, 30, 30, 30, -1, 7, 30, 30, -1, 50 }

// Ammo IDs for weapons
new const AMMOID[] = { -1, 9, -1, 2, 12, 5, 14, 6, 4, 13, 10, 7, 6, 4, 4, 4, 6, 10, 1, 10, 3, 5, 4, 10, 2, 11, 8, 4, 2, -1, 7 }

// Ammo Type Names for weapons
new const AMMOTYPE[][] = { "", "357sig", "", "762nato", "", "buckshot", "", "45acp", "556nato", "", "9mm", "57mm", "45acp", "556nato", "556nato", "556nato", 
"45acp", "9mm", "338magnum", "9mm", "556natobox", "buckshot", "556nato", "9mm", "762nato", "", "50ae", "556nato", "762nato", "", "57mm" }

// Weapon IDs for ammo types
new const AMMOWEAPON[] = { 0, CSW_AWP, CSW_SCOUT, CSW_M249, CSW_AUG, CSW_XM1014, CSW_MAC10, CSW_FIVESEVEN, CSW_DEAGLE, CSW_P228, CSW_ELITE, CSW_FLASHBANG, CSW_HEGRENADE, CSW_SMOKEGRENADE, CSW_C4 }

// Primary and Secondary Weapon Names
new const WEAPONNAMES[][] = { "", "P228 Compact", "", "Schmidt Scout", "", "XM1014 M4", "", "Ingram MAC-10", "Steyr AUG A1", "", "Dual Elite Berettas", "FiveseveN", "UMP 45", 
"SG-550 Auto-Sniper", "IMI Galil", "Famas", "USP .45 ACP Tactical", "Glock 18C", "AWP Magnum Sniper", "MP5 Navy", "M249 Para Machinegun", "M3 Super 90", "M4A1 Carbine", 
"Schmidt TMP", "G3SG1 Auto-Sniper", "", "Desert Eagle .50 AE", "SG-552 Commando", "AK-47 Kalashnikov", "", "ES P90" }

// Weapon entity names
new const WEAPONENTNAMES[][] = { "", "weapon_p228", "", "weapon_scout", "weapon_hegrenade", "weapon_xm1014", "weapon_c4", "weapon_mac10", "weapon_aug", "weapon_smokegrenade", 
"weapon_elite", "weapon_fiveseven", "weapon_ump45", "weapon_sg550", "weapon_galil", "weapon_famas", "weapon_usp", "weapon_glock18", "weapon_awp", "weapon_mp5navy", "weapon_m249",
"weapon_m3", "weapon_m4a1", "weapon_tmp", "weapon_g3sg1", "weapon_flashbang", "weapon_deagle", "weapon_sg552", "weapon_ak47", "weapon_knife", "weapon_p90" }

// CS sounds
new const sound_flashlight[] = "items/flashlight1.wav"
new const sound_buyammo[] = "items/9mmclip1.wav"
new const sound_armorhit[] = "player/bhit_helmet-1.wav"

// Explosion radius for custom grenades
const Float:NADE_EXPLOSION_RADIUS = 240.0

// HACK: pev_ field used to store additional ammo on weapons
const PEV_ADDITIONAL_AMMO = pev_iuser1

// HACK: pev_ field used to store custom nade types and their values
const PEV_NADE_TYPE = pev_flTimeStepSound
const NADE_TYPE_INFECTION = 1111
const NADE_TYPE_NAPALM = 2222
const NADE_TYPE_FROST = 3333
const NADE_TYPE_FLARE = 4444
const PEV_FLARE_COLOR = pev_punchangle
const PEV_FLARE_DURATION = pev_flSwimTime

// Weapon bitsums
const PRIMARY_WEAPONS_BIT_SUM = (1<<CSW_SCOUT)|(1<<CSW_XM1014)|(1<<CSW_MAC10)|(1<<CSW_AUG)|(1<<CSW_UMP45)|(1<<CSW_SG550)|(1<<CSW_GALIL)|(1<<CSW_FAMAS)|(1<<CSW_AWP)|(1<<CSW_MP5NAVY)|(1<<CSW_M249)|(1<<CSW_M3)|(1<<CSW_M4A1)|(1<<CSW_TMP)|(1<<CSW_G3SG1)|(1<<CSW_SG552)|(1<<CSW_AK47)|(1<<CSW_P90)
const SECONDARY_WEAPONS_BIT_SUM = (1<<CSW_P228)|(1<<CSW_ELITE)|(1<<CSW_FIVESEVEN)|(1<<CSW_USP)|(1<<CSW_GLOCK18)|(1<<CSW_DEAGLE)

// Allowed weapons for zombies (added grenades/bomb for sub-plugin support, since they shouldn't be getting them anyway)
const ZOMBIE_ALLOWED_WEAPONS_BITSUM = (1<<CSW_KNIFE)|(1<<CSW_HEGRENADE)|(1<<CSW_FLASHBANG)|(1<<CSW_SMOKEGRENADE)|(1<<CSW_C4)

// Classnames for separate model entities
new const MODEL_ENT_CLASSNAME[] = "player_model"
new const WEAPON_ENT_CLASSNAME[] = "weapon_model"

// Menu keys
const KEYSMENU = MENU_KEY_1|MENU_KEY_2|MENU_KEY_3|MENU_KEY_4|MENU_KEY_5|MENU_KEY_6|MENU_KEY_7|MENU_KEY_8|MENU_KEY_9|MENU_KEY_0

// Ambience Sounds
enum
{
	AMBIENCE_SOUNDS_INFECTION = 0,
	AMBIENCE_SOUNDS_NEMESIS,
	AMBIENCE_SOUNDS_SURVIVOR,
	AMBIENCE_SOUNDS_SWARM,
	AMBIENCE_SOUNDS_LNJ,
	AMBIENCE_SOUNDS_PLAGUE,
	AMBIENCE_SOUNDS_SNIPER,
	AMBIENCE_SOUNDS_ASSASSIN,
	AMBIENCE_SOUNDS_BERSERKER,
	AMBIENCE_SOUNDS_PREDATOR,
	AMBIENCE_SOUNDS_WESKER,
	AMBIENCE_SOUNDS_BOMBARDIER,
	MAX_AMBIENCE_SOUNDS
}

// Admin menu actions
enum
{
	ACTION_ZOMBIEFY_HUMANIZE = 0,
	ACTION_MAKE_NEMESIS,
	ACTION_MAKE_SURVIVOR,
	ACTION_MAKE_SNIPER,
	ACTION_MAKE_ASSASSIN,	
	ACTION_MAKE_BERSERKER,
	ACTION_MAKE_PREDATOR,
	ACTION_MAKE_WESKER,
	ACTION_MAKE_BOMBARDIER,
	ACTION_RESPAWN_PLAYER
}

// Custom forward return values
const ZP_PLUGIN_HANDLED = 97
const ZP_PLUGIN_SUPERCEDE = 98

/*================================================================================
 [Global Variables]
=================================================================================*/
enum
{
	NEMESIS = 1,
	ASSASSIN,
	PREDATOR,
	BOMBARDIER,
	MAX_SPECIALS_ZOMBIES
}

enum
{
	SURVIVOR = 1,
	SNIPER,
	BERSERKER,
	WESKER,
	MAX_SPECIALS_HUMANS
}

new g_zm_special[33], g_hm_special[33] // Classes Especiais (Nemesis/Survivor/Sniper/Assassin/etc)
new g_hud_type[33], g_hud_color[2][33], g_lantern_color[33], g_lant_rgb[3], g_nv_color[2][33], g_nvrgb[3] // Variaveis do bk Player

// Player vars
new g_zombie[33], g_firstzombie[33], g_lastzombie[33], g_lasthuman[33], g_frozen[33], g_nodamage[33], g_respawn_as_zombie[33]
new g_nvision[33], g_nvisionenabled[33], g_zombieclass[33], g_zombieclassnext[33], g_flashlight[33], g_flashbattery[33] = { 100, ... }
new g_canbuy[33], g_ammopacks[33], g_damagedealt[33], Float:g_lastleaptime[33], Float:g_lastflashtime[33], g_playermodel[33][32]
new g_menu_data[33][6], g_ent_playermodel[33], g_ent_weaponmodel[33], g_burning_duration[33]

// Game vars
new g_pluginenabled, g_newround, g_endround, g_modestarted, g_allowinfection, g_deathmatchmode, g_currentmode, g_lastmode 
new g_scorezombies, g_scorehumans, g_spawnCount, g_spawnCount2, Float:g_spawns[MAX_CSDM_SPAWNS][3], Float:g_spawns2[MAX_CSDM_SPAWNS][3] 
new g_lights_i, g_lights_cycle[32], g_lights_cycle_len, Float:g_models_targettime, Float:g_teams_targettime, g_MsgSync[3]
new g_trailSpr, g_exploSpr, g_flameSpr, g_smokeSpr, g_glassSpr, g_modname[32], g_freezetime, g_maxplayers, g_czero
new g_hamczbots, g_fwSpawn, g_fwPrecacheSound, g_infbombcounter, g_antidotecounter, g_madnesscounter, g_arrays_created
new g_lastplayerleaving, g_switchingteam

enum
{
	SCORE_INFO = 0,
	NVG_TOGGLE,
	SCORE_ATTRIB,
	AMMO_PICKUP,
	SCREEN_FADE,
	DEATH_MSG,
	SET_FOV,
	FLASHLIGHT,
	FLASH_BAT,
	TEAM_INFO,
	DAMAGE,
	HIDE_WEAPON,
	CROSSHAIR,
	SAY_TEXT,
	SCREEN_SHAKE,
	CUR_WEAPON,
	MAX_MSG_ID
}
new g_msgid[MAX_MSG_ID] // Message IDs vars

enum
{
	ROUND_START = 0,
	ROUND_START_PRE,
	ROUND_END,
	INFECTED_PRE,
	INFECTED_POST,
	HUMANIZED_PRE,
	HUMANIZED_POST,
	INFECT_ATTEMP,
	HUMANIZE_ATTEMP,
	ITEM_SELECTED_PRE,
	ITEM_SELECTED_POST,
	USER_UNFROZEN,
	USER_LAST_ZOMBIE,
	USER_LAST_HUMAN,
	GAME_MODE_SELECTED,
	PLAYER_SPAWN_POST,
	FROZEN_PRE,
	FROZEN_POST,
	BURN_PRE,
	BURN_POST,
	CLASS_CHOOSED_PRE,
	CLASS_CHOOSED_POST,
	MAX_FORWARDS_NUM
};

// Some forward handlers
new g_forwards[MAX_FORWARDS_NUM], g_fwDummyResult

// Temporary Database vars (used to restore players stats in case they get disconnected)
new db_name[MAX_STATS_SAVED][32], db_ammopacks[MAX_STATS_SAVED], db_zombieclass[MAX_STATS_SAVED], db_slot_i

// Game Modes vars
new Array:g_gamemode_name, Array:g_gamemode_flag, Array:g_gamemode_chance, Array:g_gamemode_allow, Array:g_gamemode_dm, g_gamemodes_i = MAX_GAME_MODES

// Extra Items vars
new Array:g_extraitem_name, Array:g_extraitem_cost, Array:g_extraitem_team, g_extraitem_i, g_AdditionalMenuText[32]

// For extra items file parsing
new Array:g_extraitem2_realname, Array:g_extraitem2_name, Array:g_extraitem2_cost, Array:g_extraitem2_team, Array:g_extraitem_new

// Zombie Classes vars
new Array:g_zclass_name, Array:g_zclass_info, Array:g_zclass_modelsstart, Array:g_zclass_modelsend, Array:g_zclass_playermodel, g_AdditionalMenuText2[32]
new Array:g_zclass_modelindex, Array:g_zclass_clawmodel, Array:g_zclass_hp, Array:g_zclass_spd, Array:g_zclass_grav, Array:g_zclass_kb, g_zclass_i

// For zombie classes file parsing
new Array:g_zclass2_realname, Array:g_zclass2_name, Array:g_zclass2_info, Array:g_zclass2_modelsstart, Array:g_zclass2_modelsend, Array:g_zclass2_playermodel,
Array:g_zclass2_clawmodel, Array:g_zclass2_hp, Array:g_zclass2_spd, Array:g_zclass2_grav, Array:g_zclass2_kb, Array:g_zclass_new

// Customization vars
new g_access_flag[MAX_ACCESS_FLAGS], Array:model_nemesis, Array:model_survivor, Array:model_human, Array:model_admin_zombie, Array:model_admin_human, Array:model_vip_human, Array:g_modelindex_human,
Array:g_modelindex_nemesis, Array:g_modelindex_survivor, g_same_models_for_all, Array:g_modelindex_admin_zombie, Array:g_modelindex_admin_human, Array:g_modelindex_vip_human, model_vknife_human[64], model_pknife_human[64],
model_vknife_nemesis[64], model_vm249_survivor[64], model_pm249_survivor[64], model_grenade_infect[64], model_grenade_fire[64], model_grenade_frost[64], model_grenade_flare[64],
model_vknife_admin_human[64], model_pknife_admin_human[64], model_vknife_vip_human[64], model_pknife_vip_human[64], model_vknife_admin_zombie[64], sprite_grenade_trail[64], sprite_grenade_ring[64], sprite_grenade_fire[64],
sprite_grenade_smoke[64], sprite_grenade_glass[64], Array:sound_win_zombies, Array:sound_win_humans, Array:sound_win_no_one, Array:zombie_infect, Array:zombie_idle,
Array:zombie_pain, Array:nemesis_pain, Array:assassin_pain, Array:predator_pain, Array:bombardier_pain, Array:zombie_die, Array:zombie_fall, Array:zombie_miss_wall, Array:zombie_hit_normal, Array:zombie_hit_stab, g_ambience_rain,
Array:zombie_idle_last, Array:zombie_madness, Array:sound_nemesis, Array:sound_survivor, Array:sound_swarm, Array:sound_multi, Array:sound_plague, Array:grenade_infect,
Array:grenade_infect_player, Array:grenade_fire, Array:grenade_fire_player, Array:grenade_frost, Array:grenade_frost_player, Array:grenade_frost_break, Array:grenade_flare, Array:sound_antidote, Array:sound_thunder, 
g_ambience_sounds[MAX_AMBIENCE_SOUNDS], Array:sound_ambience1, Array:sound_ambience2, Array:sound_ambience3, Array:sound_ambience4, Array:sound_ambience5, Array:sound_ambience1_duration, Array:sound_ambience2_duration,
Array:sound_ambience3_duration, Array:sound_ambience4_duration, Array:sound_ambience5_duration, Array:g_primary_items, Array:g_secondary_items, Array:g_additional_items, Array:g_primary_weaponids, Array:g_secondary_weaponids, 
Array:g_extraweapon_names, Array:g_extraweapon_items, Array:g_extraweapon_costs, g_extra_costs2[EXTRA_WEAPONS_STARTID], g_ambience_snow, g_ambience_fog, g_fog_density[10], g_fog_color[12], g_sky_enable,
Array:g_sky_names, Array:lights_thunder, Array:zombie_decals, Array:g_objective_ents, Float:g_modelchange_delay, g_set_modelindex_offset, g_handle_models_on_separate_ent,
Float:kb_weapon_power[31] = { -1.0, ... }, Array:zombie_miss_slash, g_force_consistency, Array:model_sniper, Array:g_modelindex_sniper, model_vawp_sniper[64], model_pawp_sniper[64],
Array:sound_sniper, Array:sound_ambience6, Array:sound_ambience6_duration, Array:model_assassin, Array:g_modelindex_assassin, model_vknife_assassin[64],
Array:sound_assassin, Array:sound_ambience7, Array:sound_ambience7_duration, Array:sound_lnj, Array:sound_ambience8, Array:sound_ambience8_duration,
Array:model_berserker, Array:g_modelindex_berserker, model_vknife_berserker[64], model_pknife_berserker[64], Array:sound_berserker, Array:sound_ambience9, Array:sound_ambience9_duration, 
Array:model_predator, Array:g_modelindex_predator, model_vknife_predator[64], Array:sound_predator, Array:sound_ambience10, Array:sound_ambience10_duration, 
Array:model_wesker, Array:g_modelindex_wesker, model_vdeagle_wesker[64], model_pdeagle_wesker[64], Array:sound_wesker, Array:sound_ambience11, Array:sound_ambience11_duration, 
Array:model_bombardier, Array:g_modelindex_bombardier, model_vknife_bombardier[64], Array:sound_bombardier, Array:sound_ambience12, Array:sound_ambience12_duration

// CVAR pointers
new cvar_lighting, cvar_zombiefov, cvar_plague, cvar_plaguechance, cvar_zombiefirsthp, cvar_removemoney, cvar_thunder, cvar_zombiebonushp, cvar_nemhp, cvar_nem, cvar_surv,
cvar_nemchance, cvar_deathmatch, cvar_nemglow, cvar_customnvg, cvar_hitzones, cvar_humanhp, cvar_nemgravity, cvar_flashsize, cvar_ammodamage, cvar_zombiearmor, cvar_survpainfree,
cvar_nempainfree, cvar_nemspd, cvar_survchance, cvar_survhp, cvar_survspd, cvar_humanspd, cvar_swarmchance, cvar_flashdrain, cvar_zombiebleeding, cvar_removedoors, cvar_customflash,
cvar_randspawn, cvar_multi, cvar_multichance, cvar_infammo, cvar_swarm, cvar_ammoinfect, cvar_toggle, cvar_knockbackpower, cvar_freezeduration, cvar_triggered, cvar_flashcharge,
cvar_firegrenades, cvar_frostgrenades, cvar_survgravity, cvar_logcommands, cvar_survglow, cvar_humangravity, cvar_spawnprotection, cvar_nvgsize, cvar_flareduration, cvar_zclasses,
cvar_extraitems, cvar_showactivity, cvar_humanlasthp, cvar_nemignorefrags, cvar_warmup, cvar_flashdist, cvar_flarecolor, cvar_survignorefrags, cvar_fireduration, cvar_firedamage,
cvar_flaregrenades, cvar_knockbackducking, cvar_knockbackdamage, cvar_knockbackzvel, cvar_multiratio, cvar_flaresize, cvar_spawndelay, cvar_extraantidote, cvar_extramadness,
cvar_extraweapons, cvar_extranvision, cvar_nvggive, cvar_preventconsecutive, cvar_botquota, cvar_buycustom, cvar_zombiepainfree, cvar_fireslowdown, cvar_survbasehp, cvar_survaura,
cvar_nemignoreammo, cvar_survignoreammo, cvar_nemaura, cvar_extrainfbomb, cvar_knockback, cvar_fragsinfect, cvar_fragskill, cvar_humanarmor, cvar_zombiesilent, cvar_removedropped,
cvar_plagueratio, cvar_blocksuicide, cvar_knockbackdist, cvar_nemdamage, cvar_leapzombies, cvar_leapzombiesforce, cvar_leapzombiesheight, cvar_leapzombiescooldown, cvar_leapnemesis,
cvar_leapnemesisforce, cvar_leapnemesisheight, cvar_leapnemesiscooldown, cvar_leapsurvivor, cvar_leapsurvivorforce, cvar_leapsurvivorheight, cvar_nemminplayers, cvar_survminplayers,
cvar_respawnonsuicide, cvar_respawnafterlast, cvar_leapsurvivorcooldown, cvar_statssave, cvar_swarmminplayers, cvar_multiminplayers, cvar_plagueminplayers, cvar_adminmodelshuman, cvar_vipmodelshuman,
cvar_adminmodelszombie, cvar_nembasehp, cvar_blockpushables, cvar_respawnworldspawnkill, cvar_madnessduration, cvar_plaguenemnum, cvar_plaguenemhpmulti, cvar_plaguesurvhpmulti,
cvar_survweapon, cvar_plaguesurvnum, cvar_infectionscreenfade, cvar_infectionscreenshake, cvar_infectionsparkle, cvar_infectiontracers, cvar_infectionparticles, cvar_infbomblimit,
cvar_allowrespawnsurv, cvar_flashshowall, cvar_allowrespawninfection, cvar_allowrespawnnem, cvar_allowrespawnswarm, cvar_allowrespawnplague, cvar_survinfammo, cvar_nemknockback,
cvar_hudicons, cvar_respawnzomb, cvar_respawnhum, cvar_respawnnem, cvar_respawnsurv, cvar_startammopacks, cvar_randweapons, cvar_antidotelimit, cvar_madnesslimit, cvar_survdamage,
cvar_adminknifemodelshuman, cvar_vipknifemodelshuman, cvar_adminknifemodelszombie, cvar_keephealthondisconnect, cvar_sniper, cvar_sniperchance, cvar_sniperminplayers, cvar_sniperdamage, cvar_sniperhp,
cvar_sniperglow, cvar_sniperbasehp, cvar_sniperpainfree, cvar_sniperinfammo, cvar_sniperspd, cvar_respawnsniper, cvar_snipergravity, cvar_sniperaura, cvar_sniperfraggore, cvar_nemfraggore,
cvar_sniperignorefrags, cvar_sniperignoreammo, cvar_allowrespawnsniper,cvar_surv_aura_radius, cvar_leapsniper, cvar_leapsniperforce, cvar_leapsniperheight, cvar_leapsnipercooldown, cvar_sniperauraradius,
cvar_respawnassassin ,cvar_allowrespawnassassin,cvar_assassin,cvar_assassinchance ,cvar_assassinminplayers, cvar_assassinhp , cvar_assassinbasehp ,cvar_assassinspd ,cvar_assassingravity ,cvar_assassindamage ,cvar_assassinknockback ,
cvar_assassinglow ,cvar_assassinaura ,cvar_assassinpainfree ,cvar_assassinignorefrags , cvar_assassinignoreammo, cvar_leapassassin, cvar_leapassassinforce, cvar_leapassassinheight, cvar_leapassassincooldown, cvar_flaresize2, cvar_humansurvive,
cvar_lnj, cvar_lnjchance, cvar_lnjminplayers, cvar_lnjnemhpmulti, cvar_lnjsurvhpmulti,  cvar_allowrespawnlnj, cvar_lnjratio, cvar_lnjrespsurv, cvar_lnjrespnem  , cvar_flashsize2, cvar_frozenhit, cvar_aiminfo, cvar_nemauraradius,
cvar_berserker, cvar_berserkerchance, cvar_berserkerminplayers, cvar_berserkerdamage, cvar_berserkerhp, cvar_berserkerglow, cvar_berserkerbasehp, cvar_berserkerpainfree, cvar_berserkerspd,
cvar_respawnberserker, cvar_berserkergravity, cvar_berserkeraura, cvar_berserkerignorefrags, cvar_berserkerignoreammo, cvar_allowrespawnberserker, cvar_leapberserker, cvar_leapberserkerforce, cvar_leapberserkerheight, cvar_leapberserkercooldown, cvar_berserkerauraradius,
cvar_respawnpredator ,cvar_allowrespawnpredator,cvar_predator,cvar_predatorchance ,cvar_predatorminplayers , cvar_predatorhp , cvar_predatorbasehp ,cvar_predatorspd ,cvar_predatorgravity ,cvar_predatordamage ,cvar_predatorknockback ,
cvar_predatorglow ,cvar_predatoraura ,cvar_predatorpainfree ,cvar_predatorignorefrags , cvar_predatorignoreammo, cvar_leappredator, cvar_leappredatorforce, cvar_leappredatorheight, cvar_leappredatorcooldown,
cvar_wesker, cvar_weskerchance, cvar_weskerminplayers, cvar_weskerdamage, cvar_weskerinfammo, cvar_weskerhp, cvar_weskerglow, cvar_weskerbasehp, cvar_weskerpainfree, cvar_weskerspd, cvar_respawnwesker, cvar_weskergravity, cvar_weskeraura,
cvar_weskerignorefrags, cvar_weskerignoreammo, cvar_allowrespawnwesker, cvar_leapwesker, cvar_leapweskerforce, cvar_leapweskerheight, cvar_leapweskercooldown, cvar_weskerauraradius,
cvar_respawnbombardier ,cvar_allowrespawnbombardier,cvar_bombardier,cvar_bombardierchance ,cvar_bombardierminplayers , cvar_bombardierhp , cvar_bombardierbasehp ,cvar_bombardierspd ,cvar_bombardiergravity ,cvar_bombardierdamage ,cvar_bombardierknockback ,
cvar_bombardierglow ,cvar_bombardieraura ,cvar_bombardierpainfree ,cvar_bombardierignorefrags , cvar_bombardierignoreammo, cvar_leapbombardier, cvar_leapbombardierforce, cvar_leapbombardierheight, cvar_leapbombardiercooldown,
game_name[64], cvar_gamename, cvar_antidote_minzms

// CVARS with arrays
new cvar_nvgcolor[3], cvar_nemnvgcolor[3], cvar_assassinnvgcolor[3], cvar_predatornvgcolor[3], cvar_bombardiernvgcolor[3],
cvar_humnvgcolor[3], cvar_flashcolor[3], cvar_snipercolor[3], cvar_berserkercolor[3], cvar_weskercolor[3],
cvar_surv_aura[3], cvar_flashcolor2[3]

// Cached stuff for players
new g_isconnected[33], g_isalive[33], g_isbot[33], g_currentweapon[33], g_playername[33][32], Float:g_zombie_spd[33], Float:g_zombie_knockback[33], g_zombie_classname[33][32]
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && g_isalive[%1])

// Cached CVARs
new g_cached_customflash, g_cached_zombiesilent, Float:g_cached_humanspd, Float:g_cached_nemspd,
Float:g_cached_survspd, g_cached_leapzombies, Float:g_cached_leapzombiescooldown, g_cached_leapnemesis,
Float:g_cached_leapnemesiscooldown, g_cached_leapsurvivor, Float:g_cached_leapsurvivorcooldown,
Float:g_cached_sniperspd, g_cached_leapsniper, Float:g_cached_leapsnipercooldown,
Float:g_cached_assassinspd, g_cached_leapassassin, Float:g_cached_leapassassincooldown,
Float:g_cached_predatorspd, g_cached_leappredator, Float:g_cached_leappredatorcooldown,
Float:g_cached_bombardierspd, g_cached_leapbombardier, Float:g_cached_leapbombardiercooldown,
Float:g_cached_berserkerspd, g_cached_leapberserker, Float:g_cached_leapberserkercooldown,
Float:g_cached_weskerspd, g_cached_leapwesker, Float:g_cached_leapweskercooldown

/*================================================================================
 [Natives, Precache and Init]
=================================================================================*/

public plugin_natives()
{
	// Player specific natives
	register_native("zp_get_user_zombie", "native_get_user_zombie", 1)
	register_native("zp_get_user_nemesis", "native_get_user_nemesis", 1)
	register_native("zp_get_user_survivor", "native_get_user_survivor", 1)
	register_native("zp_get_user_first_zombie", "native_get_user_first_zombie", 1)
	register_native("zp_get_user_last_zombie", "native_get_user_last_zombie", 1)
	register_native("zp_get_user_last_human", "native_get_user_last_human", 1)
	register_native("zp_get_user_zombie_class", "native_get_user_zombie_class", 1)
	register_native("zp_get_user_next_class", "native_get_user_next_class", 1)
	register_native("zp_set_user_zombie_class", "native_set_user_zombie_class", 1)
	register_native("zp_get_user_ammo_packs", "native_get_user_ammo_packs", 1)
	register_native("zp_set_user_ammo_packs", "native_set_user_ammo_packs", 1)
	register_native("zp_get_zombie_maxhealth", "native_get_zombie_maxhealth", 1)
	register_native("zp_get_user_batteries", "native_get_user_batteries", 1)
	register_native("zp_set_user_batteries", "native_set_user_batteries", 1)
	register_native("zp_get_user_nightvision", "native_get_user_nightvision", 1)
	register_native("zp_set_user_nightvision", "native_set_user_nightvision", 1)
	register_native("zp_infect_user", "native_infect_user", 1)
	register_native("zp_disinfect_user", "native_disinfect_user", 1)
	register_native("zp_make_user_nemesis", "native_make_user_nemesis", 1)
	register_native("zp_make_user_survivor", "native_make_user_survivor", 1)
	register_native("zp_respawn_user", "native_respawn_user", 1)
	register_native("zp_force_buy_extra_item", "native_force_buy_extra_item", 1)
	register_native("zp_get_user_sniper", "native_get_user_sniper", 1)
	register_native("zp_make_user_sniper", "native_make_user_sniper", 1)
	register_native("zp_get_user_assassin", "native_get_user_assassin", 1)
	register_native("zp_make_user_assassin", "native_make_user_assassin", 1)
	register_native("zp_get_user_predator", "native_get_user_predator", 1)
	register_native("zp_make_user_predator", "native_make_user_predator", 1)
	register_native("zp_get_user_bombardier", "native_get_user_bombardier", 1)
	register_native("zp_make_user_bombardier", "native_make_user_bombardier", 1)
	register_native("zp_get_user_berserker", "native_get_user_berserker", 1)
	register_native("zp_make_user_berserker", "native_make_user_berserker", 1)
	register_native("zp_get_user_wesker", "native_get_user_wesker", 1)
	register_native("zp_make_user_wesker", "native_make_user_wesker", 1)
	register_native("zp_get_user_model", "native_get_user_model", 0)
	register_native("zp_override_user_model", "native_override_user_model", 1)
	register_native("zp_set_user_model", "native_override_user_model", 1)
	
	// Round natives
	register_native("zp_has_round_started", "native_has_round_started", 1)
	register_native("zp_is_nemesis_round", "native_is_nemesis_round", 1)
	register_native("zp_is_survivor_round", "native_is_survivor_round", 1)
	register_native("zp_is_swarm_round", "native_is_swarm_round", 1)
	register_native("zp_is_plague_round", "native_is_plague_round", 1)
	register_native("zp_get_zombie_count", "native_get_zombie_count", 1)
	register_native("zp_get_human_count", "native_get_human_count", 1)
	register_native("zp_get_nemesis_count", "native_get_nemesis_count", 1)
	register_native("zp_get_survivor_count", "native_get_survivor_count", 1)
	register_native("zp_is_sniper_round", "native_is_sniper_round", 1)
	register_native("zp_get_sniper_count", "native_get_sniper_count", 1)
	register_native("zp_is_assassin_round", "native_is_assassin_round", 1)
	register_native("zp_get_assassin_count", "native_get_assassin_count", 1)
	register_native("zp_is_predator_round", "native_is_predator_round", 1)
	register_native("zp_get_predator_count", "native_get_predator_count", 1)
	register_native("zp_is_bombardier_round", "native_is_bombardier_round", 1)
	register_native("zp_get_bombardier_count", "native_get_bombardier_count", 1)
	register_native("zp_is_berserker_round", "native_is_berserker_round", 1)
	register_native("zp_get_berserker_count", "native_get_berserker_count", 1)
	register_native("zp_is_wesker_round", "native_is_wesker_round", 1)
	register_native("zp_get_wesker_count", "native_get_wesker_count", 1)
	register_native("zp_is_lnj_round", "native_is_lnj_round", 1)
	register_native("zp_get_current_mode", "native_get_current_mode", 1)
	
	// External additions natives
	register_native("zp_register_game_mode", "native_register_game_mode", 1)
	register_native("zp_register_extra_item", "native_register_extra_item", 1)
	register_native("zp_register_zombie_class", "native_register_zombie_class", 1)
	register_native("zp_get_extra_item_id", "native_get_extra_item_id", 1)
	register_native("zp_get_zombie_class_id", "native_get_zombie_class_id", 1)
	
	// Novas Natives
	register_native("zp_get_user_madness", "native_get_user_madness", 1)
	register_native("zp_set_user_madness", "native_set_user_madness", 1)
	register_native("zp_get_user_burn", "native_get_user_burn", 1)
	register_native("zp_set_user_burn", "native_set_user_burn", 1)
	register_native("zp_get_user_frozen", "native_get_user_frozen", 1)
	register_native("zp_set_user_frozen", "native_set_user_frozen", 1)
	register_native("zp_get_user_infectnade", "native_get_user_infectnade", 1)
	register_native("zp_set_user_infectnade", "native_set_user_infectnade", 1)
	register_native("zp_extra_item_textadd", "native_extra_item_textadd")
	register_native("zp_zombie_class_textadd", "native_zombie_class_textadd")
	register_native("zp_get_human_special_class", "native_get_human_special_class", 1)
	register_native("zp_get_zombie_special_class", "native_get_zombie_special_class", 1)
}

public plugin_precache()
{
	// Register earlier to show up in plugins list properly after plugin disable/error at loading
	register_plugin("Zombie Plague Advance", "1.6.1", "MeRcyLeZZ | @bdul!")
	
	// To switch plugin on/off
	cvar_toggle = register_cvar("zp_on", "1")
	
	// Plugin disabled?
	if (!get_pcvar_num(cvar_toggle)) return;
	g_pluginenabled = true
	
	// Initialize a few dynamically sized arrays (alright, maybe more than just a few...)
	model_human = ArrayCreate(32, 1)
	model_nemesis = ArrayCreate(32, 1)
	model_survivor = ArrayCreate(32, 1)
	model_admin_human = ArrayCreate(32, 1)
	model_vip_human = ArrayCreate(32, 1)
	model_admin_zombie = ArrayCreate(32, 1)
	g_modelindex_human = ArrayCreate(1, 1)
	g_modelindex_nemesis = ArrayCreate(1, 1)
	g_modelindex_survivor = ArrayCreate(1, 1)
	g_modelindex_admin_human = ArrayCreate(1, 1)
	g_modelindex_vip_human = ArrayCreate(1, 1)
	g_modelindex_admin_zombie = ArrayCreate(1, 1)
	sound_win_zombies = ArrayCreate(64, 1)
	sound_win_humans = ArrayCreate(64, 1)
	sound_win_no_one = ArrayCreate(64, 1)
	zombie_infect = ArrayCreate(64, 1)
	zombie_pain = ArrayCreate(64, 1)
	nemesis_pain = ArrayCreate(64, 1)
	assassin_pain = ArrayCreate(64, 1)
	predator_pain = ArrayCreate(64, 1)
	bombardier_pain = ArrayCreate(64, 1)
	zombie_die = ArrayCreate(64, 1)
	zombie_fall = ArrayCreate(64, 1)
	zombie_miss_slash = ArrayCreate(64, 1)
	zombie_miss_wall = ArrayCreate(64, 1)
	zombie_hit_normal = ArrayCreate(64, 1)
	zombie_hit_stab = ArrayCreate(64, 1)
	zombie_idle = ArrayCreate(64, 1)
	zombie_idle_last = ArrayCreate(64, 1)
	zombie_madness = ArrayCreate(64, 1)
	sound_nemesis = ArrayCreate(64, 1)
	sound_survivor = ArrayCreate(64, 1)
	sound_swarm = ArrayCreate(64, 1)
	sound_multi = ArrayCreate(64, 1)
	sound_plague = ArrayCreate(64, 1)
	grenade_infect = ArrayCreate(64, 1)
	grenade_infect_player = ArrayCreate(64, 1)
	grenade_fire = ArrayCreate(64, 1)
	grenade_fire_player = ArrayCreate(64, 1)
	grenade_frost = ArrayCreate(64, 1)
	grenade_frost_player = ArrayCreate(64, 1)
	grenade_frost_break = ArrayCreate(64, 1)
	grenade_flare = ArrayCreate(64, 1)
	sound_antidote = ArrayCreate(64, 1)
	sound_thunder = ArrayCreate(64, 1)
	sound_ambience1 = ArrayCreate(64, 1)
	sound_ambience2 = ArrayCreate(64, 1)
	sound_ambience3 = ArrayCreate(64, 1)
	sound_ambience4 = ArrayCreate(64, 1)
	sound_ambience5 = ArrayCreate(64, 1)
	sound_ambience1_duration = ArrayCreate(32, 1)
	sound_ambience2_duration = ArrayCreate(32, 1)
	sound_ambience3_duration = ArrayCreate(32, 1)
	sound_ambience4_duration = ArrayCreate(32, 1)
	sound_ambience5_duration = ArrayCreate(32, 1)
	g_primary_items = ArrayCreate(32, 1)
	g_secondary_items = ArrayCreate(32, 1)
	g_additional_items = ArrayCreate(32, 1)
	g_primary_weaponids = ArrayCreate(1, 1)
	g_secondary_weaponids = ArrayCreate(1, 1)
	g_extraweapon_names = ArrayCreate(32, 1)
	g_extraweapon_items = ArrayCreate(32, 1)
	g_extraweapon_costs = ArrayCreate(32, 1)
	g_sky_names = ArrayCreate(32, 1)
	lights_thunder = ArrayCreate(32, 1)
	zombie_decals = ArrayCreate(32, 1)
	g_objective_ents = ArrayCreate(32, 1)
	g_gamemode_name = ArrayCreate(32, 1)
	g_gamemode_flag = ArrayCreate(1, 1)
	g_gamemode_chance = ArrayCreate(1, 1)
	g_gamemode_allow = ArrayCreate(1, 1)
	g_gamemode_dm = ArrayCreate(1, 1)
	g_extraitem_name = ArrayCreate(32, 1)
	g_extraitem_cost = ArrayCreate(1, 1)
	g_extraitem_team = ArrayCreate(1, 1)
	g_extraitem2_realname = ArrayCreate(32, 1)
	g_extraitem2_name = ArrayCreate(32, 1)
	g_extraitem2_cost = ArrayCreate(1, 1)
	g_extraitem2_team = ArrayCreate(1, 1)
	g_extraitem_new = ArrayCreate(1, 1)
	g_zclass_name = ArrayCreate(32, 1)
	g_zclass_info = ArrayCreate(32, 1)
	g_zclass_modelsstart = ArrayCreate(1, 1)
	g_zclass_modelsend = ArrayCreate(1, 1)
	g_zclass_playermodel = ArrayCreate(32, 1)
	g_zclass_modelindex = ArrayCreate(1, 1)
	g_zclass_clawmodel = ArrayCreate(32, 1)
	g_zclass_hp = ArrayCreate(1, 1)
	g_zclass_spd = ArrayCreate(1, 1)
	g_zclass_grav = ArrayCreate(1, 1)
	g_zclass_kb = ArrayCreate(1, 1)
	g_zclass2_realname = ArrayCreate(32, 1)
	g_zclass2_name = ArrayCreate(32, 1)
	g_zclass2_info = ArrayCreate(32, 1)
	g_zclass2_modelsstart = ArrayCreate(1, 1)
	g_zclass2_modelsend = ArrayCreate(1, 1)
	g_zclass2_playermodel = ArrayCreate(32, 1)
	g_zclass2_clawmodel = ArrayCreate(32, 1)
	g_zclass2_hp = ArrayCreate(1, 1)
	g_zclass2_spd = ArrayCreate(1, 1)
	g_zclass2_grav = ArrayCreate(1, 1)
	g_zclass2_kb = ArrayCreate(1, 1)
	g_zclass_new = ArrayCreate(1, 1)
	model_sniper = ArrayCreate(32, 1)
	g_modelindex_sniper = ArrayCreate(1, 1)
	sound_sniper = ArrayCreate(64, 1)
	sound_ambience6 = ArrayCreate(64, 1)
	sound_ambience6_duration = ArrayCreate(1, 1)
	sound_lnj = ArrayCreate(64, 1)
	sound_ambience8 = ArrayCreate(64, 1)
	sound_ambience8_duration = ArrayCreate(1, 1)
	model_assassin = ArrayCreate(32, 1)
	g_modelindex_assassin = ArrayCreate(1, 1)
	sound_assassin = ArrayCreate(64, 1)
	model_predator = ArrayCreate(32, 1)
	g_modelindex_predator = ArrayCreate(1, 1)
	sound_predator = ArrayCreate(64, 1)
	model_bombardier = ArrayCreate(32, 1)
	g_modelindex_bombardier = ArrayCreate(1, 1)
	sound_bombardier = ArrayCreate(64, 1)
	sound_ambience7 = ArrayCreate(64, 1)
	sound_ambience7_duration = ArrayCreate(1, 1)
	model_berserker = ArrayCreate(32, 1)
	g_modelindex_berserker = ArrayCreate(1, 1)
	sound_berserker = ArrayCreate(64, 1)
	sound_ambience9 = ArrayCreate(64, 1)
	sound_ambience9_duration = ArrayCreate(1, 1)
	sound_ambience10 = ArrayCreate(64, 1)
	sound_ambience10_duration = ArrayCreate(1, 1)
	model_wesker = ArrayCreate(32, 1)
	g_modelindex_wesker = ArrayCreate(1, 1)
	sound_wesker = ArrayCreate(64, 1)
	sound_ambience11 = ArrayCreate(64, 1)
	sound_ambience11_duration = ArrayCreate(1, 1)
	sound_ambience12 = ArrayCreate(64, 1)
	sound_ambience12_duration = ArrayCreate(1, 1)
	
	// Allow registering stuff now
	g_arrays_created = true
	
	// Load customization data
	load_customization_from_files()
	
	new i, buffer[100]
	
	// Load up the hard coded extra items
	native_register_extra_item2("NightVision", g_extra_costs2[EXTRA_NVISION], ZP_TEAM_HUMAN)
	native_register_extra_item2("T-Virus Antidote", g_extra_costs2[EXTRA_ANTIDOTE], ZP_TEAM_ZOMBIE)
	native_register_extra_item2("Zombie Madness", g_extra_costs2[EXTRA_MADNESS], ZP_TEAM_ZOMBIE)
	native_register_extra_item2("Infection Bomb", g_extra_costs2[EXTRA_INFBOMB], ZP_TEAM_ZOMBIE)
	
	// Extra weapons
	new szCost[100], szCost2[20]
	for (i = 0; i < ArraySize(g_extraweapon_names); i++)
	{
		ArrayGetString(g_extraweapon_names, i, buffer, charsmax(buffer))
		ArrayGetString(g_extraweapon_costs, i, szCost, charsmax(szCost))
		formatex(szCost2, charsmax(szCost2), "%s", szCost)
		
		native_register_extra_item2(buffer, str_to_num(szCost2), ZP_TEAM_HUMAN)
	}
	
	// Custom player models
	for (i = 0; i < ArraySize(model_human); i++)
	{
		ArrayGetString(model_human, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_human, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_nemesis); i++)
	{
		ArrayGetString(model_nemesis, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_nemesis, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_survivor); i++)
	{
		ArrayGetString(model_survivor, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_survivor, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_admin_zombie); i++)
	{
		ArrayGetString(model_admin_zombie, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_admin_zombie, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_admin_human); i++)
	{
		ArrayGetString(model_admin_human, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_admin_human, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_vip_human); i++)
	{
		ArrayGetString(model_vip_human, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_vip_human, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_sniper); i++)
	{
		ArrayGetString(model_sniper, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_sniper, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_assassin); i++)
	{
		ArrayGetString(model_assassin, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_assassin, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	
	for (i = 0; i < ArraySize(model_berserker); i++)
	{
		ArrayGetString(model_berserker, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_berserker, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_predator); i++)
	{
		ArrayGetString(model_predator, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_predator, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	for (i = 0; i < ArraySize(model_wesker); i++)
	{
		ArrayGetString(model_wesker, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_wesker, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	
	for (i = 0; i < ArraySize(model_bombardier); i++)
	{
		ArrayGetString(model_bombardier, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_bombardier, engfunc(EngFunc_PrecacheModel, buffer))
		if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
	}
	
	// Custom weapon models
	engfunc(EngFunc_PrecacheModel, model_vknife_human)
	engfunc(EngFunc_PrecacheModel, model_pknife_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_nemesis)
	engfunc(EngFunc_PrecacheModel, model_vm249_survivor)
	engfunc(EngFunc_PrecacheModel, model_pm249_survivor)
	engfunc(EngFunc_PrecacheModel, model_grenade_infect)
	engfunc(EngFunc_PrecacheModel, model_grenade_fire)
	engfunc(EngFunc_PrecacheModel, model_grenade_frost)
	engfunc(EngFunc_PrecacheModel, model_grenade_flare)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_human)
	engfunc(EngFunc_PrecacheModel, model_pknife_admin_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_vip_human)
	engfunc(EngFunc_PrecacheModel, model_pknife_vip_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_zombie)
	engfunc(EngFunc_PrecacheModel, model_vawp_sniper)
	engfunc(EngFunc_PrecacheModel, model_pawp_sniper)
	engfunc(EngFunc_PrecacheModel, model_vknife_assassin)
	engfunc(EngFunc_PrecacheModel, model_vknife_predator)
	engfunc(EngFunc_PrecacheModel, model_vknife_bombardier)
	engfunc(EngFunc_PrecacheModel, model_vknife_berserker)
	engfunc(EngFunc_PrecacheModel, model_pknife_berserker)
	engfunc(EngFunc_PrecacheModel, model_vdeagle_wesker)
	engfunc(EngFunc_PrecacheModel, model_pdeagle_wesker)
	
	// Custom sprites for grenades
	g_trailSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_trail)
	g_exploSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_ring)
	g_flameSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_fire)
	g_smokeSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_smoke)
	g_glassSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_glass)
	
	// Custom sounds
	for (i = 0; i < ArraySize(sound_win_zombies); i++)
	{
		ArrayGetString(sound_win_zombies, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_win_humans); i++)
	{
		ArrayGetString(sound_win_humans, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_win_no_one); i++)
	{
		ArrayGetString(sound_win_no_one, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_infect); i++)
	{
		ArrayGetString(zombie_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_pain); i++)
	{
		ArrayGetString(zombie_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(nemesis_pain); i++)
	{
		ArrayGetString(nemesis_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(assassin_pain); i++)
	{
		ArrayGetString(assassin_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(predator_pain); i++)
	{
		ArrayGetString(predator_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(bombardier_pain); i++)
	{
		ArrayGetString(bombardier_pain, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_die); i++)
	{
		ArrayGetString(zombie_die, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_fall); i++)
	{
		ArrayGetString(zombie_fall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_slash); i++)
	{
		ArrayGetString(zombie_miss_slash, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_wall); i++)
	{
		ArrayGetString(zombie_miss_wall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_normal); i++)
	{
		ArrayGetString(zombie_hit_normal, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_stab); i++)
	{
		ArrayGetString(zombie_hit_stab, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle); i++)
	{
		ArrayGetString(zombie_idle, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle_last); i++)
	{
		ArrayGetString(zombie_idle_last, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_madness); i++)
	{
		ArrayGetString(zombie_madness, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_nemesis); i++)
	{
		ArrayGetString(sound_nemesis, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_survivor); i++)
	{
		ArrayGetString(sound_survivor, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_swarm); i++)
	{
		ArrayGetString(sound_swarm, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_multi); i++)
	{
		ArrayGetString(sound_multi, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_plague); i++)
	{
		ArrayGetString(sound_plague, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_infect); i++)
	{
		ArrayGetString(grenade_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_infect_player); i++)
	{
		ArrayGetString(grenade_infect_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire); i++)
	{
		ArrayGetString(grenade_fire, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire_player); i++)
	{
		ArrayGetString(grenade_fire_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost); i++)
	{
		ArrayGetString(grenade_frost, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_player); i++)
	{
		ArrayGetString(grenade_frost_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_break); i++)
	{
		ArrayGetString(grenade_frost_break, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_flare); i++)
	{
		ArrayGetString(grenade_flare, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_antidote); i++)
	{
		ArrayGetString(sound_antidote, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_thunder); i++)
	{
		ArrayGetString(sound_thunder, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_sniper); i++)
	{
		ArrayGetString(sound_sniper, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_assassin); i++)
	{
		ArrayGetString(sound_assassin, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	for (i = 0; i < ArraySize(sound_berserker); i++)
	{
		ArrayGetString(sound_berserker, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_predator); i++)
	{
		ArrayGetString(sound_predator, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	for (i = 0; i < ArraySize(sound_wesker); i++)
	{
		ArrayGetString(sound_wesker, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	for (i = 0; i < ArraySize(sound_bombardier); i++)
	{
		ArrayGetString(sound_bombardier, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	for (i = 0; i < ArraySize(sound_lnj); i++)
	{
		ArrayGetString(sound_lnj, i, buffer, charsmax(buffer))
		if (equal(buffer[strlen(buffer)-4], ".mp3")) {
			format(buffer, charsmax(buffer), "sound/%s", buffer)
			engfunc(EngFunc_PrecacheGeneric, buffer)
		}
		else engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	// Ambience Sounds
	if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
	{
		for (i = 0; i < ArraySize(sound_ambience1); i++)
		{
			ArrayGetString(sound_ambience1, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS])
	{
		for (i = 0; i < ArraySize(sound_ambience2); i++)
		{
			ArrayGetString(sound_ambience2, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR])
	{
		for (i = 0; i < ArraySize(sound_ambience3); i++)
		{
			ArrayGetString(sound_ambience3, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM])
	{
		for (i = 0; i < ArraySize(sound_ambience4); i++)
		{
			ArrayGetString(sound_ambience4, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE])
	{
		for (i = 0; i < ArraySize(sound_ambience5); i++)
		{
			ArrayGetString(sound_ambience5, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER])
	{
		for (i = 0; i < ArraySize(sound_ambience6); i++)
		{
			ArrayGetString(sound_ambience6, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN])
	{
		for (i = 0; i < ArraySize(sound_ambience7); i++)
		{
			ArrayGetString(sound_ambience7, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_LNJ])
	{
		for (i = 0; i < ArraySize(sound_ambience8); i++)
		{
			ArrayGetString(sound_ambience8, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER])
	{
		for (i = 0; i < ArraySize(sound_ambience9); i++)
		{
			ArrayGetString(sound_ambience9, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR])
	{
		for (i = 0; i < ArraySize(sound_ambience10); i++)
		{
			ArrayGetString(sound_ambience10, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_WESKER])
	{
		for (i = 0; i < ArraySize(sound_ambience11); i++)
		{
			ArrayGetString(sound_ambience11, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	if (g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER])
	{
		for (i = 0; i < ArraySize(sound_ambience12); i++)
		{
			ArrayGetString(sound_ambience12, i, buffer, charsmax(buffer))
			
			if (equal(buffer[strlen(buffer)-4], ".mp3"))
			{
				format(buffer, charsmax(buffer), "sound/%s", buffer)
				engfunc(EngFunc_PrecacheGeneric, buffer)
			}
			else
			{
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}

	// CS sounds (just in case)
	engfunc(EngFunc_PrecacheSound, sound_flashlight)
	engfunc(EngFunc_PrecacheSound, sound_buyammo)
	engfunc(EngFunc_PrecacheSound, sound_armorhit)
	
	new ent
	
	// Fake Hostage (to force round ending)
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "hostage_entity"))
	if (pev_valid(ent))
	{
		engfunc(EngFunc_SetOrigin, ent, Float:{8192.0,8192.0,8192.0})
		dllfunc(DLLFunc_Spawn, ent)
	}
	
	// Weather/ambience effects
	if (g_ambience_fog)
	{
		ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_fog"))
		if (pev_valid(ent))
		{
			fm_set_kvd(ent, "density", g_fog_density, "env_fog")
			fm_set_kvd(ent, "rendercolor", g_fog_color, "env_fog")
		}
	}
	if (g_ambience_rain) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_rain"))
	if (g_ambience_snow) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_snow"))
	
	// Prevent some entities from spawning
	g_fwSpawn = register_forward(FM_Spawn, "fw_Spawn")
	
	// Prevent hostage sounds from being precached
	g_fwPrecacheSound = register_forward(FM_PrecacheSound, "fw_PrecacheSound")
}

public plugin_init()
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// No zombie classes?
	if (!g_zclass_i) set_fail_state("No zombie classes loaded!")
	
	// Print the number of registered Game Modes (if any)
	if (g_gamemodes_i > MAX_GAME_MODES)
		server_print("[ZP] Total Registered Custom Game Modes: %d", g_gamemodes_i - MAX_GAME_MODES)
	
	// Print the number of registered Zombie Classes
	server_print("[ZP] Total Registered Zombie Classes: %d", g_zclass_i)
	
	// Print the number of registered Extra Items
	server_print("[ZP] Total Registered Extra Items: %d", g_extraitem_i)
	
	// Language files
	register_dictionary("zombie_plague_advance.txt")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_event("StatusValue", "event_show_status", "be", "1=2", "2!0")
	register_event("StatusValue", "event_hide_status", "be", "1=1", "2=0")
	register_logevent("logevent_round_start",2, "1=Round_Start")
	register_logevent("logevent_round_end", 2, "1=Round_End")
	register_event("AmmoX", "event_ammo_x", "be")

	for (new i = 0; i < MAX_AMBIENCE_SOUNDS; i++) if (g_ambience_sounds[i]) register_event("30", "event_intermission", "a")
	
	// HAM Forwards
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", 1)
	RegisterHam(Ham_TraceAttack, "player", "fw_TraceAttack")
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_pushable", "fw_UsePushable")
	RegisterHam(Ham_Touch, "weaponbox", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "armoury_entity", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "weapon_shield", "fw_TouchWeapon")
	RegisterHam(Ham_AddPlayerItem, "player", "fw_AddPlayerItem")
	for (new i = 1; i < sizeof WEAPONENTNAMES; i++)
		if (WEAPONENTNAMES[i][0]) RegisterHam(Ham_Item_Deploy, WEAPONENTNAMES[i], "fw_Item_Deploy_Post", 1)
	
	// FM Forwards
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect")
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect_Post", 1)
	register_forward(FM_ClientKill, "fw_ClientKill")
	register_forward(FM_EmitSound, "fw_EmitSound")
	if (!g_handle_models_on_separate_ent) register_forward(FM_SetClientKeyValue, "fw_SetClientKeyValue")
	register_forward(FM_ClientUserInfoChanged, "fw_ClientUserInfoChanged")
	register_forward(FM_GetGameDescription, "fw_GetGameDescription")
	register_forward(FM_SetModel, "fw_SetModel")
	RegisterHam(Ham_Think, "grenade", "fw_ThinkGrenade")
	register_forward(FM_CmdStart, "fw_CmdStart")
	register_forward(FM_PlayerPreThink, "fw_PlayerPreThink")
	unregister_forward(FM_Spawn, g_fwSpawn)
	unregister_forward(FM_PrecacheSound, g_fwPrecacheSound)
	
	// Client commands
	register_clcmd("nightvision", "clcmd_nightvision")
	register_clcmd("drop", "clcmd_drop")
	register_clcmd("buyammo1", "clcmd_buyammo")
	register_clcmd("buyammo2", "clcmd_buyammo")
	register_clcmd("chooseteam", "clcmd_changeteam")
	register_clcmd("jointeam", "clcmd_changeteam")
	
	// Menus
	register_menu("Game Menu", KEYSMENU, "menu_game")
	register_menu("Buy Menu 1", KEYSMENU, "menu_buy1")
	register_menu("Buy Menu 2", KEYSMENU, "menu_buy2")
	register_menu("Menu2 Admin", KEYSMENU, "menu2_admin")
	register_menu("Menu3 Admin", KEYSMENU, "menu3_admin")
	
	// Admin commands
	register_concmd("zp_zombie", "cmd_zombie", _, "<target> - Turn someone into a Zombie", 0)
	register_concmd("zp_human", "cmd_human", _, "<target> - Turn someone back to Human", 0)
	register_concmd("zp_nemesis", "cmd_nemesis", _, "<target> - Turn someone into a Nemesis", 0)
	register_concmd("zp_survivor", "cmd_survivor", _, "<target> - Turn someone into a Survivor", 0)
	register_concmd("zp_respawn", "cmd_respawn", _, "<target> - Respawn someone", 0)
	register_concmd("zp_swarm", "cmd_swarm", _, " - Start Swarm Mode", 0)
	register_concmd("zp_multi", "cmd_multi", _, " - Start Multi Infection", 0)
	register_concmd("zp_plague", "cmd_plague", _, " - Start Plague Mode", 0)
	register_concmd("zp_sniper", "cmd_sniper", _, "<target> - Turn someone into a Sniper", 0)
	register_concmd("zp_assassin", "cmd_assassin", _, "<target> - Turn someone into an Assassin", 0)
	register_concmd("zp_predator", "cmd_predator", _, "<target> - Turn someone into an Predator", 0)
	register_concmd("zp_bombardier", "cmd_bombardier", _, "<target> - Turn someone into an Bombardier", 0)
	register_concmd("zp_berserker", "cmd_berserker", _, "<target> - Turn someone into a Berserker", 0)
	register_concmd("zp_wesker", "cmd_wesker", _, "<target> - Turn someone into a Wesker", 0)
	register_concmd("zp_lnj", "cmd_lnj", _, " - Start Apocalypse Mode", 0)
	
	// Message IDs
	g_msgid[SCORE_INFO] = get_user_msgid("ScoreInfo")
	g_msgid[TEAM_INFO] = get_user_msgid("TeamInfo")
	g_msgid[DEATH_MSG] = get_user_msgid("DeathMsg")
	g_msgid[SCORE_ATTRIB] = get_user_msgid("ScoreAttrib")
	g_msgid[SET_FOV] = get_user_msgid("SetFOV")
	g_msgid[SCREEN_FADE] = get_user_msgid("ScreenFade")
	g_msgid[SCREEN_SHAKE] = get_user_msgid("ScreenShake")
	g_msgid[NVG_TOGGLE] = get_user_msgid("NVGToggle")
	g_msgid[FLASHLIGHT] = get_user_msgid("Flashlight")
	g_msgid[FLASH_BAT] = get_user_msgid("FlashBat")
	g_msgid[AMMO_PICKUP] = get_user_msgid("AmmoPickup")
	g_msgid[DAMAGE] = get_user_msgid("Damage")
	g_msgid[HIDE_WEAPON] = get_user_msgid("HideWeapon")
	g_msgid[CROSSHAIR] = get_user_msgid("Crosshair")
	g_msgid[SAY_TEXT] = get_user_msgid("SayText")
	g_msgid[CUR_WEAPON] = get_user_msgid("CurWeapon")
	
	// Message hooks
	register_message(g_msgid[CUR_WEAPON], "message_cur_weapon")
	register_message(get_user_msgid("Money"), "message_money")
	register_message(get_user_msgid("Health"), "message_health")
	register_message(g_msgid[FLASH_BAT], "message_flashbat")
	register_message(g_msgid[SCREEN_FADE], "message_screenfade")
	register_message(g_msgid[NVG_TOGGLE], "message_nvgtoggle")
	if (g_handle_models_on_separate_ent) register_message(get_user_msgid("ClCorpse"), "message_clcorpse")
	register_message(get_user_msgid("WeapPickup"), "message_weappickup")
	register_message(g_msgid[AMMO_PICKUP], "message_ammopickup")
	register_message(get_user_msgid("Scenario"), "message_scenario")
	register_message(get_user_msgid("HostagePos"), "message_hostagepos")
	register_message(get_user_msgid("TextMsg"), "message_textmsg")
	register_message(get_user_msgid("SendAudio"), "message_sendaudio")
	register_message(get_user_msgid("TeamScore"), "message_teamscore")
	register_message(g_msgid[TEAM_INFO], "message_teaminfo")

	
	// CVARS - General Purpose
	cvar_warmup = register_cvar("zp_delay", "10")
	cvar_lighting = register_cvar("zp_lighting", "a")
	cvar_thunder = register_cvar("zp_thunderclap", "90")
	cvar_triggered = register_cvar("zp_triggered_lights", "1")
	cvar_removedoors = register_cvar("zp_remove_doors", "0")
	cvar_blockpushables = register_cvar("zp_blockuse_pushables", "1")
	cvar_blocksuicide = register_cvar("zp_block_suicide", "1")
	cvar_randspawn = register_cvar("zp_random_spawn", "1")
	cvar_respawnworldspawnkill = register_cvar("zp_respawn_on_worldspawn_kill", "1")
	cvar_removedropped = register_cvar("zp_remove_dropped", "0")
	cvar_removemoney = register_cvar("zp_remove_money", "1")
	cvar_buycustom = register_cvar("zp_buy_custom", "1")
	cvar_randweapons = register_cvar("zp_random_weapons", "0")
	cvar_adminmodelshuman = register_cvar("zp_admin_models_human", "1")
	cvar_adminknifemodelshuman = register_cvar("zp_admin_knife_models_human", "0")
	cvar_vipmodelshuman = register_cvar("zp_vip_models_human", "1")
	cvar_vipknifemodelshuman = register_cvar("zp_vip_knife_models_human", "1")
	cvar_adminmodelszombie = register_cvar("zp_admin_models_zombie", "1")
	cvar_adminknifemodelszombie = register_cvar("zp_admin_knife_models_zombie", "0")
	cvar_zclasses = register_cvar("zp_zombie_classes", "1")
	cvar_statssave = register_cvar("zp_stats_save", "1")
	cvar_startammopacks = register_cvar("zp_starting_ammo_packs", "5")
	cvar_preventconsecutive = register_cvar("zp_prevent_consecutive_modes", "1")
	cvar_keephealthondisconnect = register_cvar("zp_keep_health_on_disconnect", "1")
	cvar_humansurvive = register_cvar("zp_human_survive", "0")
	cvar_aiminfo = register_cvar("zp_aim_info", "1")
	cvar_gamename = register_cvar("zp_game_name", "Zombie Plague Special 2.0")
	
	// CVARS - Deathmatch
	cvar_deathmatch = register_cvar("zp_deathmatch", "0")
	cvar_spawndelay = register_cvar("zp_spawn_delay", "5")
	cvar_spawnprotection = register_cvar("zp_spawn_protection", "5")
	cvar_respawnonsuicide = register_cvar("zp_respawn_on_suicide", "0")
	cvar_respawnafterlast = register_cvar("zp_respawn_after_last_human", "1")
	cvar_allowrespawninfection = register_cvar("zp_infection_allow_respawn", "1")
	cvar_allowrespawnnem = register_cvar("zp_nem_allow_respawn", "0")
	cvar_allowrespawnsurv = register_cvar("zp_surv_allow_respawn", "0")
	cvar_allowrespawnswarm = register_cvar("zp_swarm_allow_respawn", "0")
	cvar_allowrespawnplague = register_cvar("zp_plague_allow_respawn", "0")
	cvar_respawnzomb = register_cvar("zp_respawn_zombies", "1")
	cvar_respawnhum = register_cvar("zp_respawn_humans", "1")
	cvar_respawnnem = register_cvar("zp_respawn_nemesis", "1")
	cvar_respawnsurv = register_cvar("zp_respawn_survivors", "1")
	cvar_allowrespawnsniper = register_cvar("zp_sniper_allow_respawn", "0")
	cvar_respawnsniper = register_cvar("zp_respawn_snipers", "1")
	cvar_allowrespawnassassin = register_cvar("zp_assassin_allow_respawn", "0")
	cvar_respawnassassin = register_cvar("zp_respawn_assassins", "1")
	cvar_allowrespawnpredator = register_cvar("zp_predator_allow_respawn", "0")
	cvar_respawnpredator = register_cvar("zp_respawn_predators", "1")
	cvar_allowrespawnbombardier = register_cvar("zp_bombardier_allow_respawn", "0")
	cvar_respawnbombardier = register_cvar("zp_respawn_bombardiers", "1")
	cvar_allowrespawnberserker = register_cvar("zp_berserker_allow_respawn", "0")
	cvar_respawnberserker = register_cvar("zp_respawn_berserkers", "1")
	cvar_allowrespawnwesker = register_cvar("zp_wesker_allow_respawn", "0")
	cvar_respawnwesker = register_cvar("zp_respawn_weskers", "1")
	cvar_allowrespawnlnj = register_cvar("zp_lnj_allow_respawn", "0")
	cvar_lnjrespsurv = register_cvar("zp_lnj_respawn_surv", "0")
	cvar_lnjrespnem = register_cvar("zp_lnj_respawn_nem", "0")
	
	// CVARS - Extra Items
	cvar_extraitems = register_cvar("zp_extra_items", "1")
	cvar_extraweapons = register_cvar("zp_extra_weapons", "1")
	cvar_extranvision = register_cvar("zp_extra_nvision", "1")
	cvar_extraantidote = register_cvar("zp_extra_antidote", "1")
	cvar_antidotelimit = register_cvar("zp_extra_antidote_limit", "999")
	cvar_extramadness = register_cvar("zp_extra_madness", "1")
	cvar_madnesslimit = register_cvar("zp_extra_madness_limit", "999")
	cvar_madnessduration = register_cvar("zp_extra_madness_duration", "5.0")
	cvar_extrainfbomb = register_cvar("zp_extra_infbomb", "1")
	cvar_infbomblimit = register_cvar("zp_extra_infbomb_limit", "999")
	cvar_antidote_minzms = register_cvar("zp_extra_antiodote_min_zms", "5")

	
	// CVARS - Flashlight and Nightvision
	cvar_nvggive = register_cvar("zp_nvg_give", "1")
	cvar_customnvg = register_cvar("zp_nvg_custom", "1")
	cvar_nvgsize = register_cvar("zp_nvg_size", "80")
	cvar_nvgcolor[0] = register_cvar("zp_nvg_color_R", "0")
	cvar_nvgcolor[1] = register_cvar("zp_nvg_color_G", "150")
	cvar_nvgcolor[2] = register_cvar("zp_nvg_color_B", "0")
	cvar_humnvgcolor[0] = register_cvar("zp_nvg_hum_color_R", "0")
	cvar_humnvgcolor[1] = register_cvar("zp_nvg_hum_color_G", "150")
	cvar_humnvgcolor[2] = register_cvar("zp_nvg_hum_color_B", "0")
	cvar_nemnvgcolor[0] = register_cvar("zp_nvg_nem_color_R", "150")
	cvar_nemnvgcolor[1] = register_cvar("zp_nvg_nem_color_G", "0")
	cvar_nemnvgcolor[2] = register_cvar("zp_nvg_nem_color_B", "0")
	cvar_assassinnvgcolor[0] = register_cvar("zp_nvg_assassin_color_R", "150")
	cvar_assassinnvgcolor[1] = register_cvar("zp_nvg_assassin_color_G", "70")
	cvar_assassinnvgcolor[2] = register_cvar("zp_nvg_assassin_color_B", "70")
	cvar_predatornvgcolor[0] = register_cvar("zp_nvg_predator_color_R", "150")
	cvar_predatornvgcolor[1] = register_cvar("zp_nvg_predator_color_G", "70")
	cvar_predatornvgcolor[2] = register_cvar("zp_nvg_predator_color_B", "70")
	cvar_bombardiernvgcolor[0] = register_cvar("zp_nvg_bombardier_color_R", "150")
	cvar_bombardiernvgcolor[1] = register_cvar("zp_nvg_bombardier_color_G", "70")
	cvar_bombardiernvgcolor[2] = register_cvar("zp_nvg_bombardier_color_B", "70")
	cvar_customflash = register_cvar("zp_flash_custom", "0")
	cvar_flashsize = register_cvar("zp_flash_size", "10")
	cvar_flashsize2 = register_cvar("zp_flash_size_assassin", "7")
	cvar_flashdrain = register_cvar("zp_flash_drain", "1")
	cvar_flashcharge = register_cvar("zp_flash_charge", "5")
	cvar_flashdist = register_cvar("zp_flash_distance", "1000")
	cvar_flashcolor[0] = register_cvar("zp_flash_color_R", "100")
	cvar_flashcolor[1] = register_cvar("zp_flash_color_G", "100")
	cvar_flashcolor[2] = register_cvar("zp_flash_color_B", "100")
	cvar_flashcolor2[0] = register_cvar("zp_flash_color_assassin_R", "100")
	cvar_flashcolor2[1] = register_cvar("zp_flash_color_assassin_G", "0")
	cvar_flashcolor2[2] = register_cvar("zp_flash_color_assassin_B", "0")
	cvar_flashshowall = register_cvar("zp_flash_show_all", "1")
	
	// CVARS - Knockback
	cvar_knockback = register_cvar("zp_knockback", "0")
	cvar_knockbackdamage = register_cvar("zp_knockback_damage", "1")
	cvar_knockbackpower = register_cvar("zp_knockback_power", "1")
	cvar_knockbackzvel = register_cvar("zp_knockback_zvel", "0")
	cvar_knockbackducking = register_cvar("zp_knockback_ducking", "0.25")
	cvar_knockbackdist = register_cvar("zp_knockback_distance", "500")
	cvar_nemknockback = register_cvar("zp_knockback_nemesis", "0.25")
	cvar_assassinknockback = register_cvar("zp_knockback_assassin", "0.25")
	cvar_predatorknockback = register_cvar("zp_knockback_predator", "0.25")
	cvar_bombardierknockback = register_cvar("zp_knockback_bombardier", "0.25")
	
	// CVARS - Leap
	cvar_leapzombies = register_cvar("zp_leap_zombies", "0")
	cvar_leapzombiesforce = register_cvar("zp_leap_zombies_force", "500")
	cvar_leapzombiesheight = register_cvar("zp_leap_zombies_height", "300")
	cvar_leapzombiescooldown = register_cvar("zp_leap_zombies_cooldown", "5.0")
	cvar_leapnemesis = register_cvar("zp_leap_nemesis", "1")
	cvar_leapnemesisforce = register_cvar("zp_leap_nemesis_force", "500")
	cvar_leapnemesisheight = register_cvar("zp_leap_nemesis_height", "300")
	cvar_leapnemesiscooldown = register_cvar("zp_leap_nemesis_cooldown", "5.0")
	cvar_leapsurvivor = register_cvar("zp_leap_survivor", "0")
	cvar_leapsurvivorforce = register_cvar("zp_leap_survivor_force", "500")
	cvar_leapsurvivorheight = register_cvar("zp_leap_survivor_height", "300")
	cvar_leapsurvivorcooldown = register_cvar("zp_leap_survivor_cooldown", "5.0")
	cvar_leapsniper = register_cvar("zp_leap_sniper", "0")
	cvar_leapsniperforce = register_cvar("zp_leap_sniper_force", "500")
	cvar_leapsniperheight = register_cvar("zp_leap_sniper_height", "300")
	cvar_leapsnipercooldown = register_cvar("zp_leap_sniper_cooldown", "5.0")
	cvar_leapassassin = register_cvar("zp_leap_assassin", "0")
	cvar_leapassassinforce = register_cvar("zp_leap_assassin_force", "500")
	cvar_leapassassinheight = register_cvar("zp_leap_assassin_height", "300")
	cvar_leapassassincooldown = register_cvar("zp_leap_assassin_cooldown", "5.0")
	cvar_leappredator = register_cvar("zp_leap_predator", "0")
	cvar_leappredatorforce = register_cvar("zp_leap_predator_force", "500")
	cvar_leappredatorheight = register_cvar("zp_leap_predator_height", "300")
	cvar_leappredatorcooldown = register_cvar("zp_leap_predator_cooldown", "5.0")
	cvar_leapbombardier = register_cvar("zp_leap_bombardier", "0")
	cvar_leapbombardierforce = register_cvar("zp_leap_bombardier_force", "500")
	cvar_leapbombardierheight = register_cvar("zp_leap_bombardier_height", "300")
	cvar_leapbombardiercooldown = register_cvar("zp_leap_bombardier_cooldown", "5.0")
	cvar_leapberserker = register_cvar("zp_leap_berserker", "0")
	cvar_leapberserkerforce = register_cvar("zp_leap_berserker_force", "500")
	cvar_leapberserkerheight = register_cvar("zp_leap_berserker_height", "300")
	cvar_leapberserkercooldown = register_cvar("zp_leap_berserker_cooldown", "5.0")
	cvar_leapwesker = register_cvar("zp_leap_wesker", "0")
	cvar_leapweskerforce = register_cvar("zp_leap_wesker_force", "500")
	cvar_leapweskerheight = register_cvar("zp_leap_wesker_height", "300")
	cvar_leapweskercooldown = register_cvar("zp_leap_wesker_cooldown", "5.0")
	
	// CVARS - Humans
	cvar_humanhp = register_cvar("zp_human_health", "100")
	cvar_humanlasthp = register_cvar("zp_human_last_extrahp", "0")
	cvar_humanspd = register_cvar("zp_human_speed", "240")
	cvar_humangravity = register_cvar("zp_human_gravity", "1.0")
	cvar_humanarmor = register_cvar("zp_human_armor_protect", "1")
	cvar_infammo = register_cvar("zp_human_unlimited_ammo", "0")
	cvar_ammodamage = register_cvar("zp_human_damage_reward", "500")
	cvar_fragskill = register_cvar("zp_human_frags_for_kill", "1")
	
	// CVARS - Custom Grenades
	cvar_firegrenades = register_cvar("zp_fire_grenades", "1")
	cvar_fireduration = register_cvar("zp_fire_duration", "10")
	cvar_firedamage = register_cvar("zp_fire_damage", "5")
	cvar_fireslowdown = register_cvar("zp_fire_slowdown", "0.5")
	cvar_frostgrenades = register_cvar("zp_frost_grenades", "1")
	cvar_freezeduration = register_cvar("zp_frost_duration", "3")
	cvar_frozenhit = register_cvar("zp_frost_hit", "1")
	cvar_flaregrenades = register_cvar("zp_flare_grenades","1")
	cvar_flareduration = register_cvar("zp_flare_duration", "60")
	cvar_flaresize = register_cvar("zp_flare_size", "25")
	cvar_flarecolor = register_cvar("zp_flare_color", "5")
	cvar_flaresize2 = register_cvar("zp_flare_size_assassin", "15")
	
	// CVARS - Zombies
	cvar_zombiefirsthp = register_cvar("zp_zombie_first_hp", "2.0")
	cvar_zombiearmor = register_cvar("zp_zombie_armor", "0.75")
	cvar_hitzones = register_cvar("zp_zombie_hitzones", "0")
	cvar_zombiebonushp = register_cvar("zp_zombie_infect_health", "100")
	cvar_zombiefov = register_cvar("zp_zombie_fov", "110")
	cvar_zombiesilent = register_cvar("zp_zombie_silent", "1")
	cvar_zombiepainfree = register_cvar("zp_zombie_painfree", "2")
	cvar_zombiebleeding = register_cvar("zp_zombie_bleeding", "1")
	cvar_ammoinfect = register_cvar("zp_zombie_infect_reward", "1")
	cvar_fragsinfect = register_cvar("zp_zombie_frags_for_infect", "1")
	
	// CVARS - Special Effects
	cvar_infectionscreenfade = register_cvar("zp_infection_screenfade", "1")
	cvar_infectionscreenshake = register_cvar("zp_infection_screenshake", "1")
	cvar_infectionsparkle = register_cvar("zp_infection_sparkle", "1")
	cvar_infectiontracers = register_cvar("zp_infection_tracers", "1")
	cvar_infectionparticles = register_cvar("zp_infection_particles", "1")
	cvar_hudicons = register_cvar("zp_hud_icons", "1")
	cvar_sniperfraggore = register_cvar("zp_sniper_frag_gore", "1")
	cvar_nemfraggore = register_cvar("zp_assassin_frag_gore", "1")
	cvar_nemauraradius = register_cvar("zp_zombies_aura_size", "21")
	
	// CVARS - Nemesis
	cvar_nem = register_cvar("zp_nem_enabled", "1")
	cvar_nemchance = register_cvar("zp_nem_chance", "20")
	cvar_nemminplayers = register_cvar("zp_nem_min_players", "0")
	cvar_nemhp = register_cvar("zp_nem_health", "0")
	cvar_nembasehp = register_cvar("zp_nem_base_health", "0")
	cvar_nemspd = register_cvar("zp_nem_speed", "250")
	cvar_nemgravity = register_cvar("zp_nem_gravity", "0.5")
	cvar_nemdamage = register_cvar("zp_nem_damage", "250")
	cvar_nemglow = register_cvar("zp_nem_glow", "1")
	cvar_nemaura = register_cvar("zp_nem_aura", "1")	
	cvar_nempainfree = register_cvar("zp_nem_painfree", "0")
	cvar_nemignorefrags = register_cvar("zp_nem_ignore_frags", "1")
	cvar_nemignoreammo = register_cvar("zp_nem_ignore_rewards", "1")
	
	// CVARS - Survivor
	cvar_surv = register_cvar("zp_surv_enabled", "1")
	cvar_survchance = register_cvar("zp_surv_chance", "20")
	cvar_survminplayers = register_cvar("zp_surv_min_players", "0")
	cvar_survhp = register_cvar("zp_surv_health", "0")
	cvar_survbasehp = register_cvar("zp_surv_base_health", "0")
	cvar_survspd = register_cvar("zp_surv_speed", "230")
	cvar_survgravity = register_cvar("zp_surv_gravity", "1.25")
	cvar_survglow = register_cvar("zp_surv_glow", "1")
	cvar_survaura = register_cvar("zp_surv_aura", "1")
	cvar_survdamage = register_cvar("zp_surv_damage_mult", "5.0")
	cvar_surv_aura[0] = register_cvar("zp_surv_aura_R", "200")
	cvar_surv_aura[1] = register_cvar("zp_surv_aura_G", "200")
	cvar_surv_aura[2] = register_cvar("zp_surv_aura_B", "200")
	cvar_survpainfree = register_cvar("zp_surv_painfree", "1")
	cvar_survignorefrags = register_cvar("zp_surv_ignore_frags", "1")
	cvar_survignoreammo = register_cvar("zp_surv_ignore_rewards", "1")
	cvar_survweapon = register_cvar("zp_surv_weapon", "weapon_m249")
	cvar_survinfammo = register_cvar("zp_surv_unlimited_ammo", "2")
	cvar_surv_aura_radius =  register_cvar("zp_surv_aura_size", "35")
	
	// CVARS - Swarm Mode
	cvar_swarm = register_cvar("zp_swarm_enabled", "1")
	cvar_swarmchance = register_cvar("zp_swarm_chance", "20")
	cvar_swarmminplayers = register_cvar("zp_swarm_min_players", "0")
	
	// CVARS - Multi Infection
	cvar_multi = register_cvar("zp_multi_enabled", "1")
	cvar_multichance = register_cvar("zp_multi_chance", "20")
	cvar_multiminplayers = register_cvar("zp_multi_min_players", "0")
	cvar_multiratio = register_cvar("zp_multi_ratio", "0.15")
	
	// CVARS - Plague Mode
	cvar_plague = register_cvar("zp_plague_enabled", "1")
	cvar_plaguechance = register_cvar("zp_plague_chance", "30")
	cvar_plagueminplayers = register_cvar("zp_plague_min_players", "0")
	cvar_plagueratio = register_cvar("zp_plague_ratio", "0.5")
	cvar_plaguenemnum = register_cvar("zp_plague_nem_number", "1")
	cvar_plaguenemhpmulti = register_cvar("zp_plague_nem_hp_multi", "0.5")
	cvar_plaguesurvnum = register_cvar("zp_plague_surv_number", "1")
	cvar_plaguesurvhpmulti = register_cvar("zp_plague_surv_hp_multi", "0.5")
	
	// CVARS - Sniper
	cvar_sniper = register_cvar("zp_sniper_enabled", "1")
	cvar_sniperchance = register_cvar("zp_sniper_chance", "20")
	cvar_sniperminplayers = register_cvar("zp_sniper_min_players", "0")
	cvar_sniperhp = register_cvar("zp_sniper_health", "0")
	cvar_sniperbasehp = register_cvar("zp_sniper_base_health", "0")
	cvar_sniperspd = register_cvar("zp_sniper_speed", "230")
	cvar_snipergravity = register_cvar("zp_sniper_gravity", "0.75")
	cvar_sniperglow = register_cvar("zp_sniper_glow", "1")
	cvar_sniperaura = register_cvar("zp_sniper_aura", "1")
	cvar_sniperpainfree = register_cvar("zp_sniper_painfree", "1")
	cvar_sniperignorefrags = register_cvar("zp_sniper_ignore_frags", "1")
	cvar_sniperignoreammo = register_cvar("zp_sniper_ignore_rewards", "1")
	cvar_sniperdamage = register_cvar("zp_sniper_damage", "5000.0")
	cvar_sniperinfammo = register_cvar("zp_sniper_unlimited_ammo", "2")
	cvar_sniperauraradius = register_cvar("zp_sniper_aura_size", "25")
	cvar_snipercolor[0] = register_cvar("zp_sniper_aura_color_R", "200")
	cvar_snipercolor[1] = register_cvar("zp_sniper_aura_color_G", "200")
	cvar_snipercolor[2]= register_cvar("zp_sniper_aura_color_B", "0")
	
	// CVARS - Assassin
	cvar_assassin = register_cvar("zp_assassin_enabled", "1")
	cvar_assassinchance = register_cvar("zp_assassin_chance", "20")
	cvar_assassinminplayers = register_cvar("zp_assassin_min_players", "0")
	cvar_assassinhp = register_cvar("zp_assassin_health", "0")
	cvar_assassinbasehp = register_cvar("zp_assassin_base_health", "0")
	cvar_assassinspd = register_cvar("zp_assassin_speed", "250")
	cvar_assassingravity = register_cvar("zp_assassin_gravity", "0.5")
	cvar_assassindamage = register_cvar("zp_assassin_damage", "250")
	cvar_assassinglow = register_cvar("zp_assassin_glow", "1")
	cvar_assassinaura = register_cvar("zp_assassin_aura", "1")	
	cvar_assassinpainfree = register_cvar("zp_assassin_painfree", "0")
	cvar_assassinignorefrags = register_cvar("zp_assassin_ignore_frags", "1")
	cvar_assassinignoreammo = register_cvar("zp_assassin_ignore_rewards", "1")
	
	// CVARS - Predator
	cvar_predator = register_cvar("zp_predator_enabled", "1")
	cvar_predatorchance = register_cvar("zp_predator_chance", "20")
	cvar_predatorminplayers = register_cvar("zp_predator_min_players", "0")
	cvar_predatorhp = register_cvar("zp_predator_health", "0")
	cvar_predatorbasehp = register_cvar("zp_predator_base_health", "0")
	cvar_predatorspd = register_cvar("zp_predator_speed", "250")
	cvar_predatorgravity = register_cvar("zp_predator_gravity", "0.5")
	cvar_predatordamage = register_cvar("zp_predator_damage", "250")
	cvar_predatorglow = register_cvar("zp_predator_glow", "0")
	cvar_predatoraura = register_cvar("zp_predator_aura", "0")	
	cvar_predatorpainfree = register_cvar("zp_predator_painfree", "0")
	cvar_predatorignorefrags = register_cvar("zp_predator_ignore_frags", "1")
	cvar_predatorignoreammo = register_cvar("zp_predator_ignore_rewards", "1")
	
	// CVARS - Bombardier
	cvar_bombardier = register_cvar("zp_bombardier_enabled", "1")
	cvar_bombardierchance = register_cvar("zp_bombardier_chance", "20")
	cvar_bombardierminplayers = register_cvar("zp_bombardier_min_players", "0")
	cvar_bombardierhp = register_cvar("zp_bombardier_health", "0")
	cvar_bombardierbasehp = register_cvar("zp_bombardier_base_health", "0")
	cvar_bombardierspd = register_cvar("zp_bombardier_speed", "250")
	cvar_bombardiergravity = register_cvar("zp_bombardier_gravity", "0.5")
	cvar_bombardierdamage = register_cvar("zp_bombardier_damage", "250")
	cvar_bombardierglow = register_cvar("zp_bombardier_glow", "1")
	cvar_bombardieraura = register_cvar("zp_bombardier_aura", "1")	
	cvar_bombardierpainfree = register_cvar("zp_bombardier_painfree", "0")
	cvar_bombardierignorefrags = register_cvar("zp_bombardier_ignore_frags", "1")
	cvar_bombardierignoreammo = register_cvar("zp_bombardier_ignore_rewards", "1")

	// CVARS - Berserker
	cvar_berserker = register_cvar("zp_berserker_enabled", "1")
	cvar_berserkerchance = register_cvar("zp_berserker_chance", "20")
	cvar_berserkerminplayers = register_cvar("zp_berserker_min_players", "0")
	cvar_berserkerhp = register_cvar("zp_berserker_health", "0")
	cvar_berserkerbasehp = register_cvar("zp_berserker_base_health", "0")
	cvar_berserkerspd = register_cvar("zp_berserker_speed", "230")
	cvar_berserkergravity = register_cvar("zp_berserker_gravity", "0.75")
	cvar_berserkerglow = register_cvar("zp_berserker_glow", "1")
	cvar_berserkeraura = register_cvar("zp_berserker_aura", "1")
	cvar_berserkerpainfree = register_cvar("zp_berserker_painfree", "1")
	cvar_berserkerignorefrags = register_cvar("zp_berserker_ignore_frags", "1")
	cvar_berserkerignoreammo = register_cvar("zp_berserker_ignore_rewards", "1")
	cvar_berserkerdamage = register_cvar("zp_berserker_damage", "5000.0")
	cvar_berserkerauraradius = register_cvar("zp_berserker_aura_size", "25")
	cvar_berserkercolor[0] = register_cvar("zp_berserker_aura_color_R", "200")
	cvar_berserkercolor[1] = register_cvar("zp_berserker_aura_color_G", "200")
	cvar_berserkercolor[2]= register_cvar("zp_berserker_aura_color_B", "0")	
	
	// CVARS - Wesker
	cvar_wesker = register_cvar("zp_wesker_enabled", "1")
	cvar_weskerchance = register_cvar("zp_wesker_chance", "20")
	cvar_weskerminplayers = register_cvar("zp_wesker_min_players", "0")
	cvar_weskerhp = register_cvar("zp_wesker_health", "0")
	cvar_weskerbasehp = register_cvar("zp_wesker_base_health", "0")
	cvar_weskerspd = register_cvar("zp_wesker_speed", "230")
	cvar_weskergravity = register_cvar("zp_wesker_gravity", "0.75")
	cvar_weskerglow = register_cvar("zp_wesker_glow", "1")
	cvar_weskeraura = register_cvar("zp_wesker_aura", "1")
	cvar_weskerpainfree = register_cvar("zp_wesker_painfree", "1")
	cvar_weskerignorefrags = register_cvar("zp_wesker_ignore_frags", "1")
	cvar_weskerignoreammo = register_cvar("zp_wesker_ignore_rewards", "1")
	cvar_weskerdamage = register_cvar("zp_wesker_damage_multi", "6.0")
	cvar_weskerauraradius = register_cvar("zp_wesker_aura_size", "25")
	cvar_weskerinfammo = register_cvar("zp_wesker_unlimited_ammo", "2")
	cvar_weskercolor[0] = register_cvar("zp_wesker_aura_color_R", "200")
	cvar_weskercolor[1] = register_cvar("zp_wesker_aura_color_G", "200")
	cvar_weskercolor[2] = register_cvar("zp_wesker_aura_color_B", "0")	

	// CVARS - LNJ Mode
	cvar_lnj = register_cvar("zp_lnj_enabled", "1")
	cvar_lnjchance = register_cvar("zp_lnj_chance", "30")
	cvar_lnjminplayers = register_cvar("zp_lnj_min_players", "0")
	cvar_lnjnemhpmulti = register_cvar("zp_lnj_nem_hp_multi", "2.0")
	cvar_lnjsurvhpmulti = register_cvar("zp_lnj_surv_hp_multi", "4.0")
	cvar_lnjratio = register_cvar("zp_lnj_ratio", "0.5")
	
	// CVARS - Others
	cvar_logcommands = register_cvar("zp_logcommands", "1")
	cvar_showactivity = get_cvar_pointer("amx_show_activity")
	cvar_botquota = get_cvar_pointer("bot_quota")
	register_cvar("zp_version_adv", "1.6.1", FCVAR_SERVER|FCVAR_SPONLY)
	set_cvar_string("zp_version_adv", "1.6.1")
	
	// Custom Forwards
	g_forwards[ROUND_START] = CreateMultiForward("zp_round_started", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[ROUND_START_PRE] = CreateMultiForward("zp_round_started_pre", ET_CONTINUE, FP_CELL)
	g_forwards[ROUND_END] = CreateMultiForward("zp_round_ended", ET_IGNORE, FP_CELL)
	g_forwards[INFECTED_PRE] = CreateMultiForward("zp_user_infected_pre", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL)
	g_forwards[INFECTED_POST] = CreateMultiForward("zp_user_infected_post", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL)
	g_forwards[HUMANIZED_PRE] = CreateMultiForward("zp_user_humanized_pre", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[HUMANIZED_POST] = CreateMultiForward("zp_user_humanized_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[INFECT_ATTEMP] = CreateMultiForward("zp_user_infect_attempt", ET_CONTINUE, FP_CELL, FP_CELL, FP_CELL)
	g_forwards[HUMANIZE_ATTEMP] = CreateMultiForward("zp_user_humanize_attempt", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[ITEM_SELECTED_POST] = CreateMultiForward("zp_extra_item_selected", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[USER_UNFROZEN] = CreateMultiForward("zp_user_unfrozen", ET_IGNORE, FP_CELL)
	g_forwards[USER_LAST_ZOMBIE] = CreateMultiForward("zp_user_last_zombie", ET_IGNORE, FP_CELL)
	g_forwards[USER_LAST_HUMAN] = CreateMultiForward("zp_user_last_human", ET_IGNORE, FP_CELL)
	g_forwards[GAME_MODE_SELECTED] = CreateMultiForward("zp_game_mode_selected", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[PLAYER_SPAWN_POST] = CreateMultiForward("zp_player_spawn_post", ET_IGNORE, FP_CELL)
	
	// New Forwards
	g_forwards[FROZEN_PRE] = CreateMultiForward("zp_user_frozen_pre", ET_CONTINUE, FP_CELL)
	g_forwards[FROZEN_POST] = CreateMultiForward("zp_user_frozen_post", ET_IGNORE, FP_CELL)
	g_forwards[BURN_PRE] = CreateMultiForward("zp_user_burn_pre", ET_CONTINUE, FP_CELL)
	g_forwards[BURN_POST] = CreateMultiForward("zp_user_burn_post", ET_IGNORE, FP_CELL)
	g_forwards[ITEM_SELECTED_PRE] = CreateMultiForward("zp_extra_item_selected_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[CLASS_CHOOSED_PRE] = CreateMultiForward("zp_zombie_class_choosed_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[CLASS_CHOOSED_POST] = CreateMultiForward("zp_zombie_class_choosed_post", ET_IGNORE, FP_CELL, FP_CELL)
	
	// Collect random spawn points
	load_spawns()
	
	// Set a random skybox?
	if (g_sky_enable)
	{
		new sky[32]
		ArrayGetString(g_sky_names, random_num(0, ArraySize(g_sky_names) - 1), sky, charsmax(sky))
		set_cvar_string("sv_skyname", sky)
	}
	
	// Disable sky lighting so it doesn't mess with our custom lighting
	set_cvar_num("sv_skycolor_r", 0)
	set_cvar_num("sv_skycolor_g", 0)
	set_cvar_num("sv_skycolor_b", 0)
	
	// Create the HUD Sync Objects
	g_MsgSync[0] = CreateHudSyncObj()
	g_MsgSync[1] = CreateHudSyncObj()
	g_MsgSync[2] = CreateHudSyncObj()
	
	// Format mod name
	get_pcvar_string(cvar_gamename, game_name, charsmax(game_name))
	formatex(g_modname, charsmax(g_modname), game_name)
	
	// Get Max Players
	g_maxplayers = get_maxplayers()
	
	// Reserved saving slots starts on maxplayers+1
	db_slot_i = g_maxplayers+1
	
	// Check if it's a CZ server
	new mymod[6]
	get_modname(mymod, charsmax(mymod))
	if (equal(mymod, "czero")) g_czero = 1
}

public plugin_cfg()
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// Get configs dir
	new cfgdir[32]
	get_configsdir(cfgdir, charsmax(cfgdir))
	
	// Execute config file (zombie_plague_advance.cfg)
	server_cmd("exec %s/zombie_plague_special.cfg", cfgdir)
	
	// Prevent any more stuff from registering
	g_arrays_created = false
	
	// Save customization data
	//save_customization()
	
	// Lighting task
	set_task(5.0, "lighting_effects", _, _, _, "b")
	
	// Cache CVARs after configs are loaded / call roundstart manually
	set_task(0.5, "cache_cvars")
	set_task(0.5, "event_round_start")
	set_task(0.5, "logevent_round_start")
}

/*================================================================================
 [Main Events]
=================================================================================*/

// Event Round Start
public event_round_start()
{
	// Remove doors/lights?
	set_task(0.1, "remove_stuff")
	
	// New round starting
	g_newround = true
	g_endround = false
	g_modestarted = false
	g_allowinfection = false
	
	// No present mode in progress ?
	g_currentmode = MODE_NONE
	
	// Reset bought infection bombs counter
	g_infbombcounter = 0
	g_antidotecounter = 0
	g_madnesscounter = 0
	g_Mode = 0
	
	// Freezetime begins
	g_freezetime = true
	
	// Show welcome message and T-Virus notice
	remove_task(TASK_WELCOMEMSG)
	set_task(2.0, "welcome_msg", TASK_WELCOMEMSG)
	
	// Set a new "Make Zombie Task"
	remove_task(TASK_MAKEZOMBIE)
	set_task(2.0 + get_pcvar_float(cvar_warmup), "make_zombie_task", TASK_MAKEZOMBIE)
	
	for(new id = 1; id <= g_maxplayers; id++) g_zombieclassnext[id] = ZCLASS_NONE
}

// Log Event Round Start
public logevent_round_start()
{
	// Freezetime ends
	g_freezetime = false
}

// Log Event Round End
public logevent_round_end()
{
	// Prevent this from getting called twice when restarting (bugfix)
	static Float:lastendtime, Float:current_time
	current_time = get_gametime()
	if (current_time - lastendtime < 0.5) return;
	lastendtime = current_time
	
	// Temporarily save player stats?
	if (get_pcvar_num(cvar_statssave))
	{
		static id, team
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not connected
			if (!g_isconnected[id])
				continue;
			
			
			
			team = fm_cs_get_user_team(id)
			
			// Not playing
			if (team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
				continue;
			
			save_stats(id)
		}
	}
	
	// Round ended
	g_endround = true
	
	// No infection allowed
	g_allowinfection = false
	
	// No current mode is bieng played
	g_currentmode = MODE_NONE
	
	// Stop old tasks (if any)
	remove_task(TASK_WELCOMEMSG)
	remove_task(TASK_MAKEZOMBIE)
	remove_task(TASK_AMBIENCESOUNDS)
	ambience_sound_stop()
	
	// Show HUD notice, play win sound, update team scores...
	static sound[64]
	if (!fnGetZombies())
	{
		// Human team wins
		set_hudmessage(0, 0, 200, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_HUMAN")
		
		// Play win sound and increase score
		ArrayGetString(sound_win_humans, random_num(0, ArraySize(sound_win_humans) - 1), sound, charsmax(sound))
		PlaySound(sound)
		g_scorehumans++
		
		// Round end forward
		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, ZP_TEAM_HUMAN);
	}
	else if (!fnGetHumans())
	{
		// Zombie team wins
		set_hudmessage(200, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_ZOMBIE")
		
		// Play win sound and increase score
		ArrayGetString(sound_win_zombies, random_num(0, ArraySize(sound_win_zombies) - 1), sound, charsmax(sound))
		PlaySound(sound)
		g_scorezombies++
		
		// Round end forward
		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, ZP_TEAM_ZOMBIE);
	}
	else if (get_pcvar_num(cvar_humansurvive))
	{
		// Humans survived the plague
		set_hudmessage(0, 200, 100, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_HUMAN_SURVIVE")
		
		// Play win sound and increase human score
		ArrayGetString(sound_win_humans, random_num(0, ArraySize(sound_win_humans) - 1), sound, charsmax(sound))
		PlaySound(sound)
		g_scorehumans++
		
		// Round end forward (will remain same)
		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, ZP_TEAM_NO_ONE);
	}
	else 
	{
		// No one wins
		set_hudmessage(0, 200, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_NO_ONE")
		
		// Play win sound and increase human score
		ArrayGetString(sound_win_no_one, random_num(0, ArraySize(sound_win_no_one) - 1), sound, charsmax(sound))
		PlaySound(sound)
		
		// Round end forward
		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, ZP_TEAM_NO_ONE);
	}
	
	// Balance the teams
	balance_teams()
}

// Event Map Ended
public event_intermission()
{
	// Remove ambience sounds task
	remove_task(TASK_AMBIENCESOUNDS)
}

// BP Ammo update
public event_ammo_x(id)
{
	// Humans only
	if (g_zombie[id])
		return;
	
	// Get ammo type
	static type
	type = read_data(1)
	
	// Unknown ammo type
	if (type >= sizeof AMMOWEAPON)
		return;
	
	// Get weapon's id
	static weapon
	weapon = AMMOWEAPON[type]
	
	// Primary and secondary only
	if (MAXBPAMMO[weapon] <= 2)
		return;
	
	// Get ammo amount
	static amount
	amount = read_data(2)
	
	// Unlimited BP Ammo?
	if (g_hm_special[id] <= 0 && get_pcvar_num(cvar_infammo) || g_hm_special[id] == SURVIVOR && get_pcvar_num(cvar_survinfammo) 
	|| g_hm_special[id] == SNIPER && get_pcvar_num(cvar_sniperinfammo) || g_hm_special[id] == WESKER && get_pcvar_num(cvar_weskerinfammo))
	{
		if (amount < MAXBPAMMO[weapon])
		{
			// The BP Ammo refill code causes the engine to send a message, but we
			// can't have that in this forward or we risk getting some recursion bugs.
			// For more info see: https://bugs.alliedmods.net/show_bug.cgi?id=3664
			static args[1]
			args[0] = weapon
			set_task(0.1, "refill_bpammo", id, args, sizeof args)
		}
	}
	
	// Bots automatically buy ammo when needed
	if (g_isbot[id] && amount <= BUYAMMO[weapon])
	{
		// Task needed for the same reason as above
		set_task(0.1, "clcmd_buyammo", id)
	}
}

/*================================================================================
 [Main Forwards]
=================================================================================*/

// Entity Spawn Forward
public fw_Spawn(entity)
{
	// Invalid entity
	if (!pev_valid(entity)) return FMRES_IGNORED;
	
	// Get classname
	new classname[32], objective[32], size = ArraySize(g_objective_ents)
	pev(entity, pev_classname, classname, charsmax(classname))
	
	// Check whether it needs to be removed
	for (new i = 0; i < size; i++)
	{
		ArrayGetString(g_objective_ents, i, objective, charsmax(objective))
		
		if (equal(classname, objective))
		{
			engfunc(EngFunc_RemoveEntity, entity)
			return FMRES_SUPERCEDE;
		}
	}
	
	return FMRES_IGNORED;
}

// Sound Precache Forward
public fw_PrecacheSound(const sound[])
{
	// Block all those unneeeded hostage sounds
	if (equal(sound, "hostage", 7))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Ham Player Spawn Post Forward
public fw_PlayerSpawn_Post(id)
{
	// Not alive or didn't join a team yet
	if (!is_user_alive(id) || !fm_cs_get_user_team(id))
		return;
	
	// Player spawned
	g_isalive[id] = true
	
	// Remove previous tasks
	remove_task(id+TASK_SPAWN)
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_CHARGE)
	remove_task(id+TASK_FLASH)
	remove_task(id+TASK_NVISION)
	
	// Spawn at a random location?
	if (get_pcvar_num(cvar_randspawn)) do_random_spawn(id)
	
	// Hide money?
	if (get_pcvar_num(cvar_removemoney))
		set_task(0.4, "task_hide_money", id+TASK_SPAWN)
	
	// Respawn player if he dies because of a worldspawn kill?
	if (get_pcvar_num(cvar_respawnworldspawnkill))
		set_task(2.0, "respawn_player_task", id+TASK_SPAWN)
	
	// Check whether to transform the player before spawning
	if (!g_newround)
	{
		// Respawn as a zombie ?
		if (g_respawn_as_zombie[id])
		{
			// Reset player vars
			reset_vars(id, 0)
			
			// Respawn as a nemesis on LNJ round ?
			if (g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespnem))
			{
				// Make him nemesis right away
				zombieme(id, 0, NEMESIS, 0, 0)
				
				// Apply the nemesis health multiplier
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjnemhpmulti)))
			}
			// Make him zombie right away
			else zombieme(id, 0, 0, 0, 0)
		}
		else
		{
			// Reset player vars
			reset_vars(id, 0)
			
			// Respawn as a survivor on LNJ round ?
			if (g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespsurv))
			{
				// Make him survivor right away
				humanme(id, SURVIVOR, 0)
				
				// Apply the survivor health multiplier
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti)))
			}
		}
		
		// Execute our player spawn post forward
		if (g_zombie[id] || g_hm_special[id] == SURVIVOR)
		{
			ExecuteForward(g_forwards[PLAYER_SPAWN_POST], g_fwDummyResult, id);
			return;
		}
	}
	
	// Reset player vars
	reset_vars(id, 0)
	
	// Show custom buy menu?
	if (get_pcvar_num(cvar_buycustom))
		set_task(0.2, "show_menu_buy1", id+TASK_SPAWN)
	
	// Set health and gravity
	fm_set_user_health(id, get_pcvar_num(cvar_humanhp))
	set_pev(id, pev_gravity, get_pcvar_float(cvar_humangravity))
	
	// Switch to CT if spawning mid-round
	if (!g_newround && fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		if (get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
		{
			iRand = random_num(0, ArraySize(model_admin_human) - 1)
			ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
		}
		else if (get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]))
		{
			iRand = random_num(0, ArraySize(model_vip_human) - 1)
			ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
		}
		else
		{
			iRand = random_num(0, ArraySize(model_human) - 1)
			ArrayGetString(model_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human, iRand))
		}
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Remove glow on player model entity
		fm_set_rendering(g_ent_playermodel[id])
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
		{
			size = ArraySize(model_admin_human)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_admin_human, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
			}
		}
		else if (get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]))
		{
			size = ArraySize(model_vip_human)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_vip_human, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
			}
		}
		else
		{
			size = ArraySize(model_human)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_human, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human, iRand))
			}
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Remove glow
		fm_set_rendering(id)
	}
	
	// Bots stuff
	if (g_isbot[id])
	{
		// Turn off NVG for bots
		cs_set_user_nvg(id, 0)
		
		// Automatically buy extra items/weapons after first zombie is chosen
		if (get_pcvar_num(cvar_extraitems))
		{
			if (g_newround) set_task(10.0 + get_pcvar_float(cvar_warmup), "bot_buy_extras", id+TASK_SPAWN)
			else set_task(10.0, "bot_buy_extras", id+TASK_SPAWN)
		}
	}
	
	// Enable spawn protection for humans spawning mid-round
	if (!g_newround && get_pcvar_float(cvar_spawnprotection) > 0.0)
	{
		// Do not take damage
		g_nodamage[id] = true
		
		set_pev(id, pev_takedamage, DAMAGE_NO)
		
		// Make temporarily invisible
		set_pev(id, pev_effects, pev(id, pev_effects) | EF_NODRAW)
		
		// Set task to remove it
		set_task(get_pcvar_float(cvar_spawnprotection), "remove_spawn_protection", id+TASK_SPAWN)
	}
	
	// Set the flashlight charge task to update battery status
	if (g_cached_customflash)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	
	// Replace weapon models (bugfix)
	static weapon_ent; weapon_ent = fm_cs_get_current_weapon_ent(id)
	if (pev_valid(weapon_ent)) replace_weapon_models(id, cs_get_weapon_id(weapon_ent))
	
	// Last Zombie Check
	fnCheckLastZombie()
	
	// Execute our player spawn post forward
	ExecuteForward(g_forwards[PLAYER_SPAWN_POST], g_fwDummyResult, id);
}

// Ham Player Killed Forward
public fw_PlayerKilled(victim, attacker, shouldgib)
{
	// Player killed
	g_isalive[victim] = false
	
	// Enable dead players nightvision
	set_task(0.1, "spec_nvision", victim)
	
	// Disable nightvision when killed (bugfix)
	if (get_pcvar_num(cvar_nvggive) == 0 && g_nvision[victim])
	{
		if (get_pcvar_num(cvar_customnvg)) remove_task(victim+TASK_NVISION)
		else if (g_nvisionenabled[victim]) set_user_gnvision(victim, 0)
		g_nvision[victim] = false
		g_nvisionenabled[victim] = false
	}
	
	// Turn off nightvision when killed (bugfix)
	if (get_pcvar_num(cvar_nvggive) == 2 && g_nvision[victim] && g_nvisionenabled[victim])
	{
		if (get_pcvar_num(cvar_customnvg)) remove_task(victim+TASK_NVISION)
		else set_user_gnvision(victim, 0)
		g_nvisionenabled[victim] = false
	}
	
	// Turn off custom flashlight when killed
	if (g_cached_customflash)
	{
		// Turn it off
		g_flashlight[victim] = false
		g_flashbattery[victim] = 100
		
		// Remove previous tasks
		remove_task(victim+TASK_CHARGE)
		remove_task(victim+TASK_FLASH)
	}
	
	// Stop bleeding/burning/aura when killed
	if (g_zombie[victim] || g_hm_special[victim] > 0 && g_hm_special[victim] < MAX_SPECIALS_HUMANS)
	{
		remove_task(victim+TASK_BLOOD)
		remove_task(victim+TASK_AURA)
		remove_task(victim+TASK_BURN)
	}
	
	// Nemesis and Assassin explode! or when killed by a Assassin victim is cut in pieces
	if (g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES || (g_zm_special[attacker] == ASSASSIN && get_pcvar_num(cvar_nemfraggore)))
		SetHamParamInteger(3, 2)
	
	// Get deathmatch mode status and whether the player killed himself
	static selfkill
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false
	
	// Make sure that the player was not killed by a non-player entity or through self killing
	if (!selfkill)
	{
		// Ignore Nemesis/Survivor/Sniper/Berserker Frags?
		if ((g_zm_special[attacker] == NEMESIS && get_pcvar_num(cvar_nemignorefrags)) || (g_hm_special[attacker] == SURVIVOR && get_pcvar_num(cvar_survignorefrags)) 
		|| (g_hm_special[attacker] == SNIPER && get_pcvar_num(cvar_sniperignorefrags))|| (g_zm_special[attacker] == ASSASSIN && get_pcvar_num(cvar_assassinignorefrags)) 
		|| (g_hm_special[attacker] == BERSERKER && get_pcvar_num(cvar_berserkerignorefrags)) || (g_zm_special[attacker] == PREDATOR && get_pcvar_num(cvar_predatorignorefrags))
		|| (g_hm_special[attacker] == WESKER && get_pcvar_num(cvar_weskerignorefrags)) || (g_zm_special[attacker] == BOMBARDIER && get_pcvar_num(cvar_bombardierignorefrags)))
			RemoveFrags(attacker, victim)
		
		// Zombie/nemesis/assassin killed human, reward ammo packs
		if (g_zombie[attacker] && (g_zm_special[attacker] != NEMESIS || !get_pcvar_num(cvar_nemignoreammo)) && (g_zm_special[attacker] != ASSASSIN || !get_pcvar_num(cvar_assassinignoreammo)) 
		&& (g_zm_special[attacker] != PREDATOR || !get_pcvar_num(cvar_predatorignoreammo)) && (g_zm_special[attacker] != BOMBARDIER || !get_pcvar_num(cvar_bombardierignoreammo)))
			g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
		
		// Human killed zombie, add up the extra frags for kill
		if (!g_zombie[attacker] && get_pcvar_num(cvar_fragskill) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragskill) - 1, 0, 0)
		
		// Zombie killed human, add up the extra frags for kill
		if (g_zombie[attacker] && get_pcvar_num(cvar_fragsinfect) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragsinfect) - 1, 0, 0)
			
		// When killed by a Sniper victim explodes
		if (g_hm_special[attacker] == SNIPER && (g_currentweapon[attacker] == CSW_AWP) && get_pcvar_num(cvar_sniperfraggore) && g_zombie[victim])
		{	
			// Cut him into pieces
			SetHamParamInteger(3, 2)
			
			// Get his origin
			static origin[3]
			get_user_origin(victim, origin)
			
			// Make some blood in the air
			message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
			write_byte(TE_LAVASPLASH) // TE id
			write_coord(origin[0]) // origin x
			write_coord(origin[1]) // origin y
			write_coord(origin[2] - 26) // origin z
			message_end()
		}
	}
	
	// Respawn if deathmatch is enabled
	if (get_pcvar_num(cvar_deathmatch) || ((g_currentmode > MODE_LNJ) && (g_deathmatchmode > 0)))
	{
		// Respawn on suicide?
		if (selfkill && !get_pcvar_num(cvar_respawnonsuicide))
			return;
		
		// Respawn if only the last human is left?
		if (!get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() <= 1)
			return;
		
		// Respawn if human/zombie/nemesis/assassin/survivor/sniper/berserker/wesker?
		if ((g_zombie[victim] && g_zm_special[victim] <= 0 && !get_pcvar_num(cvar_respawnzomb)) || (!g_zombie[victim] && g_hm_special[victim] <= 0 && !get_pcvar_num(cvar_respawnhum)) 
		|| (g_zm_special[victim] == NEMESIS && !get_pcvar_num(cvar_respawnnem)) || (g_hm_special[victim] == SURVIVOR && !get_pcvar_num(cvar_respawnsurv)) 
		|| (g_hm_special[victim] == SNIPER && !get_pcvar_num(cvar_respawnsniper)) || (g_zm_special[victim] == ASSASSIN && !get_pcvar_num(cvar_respawnassassin)) || (g_zm_special[victim] == PREDATOR && !get_pcvar_num(cvar_respawnpredator)) 
		|| (g_zm_special[victim] == BOMBARDIER && !get_pcvar_num(cvar_respawnbombardier)) || (g_hm_special[victim] == BERSERKER && !get_pcvar_num(cvar_respawnberserker)) || (g_hm_special[victim] == WESKER && !get_pcvar_num(cvar_respawnwesker)))
			return;
		
		// Respawn as zombie?
		if ((g_currentmode > MODE_LNJ) && (g_deathmatchmode > 0)) // Custom round ?
		{
			if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
				g_respawn_as_zombie[victim] = true
		}
		else if (get_pcvar_num(cvar_deathmatch) > 0) // Normal round
		{
			if (get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
				g_respawn_as_zombie[victim] = true
		}
		
		// Set the respawn task
		set_task(get_pcvar_float(cvar_spawndelay), "respawn_player_task", victim+TASK_SPAWN)
	}
}

// Ham Player Killed Post Forward
public fw_PlayerKilled_Post()
{
	// Last Zombie Check
	fnCheckLastZombie()
}

// Ham Take Damage Forward
public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if (g_newround || g_endround || g_currentmode == MODE_NONE)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if (g_nodamage[victim] || (g_frozen[victim] && !(get_pcvar_num(cvar_frozenhit))))
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if (is_user_alive(attacker) && fm_cs_get_user_team(attacker) == fm_cs_get_user_team(victim))
		return HAM_SUPERCEDE;
	
	// Attacker is human...
	if (!g_zombie[attacker])
	{
		switch(g_hm_special[attacker])
		{
			case SURVIVOR: if (g_currentweapon[attacker] == CSW_M249) SetHamParamFloat(4, damage * get_pcvar_float(cvar_survdamage))
			case SNIPER: if (g_currentweapon[attacker] == CSW_AWP) SetHamParamFloat(4, get_pcvar_float(cvar_sniperdamage))
			case BERSERKER: if (g_currentweapon[attacker] == CSW_KNIFE) SetHamParamFloat(4, get_pcvar_float(cvar_berserkerdamage))
			case WESKER: if (g_currentweapon[attacker] == CSW_DEAGLE) SetHamParamFloat(4, damage * get_pcvar_float(cvar_weskerdamage))
		}
		
		// Armor multiplier for the final damage on normal zombies
		if (g_zm_special[attacker] <= 0 && g_hm_special[attacker] <= 0)
		{
			damage *= get_pcvar_float(cvar_zombiearmor)
			SetHamParamFloat(4, damage)
		}
		
		if(g_zm_special[victim] == PREDATOR)
		{
			fm_set_rendering(victim, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 255)
			set_task(1.0, "turn_invisible", victim)
		}
		
		// Reward ammo packs
		if ((g_hm_special[attacker] == SURVIVOR && !get_pcvar_num(cvar_survignoreammo)) || (g_hm_special[attacker] == SNIPER && !get_pcvar_num(cvar_sniperignoreammo)) 
		|| (g_hm_special[attacker] == BERSERKER && !get_pcvar_num(cvar_berserkerignoreammo)) || (g_hm_special[attacker] == WESKER && !get_pcvar_num(cvar_weskerignoreammo)) || g_hm_special[attacker] <= 0)
		{
			// Store damage dealt
			g_damagedealt[attacker] += floatround(damage)
			
			// Reward ammo packs for every [ammo damage] dealt
			while (g_damagedealt[attacker] > get_pcvar_num(cvar_ammodamage))
			{
				g_ammopacks[attacker]++
				g_damagedealt[attacker] -= get_pcvar_num(cvar_ammodamage)
			}
		}
	
		return HAM_IGNORED;
	}
	
	// Attacker is zombie...
	
	// Prevent infection/damage by HE grenade (bugfix)
	if (damage_type & DMG_HEGRENADE)
		return HAM_SUPERCEDE;
	
	// Nemesis/Assassin?
	if (g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES)
	{
		// Ignore nemesis/assassin damage override if damage comes from a 3rd party entity
		// (to prevent this from affecting a sub-plugin's rockets e.g.)
		if (inflictor == attacker)
		{
			switch(g_zm_special[attacker])
			{
				case NEMESIS: SetHamParamFloat(4, get_pcvar_float(cvar_nemdamage))
				case ASSASSIN: SetHamParamFloat(4,get_pcvar_float(cvar_assassindamage))
				case PREDATOR: SetHamParamFloat(4, get_pcvar_float(cvar_predatordamage))
				case BOMBARDIER: SetHamParamFloat(4, get_pcvar_float(cvar_bombardierdamage))
			}
		}
		
		return HAM_IGNORED;
	}
	
	// Last human or infection not allowed
	if (!g_allowinfection || fnGetHumans() == 1)
		return HAM_IGNORED; // human is killed
	
	// Does human armor need to be reduced before infecting?
	if (get_pcvar_num(cvar_humanarmor))
	{
		// Get victim armor
		static Float:armor
		pev(victim, pev_armorvalue, armor)
		
		// Block the attack if he has some
		if (armor > 0.0)
		{
			emit_sound(victim, CHAN_BODY, sound_armorhit, 1.0, ATTN_NORM, 0, PITCH_NORM)
			set_pev(victim, pev_armorvalue, floatmax(0.0, armor - damage))
			return HAM_SUPERCEDE;
		}
	}
	
	// Infection allowed
	zombieme(victim, attacker, 0, 0, 1) // turn into zombie
	return HAM_SUPERCEDE;
}

// Ham Take Damage Post Forward
public fw_TakeDamage_Post(victim)
{
	// --- Check if victim should be Pain Shock Free ---
	
	// Check if proper CVARs are enabled
	if (g_zombie[victim])
	{
		switch(g_zm_special[victim])
		{
			case NEMESIS: if (!get_pcvar_num(cvar_nempainfree)) return;
			case ASSASSIN: if (!get_pcvar_num(cvar_assassinpainfree)) return;
			case PREDATOR: if (!get_pcvar_num(cvar_predatorpainfree)) return;
			case BOMBARDIER: if (!get_pcvar_num(cvar_bombardierpainfree)) return;
			default:
			{
				switch (get_pcvar_num(cvar_zombiepainfree))
				{
					case 0: return;
					case 2: if (!g_lastzombie[victim]) return;
				}
			}
		}
	}
	else
	{
		
		
		switch(g_hm_special[victim])
		{
			case SURVIVOR: if (!get_pcvar_num(cvar_survpainfree)) return;
			case SNIPER: if (!get_pcvar_num(cvar_sniperpainfree)) return;
			case BERSERKER: if (!get_pcvar_num(cvar_berserkerpainfree)) return;
			case WESKER: if (!get_pcvar_num(cvar_weskerpainfree)) return;
			default: return;
		}
	}
	
	// Set pain shock free offset
	set_pdata_float(victim, OFFSET_PAINSHOCK, 1.0, OFFSET_LINUX)
}

// Ham Trace Attack Forward
public fw_TraceAttack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type)
{
	// Non-player damage or self damage
	if (victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if (g_newround || g_endround)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if (g_nodamage[victim] || (g_frozen[victim] && !get_pcvar_num(cvar_frozenhit)))
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if (g_zombie[attacker] == g_zombie[victim])
		return HAM_SUPERCEDE;
	
	// Victim isn't a zombie or not bullet damage, nothing else to do here
	if (!g_zombie[victim] || !(damage_type & DMG_BULLET))
		return HAM_IGNORED;
	
	// If zombie hitzones are enabled, check whether we hit an allowed one
	if (get_pcvar_num(cvar_hitzones) && g_zm_special[victim] <= 0 && !(get_pcvar_num(cvar_hitzones) & (1<<get_tr2(tracehandle, TR_iHitgroup))))
		return HAM_SUPERCEDE;
	
	// Knockback disabled, nothing else to do here
	if (!get_pcvar_num(cvar_knockback))
		return HAM_IGNORED;
	
	// Specials knockback disabled, nothing else to do here
	if (g_zm_special[victim] == NEMESIS && get_pcvar_float(cvar_nemknockback) == 0.0 || g_zm_special[victim] == ASSASSIN && get_pcvar_float(cvar_assassinknockback) == 0.0
	|| g_zm_special[victim] == PREDATOR && get_pcvar_float(cvar_predatorknockback) == 0.0 || g_zm_special[victim] == BOMBARDIER && get_pcvar_float(cvar_bombardierknockback) == 0.0)
		return HAM_IGNORED;
	
	// Get whether the victim is in a crouch state
	static ducking
	ducking = pev(victim, pev_flags) & (FL_DUCKING | FL_ONGROUND) == (FL_DUCKING | FL_ONGROUND)
	
	// Zombie knockback when ducking disabled
	if (ducking && get_pcvar_float(cvar_knockbackducking) == 0.0)
		return HAM_IGNORED;
	
	// Get distance between players
	static origin1[3], origin2[3]
	get_user_origin(victim, origin1)
	get_user_origin(attacker, origin2)
	
	// Max distance exceeded
	if (get_distance(origin1, origin2) > get_pcvar_num(cvar_knockbackdist))
		return HAM_IGNORED;
	
	// Get victim's velocity
	static Float:velocity[3]
	pev(victim, pev_velocity, velocity)
	
	// Use damage on knockback calculation
	if (get_pcvar_num(cvar_knockbackdamage))
		xs_vec_mul_scalar(direction, damage, direction)
	
	// Use weapon power on knockback calculation
	if (get_pcvar_num(cvar_knockbackpower) && kb_weapon_power[g_currentweapon[attacker]] > 0.0)
		xs_vec_mul_scalar(direction, kb_weapon_power[g_currentweapon[attacker]], direction)
	
	// Apply ducking knockback multiplier
	if (ducking)
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_knockbackducking), direction)
	
	// Apply zombie class/nemesis knockback multiplier
	switch(g_zm_special[victim])
	{
		case NEMESIS: xs_vec_mul_scalar(direction, get_pcvar_float(cvar_nemknockback), direction)
		case ASSASSIN: xs_vec_mul_scalar(direction, get_pcvar_float(cvar_assassinknockback), direction)
		case PREDATOR: xs_vec_mul_scalar(direction, get_pcvar_float(cvar_predatorknockback), direction)
		case BOMBARDIER: xs_vec_mul_scalar(direction, get_pcvar_float(cvar_bombardierknockback), direction)
		default: xs_vec_mul_scalar(direction, g_zombie_knockback[victim], direction)
	}
	
	// Add up the new vector
	xs_vec_add(velocity, direction, direction)
	
	// Should knockback also affect vertical velocity?
	if (!get_pcvar_num(cvar_knockbackzvel))
		direction[2] = velocity[2]
	
	// Set the knockback'd victim's velocity
	set_pev(victim, pev_velocity, direction)
	
	return HAM_IGNORED;
}

// Ham Use Stationary Gun Forward
public fw_UseStationary(entity, caller, activator, use_type)
{
	// Prevent zombies from using stationary guns
	if (use_type == USE_USING && is_user_valid_connected(caller) && g_zombie[caller])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Use Stationary Gun Post Forward
public fw_UseStationary_Post(entity, caller, activator, use_type)
{
	// Someone stopped using a stationary gun
	if (use_type == USE_STOPPED && is_user_valid_connected(caller))
		replace_weapon_models(caller, g_currentweapon[caller]) // replace weapon models (bugfix)
}

// Ham Use Pushable Forward
public fw_UsePushable()
{
	// Prevent speed bug with pushables?
	if (get_pcvar_num(cvar_blockpushables))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Weapon Touch Forward
public fw_TouchWeapon(weapon, id)
{
	// Not a player
	if (!is_user_valid_connected(id))
		return HAM_IGNORED;
	
	// Dont pickup weapons if zombie, survivor, sniper and (+PODBot MM fix)
	if (g_zombie[id] || (g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS && !g_isbot[id]))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Weapon Pickup Forward
public fw_AddPlayerItem(id, weapon_ent)
{
	// HACK: Retrieve our custom extra ammo from the weapon
	static extra_ammo
	extra_ammo = pev(weapon_ent, PEV_ADDITIONAL_AMMO)
	
	// If present
	if (extra_ammo)
	{
		// Get weapon's id
		static weaponid
		weaponid = cs_get_weapon_id(weapon_ent)
		
		// Add to player's bpammo
		ExecuteHamB(Ham_GiveAmmo, id, extra_ammo, AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
		set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, 0)
	}
}

// Ham Weapon Deploy Forward
public fw_Item_Deploy_Post(weapon_ent)
{
	// Get weapon's owner
	static owner
	owner = fm_cs_get_weapon_ent_owner(weapon_ent)
	
	// Get weapon's id
	static weaponid
	weaponid = cs_get_weapon_id(weapon_ent)
	
	// Store current weapon's id for reference
	g_currentweapon[owner] = weaponid
	
	// Replace weapon models with custom ones
	replace_weapon_models(owner, weaponid)
	
	// Zombie not holding an allowed weapon for some reason
	if (g_zombie[owner] && !((1<<weaponid) & ZOMBIE_ALLOWED_WEAPONS_BITSUM))
	{
		// Switch to knife
		g_currentweapon[owner] = CSW_KNIFE
		engclient_cmd(owner, "weapon_knife")
	}
}

// WeaponMod bugfix
// forward wpn_gi_reset_weapon(id);
public wpn_gi_reset_weapon(id)
{
	// Replace knife model
	replace_weapon_models(id, CSW_KNIFE)
}

// Client joins the game
public client_putinserver(id)
{
	// Plugin disabled?
	if (!g_pluginenabled) return;
	
	// Player joined
	g_isconnected[id] = true
	g_zombieclassnext[id] = ZCLASS_NONE
	
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	// Initialize player vars
	reset_vars(id, 1)
	g_hud_color[0][id] = 8
	g_hud_color[1][id] = 7
	
	// Load player stats?
	if (get_pcvar_num(cvar_statssave)) load_stats(id)
	
	// Set some tasks for humans only
	if (!is_user_bot(id))
	{
		// Set the custom HUD display task
		set_task(1.0, "ShowHUD", id+TASK_SHOWHUD, _, _, "b")
		
		// Disable minmodels for clients to see zombies properly
		set_task(5.0, "disable_minmodels", id)
	}
	else
	{
		// Set bot flag
		g_isbot[id] = true
		
		// CZ bots seem to use a different "classtype" for player entities
		// (or something like that) which needs to be hooked separately
		if (!g_hamczbots && cvar_botquota)
		{
			// Set a task to let the private data initialize
			set_task(0.1, "register_ham_czbots", id)
		}
	}
}

// Client leaving
public fw_ClientDisconnect(id)
{
	// Check that we still have both humans and zombies to keep the round going
	if (g_isalive[id]) check_round(id)
	
	// Temporarily save player stats?
	if (get_pcvar_num(cvar_statssave)) save_stats(id)
	
	// Remove previous tasks
	remove_task(id+TASK_TEAM)
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_FLASH)
	remove_task(id+TASK_CHARGE)
	remove_task(id+TASK_SPAWN)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_NVISION)
	remove_task(id+TASK_SHOWHUD)
	
	if (g_handle_models_on_separate_ent)
	{
		// Remove custom model entities
		fm_remove_model_ents(id)
	}
	
	// Player left, clear cached flags
	g_isconnected[id] = false
	g_isbot[id] = false
	g_isalive[id] = false
}

// Client left
public fw_ClientDisconnect_Post()
{
	// Last Zombie Check
	fnCheckLastZombie()
}

// Client Kill Forward
public fw_ClientKill()
{
	// Prevent players from killing themselves?
	if (get_pcvar_num(cvar_blocksuicide))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Emit Sound Forward
public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch)
{
	// Block all those unneeeded hostage sounds
	if (sample[0] == 'h' && sample[1] == 'o' && sample[2] == 's' && sample[3] == 't' && sample[4] == 'a' && sample[5] == 'g' && sample[6] == 'e')
		return FMRES_SUPERCEDE;
	
	// Replace these next sounds for zombies only
	if (!is_user_valid_connected(id) || !g_zombie[id])
		return FMRES_IGNORED;
	
	static sound[64]
	
	// Zombie being hit
	if (sample[7] == 'b' && sample[8] == 'h' && sample[9] == 'i' && sample[10] == 't')
	{
		if (g_zm_special[id] == NEMESIS)
		{
			ArrayGetString(nemesis_pain, random_num(0, ArraySize(nemesis_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		else if (g_zm_special[id] == ASSASSIN)
		{
			ArrayGetString(assassin_pain, random_num(0, ArraySize(assassin_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		else if (g_zm_special[id] == PREDATOR)
		{
			ArrayGetString(predator_pain, random_num(0, ArraySize(predator_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		else if (g_zm_special[id] == BOMBARDIER)
		{
			ArrayGetString(bombardier_pain, random_num(0, ArraySize(bombardier_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		else
		{
			ArrayGetString(zombie_pain, random_num(0, ArraySize(zombie_pain) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
		}
		return FMRES_SUPERCEDE;
	}
	
	// Zombie attacks with knife
	if (sample[8] == 'k' && sample[9] == 'n' && sample[10] == 'i')
	{
		if (sample[14] == 's' && sample[15] == 'l' && sample[16] == 'a') // slash
		{
			ArrayGetString(zombie_miss_slash, random_num(0, ArraySize(zombie_miss_slash) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
		if (sample[14] == 'h' && sample[15] == 'i' && sample[16] == 't') // hit
		{
			if (sample[17] == 'w') // wall
			{
				ArrayGetString(zombie_miss_wall, random_num(0, ArraySize(zombie_miss_wall) - 1), sound, charsmax(sound))
				emit_sound(id, channel, sound, volume, attn, flags, pitch)
				return FMRES_SUPERCEDE;
			}
			else
			{
				ArrayGetString(zombie_hit_normal, random_num(0, ArraySize(zombie_hit_normal) - 1), sound, charsmax(sound))
				emit_sound(id, channel, sound, volume, attn, flags, pitch)
				return FMRES_SUPERCEDE;
			}
		}
		if (sample[14] == 's' && sample[15] == 't' && sample[16] == 'a') // stab
		{
			ArrayGetString(zombie_hit_stab, random_num(0, ArraySize(zombie_hit_stab) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
	}
	
	// Zombie dies
	if (sample[7] == 'd' && ((sample[8] == 'i' && sample[9] == 'e') || (sample[8] == 'e' && sample[9] == 'a')))
	{
		ArrayGetString(zombie_die, random_num(0, ArraySize(zombie_die) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie falls off
	if (sample[10] == 'f' && sample[11] == 'a' && sample[12] == 'l' && sample[13] == 'l')
	{
		ArrayGetString(zombie_fall, random_num(0, ArraySize(zombie_fall) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	return FMRES_IGNORED;
}

// Forward Set ClientKey Value -prevent CS from changing player models-
public fw_SetClientKeyValue(id, const infobuffer[], const key[])
{
	// Block CS model changes
	if (key[0] == 'm' && key[1] == 'o' && key[2] == 'd' && key[3] == 'e' && key[4] == 'l')
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Forward Client User Info Changed -prevent players from changing models-
public fw_ClientUserInfoChanged(id)
{
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	if (!g_handle_models_on_separate_ent)
	{
		// Get current model
		static currentmodel[32]
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// If they're different, set model again
		if (!equal(currentmodel, g_playermodel[id]) && !task_exists(id+TASK_MODEL))
			fm_cs_set_user_model(id+TASK_MODEL)
	}
}

// Forward Get Game Description
public fw_GetGameDescription()
{
	// Return the mod name so it can be easily identified
	forward_return(FMV_STRING, g_modname)
	
	return FMRES_SUPERCEDE;
}

// Forward Set Model
public fw_SetModel(entity, const model[])
{
	// We don't care
	if (strlen(model) < 8)
		return;
	
	// Remove weapons?
	if (get_pcvar_float(cvar_removedropped) > 0.0)
	{
		// Get entity's classname
		static classname[10]
		pev(entity, pev_classname, classname, charsmax(classname))
		
		// Check if it's a weapon box
		if (equal(classname, "weaponbox"))
		{
			// They get automatically removed when thinking
			set_pev(entity, pev_nextthink, get_gametime() + get_pcvar_float(cvar_removedropped))
			return;
		}
	}
	
	// Narrow down our matches a bit
	if (model[7] != 'w' || model[8] != '_')
		return;
	
	// Get damage time of grenade
	static Float:dmgtime
	pev(entity, pev_dmgtime, dmgtime)
	
	// Grenade not yet thrown
	if (dmgtime == 0.0)
		return;
	
	// Get whether grenade's owner is a zombie
	if (g_zombie[pev(entity, pev_owner)])
	{
		if (model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_extrainfbomb)) // Infection Bomb
		{
			// Give it a glow
			fm_set_rendering(entity, kRenderFxGlowShell, 0, 250, 0, kRenderNormal, 16);
			
			// And a colored trail
			message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
			write_byte(TE_BEAMFOLLOW) // TE id
			write_short(entity) // entity
			write_short(g_trailSpr) // sprite
			write_byte(10) // life
			write_byte(10) // width
			write_byte(0) // r
			write_byte(250) // g
			write_byte(0) // b
			write_byte(200) // brightness
			message_end()
			
			// Set grenade type on the thrown grenade entity
			set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_INFECTION)
		}
	}
	else if (model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_firegrenades)) // Napalm Grenade
	{
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, 200, 0, 0, kRenderNormal, 16);
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_trailSpr) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(200) // r
		write_byte(0) // g
		write_byte(0) // b
		write_byte(200) // brightness
		message_end()
		
		// Set grenade type on the thrown grenade entity
		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_NAPALM)
	}
	else if (model[9] == 'f' && model[10] == 'l' && get_pcvar_num(cvar_frostgrenades)) // Frost Grenade
	{
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 16);
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_trailSpr) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(0) // r
		write_byte(100) // g
		write_byte(200) // b
		write_byte(200) // brightness
		message_end()
		
		// Set grenade type on the thrown grenade entity
		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FROST)
	}
	else if (model[9] == 's' && model[10] == 'm' && get_pcvar_num(cvar_flaregrenades)) // Flare
	{
		// Build flare's color
		static rgb[3]
		switch (get_pcvar_num(cvar_flarecolor))
		{
			case 0: // white
			{
				rgb[0] = 255 // r
				rgb[1] = 255 // g
				rgb[2] = 255 // b
			}
			case 1: // red
			{
				rgb[0] = random_num(50,255) // r
				rgb[1] = 0 // g
				rgb[2] = 0 // b
			}
			case 2: // green
			{
				rgb[0] = 0 // r
				rgb[1] = random_num(50,255) // g
				rgb[2] = 0 // b
			}
			case 3: // blue
			{
				rgb[0] = 0 // r
				rgb[1] = 0 // g
				rgb[2] = random_num(50,255) // b
			}
			case 4: // random (all colors)
			{
				rgb[0] = random_num(50,200) // r
				rgb[1] = random_num(50,200) // g
				rgb[2] = random_num(50,200) // b
			}
			case 5: // random (r,g,b)
			{
				switch (random_num(1, 6))
				{
					case 1: // red
					{
						rgb[0] = 250 // r
						rgb[1] = 0 // g
						rgb[2] = 0 // b
					}
					case 2: // green
					{
						rgb[0] = 0 // r
						rgb[1] = 250 // g
						rgb[2] = 0 // b
					}
					case 3: // blue
					{
						rgb[0] = 0 // r
						rgb[1] = 0 // g
						rgb[2] = 250 // b
					}
					case 4: // cyan
					{
						rgb[0] = 0 // r
						rgb[1] = 250 // g
						rgb[2] = 250 // b
					}
					case 5: // pink
					{
						rgb[0] = 250 // r
						rgb[1] = 0 // g
						rgb[2] = 250 // b
					}
					case 6: // yellow
					{
						rgb[0] = 250 // r
						rgb[1] = 250 // g
						rgb[2] = 0 // b
					}
				}
			}
		}
		
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, rgb[0], rgb[1], rgb[2], kRenderNormal, 16);
		
		// And a colored trail
		message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
		write_byte(TE_BEAMFOLLOW) // TE id
		write_short(entity) // entity
		write_short(g_trailSpr) // sprite
		write_byte(10) // life
		write_byte(10) // width
		write_byte(rgb[0]) // r
		write_byte(rgb[1]) // g
		write_byte(rgb[2]) // b
		write_byte(200) // brightness
		message_end()
		
		// Set grenade type on the thrown grenade entity
		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FLARE)
		
		// Set flare color on the thrown grenade entity
		set_pev(entity, PEV_FLARE_COLOR, rgb)
	}
}

// Ham Grenade Think Forward
public fw_ThinkGrenade(entity)
{
	// Invalid entity
	if (!pev_valid(entity)) return HAM_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime, Float:current_time
	pev(entity, pev_dmgtime, dmgtime)
	current_time = get_gametime()
	
	// Check if it's time to go off
	if (dmgtime > current_time)
		return HAM_IGNORED;
	
	// Check if it's one of our custom nades
	switch (pev(entity, PEV_NADE_TYPE))
	{
		case NADE_TYPE_INFECTION: // Infection Bomb
		{
			infection_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_NAPALM: // Napalm Grenade
		{
			fire_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_FROST: // Frost Grenade
		{
			frost_explode(entity)
			return HAM_SUPERCEDE;
		}
		case NADE_TYPE_FLARE: // Flare
		{
			// Get its duration
			static duration
			duration = pev(entity, PEV_FLARE_DURATION)
			
			// Already went off, do lighting loop for the duration of PEV_FLARE_DURATION
			if (duration > 0)
			{
				// Check whether this is the last loop
				if (duration == 1)
				{
					// Get rid of the flare entity
					engfunc(EngFunc_RemoveEntity, entity)
					return HAM_SUPERCEDE;
				}
				
				// Light it up!
				flare_lighting(entity, duration)
				
				// Set time for next loop
				set_pev(entity, PEV_FLARE_DURATION, --duration)
				set_pev(entity, pev_dmgtime, current_time + 5.0)
			}
			// Light up when it's stopped on ground
			else if ((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10)
			{
				// Flare sound
				static sound[64]
				ArrayGetString(grenade_flare, random_num(0, ArraySize(grenade_flare) - 1), sound, charsmax(sound))
				emit_sound(entity, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				// Set duration and start lightning loop on next think
				set_pev(entity, PEV_FLARE_DURATION, 1 + get_pcvar_num(cvar_flareduration)/5)
				set_pev(entity, pev_dmgtime, current_time + 0.1)
			}
			else
			{
				// Delay explosion until we hit ground
				set_pev(entity, pev_dmgtime, current_time + 0.5)
			}
		}
	}
	
	return HAM_IGNORED;
}

// Forward CmdStart
public fw_CmdStart(id, handle)
{
	// Not alive
	if (!g_isalive[id])
		return;
	
	// This logic looks kinda weird, but it should work in theory...
	// p = g_zombie[id], q = g_hm_special[id] == SURVIVOR, r = g_cached_customflash
	// ¬(p v q v (¬p ^ r)) <==> ¬p ^ ¬q ^ (p v ¬r)
	if (!g_zombie[id] && g_hm_special[id] <= 0 && (g_zombie[id] || !g_cached_customflash))
		return;
	
	// Check if it's a flashlight impulse
	if (get_uc(handle, UC_Impulse) != IMPULSE_FLASHLIGHT)
		return;
	
	// Block it I say!
	set_uc(handle, UC_Impulse, 0)
	
	// Should human's custom flashlight be turned on?
	if (!g_zombie[id] && g_hm_special[id] <= 0 && g_flashbattery[id] > 2 && get_gametime() - g_lastflashtime[id] > 1.2)
	{
		// Prevent calling flashlight too quickly (bugfix)
		g_lastflashtime[id] = get_gametime()
		
		// Toggle custom flashlight
		g_flashlight[id] = !(g_flashlight[id])
		
		// Play flashlight toggle sound
		emit_sound(id, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on the HUD
		message_begin(MSG_ONE, g_msgid[FLASHLIGHT], _, id)
		write_byte(g_flashlight[id]) // toggle
		write_byte(g_flashbattery[id]) // battery
		message_end()
		
		// Remove previous tasks
		remove_task(id+TASK_CHARGE)
		remove_task(id+TASK_FLASH)
		
		// Set the flashlight charge task
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
		
		// Call our custom flashlight task if enabled
		if (g_flashlight[id]) set_task(0.1, "set_user_flashlight", id+TASK_FLASH, _, _, "b")
	}
}

// Forward Player PreThink
public fw_PlayerPreThink(id)
{
	// Not alive
	if (!g_isalive[id])
		return;
	
	// Silent footsteps for zombies/assassins ?
	if ((g_cached_zombiesilent && g_zombie[id] && g_zm_special[id] <= 0))// || g_zm_special[id] == ASSASSIN || g_zm_special[id] == PREDATOR || g_zm_special[id] == BOMBARDIER)
		set_pev(id, pev_flTimeStepSound, STEPTIME_SILENT)
	
	// Set Player MaxSpeed
	if (g_frozen[id])
	{
		set_pev(id, pev_velocity, Float:{0.0,0.0,0.0}) // stop motion
		set_pev(id, pev_maxspeed, 1.0) // prevent from moving
		return; // shouldn't leap while frozen
	}
	else if (g_freezetime)
	{
		return; // shouldn't leap while in freezetime
	}
	else
	{
		if (g_zombie[id])
		{
			switch(g_zm_special[id])
			{
				case NEMESIS: set_pev(id, pev_maxspeed, g_cached_nemspd)
				case ASSASSIN: set_pev(id, pev_maxspeed, g_cached_assassinspd)
				case PREDATOR: set_pev(id, pev_maxspeed, g_cached_predatorspd)
				case BOMBARDIER: set_pev(id, pev_maxspeed, g_cached_bombardierspd)
				default: set_pev(id, pev_maxspeed, g_zombie_spd[id])
			}
		}
		else
		{
			switch(g_hm_special[id])
			{
				case SURVIVOR: set_pev(id, pev_maxspeed, g_cached_survspd)
				case SNIPER: set_pev(id, pev_maxspeed, g_cached_sniperspd)
				case BERSERKER: set_pev(id, pev_maxspeed, g_cached_berserkerspd)
				case WESKER: set_pev(id, pev_maxspeed, g_cached_weskerspd)
				default: set_pev(id, pev_maxspeed, g_cached_humanspd)
			}
		}
	}
	
	// --- Check if player should leap ---
	
	// Check if proper CVARs are enabled and retrieve leap settings
	static Float:cooldown, Float:current_time
	if (g_zombie[id])
	{
		switch(g_zm_special[id])
		{
			case NEMESIS:
			{
				if (!g_cached_leapnemesis) return;
				cooldown = g_cached_leapnemesiscooldown
			}
			case ASSASSIN:
			{
				if (!g_cached_leapassassin) return;
				cooldown = g_cached_leapassassincooldown
			}
			case PREDATOR:
			{
				if (!g_cached_leappredator) return;
				cooldown = g_cached_leappredatorcooldown
			}
			case BOMBARDIER:
			{
				if (!g_cached_leapbombardier) return;
				cooldown = g_cached_leapbombardiercooldown
			}
			default:
			{
				switch (g_cached_leapzombies)
				{
					case 0: return;
					case 2: if (!g_firstzombie[id]) return;
					case 3: if (!g_lastzombie[id]) return;
				}
				cooldown = g_cached_leapzombiescooldown
			}
		}
	}
	else
	{
		switch(g_hm_special[id])
		{
			case SURVIVOR: 
			{
				if (!g_cached_leapsurvivor) return;
				cooldown = g_cached_leapsurvivorcooldown
			}
			case SNIPER: 
			{
				if (!g_cached_leapsniper) return;
				cooldown = g_cached_leapsnipercooldown
			}
			case BERSERKER: 
			{
				if (!g_cached_leapberserker) return;
				cooldown = g_cached_leapberserkercooldown
			}
			case WESKER: 
			{
				if (!g_cached_leapwesker) return;
				cooldown = g_cached_leapweskercooldown
			}
			default: return;
		}
	}
	
	current_time = get_gametime()
	
	// Cooldown not over yet
	if (current_time - g_lastleaptime[id] < cooldown)
		return;
	
	// Not doing a longjump (don't perform check for bots, they leap automatically)
	if (!g_isbot[id] && !(pev(id, pev_button) & (IN_JUMP | IN_DUCK) == (IN_JUMP | IN_DUCK)))
		return;
	
	// Not on ground or not enough speed
	if (!(pev(id, pev_flags) & FL_ONGROUND) || fm_get_speed(id) < 80)
		return;
	
	static Float:velocity[3]

	if(g_zombie[id])
	{
		switch(g_zm_special[id])
		{
			case NEMESIS: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapnemesisforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapnemesisheight)
			}
			case ASSASSIN: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapassassinforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapassassinheight)
			}
			case PREDATOR: {
				velocity_by_aim(id, get_pcvar_num(cvar_leappredatorforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leappredatorheight)
			}
			case BOMBARDIER: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapbombardierforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapbombardierheight)
			}
			default: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapzombiesforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapzombiesheight)
			}
		}
	}
	else
	{
		switch(g_hm_special[id])
		{
			case SURVIVOR: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapsurvivorforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapsurvivorheight)
			}
			case SNIPER: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapsniperforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapsniperheight)
			}
			case BERSERKER: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapberserkerforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapberserkerheight)
			}
			case WESKER: {
				velocity_by_aim(id, get_pcvar_num(cvar_leapweskerforce), velocity)
				velocity[2] = get_pcvar_float(cvar_leapweskerheight)
			}
		}
	}

	// Apply the new velocity
	set_pev(id, pev_velocity, velocity)
	
	// Update last leap time
	g_lastleaptime[id] = current_time
	
}

/*================================================================================
 [Client Commands]
=================================================================================*/
// Nightvision toggle
public clcmd_nightvision(id)
{
	if (g_nvision[id])
	{
		// Enable-disable
		g_nvisionenabled[id] = !(g_nvisionenabled[id])
		
		// Custom nvg?
		if (get_pcvar_num(cvar_customnvg))
		{
			remove_task(id+TASK_NVISION)
			if (g_nvisionenabled[id]) set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
		}
		else
			set_user_gnvision(id, g_nvisionenabled[id])
	}
	
	return PLUGIN_HANDLED;
}

// Weapon Drop
public clcmd_drop(id)
{
	// Survivor/Sniper/Berserker/Wesker should stick with its weapon
	if (g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS)
		return PLUGIN_HANDLED

	return PLUGIN_CONTINUE;
}

// Buy BP Ammo
public clcmd_buyammo(id)
{
	// Not alive or infinite ammo setting enabled
	if (!g_isalive[id] || get_pcvar_num(cvar_infammo))
		return PLUGIN_HANDLED;
	
	// Not human
	if (g_zombie[id])
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_HUMAN_ONLY")
		return PLUGIN_HANDLED;
	}
	
	// Not enough ammo packs
	if (g_ammopacks[id] < 1)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "NOT_ENOUGH_AMMO")
		return PLUGIN_HANDLED;
	}
	
	// Get user weapons
	static weapons[32], num, i, currentammo, weaponid, refilled
	num = 0 // reset passed weapons count (bugfix)
	refilled = false
	get_user_weapons(id, weapons, num)
	
	// Loop through them and give the right ammo type
	for (i = 0; i < num; i++)
	{
		// Prevents re-indexing the array
		weaponid = weapons[i]
		
		// Primary and secondary only
		if (MAXBPAMMO[weaponid] > 2)
		{
			// Get current ammo of the weapon
			currentammo = cs_get_user_bpammo(id, weaponid)
			
			// Give additional ammo
			ExecuteHamB(Ham_GiveAmmo, id, BUYAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
			
			// Check whether we actually refilled the weapon's ammo
			if (cs_get_user_bpammo(id, weaponid) - currentammo > 0) refilled = true
		}
	}
	
	// Weapons already have full ammo
	if (!refilled) return PLUGIN_HANDLED;
	
	// Deduce ammo packs, play clip purchase sound, and notify player
	g_ammopacks[id]--
	emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
	zp_colored_print(id, "^x04[ZP]^x01 %L", id, "AMMO_BOUGHT")
	
	return PLUGIN_HANDLED;
}

// Block Team Change
public clcmd_changeteam(id)
{
	static team
	team = fm_cs_get_user_team(id)
	
	// Unless it's a spectator joining the game
	if (team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
		return PLUGIN_CONTINUE;
	
	// Pressing 'M' (chooseteam) ingame should show the main menu instead
	show_menu_game(id)
	return PLUGIN_HANDLED;
}

/*================================================================================
 [Menus]
=================================================================================*/

// Game Menu
show_menu_game(id)
{
	static menu[250], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\d%s^n^n", g_modname)
	
	// 1. Buy weapons
	if (get_pcvar_num(cvar_buycustom))
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_BUY")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_BUY")
	
	// 2. Extra items
	if (get_pcvar_num(cvar_extraitems) && g_isalive[id])
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_EXTRABUY")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_EXTRABUY")
	
	// 3. Zombie class
	if (get_pcvar_num(cvar_zclasses))
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id,"MENU_ZCLASS")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id,"MENU_ZCLASS")
	

	// 4. Opcoes Pessoais
	len += formatex(menu[len], charsmax(menu) - len, "\r4.\w Opcoes Pessoais^n")
	
	// 5. VIP
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w Menu VIP^n")
	
	// 6. Fichas
	len += formatex(menu[len], charsmax(menu) - len, "\r6.\w Ver suas Fichas^n^n")
	
	// 8. Join spec
	if (!g_isalive[id] || !get_pcvar_num(cvar_blocksuicide) || (userflags & g_access_flag[ACCESS_ADMIN_MENU]))
		len += formatex(menu[len], charsmax(menu) - len, "\r8.\w %L^n^n", id, "MENU_SPECTATOR")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d8. %L^n^n", id, "MENU_SPECTATOR")
	
	// 9. Admin menu
	if (userflags & g_access_flag[ACCESS_ADMIN_MENU3])
		len += formatex(menu[len], charsmax(menu) - len, "\r9.\w %L", id, "MENU3_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d9. %L", id, "MENU3_ADMIN")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w %L", id, "MENU_EXIT")
	
	show_menu(id, KEYSMENU, menu, -1, "Game Menu")
}

// Buy Menu 1
public show_menu_buy1(taskid)
{
	// Get player's id
	static id
	(taskid > g_maxplayers) ? (id = ID_SPAWN) : (id = taskid);
	
	// Zombies, survivors or snipers get no guns
	if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS)
		return;
	
	// Bots pick their weapons randomly / Random weapons setting enabled
	if (get_pcvar_num(cvar_randweapons) || g_isbot[id])
	{
		buy_primary_weapon(id, random_num(0, ArraySize(g_primary_items) - 1))
		menu_buy2(id, random_num(0, ArraySize(g_secondary_items) - 1))
		return;
	}
	
	// Automatic selection enabled for player and menu called on spawn event
	if (WPN_AUTO_ON && taskid > g_maxplayers)
	{
		buy_primary_weapon(id, WPN_AUTO_PRI)
		menu_buy2(id, WPN_AUTO_SEC)
		return;
	}
	
	static menu[300], len, weap, maxloops
	len = 0
	maxloops = min(WPN_STARTID+7, WPN_MAXIDS)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L \r[%d-%d]^n^n", id, "MENU_BUY1_TITLE", WPN_STARTID+1, min(WPN_STARTID+7, WPN_MAXIDS))
	
	// 1-7. Weapon List
	for (weap = WPN_STARTID; weap < maxloops; weap++)
		len += formatex(menu[len], charsmax(menu) - len, "\r%d.\w %s^n", weap-WPN_STARTID+1, WEAPONNAMES[ArrayGetCell(g_primary_weaponids, weap)])
	
	// 8. Auto Select
	len += formatex(menu[len], charsmax(menu) - len, "^n\r8.\w %L \y[%L]", id, "MENU_AUTOSELECT", id, (WPN_AUTO_ON) ? "MOTD_ENABLED" : "MOTD_DISABLED")
	
	// 9. Next/Back - 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r9.\w %L/%L^n^n\r0.\w %L", id, "MENU_NEXT", id, "MENU_BACK", id, "MENU_EXIT")
	
	show_menu(id, KEYSMENU, menu, -1, "Buy Menu 1")
}

// Buy Menu 2
show_menu_buy2(id)
{
	static menu[250], len, weap, maxloops
	len = 0
	maxloops = ArraySize(g_secondary_items)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n", id, "MENU_BUY2_TITLE")
	
	// 1-6. Weapon List
	for (weap = 0; weap < maxloops; weap++)
		len += formatex(menu[len], charsmax(menu) - len, "^n\r%d.\w %s", weap+1, WEAPONNAMES[ArrayGetCell(g_secondary_weaponids, weap)])
	
	// 8. Auto Select
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r8.\w %L \y[%L]", id, "MENU_AUTOSELECT", id, (WPN_AUTO_ON) ? "MOTD_ENABLED" : "MOTD_DISABLED")
	
	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w %L", id, "MENU_EXIT")
	
	show_menu(id, KEYSMENU, menu, -1, "Buy Menu 2")
}

// Extra Items Menu
show_menu_extras(id)
{
	static menuid, menu[128], item, team, buffer[32]
	
	// Title
	if (g_zombie[id])
	{
		switch(g_zm_special[id])
		{
			case NEMESIS: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_NEMESIS")
			case ASSASSIN: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_ASSASSIN")
			case PREDATOR: formatex(menu, charsmax(menu), "%L [Predator]\r", id, "MENU_EXTRA_TITLE")
			case BOMBARDIER: formatex(menu, charsmax(menu), "%L [Bombardier]\r", id, "MENU_EXTRA_TITLE")
			default: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_ZOMBIE")
		}
	}
	else
	{
		
		switch(g_hm_special[id])
		{
			case SURVIVOR: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_SURVIVOR")
			case SNIPER: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_SNIPER")
			case BERSERKER: formatex(menu, charsmax(menu), "%L [Berserker]\r", id, "MENU_EXTRA_TITLE")
			case WESKER: formatex(menu, charsmax(menu), "%L [Wesker]\r", id, "MENU_EXTRA_TITLE")
			default: formatex(menu, charsmax(menu), "%L [%L]\r", id, "MENU_EXTRA_TITLE", id, "CLASS_HUMAN")
		}
	}
	menuid = menu_create(menu, "menu_extras")
	
	// Item List
	for (item = 0; item < g_extraitem_i; item++)
	{
		g_AdditionalMenuText[0] = 0
		
		// Retrieve item's team
		team = ArrayGetCell(g_extraitem_team, item)
		
		// Item not available to player's team/class
		if ((g_zombie[id] && g_zm_special[id] <= 0 && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && g_hm_special[id] <= 0 && !(team & ZP_TEAM_HUMAN)) || (g_zm_special[id] == NEMESIS && !(team & ZP_TEAM_NEMESIS))
		|| (g_hm_special[id] == SURVIVOR && !(team & ZP_TEAM_SURVIVOR)) || (g_hm_special[id] == SNIPER && !(team & ZP_TEAM_SNIPER)) || (g_zm_special[id] == ASSASSIN && !(team & ZP_TEAM_ASSASSIN)) 
		|| (g_hm_special[id] == BERSERKER && !(team & ZP_TEAM_BERSERKER) || (g_zm_special[id] == PREDATOR && !(team & ZP_TEAM_PREDATOR)) || (g_hm_special[id] == WESKER && !(team & ZP_TEAM_WESKER)))
		|| (g_zm_special[id] == BOMBARDIER && !(team & ZP_TEAM_BOMBARDIER)) ) 
			continue;
		
		// Check if it's one of the hardcoded items, check availability, set translated caption
		switch (item)
		{
			case EXTRA_NVISION:
			{
				if (!get_pcvar_num(cvar_extranvision)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA1")
			}
			case EXTRA_ANTIDOTE:
			{
				if (!get_pcvar_num(cvar_extraantidote) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA2")
			}
			case EXTRA_MADNESS:
			{
				if (!get_pcvar_num(cvar_extramadness) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA3")
			}
			case EXTRA_INFBOMB:
			{
				if (!get_pcvar_num(cvar_extrainfbomb) || g_infbombcounter >= get_pcvar_num(cvar_infbomblimit)) continue;
				formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA4")
			}
			default:
			{				
				if (item >= EXTRA_WEAPONS_STARTID && item <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
			}
		}
		
		// Item selected Pre forward
		ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, item);
						
		// Not Show the Item Extra
		if (g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue;
			
		// Add Item Name and Cost
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED || g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, item)) formatex(menu, charsmax(menu), "\d%s \d[%d] \d%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)
		else formatex(menu, charsmax(menu), "%s \r[%d] \w%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)
		buffer[0] = item
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// No items to display?
	if (menu_items(menuid) <= 0)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id ,"CMD_NOT_EXTRAS")
		menu_destroy(menuid)
		return;
	}
	
	else if (!native_has_round_started())
	{
		zp_colored_print(id, "^4[ZP]^1 Espere o round comecar...")
		menu_destroy(menuid)
		return;
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
}

// Zombie Class Menu
public show_menu_zclass(id)
{
	// Player disconnected
	if (!g_isconnected[id] || g_zm_special[id] > 0) // Nao Abrir o Menu se for nemesis
		return;
	
	// Bots pick their zombie class randomly
	if (g_isbot[id])
	{
		g_zombieclassnext[id] = random_num(0, g_zclass_i - 1)
		return;
	}
	
	static menuid, menu[128], class, buffer[32], buffer2[32]
	
	// Title
	formatex(menu, charsmax(menu), "%L\r", id, "MENU_ZCLASS_TITLE")
	menuid = menu_create(menu, "menu_zclass")
	
	// Class List
	for (class = 0; class < g_zclass_i; class++)
	{
		g_AdditionalMenuText2[0] = 0
		
		// Retrieve name and info
		ArrayGetString(g_zclass_name, class, buffer, charsmax(buffer))
		ArrayGetString(g_zclass_info, class, buffer2, charsmax(buffer2))
		
		// Item selected Pre forward
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, class);
						
		// Not Show the Zombie Class
		if (g_fwDummyResult < ZP_PLUGIN_SUPERCEDE)
		{
			// Add to menu
			if (class == g_zombieclassnext[id])
				formatex(menu, charsmax(menu), "%s%s \r[\d%s\r] \r[\dX\r] %s", g_fwDummyResult >= ZP_PLUGIN_HANDLED ? "\d" : "\w", buffer, buffer2, g_AdditionalMenuText2)
			else
				formatex(menu, charsmax(menu), "%s%s \r[\d%s\r] \r[] %s", g_fwDummyResult >= ZP_PLUGIN_HANDLED ? "\d" : "\w", buffer, buffer2, g_AdditionalMenuText2)
		
			buffer[0] = class
			buffer[1] = 0
			menu_additem(menuid, menu, buffer)
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
}

// Custom game mode menu
public show_menu_game_mode(id)
{
	// Player disconnected
	if (!g_isconnected[id])
		return;
	
	// No custom game modes registered ?
	if (g_gamemodes_i == MAX_GAME_MODES)
	{
		// Print a message
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_GAME_MODES")
		
		// Show the main admin menu and stop
		show_menu3_admin(id)
		return;
	}
	
	// Create vars necessary for displaying the game modes menu
	static menuid, menu[128], game,  buffer[32]
	
	// Title
	formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_TITLE")
	menuid = menu_create(menu, "menu_mode")
	
	// Game mode List
	for (game = MAX_GAME_MODES; game < g_gamemodes_i; game++)
	{
		// Retrieve the game mode's name
		ArrayGetString(g_gamemode_name, (game - MAX_GAME_MODES), buffer, charsmax(buffer))
		
		// Check for access flags and other conditions
		if ((get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (game - MAX_GAME_MODES))) && allowed_custom_game())
			formatex(menu, charsmax(menu), "%L %s ", id, "MENU_ADMIN1_CUSTOM", buffer)
		else
			formatex(menu, charsmax(menu), "\d%L %s", id, "MENU_ADMIN1_CUSTOM", buffer)
		
		// Add the item to the menu
		buffer[0] = game
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
	
}
// Admin Menu
public show_menu_admin(id)
{
	new szText[999 char], userflags = get_user_flags(id)
	formatex(szText, charsmax(szText), "\y%L\r", id, "MENU_ADMIN_TITLE")
	
	new menu = menu_create(szText, "menu_admin")
	
	if (userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN1")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN1")

	menu_additem(menu, szText, "1")
	
	if (userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN2")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN2")

	menu_additem(menu, szText, "2")
	
	if (userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN3")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN3")

	menu_additem(menu, szText, "3")
	
	if (userflags & (g_access_flag[ACCESS_MODE_SNIPER] | g_access_flag[ACCESS_MAKE_SNIPER]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN8")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN8")

	menu_additem(menu, szText, "4")
	
	if (userflags & (g_access_flag[ACCESS_MODE_ASSASSIN] | g_access_flag[ACCESS_MAKE_ASSASSIN]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN9")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN9")

	menu_additem(menu, szText, "5")
	
	if (userflags & (g_access_flag[ACCESS_MODE_BERSERKER] | g_access_flag[ACCESS_MAKE_BERSERKER]))
		formatex(szText, charsmax(szText), "\wConverter Para Berserker")
	else
		formatex(szText, charsmax(szText), "\dConverter Para Berserker")

	menu_additem(menu, szText, "6")
	
	if (userflags & (g_access_flag[ACCESS_MODE_PREDATOR] | g_access_flag[ACCESS_MAKE_PREDATOR]))
		formatex(szText, charsmax(szText), "\wConverter Para Predator")
	else
		formatex(szText, charsmax(szText), "\dConverter Para Predator")

	menu_additem(menu, szText, "7")
	
	if (userflags & (g_access_flag[ACCESS_MODE_WESKER] | g_access_flag[ACCESS_MAKE_WESKER]))
		formatex(szText, charsmax(szText), "\wConverter Para Wesker")
	else
		formatex(szText, charsmax(szText), "\dConverter Para Wesker")

	menu_additem(menu, szText, "8")
	
	if (userflags & (g_access_flag[ACCESS_MODE_BOMBARDIER] | g_access_flag[ACCESS_MAKE_BOMBARDIER]))
		formatex(szText, charsmax(szText), "\wConverter Para Bombardier")
	else
		formatex(szText, charsmax(szText), "\dConverter Para Bombardier")

	menu_additem(menu, szText, "9")
	
	if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN4")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN4")

	menu_additem(menu, szText, "10")
	
	// Back - Next - Exit
	formatex(szText, charsmax(szText), "%L", id, "MENU_BACK")
	menu_setprop(menu, MPROP_BACKNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_NEXT")
	menu_setprop(menu, MPROP_NEXTNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_EXIT")
	menu_setprop(menu, MPROP_EXITNAME, szText)
	
	menu_display(id, menu, 0)
}

// Admin Menu 2
show_menu2_admin(id)
{
	static menu[250], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n^n", id, "MENU2_ADMIN_TITLE")
	
	// 1. Multi infection command
	if ((userflags & g_access_flag[ACCESS_MODE_MULTI]) && allowed_multi())
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_ADMIN6")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_ADMIN6")
		
	// 2. Swarm mode command
	if ((userflags & g_access_flag[ACCESS_MODE_SWARM]) && allowed_swarm())
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_ADMIN5")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_ADMIN5")
	
	// 3. Plague mode command
	if ((userflags & g_access_flag[ACCESS_MODE_PLAGUE]) && allowed_plague())
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id, "MENU_ADMIN7")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id, "MENU_ADMIN7")
	
	// 4. Armageddon mode command
	if ((userflags & g_access_flag[ACCESS_MODE_LNJ]) && allowed_lnj())
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id, "MENU_ADMIN10")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id, "MENU_ADMIN10")

	// 9. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r9.\w %L", id, "MENU_EXIT")
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_BACK")
	
	show_menu(id, KEYSMENU, menu, -1, "Menu2 Admin")
}

// Admin Menu 3
show_menu3_admin(id)
{
	static menu[245], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n^n", id, "MENU3_ADMIN_TITLE")
	
	// 1. Admin menu of classes
	if (userflags & g_access_flag[ACCESS_ADMIN_MENU])
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_ADMIN")
		
	// 2. Main Modes admin menu
	if (userflags & g_access_flag[ACCESS_ADMIN_MENU2])
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU2_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU2_ADMIN")
	
	// 3. Custom modes admin menu
	if (userflags & g_access_flag[ACCESS_ADMIN_MENU3])
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n^n", id, "MENU_ADMIN_CUSTOM")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n^n", id, "MENU_ADMIN_CUSTOM")

	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_EXIT")
	
	show_menu(id, KEYSMENU, menu, -1, "Menu3 Admin")
}

// Player List Menu
show_menu_player_list(id)
{
	static menuid, menu[9999], player, userflags, buffer[4]
	userflags = get_user_flags(id)
	
	// Title
	switch (PL_ACTION)
	{
		case ACTION_ZOMBIEFY_HUMANIZE: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN1")
		case ACTION_MAKE_NEMESIS: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN2")
		case ACTION_MAKE_SURVIVOR: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN3")
		case ACTION_MAKE_SNIPER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN8")
		case ACTION_MAKE_ASSASSIN: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN9")
		case ACTION_MAKE_PREDATOR: formatex(menu, charsmax(menu), "Converter Para Predator\r")
		case ACTION_MAKE_BOMBARDIER: formatex(menu, charsmax(menu), "Converter Para Bombardier\r")
		case ACTION_MAKE_BERSERKER: formatex(menu, charsmax(menu), "Converter Para Berserker\r")
		case ACTION_MAKE_WESKER: formatex(menu, charsmax(menu), "Converter Para Wesker\r")
		case ACTION_RESPAWN_PLAYER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN4")

	}
	menuid = menu_create(menu, "menu_player_list")
	
	// Player List
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Skip if not connected
		if (!g_isconnected[player])
			continue;
		
		// Format text depending on the action to take
		switch (PL_ACTION) 
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if (g_zombie[player])
				{
					if (allowed_human(player) && (userflags & g_access_flag[ACCESS_MAKE_HUMAN]))
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
				}
				else
				{
					if (allowed_zombie(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE])))
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if (allowed_nemesis(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if (allowed_survivor(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_SNIPER: // Sniper command
			{
				if (allowed_sniper(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SNIPER]) : (userflags & g_access_flag[ACCESS_MAKE_SNIPER])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_ASSASSIN: // Nemesis command
			{
				if (allowed_assassin(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_ASSASSIN]) : (userflags & g_access_flag[ACCESS_MAKE_ASSASSIN])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_PREDATOR:
			{
				if (allowed_predator(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_PREDATOR]) : (userflags & g_access_flag[ACCESS_MAKE_PREDATOR])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else 
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}

			case ACTION_MAKE_BOMBARDIER:
			{
				if (allowed_bombardier(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BOMBARDIER]) : (userflags & g_access_flag[ACCESS_MAKE_BOMBARDIER])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_BERSERKER: // Berserker command
			{
				if (allowed_berserker(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BERSERKER]) : (userflags & g_access_flag[ACCESS_MAKE_BERSERKER])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
			case ACTION_MAKE_WESKER: // Wesker command
			{
				if (allowed_wesker(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_WESKER]) : (userflags & g_access_flag[ACCESS_MAKE_WESKER])))
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "%s \r[Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "%s \r[Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \r[%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "%s \y[Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "%s \y[Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "%s \y[%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
				else
				{
					if (g_zombie[player])
					{
						if (g_zm_special[player] == NEMESIS) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_NEMESIS")
						else if (g_zm_special[player] == ASSASSIN) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ASSASSIN")
						else if (g_zm_special[player] == PREDATOR) formatex(menu, charsmax(menu), "\d%s [Predator]", g_playername[player])
						else if (g_zm_special[player] == BOMBARDIER) formatex(menu, charsmax(menu), "\d%s [Bombardier]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_ZOMBIE")
					}
					else
					{
						if (g_hm_special[player] == SURVIVOR) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SURVIVOR")
						else if (g_hm_special[player] == SNIPER) formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_SNIPER")
						else if (g_hm_special[player] == BERSERKER) formatex(menu, charsmax(menu), "\d%s [Berserker]", g_playername[player])
						else if (g_hm_special[player] == WESKER) formatex(menu, charsmax(menu), "\d%s [Wesker]", g_playername[player])
						else formatex(menu, charsmax(menu), "\d%s [%L]", g_playername[player], id, "CLASS_HUMAN")
					}
				}
			}
		
			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if (allowed_respawn(player) && (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS]))
					formatex(menu, charsmax(menu), "%s", g_playername[player])
				else
					formatex(menu, charsmax(menu), "\d%s", g_playername[player])
			}			
			
		}
		
		// Add player
		buffer[0] = player
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)
	menu_display(id, menuid)
}

/*================================================================================
 [Menu Handlers]
=================================================================================*/

// Game Menu
public menu_game(id, key)
{
	switch (key)
	{
		case 0: // Buy Weapons
		{
			// Custom buy menus enabled?
			if (get_pcvar_num(cvar_buycustom))
			{
				// Disable the remember selection setting
				WPN_AUTO_ON = 0
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "BUY_ENABLED")
				
				// Show menu if player hasn't yet bought anything
				if (g_canbuy[id]) show_menu_buy1(id)
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		}
		case 1: // Extra Items
		{
			// Extra items enabled?
			if (get_pcvar_num(cvar_extraitems))
			{
				// Check whether the player is able to buy anything
				if (g_isalive[id])
					show_menu_extras(id)
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_EXTRAS")
		}
		case 2: // Zombie Classes
		{
			// Zombie classes enabled?
			if (get_pcvar_num(cvar_zclasses))
				show_menu_zclass(id)
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ZCLASSES")
		}
		/*case 3: // Unstuck
		{
			// Check if player is stuck
			if (g_isalive[id])
			{
				if (is_player_stuck(id))
				{
					// Move to an initial spawn
					if (get_pcvar_num(cvar_randspawn))
						do_random_spawn(id) // random spawn (including CSDM)
					else
						do_random_spawn(id, 1) // regular spawn
				}
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_STUCK")
			}
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		}*/
		case 3: // OP Pessoais
		{
			menu_bkplayer(id)
		}
		case 4: // Menu VIP
		{
			client_cmd(id, "say /vm")
		}
		case 5: // Fichas
		{
			client_cmd(id, "say /fichas")
		}
		case 7: // Join Spectator
		{
			// Player alive?
			if (g_isalive[id])
			{
				// Prevent abuse by non-admins if block suicide setting is enabled
				if (get_pcvar_num(cvar_blocksuicide) && !(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU]))
				{
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					return PLUGIN_HANDLED;
				}
				
				// Check that we still have both humans and zombies to keep the round going
				check_round(id)
				
				// Kill him before he switches team
				dllfunc(DLLFunc_ClientKill, id)
			}
			
			// Temporarily save player stats?
			if (get_pcvar_num(cvar_statssave)) save_stats(id)
			
			// Remove previous tasks
			remove_task(id+TASK_TEAM)
			remove_task(id+TASK_MODEL)
			remove_task(id+TASK_FLASH)
			remove_task(id+TASK_CHARGE)
			remove_task(id+TASK_SPAWN)
			remove_task(id+TASK_BLOOD)
			remove_task(id+TASK_AURA)
			remove_task(id+TASK_BURN)
			
			// Then move him to the spectator team
			fm_cs_set_user_team(id, FM_CS_TEAM_SPECTATOR)
			fm_user_team_update(id)
		}
		case 8: // Admin Menu
		{
			// Check if player has the required access
			if (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3])
				show_menu3_admin(id)
			else
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
	}
	
	return PLUGIN_HANDLED;
}

// Buy Menu 1
public menu_buy1(id, key)
{
	// Zombies, survivors or snipers get no guns
	if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS)
		return PLUGIN_HANDLED;
	
	// Special keys / weapon list exceeded
	if (key >= MENU_KEY_AUTOSELECT || WPN_SELECTION >= WPN_MAXIDS)
	{
		switch (key)
		{
			case MENU_KEY_AUTOSELECT: // toggle auto select
			{
				WPN_AUTO_ON = 1 - WPN_AUTO_ON
			}
			case MENU_KEY_NEXT: // next/back
			{
				if (WPN_STARTID+7 < WPN_MAXIDS) WPN_STARTID += 7
				else WPN_STARTID = 0
			}
			case MENU_KEY_EXIT: // exit
			{
				return PLUGIN_HANDLED;
			}
		}
		
		// Show buy menu again
		show_menu_buy1(id)
		return PLUGIN_HANDLED;
	}
	
	// Store selected weapon id
	WPN_AUTO_PRI = WPN_SELECTION
	
	// Buy primary weapon
	buy_primary_weapon(id, WPN_AUTO_PRI)
	
	// Show pistols menu
	show_menu_buy2(id)
	
	return PLUGIN_HANDLED;
}

// Buy Primary Weapon
buy_primary_weapon(id, selection)
{
	// Drop previous weapons
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip off from weapons
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	
	// Get weapon's id and name
	static weaponid, wname[32]
	weaponid = ArrayGetCell(g_primary_weaponids, selection)
	ArrayGetString(g_primary_items, selection, wname, charsmax(wname))
	
	// Give the new weapon and full ammo
	fm_give_item(id, wname)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
	
	// Weapons bought
	g_canbuy[id] = false
	
	// Give additional items
	static i
	for (i = 0; i < ArraySize(g_additional_items); i++)
	{
		ArrayGetString(g_additional_items, i, wname, charsmax(wname))
		fm_give_item(id, wname)
	}
}

// Buy Menu 2
public menu_buy2(id, key)
{	
	// Zombies, survivors or snipers get no guns
	if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS)
		return PLUGIN_HANDLED;
	
	// Special keys / weapon list exceeded
	if (key >= ArraySize(g_secondary_items))
	{
		// Toggle autoselect
		if (key == MENU_KEY_AUTOSELECT)
			WPN_AUTO_ON = 1 - WPN_AUTO_ON
		
		// Reshow menu unless user exited
		if (key != MENU_KEY_EXIT)
			show_menu_buy2(id)
		
		return PLUGIN_HANDLED;
	}
	
	// Store selected weapon
	WPN_AUTO_SEC = key
	
	// Drop secondary gun again, in case we picked another (bugfix)
	drop_weapons(id, 2)
	
	// Get weapon's id
	static weaponid, wname[32]
	weaponid = ArrayGetCell(g_secondary_weaponids, key)
	ArrayGetString(g_secondary_items, key, wname, charsmax(wname))
	
	// Give the new weapon and full ammo
	fm_give_item(id, wname)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
	
	return PLUGIN_HANDLED;
}

// Extra Items Menu
public menu_extras(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Dead players are not allowed to buy items
	if (!g_isalive[id])
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve extra item id
	static buffer[2], dummy, itemid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	itemid = buffer[0]
	
	// Item selected Pre forward
	ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
	
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Attempt to buy the item
	buy_extra_item(id, itemid)
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}

// Buy Extra Item
buy_extra_item(id, itemid, ignorecost = 0)
{
	// Retrieve item's team
	static team
	team = ArrayGetCell(g_extraitem_team, itemid)
	
	// Check for team/class specific items
	if ((g_zombie[id] && g_zm_special[id] <= 0 && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && g_hm_special[id] <= 0 && !(team & ZP_TEAM_HUMAN)) || (g_zm_special[id] == NEMESIS && !(team & ZP_TEAM_NEMESIS))
	|| (g_hm_special[id] == SURVIVOR && !(team & ZP_TEAM_SURVIVOR)) || (g_hm_special[id] == SNIPER && !(team & ZP_TEAM_SNIPER)) || (g_hm_special[id] == BERSERKER && !(team & ZP_TEAM_BERSERKER)) || (g_hm_special[id] == WESKER && !(team & ZP_TEAM_WESKER)) || (g_zm_special[id] == ASSASSIN && !(team & ZP_TEAM_ASSASSIN)) 
	|| (g_zm_special[id] == PREDATOR && !(team & ZP_TEAM_PREDATOR)) || (g_zm_special[id] == BOMBARDIER && !(team & ZP_TEAM_BOMBARDIER)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for unavailable items
	if ((itemid == EXTRA_NVISION && !get_pcvar_num(cvar_extranvision)) || (itemid == EXTRA_ANTIDOTE && (!get_pcvar_num(cvar_extraantidote) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit)))
	|| (itemid == EXTRA_MADNESS && (!get_pcvar_num(cvar_extramadness) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit))) || (itemid == EXTRA_INFBOMB && (!get_pcvar_num(cvar_extrainfbomb) 
	|| g_infbombcounter >= get_pcvar_num(cvar_infbomblimit))) || (itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for hard coded items with special conditions
	if ((itemid == EXTRA_ANTIDOTE && (g_endround || g_currentmode >= MODE_NEMESIS || fnGetZombies() <= 1 || (get_pcvar_num(cvar_deathmatch) && !get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() == 1)))
	|| (itemid == EXTRA_MADNESS && g_nodamage[id]) || (itemid == EXTRA_INFBOMB && (g_endround || g_currentmode >= MODE_NEMESIS)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_CANTUSE")
		return;
	}
	
	// Ignore item's cost?
	if (!ignorecost)
	{
		// Check that we have enough ammo packs
		if (g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, itemid))
		{
			zp_colored_print(id, "^x04[ZP]^x01 %L", id, "NOT_ENOUGH_AMMO")
			return;
		}
		
		// Deduce item cost
		g_ammopacks[id] -= ArrayGetCell(g_extraitem_cost, itemid)
	}
	
	// Check which kind of item we're buying
	switch (itemid)
	{
		case EXTRA_NVISION: // Night Vision
		{
			g_nvision[id] = true
			
			if (!g_isbot[id])
			{
				g_nvisionenabled[id] = true
				
				// Custom nvg?
				if (get_pcvar_num(cvar_customnvg))
				{
					remove_task(id+TASK_NVISION)
					set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
				}
				else
					set_user_gnvision(id, 1)
			}
			else
				cs_set_user_nvg(id, 1)
		}
		case EXTRA_ANTIDOTE: // Antidote
		{
			if(native_get_zombie_count() < get_pcvar_num(cvar_antidote_minzms))
			{
				zp_colored_print(id, "^4[ZP]^1 Tem que ter no minimo ^3%d^1 Zombies Para usar Antidoto",
				get_pcvar_num(cvar_antidote_minzms))
				native_set_user_ammo_packs(id, native_get_user_ammo_packs(id) +	g_extra_costs2[EXTRA_ANTIDOTE]) // Para que o jogador não perca os packs
				return;
			}
			// Increase antidote purchase count for this round
			g_antidotecounter++
			
			humanme(id, 0, 0)
		}
		case EXTRA_MADNESS: // Zombie Madness
		{
			if(g_nodamage[id])
			{
				zp_colored_print(id, "^4[ZP]^1 Voce ja Esta usando Furia")
				native_set_user_ammo_packs(id, native_get_user_ammo_packs(id) +	g_extra_costs2[EXTRA_MADNESS]) // Para que o jogador não perca os packs
				return;
			}
			
			// Increase madness purchase count for this round
			g_madnesscounter++
			
			g_nodamage[id] = true
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
			set_task(get_pcvar_float(cvar_madnessduration), "madness_over", id+TASK_BLOOD)
			set_pev(id, pev_takedamage, DAMAGE_NO)
			
			static sound[64]
			ArrayGetString(zombie_madness, random_num(0, ArraySize(zombie_madness) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		}
		case EXTRA_INFBOMB: // Infection Bomb
		{
			// Increase infection bomb purchase count for this round
			g_infbombcounter++
			
			// Already own one
			if (user_has_weapon(id, CSW_HEGRENADE))
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, cs_get_user_bpammo(id, CSW_HEGRENADE) + 1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgid[AMMO_PICKUP], _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
		}
		default:
		{
			if (itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1) // Weapons
			{
				// Get weapon's id and name
				static weaponid, wname[32]
				ArrayGetString(g_extraweapon_items, itemid - EXTRA_WEAPONS_STARTID, wname, charsmax(wname))
				weaponid = cs_weapon_name_to_id(wname)
				
				// If we are giving a primary/secondary weapon
				if (MAXBPAMMO[weaponid] > 2)
				{
					// Make user drop the previous one
					if ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)
						drop_weapons(id, 1)
					else
						drop_weapons(id, 2)
					
					// Give full BP ammo for the new one
					ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
				}
				// If we are giving a grenade which the user already owns
				else if (user_has_weapon(id, weaponid))
				{
					// Increase BP ammo on it instead
					cs_set_user_bpammo(id, weaponid, cs_get_user_bpammo(id, weaponid) + 1)
					
					// Flash ammo in hud
					message_begin(MSG_ONE_UNRELIABLE, g_msgid[AMMO_PICKUP], _, id)
					write_byte(AMMOID[weaponid]) // ammo id
					write_byte(1) // ammo amount
					message_end()
					
					// Play clip purchase sound
					emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
					
					return; // stop here
				}
				
				// Give weapon to the player
				fm_give_item(id, wname)
			}
			else // Custom additions
			{
				// Item selected forward
				ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
				// Item purchase blocked, restore buyer's ammo packs
				if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
				{
					g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
					show_menu_extras(id)
					return;
				}
				
				// Item selected forward
				ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
				// Item purchase blocked, restore buyer's ammo packs
				if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost)
					g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)				
			}
		}
	}
}

// Zombie Class Menu
public menu_zclass(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve zombie class id
	static buffer[2], dummy, classid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	classid = buffer[0]
	
	if(g_zombie[id] && g_zm_special[id] <= 0 && g_zombieclassnext[id] == ZCLASS_NONE) 
	{
		// Class selected Pre forward
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid);
						
		// Not Show the Zombie Class
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
		{
			show_menu_zclass(id)
			menu_destroy(menuid)
			return PLUGIN_HANDLED;
		}
		
		g_zombieclassnext[id] = classid
		zombieme(id, 0, 0, 2, 0)
		
		static name[32]
		ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))
		
		// Show selected zombie class info and stats
		zp_colored_print(id, "^x04[ZP]^x01 Sua Classe de ZM Agora eh:^x04 %s", name)
		zp_colored_print(id, "^x04[ZP]^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
		id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))
		
		ExecuteForward(g_forwards[CLASS_CHOOSED_POST], g_fwDummyResult, id, classid);
	}
	else
	{
		// Class selected Pre forward
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid);
						
		// Not Show the Zombie Class
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
		{
			show_menu_zclass(id)
			menu_destroy(menuid)
			return PLUGIN_HANDLED;
		}
	
		// Store selection for the next infection
		g_zombieclassnext[id] = classid
		
		static name[32]
		ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))
		
		// Show selected zombie class info and stats
		zp_colored_print(id, "^x04[ZP]^x01 %L^x01:^x04 %s", id, "ZOMBIE_SELECT", name)
		zp_colored_print(id, "^x04[ZP]^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
		id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))
		
		ExecuteForward(g_forwards[CLASS_CHOOSED_POST], g_fwDummyResult, id, classid);
	}
	
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}

// Custom game mode menu
public menu_mode(id, menuid, item)
{
	// Player wants to exit the menu
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	// Create some necassary vars
	static buffer[2], dummy , gameid
	
	// Retrieve the id of the game mode which was chosen
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	gameid = buffer[0]
	
	// Check users access level
	if (get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (gameid - MAX_GAME_MODES)))
	{
		// Only allow the game mode to proceed after some checks
		if (allowed_custom_game())
			command_custom_game(gameid, id)
		else
			zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			
		// Show the menu again
		show_menu_game_mode(id)
		return PLUGIN_HANDLED;
	}
	else
	{
		// Player deosnt haves the required access level
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		
		// Show the menu again
		show_menu_game_mode(id)
		return PLUGIN_HANDLED;
	}
	
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}


// Admin Menu
public menu_admin(id, menu, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static userflags
	userflags = get_user_flags(id)
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(menu, item, access, data, 6, iName, 63, callback)
	new key = str_to_num(data)  
	
	switch (key)
	{
		case 1: // Zombiefy/Humanize command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_ZOMBIEFY_HUMANIZE
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 2: // Nemesis command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_NEMESIS
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 3: // Survivor command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_SURVIVOR
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 4: // Sniper command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_SNIPER] | g_access_flag[ACCESS_MAKE_SNIPER]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_SNIPER
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 5: // Assassin command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_ASSASSIN] | g_access_flag[ACCESS_MAKE_ASSASSIN]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_ASSASSIN
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 6: // Berserker command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_BERSERKER] | g_access_flag[ACCESS_MAKE_BERSERKER]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_BERSERKER
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}		
		case 7: // predator command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_PREDATOR] | g_access_flag[ACCESS_MAKE_PREDATOR]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_PREDATOR
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 8: // Wesker command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_WESKER] | g_access_flag[ACCESS_MAKE_WESKER]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_WESKER
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 9: // Bombardier command
		{
			if (userflags & (g_access_flag[ACCESS_MODE_BOMBARDIER] | g_access_flag[ACCESS_MAKE_BOMBARDIER]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_BOMBARDIER
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		
		case 10: // Respawn command
		{
			if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_RESPAWN_PLAYER
				show_menu_player_list(id);
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS");
				show_menu_admin(id);
			}
		}
		
	}
	return PLUGIN_HANDLED;
}

public menu2_admin(id, key)
{
	static userflags
	userflags = get_user_flags(id)
	
	switch (key)
	{
		case 0: // Multiple Infection command
		{
			if (userflags & g_access_flag[ACCESS_MODE_MULTI])
			{
				if (allowed_multi()) command_multi(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu2_admin(id)
		}
		case 1: // Swarm Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_SWARM])
			{
				if (allowed_swarm()) command_swarm(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu2_admin(id)
		}
		case 2: // Plague Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_PLAGUE])
			{
				if (allowed_plague()) command_plague(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu2_admin(id)
		}
		case 3: // Armageddon Mode command
		{
			if (userflags & g_access_flag[ACCESS_MODE_LNJ])
			{
				if (allowed_lnj()) command_lnj(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu2_admin(id)
		}
		case 9: // Chose to return
		{
			show_menu3_admin(id)
		}
	}
	return PLUGIN_HANDLED;
}

public menu3_admin(id, key)
{
	switch (key)
	{
		case 0: // Admin Menu Mode
		{
			// Check if player has the required access
			if (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU]) show_menu_admin(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
		case 1: // Admin Menu Class
		{
			// Check if player has the required access
			if (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU2]) show_menu2_admin(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
		case 2: // Admin Menu of Custom Game modes
		{
			// Check if player has the required access
			if (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3]) show_menu_game_mode(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
	}
	return PLUGIN_HANDLED;
}

// Player List Menu
public menu_player_list(id, menuid, item)
{
	// Menu was closed
	if (item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_admin(id)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve player id
	static buffer[2], dummy, playerid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	playerid = buffer[0]
	
	// Perform action on player
	
	// Get admin flags
	static userflags
	userflags = get_user_flags(id)
	
	// Make sure it's still connected
	if (g_isconnected[playerid])
	{
		// Perform the right action if allowed
		switch (PL_ACTION)
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if (g_zombie[playerid])
				{
					if (userflags & g_access_flag[ACCESS_MAKE_HUMAN])
					{
						if (allowed_human(playerid)) command_human(id, playerid)
						else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
				else
				{
					if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE]))
					{
						if (allowed_zombie(playerid)) command_zombie(id, playerid)
						else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS]))
				{
					if (allowed_nemesis(playerid)) command_nemesis(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR]))
				{
					if (allowed_survivor(playerid))
						command_survivor(id, playerid)
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SNIPER: // Sniper command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SNIPER]) : (userflags & g_access_flag[ACCESS_MAKE_SNIPER]))
				{
					if (allowed_sniper(playerid))
						command_sniper(id, playerid)
					else
						zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_ASSASSIN: // Assassin command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_ASSASSIN]) : (userflags & g_access_flag[ACCESS_MAKE_ASSASSIN]))
				{
					if (allowed_assassin(playerid)) command_assassin(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_PREDATOR: // Predator command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_PREDATOR]) : (userflags & g_access_flag[ACCESS_MAKE_PREDATOR]))
				{
					if (allowed_predator(playerid)) command_predator(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_BERSERKER: // Berserker command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BERSERKER]) : (userflags & g_access_flag[ACCESS_MAKE_BERSERKER]))
				{
					if (allowed_berserker(playerid)) command_berserker(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_WESKER: // Wesker command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_WESKER]) : (userflags & g_access_flag[ACCESS_MAKE_WESKER]))
				{
					if (allowed_wesker(playerid)) command_wesker(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			
			case ACTION_MAKE_BOMBARDIER: // Bombardier command
			{
				if (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BOMBARDIER]) : (userflags & g_access_flag[ACCESS_MAKE_BOMBARDIER]))
				{
					if (allowed_bombardier(playerid)) command_bombardier(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}

			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
				{
					if (allowed_respawn(playerid)) command_respawn(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
		}
	}
	else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
	
	menu_destroy(menuid)
	show_menu_player_list(id)
	return PLUGIN_HANDLED;
}

/*================================================================================
 [Admin Commands]
=================================================================================*/

// zp_zombie [target]
public cmd_zombie(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Infection
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_INFECTION], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Zombie
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_ZOMBIE], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be zombie
	if (!allowed_zombie(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED
	}
	
	command_zombie(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_human [target]
public cmd_human(id, level, cid)
{
	// Check for access flag - Make Human
	if (!cmd_access(id, g_access_flag[ACCESS_MAKE_HUMAN], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be human
	if (!allowed_human(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_human(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_survivor [target]
public cmd_survivor(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Survivor
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Survivor
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be survivor
	if (!allowed_survivor(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_survivor(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_nemesis [target]
public cmd_nemesis(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Nemesis
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Nemesis
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be nemesis
	if (!allowed_nemesis(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_nemesis(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_respawn [target]
public cmd_respawn(id, level, cid)
{
	// Check for access flag - Respawn
	if (!cmd_access(id, g_access_flag[ACCESS_RESPAWN_PLAYERS], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be respawned
	if (!allowed_respawn(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_respawn(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_swarm
public cmd_swarm(id, level, cid)
{
	// Check for access flag - Mode Swarm
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_SWARM], cid, 2))
		return PLUGIN_HANDLED;
	
	// Swarm mode not allowed
	if (!allowed_swarm())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_swarm(id)
	
	return PLUGIN_HANDLED;
}

// zp_multi
public cmd_multi(id, level, cid)
{
	// Check for access flag - Mode Multi
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_MULTI], cid, 2))
		return PLUGIN_HANDLED;
	
	// Multi infection mode not allowed
	if (!allowed_multi())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_multi(id)
	
	return PLUGIN_HANDLED;
}

// zp_plague
public cmd_plague(id, level, cid)
{
	// Check for access flag - Mode Plague
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_PLAGUE], cid, 2))
		return PLUGIN_HANDLED;
	
	// Plague mode not allowed
	if (!allowed_plague())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_plague(id)
	
	return PLUGIN_HANDLED;
}

// zp_sniper [target]
public cmd_sniper(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Sniper
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_SNIPER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Sniper
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_SNIPER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be sniper
	if (!allowed_sniper(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_sniper(id, player)
	
	return PLUGIN_HANDLED;
}
// zp_assassin [target]
public cmd_assassin(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_ASSASSIN], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_ASSASSIN], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be assassin
	if (!allowed_assassin(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_assassin(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_predator [target]
public cmd_predator(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_PREDATOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_PREDATOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be predator
	if (!allowed_predator(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_predator(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_bombardier [target]
public cmd_bombardier(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_BOMBARDIER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_BOMBARDIER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be bombardier
	if (!allowed_bombardier(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_bombardier(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_berserker [target]
public cmd_berserker(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Berserker
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_BERSERKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Berserker
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_BERSERKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be berserker
	if (!allowed_berserker(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_berserker(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_wesker [target]
public cmd_wesker(id, level, cid)
{
	// Check for access flag depending on the resulting action
	if (g_newround)
	{
		// Start Mode Wesker
		if (!cmd_access(id, g_access_flag[ACCESS_MODE_WESKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Wesker
		if (!cmd_access(id, g_access_flag[ACCESS_MAKE_WESKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if (!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be wesker
	if (!allowed_wesker(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_wesker(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_lnj
public cmd_lnj(id, level, cid)
{
	// Check for access flag - Mode Apocalypse
	if (!cmd_access(id, g_access_flag[ACCESS_MODE_LNJ], cid, 2))
		return PLUGIN_HANDLED;
	
	// Apocalypse mode not allowed
	if (!allowed_lnj())
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_lnj(id)
	
	return PLUGIN_HANDLED;
}
/*================================================================================
 [Message Hooks]
=================================================================================*/

// Current Weapon info
public message_cur_weapon(msg_id, msg_dest, msg_entity)
{
	// Not alive or zombie
	if (!g_isalive[msg_entity] || g_zombie[msg_entity])
		return;
	
	// Not an active weapon
	if (get_msg_arg_int(1) != 1)
		return;
	
	// Unlimited clip disabled for class
	if (g_hm_special[msg_entity] == SURVIVOR ? get_pcvar_num(cvar_survinfammo) <= 1 : g_hm_special[msg_entity] == SNIPER ? get_pcvar_num(cvar_sniperinfammo) <= 1 :
	g_hm_special[msg_entity] == WESKER ? get_pcvar_num(cvar_weskerinfammo) <= 1 : get_pcvar_num(cvar_infammo) <= 1)
		return;
	
	// Get weapon's id
	static weapon
	weapon = get_msg_arg_int(2)
	
	// Unlimited Clip Ammo for this weapon?
	if (MAXBPAMMO[weapon] > 2)
	{
		// Max out clip ammo
		cs_set_weapon_ammo(fm_cs_get_current_weapon_ent(msg_entity), MAXCLIP[weapon])
		
		// HUD should show full clip all the time
		set_msg_arg_int(3, get_msg_argtype(3), MAXCLIP[weapon])
	}
}

// Take off player's money
public message_money(msg_id, msg_dest, msg_entity)
{
	// Remove money setting enabled?
	if (!get_pcvar_num(cvar_removemoney))
		return PLUGIN_CONTINUE;
	
	fm_cs_set_user_money(msg_entity, 0)
	return PLUGIN_HANDLED;
}

// Fix for the HL engine bug when HP is multiples of 256
public message_health(msg_id, msg_dest, msg_entity)
{
	// Get player's health
	static health
	health = get_msg_arg_int(1)
	
	// Don't bother
	if (health < 256) return;
	
	// Check if we need to fix it
	if (health % 256 == 0)
		fm_set_user_health(msg_entity, pev(msg_entity, pev_health) + 1)
	
	// HUD can only show as much as 255 hp
	set_msg_arg_int(1, get_msg_argtype(1), 255)
}

// Block flashlight battery messages if custom flashlight is enabled instead
public message_flashbat()
{
	if (g_cached_customflash)
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Flashbangs should only affect zombies
public message_screenfade(msg_id, msg_dest, msg_entity)
{
	if (get_msg_arg_int(4) != 255 || get_msg_arg_int(5) != 255 || get_msg_arg_int(6) != 255 || get_msg_arg_int(7) < 200)
		return PLUGIN_CONTINUE;
	
	// Nemesis/Assassin shouldn't be FBed
	if (g_zombie[msg_entity] && g_zm_special[msg_entity] <= 0)
	{
		switch(g_nv_color[1][msg_entity])
		{
			case 0: g_nvrgb = { 255, 255, 255 }
			case 1: g_nvrgb = { 255, 0, 0 }
			case 2: g_nvrgb = { 0, 255, 0 }
			case 3: g_nvrgb = { 0, 0, 255 }
			case 4: g_nvrgb = { 0, 255, 255 }
			case 5: g_nvrgb = { 255, 0, 255 }
			case 6: g_nvrgb = { 255, 255, 0 }
		}

		// Set flash color to nighvision's
		set_msg_arg_int(4, get_msg_argtype(4), g_nvrgb[0])
		set_msg_arg_int(5, get_msg_argtype(5), g_nvrgb[1])
		set_msg_arg_int(6, get_msg_argtype(6), g_nvrgb[2])
		return PLUGIN_CONTINUE;
	}
	
	return PLUGIN_HANDLED;
}

// Prevent spectators' nightvision from being turned off when switching targets, etc.
public message_nvgtoggle()
{
	return PLUGIN_HANDLED;
}

// Set correct model on player corpses
public message_clcorpse()
{
	set_msg_arg_string(1, g_playermodel[get_msg_arg_int(12)])
}

// Prevent zombies from seeing any weapon pickup icon
public message_weappickup(msg_id, msg_dest, msg_entity)
{
	if (g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Prevent zombies from seeing any ammo pickup icon
public message_ammopickup(msg_id, msg_dest, msg_entity)
{
	if (g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Block hostage HUD display
public message_scenario()
{
	if (get_msg_args() > 1)
	{
		static sprite[8]
		get_msg_arg_string(2, sprite, charsmax(sprite))
		
		if (equal(sprite, "hostage"))
			return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block hostages from appearing on radar
public message_hostagepos()
{
	return PLUGIN_HANDLED;
}

// Block some text messages
public message_textmsg()
{
	static textmsg[22]
	get_msg_arg_string(2, textmsg, charsmax(textmsg))
	
	// Game restarting, reset scores and call round end to balance the teams
	if (equal(textmsg, "#Game_will_restart_in"))
	{
		g_scorehumans = 0
		g_scorezombies = 0
		logevent_round_end()
	}
	// Block round end related messages
	else if (equal(textmsg, "#Hostages_Not_Rescued") || equal(textmsg, "#Round_Draw") || equal(textmsg, "#Terrorists_Win") || equal(textmsg, "#CTs_Win"))
	{
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block CS round win audio messages, since we're playing our own instead
public message_sendaudio()
{
	static audio[17]
	get_msg_arg_string(2, audio, charsmax(audio))
	
	if (equal(audio[7], "terwin") || equal(audio[7], "ctwin") || equal(audio[7], "rounddraw"))
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Send actual team scores (T = zombies // CT = humans)
public message_teamscore()
{
	static team[2]
	get_msg_arg_string(1, team, charsmax(team))
	
	switch (team[0])
	{
		// CT
		case 'C': set_msg_arg_int(2, get_msg_argtype(2), g_scorehumans)
		// Terrorist
		case 'T': set_msg_arg_int(2, get_msg_argtype(2), g_scorezombies)
	}
}

// Team Switch (or player joining a team for first time)
public message_teaminfo(msg_id, msg_dest)
{
	// Only hook global messages
	if (msg_dest != MSG_ALL && msg_dest != MSG_BROADCAST) return;
	
	// Don't pick up our own TeamInfo messages for this player (bugfix)
	if (g_switchingteam) return;
	
	// Get player's id
	static id
	id = get_msg_arg_int(1)
	
	// Enable spectators' nightvision if not spawning right away
	set_task(0.2, "spec_nvision", id)
	
	// Round didn't start yet, nothing to worry about
	if (g_newround) return;
	
	// Get his new team
	static team[2]
	get_msg_arg_string(2, team, charsmax(team))
	
	// Perform some checks to see if they should join a different team instead
	switch (team[0])
	{
		case 'C': // CT
		{
			if (g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM && fnGetHumans()) // survivor, sniper and berserker alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
			else if (!fnGetZombies()) // no zombies alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
		}
		case 'T': // Terrorist
		{
			if (g_currentmode >= MODE_SURVIVOR && g_currentmode <= MODE_SWARM && fnGetHumans()) // survivor/sniper/berserker alive or swarm round w\ humans --> spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
			}
			else if (fnGetZombies()) // zombies alive --> switch to CT
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				set_msg_arg_string(2, "CT")
			}
		}
	}
}

/*================================================================================
 [Main Functions]
=================================================================================*/

// Make Zombie Task
public make_zombie_task()
{
       /**
	* Note:
	* The make a zombie function has been totally changed
	* and rewritten to suit the requirements of the new
	* native for registering game modes externally.
	*/
	
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	// Not enough players, come back later!
	if (iPlayersnum < 1)
	{
		set_task(2.0, "make_zombie_task", TASK_MAKEZOMBIE)
		return;
	}
	
	// Start the game modes cycle
	start_swarm_mode(0, MODE_NONE)
}

// Start swarm mode
start_swarm_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SWARM) && random_num(1, get_pcvar_num(cvar_swarmchance)) == get_pcvar_num(cvar_swarm) && iPlayersnum >= get_pcvar_num(cvar_swarmminplayers))
	|| mode == MODE_SET)
	{		
		// Swarm Mode
		g_currentmode = MODE_SWARM
		g_lastmode = MODE_SWARM
		
		// Prevent Infection
		g_allowinfection = false
		
		// Make sure there are alive players on both teams (BUGFIX)
		if (!fnGetAliveTs())
		{
			// Move random player to T team
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			fm_user_team_update(id)
		}
		else if (!fnGetAliveCTs())
		{
			// Move random player to CT team
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
		
		// Turn every T into a zombie
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Not a Terrorist
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_T)
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play swarm sound
		ArrayGetString(sound_swarm, random_num(0, ArraySize(sound_swarm) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Swarm HUD notice
		set_hudmessage(20, 255, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SWARM")
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_SWARM, 0);
		
		// Stop here [BUGFIX]
		return;
	}
	
	// Give chance to another game mode
	start_plague_mode(0, MODE_NONE)
}

// Start plague mode
start_plague_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64], iZombies, iMaxZombies
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PLAGUE) && random_num(1, get_pcvar_num(cvar_plaguechance)) == get_pcvar_num(cvar_plague) 
	&& floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) >= 1&& 
	iPlayersnum-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) >= 1 
	&& iPlayersnum >= get_pcvar_num(cvar_plagueminplayers)) || mode == MODE_SET)
	{
		// Plague Mode
		g_currentmode = MODE_PLAGUE
		g_lastmode = MODE_PLAGUE
		
		// Prevent Infection
		g_allowinfection = false
		
		// Turn specified amount of players into Survivors
		static iSurvivors, iMaxSurvivors
		iMaxSurvivors = get_pcvar_num(cvar_plaguesurvnum)
		iSurvivors = 0
		
		while (iSurvivors < iMaxSurvivors)
		{
			// Choose random guy
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
			// Already a survivor?
			if (g_hm_special[id] == SURVIVOR)
				continue;
			
			// If not, turn him into one
			humanme(id, SURVIVOR, 0)
			iSurvivors++
			
			// Apply survivor health multiplier
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguesurvhpmulti)))
		}
		
		// Turn specified amount of players into Nemesis
		static iNemesis, iMaxNemesis
		iMaxNemesis = get_pcvar_num(cvar_plaguenemnum)
		iNemesis = 0
		
		while (iNemesis < iMaxNemesis)
		{
			// Choose random guy
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
			// Already a survivor or nemesis?
			if (g_hm_special[id] == SURVIVOR || g_zm_special[id] == NEMESIS)
				continue;
			
			// If not, turn him into one
			zombieme(id, 0, NEMESIS, 0, 0)
			iNemesis++
			
			// Apply nemesis health multiplier
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguenemhpmulti)))
		}
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into zombies
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a zombie
				zombieme(id, 0, 0, 1, 0)
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who arent zombies or survivor
			if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play plague sound
		ArrayGetString(sound_plague, random_num(0, ArraySize(sound_plague) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Plague HUD notice
		set_hudmessage(0, 50, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_PLAGUE")
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_PLAGUE, 0);
		
		// Stop here [BUGFIX]
		return;
	}
	
	// Give chance to other game modes
	start_multi_mode(0, MODE_NONE)
}

// Start multiple infection mode
start_multi_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64], iZombies, iMaxZombies
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_MULTI) && random_num(1, get_pcvar_num(cvar_multichance)) == get_pcvar_num(cvar_multi) && 
	floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_multiminplayers))
	|| mode == MODE_SET)
	{
		
		// Multi Infection Mode
		g_currentmode = MODE_MULTI
		g_lastmode = MODE_MULTI
		
		// Allow Infection
		g_allowinfection = true
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into zombies
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie
			if (!g_isalive[id] || g_zombie[id])
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a zombie
				zombieme(id, 0, 0, 1, 0)
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who aren't zombies
			if (!g_isalive[id] || g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play multi infection sound
		ArrayGetString(sound_multi, random_num(0, ArraySize(sound_multi) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Multi Infection HUD notice
		set_hudmessage(200, 50, 0, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_MULTI")
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_MULTI, 0);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_lnj_mode(0, MODE_NONE)
}

// Start LNJ mode
start_lnj_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64], iZombies, iMaxZombies
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_LNJ) && random_num(1, get_pcvar_num(cvar_lnjchance)) == get_pcvar_num(cvar_lnj) &&
	iPlayersnum >= get_pcvar_num(cvar_lnjminplayers) && floatround(iPlayersnum*get_pcvar_float(cvar_lnjratio), floatround_ceil) >= 1 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum )
	|| mode == MODE_SET)
	{
		// Armageddon Mode
		g_currentmode = MODE_LNJ
		g_lastmode = MODE_LNJ
		
		// Prevent Infection
		g_allowinfection = false
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum * get_pcvar_float(cvar_lnjratio)), floatround_ceil)
		iZombies = 0
		
		// Randomly turn iMaxZombies players into Nemesis
		while (iZombies < iMaxZombies)
		{
			// Keep looping through all players
			if (++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Random chance
			if (random_num(0, 1))
			{
				// Turn into a Nemesis
				zombieme(id, 0, NEMESIS, 0, 0)
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjnemhpmulti)))
				iZombies++
			}
		}
		
		// Turn the remaining players into survivors
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Only those of them who arent zombies or survivor
			if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Turn into a Survivor
			humanme(id, SURVIVOR, 0)
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti)))
		}
		
		// Play armageddon sound
		ArrayGetString(sound_lnj, random_num(0, ArraySize(sound_lnj) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Armageddon HUD notice
		set_hudmessage(181 , 62, 244, -1.0, 0.17, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_LNJ")
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_LNJ])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_LNJ, 0);
		
		// Stop Here
		return;
	}
	
	// Give chance to other game modes
	start_sniper_mode(0, MODE_NONE)
}

// Start sniper mode
start_sniper_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SNIPER) && random_num(1, get_pcvar_num(cvar_sniperchance)) == get_pcvar_num(cvar_sniper) && iPlayersnum >= get_pcvar_num(cvar_sniperminplayers))
	|| mode == MODE_SET)
	{
		// Sniper Mode
		g_currentmode = MODE_SNIPER
		g_lastmode = MODE_SNIPER
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make sniper
		humanme(id, SNIPER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Sniper or already a zombie
			if (g_hm_special[id] == SNIPER || g_zombie[id] )
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play sniper sound
		ArrayGetString(sound_sniper, random_num(0, ArraySize(sound_sniper) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show Sniper HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SNIPER", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_SNIPER, forward_id);
		
		// Stop here
		return;
	}
	
	// Give a chance to other game modes
	start_survivor_mode(0, MODE_NONE)
}

// Start survivor mode
start_survivor_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SURVIVOR) && random_num(1, get_pcvar_num(cvar_survchance)) == get_pcvar_num(cvar_surv) && iPlayersnum >= get_pcvar_num(cvar_survminplayers))
	|| mode == MODE_SET)
	{
		// Survivor Mode
		g_currentmode = MODE_SURVIVOR
		g_lastmode = MODE_SURVIVOR
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into a survivor
		humanme(id, SURVIVOR, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Survivor or already a zombie
			if (g_hm_special[id] == SURVIVOR || g_zombie[id] )
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play survivor sound
		ArrayGetString(sound_survivor, random_num(0, ArraySize(sound_survivor) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Survivor HUD notice
		set_hudmessage(0, 10, 255, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SURVIVOR", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_SURVIVOR, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_assassin_mode(0, MODE_NONE)
}

// Start assassin mode
start_assassin_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_ASSASSIN) && random_num(1, get_pcvar_num(cvar_assassinchance)) == get_pcvar_num(cvar_assassin) && iPlayersnum >= get_pcvar_num(cvar_assassinminplayers))
	|| mode == MODE_SET)
	{
		// Assassin Mode
		g_currentmode = MODE_ASSASSIN
		g_lastmode = MODE_ASSASSIN
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into assassin
		zombieme(id, 0, ASSASSIN, 0, 0)
		
		// Turn off the lights [Taken From Speeds Zombie Mutilation]
		static ent
		ent = -1
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "light")) != 0)
		{
			dllfunc(DLLFunc_Use, ent, 0);
		}
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// First assassin
			if (g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			
			// Make a screen fade 
			message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, id)
			write_short(UNIT_SECOND*5) // duration
			write_short(0) // hold time
			write_short(FFADE_IN) // fade type
			write_byte(250) // red
			write_byte(0) // green
			write_byte(0) // blue
			write_byte(255) // alpha
			message_end()
			
			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[SCREEN_SHAKE], _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Assassin sound
		ArrayGetString(sound_assassin, random_num(0, ArraySize(sound_assassin) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(255, 150, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_ASSASSIN", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_ASSASSIN, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_nemesis_mode(0, MODE_NONE)
}

// Start nemesis mode
start_nemesis_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_NEMESIS) && random_num(1, get_pcvar_num(cvar_nemchance)) == get_pcvar_num(cvar_nem) && iPlayersnum >= get_pcvar_num(cvar_nemminplayers))
	|| mode == MODE_SET)
	{
		// Nemesis Mode
		g_currentmode = MODE_NEMESIS
		g_lastmode = MODE_NEMESIS
			
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into nemesis
		zombieme(id, 0, NEMESIS, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// First nemesis
			if (g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play Nemesis sound
		ArrayGetString(sound_nemesis, random_num(0, ArraySize(sound_nemesis) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Nemesis HUD notice
		set_hudmessage(255, 20, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_NEMESIS", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_NEMESIS, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_berserker_mode(0, MODE_NONE)
}

// Start berserker mode
start_berserker_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_BERSERKER) && random_num(1, get_pcvar_num(cvar_berserkerchance)) == get_pcvar_num(cvar_berserker) && iPlayersnum >= get_pcvar_num(cvar_berserkerminplayers))
	|| mode == MODE_SET)
	{
		// Berserker Mode
		g_currentmode = MODE_BERSERKER
		g_lastmode = MODE_BERSERKER
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make Berserker
		humanme(id, BERSERKER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Berserker or already a zombie
			if (g_hm_special[id] == BERSERKER || g_zombie[id] )
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play berserker sound
		ArrayGetString(sound_berserker, random_num(0, ArraySize(sound_berserker) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show berserker HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "O Jogador %s Eh o Berserker", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_BERSERKER, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_predator_mode(0, MODE_NONE)
}

// Start predator mode
start_predator_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PREDATOR) && random_num(1, get_pcvar_num(cvar_predatorchance)) == get_pcvar_num(cvar_predator) && iPlayersnum >= get_pcvar_num(cvar_predatorminplayers))
	|| mode == MODE_SET)
	{
		// Predator Mode
		g_currentmode = MODE_PREDATOR
		g_lastmode = MODE_PREDATOR
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into predator
		zombieme(id, 0, PREDATOR, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// First predator
			if (g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			
			// Make a screen fade 
			message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, id)
			write_short(UNIT_SECOND*5) // duration
			write_short(0) // hold time
			write_short(FFADE_IN) // fade type
			write_byte(250) // red
			write_byte(0) // green
			write_byte(0) // blue
			write_byte(255) // alpha
			message_end()
			
			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[SCREEN_SHAKE], _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Predator sound
		ArrayGetString(sound_predator, random_num(0, ArraySize(sound_predator) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(255, 150, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "O Jogador %s Eh o Predator", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Mode fully started!
		g_modestarted = true
		
		// No more a new round
		g_newround = false
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_PREDATOR, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_wesker_mode(0, MODE_NONE)
	
}

// Start wesker mode
start_wesker_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_WESKER) && random_num(1, get_pcvar_num(cvar_weskerchance)) == get_pcvar_num(cvar_wesker) && iPlayersnum >= get_pcvar_num(cvar_weskerminplayers))
	|| mode == MODE_SET)
	{
		// Wesker Mode
		g_currentmode = MODE_WESKER
		g_lastmode = MODE_WESKER
		
		// Prevent Infection
		g_allowinfection = false
		g_modestarted = true
		g_newround = false

		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make Wesker
		humanme(id, WESKER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// Wesker or already a zombie
			if (g_hm_special[id] == WESKER || g_zombie[id] )
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play wesker sound
		ArrayGetString(sound_wesker, random_num(0, ArraySize(sound_wesker) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show wesker HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "O Jogador %s Eh o Wesker", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_WESKER])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_WESKER, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_bombardier_mode(0, MODE_NONE)

}

// Start bombardier mode
start_bombardier_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if ((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_BOMBARDIER) && random_num(1, get_pcvar_num(cvar_bombardierchance)) == get_pcvar_num(cvar_bombardier) && iPlayersnum >= get_pcvar_num(cvar_bombardierminplayers))
	|| mode == MODE_SET)
	{
		// Berserker Mode
		g_currentmode = MODE_BOMBARDIER
		g_lastmode = MODE_BOMBARDIER
		
		// Prevent Infection
		g_allowinfection = false
		g_modestarted = true
		g_newround = false

		// Choose player randomly?
		if (mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into bombardier
		zombieme(id, 0, BOMBARDIER, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if (!g_isalive[id])
				continue;
			
			// First bombardier
			if (g_zombie[id])
				continue;
			
			// Switch to CT
			if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			
			// Make a screen fade 
			message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, id)
			write_short(UNIT_SECOND*5) // duration
			write_short(0) // hold time
			write_short(FFADE_IN) // fade type
			write_byte(250) // red
			write_byte(0) // green
			write_byte(0) // blue
			write_byte(255) // alpha
			message_end()
			
			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[SCREEN_SHAKE], _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Bombardier sound
		ArrayGetString(sound_bombardier, random_num(0, ArraySize(sound_bombardier) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(255, 150, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "O Jogador %s Eh o Bombardier", g_playername[forward_id])
		
		// Start ambience sounds
		if (g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_BOMBARDIER, forward_id);
		
		// Stop here
		return;
	}
		
	// Start some custom game modes
	start_custom_mode()
	
}

// Start custom game mode
start_custom_mode()
{
	// No custom game modes registered
	if(g_gamemodes_i == MAX_GAME_MODES)
	{
		// Start our infection mode 
		start_infection_mode(0, MODE_NONE)
		return;
	}
	
	// No more a new round
	g_newround = false
	
	// Loop through every custom game mode present
	// This is to ensure that every game mode is given a chance
	static game
	for (game = MAX_GAME_MODES; game < g_gamemodes_i; game++)
	{
		// Apply chance level and check if the last played mode was not the same as this one
		if ((random_num(1, ArrayGetCell(g_gamemode_chance, (game - MAX_GAME_MODES))) == 1) && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != game))
		{
			// Execute our round start pre forward
			// This is were the game mode will decide whether to run itself or block it self
			ExecuteForward(g_forwards[ROUND_START_PRE], g_fwDummyResult, game)
			
			// The game mode didnt accept some conditions
			if (g_fwDummyResult >= ZP_PLUGIN_HANDLED)
			{
				// Give other game modes a chance
				continue;
			}
			// Game mode has accepted the conditions
			else
			{
				// Current game mode and last game mode are equal to the game mode id
				g_currentmode = game
				g_lastmode = game
				
				// Check whether or not to allow infection during this game mode
				g_allowinfection = (ArrayGetCell(g_gamemode_allow, (game - MAX_GAME_MODES)) == 1) ? true : false
				
				// Check the death match mode required by the game mode
				g_deathmatchmode = ArrayGetCell(g_gamemode_dm, (game - MAX_GAME_MODES))
				
				// Our custom game mode has fully started
				g_modestarted = true
				
				// Execute our round start forward with the game mode id
				ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, game, 0)
				
				// Turn the remaining players into humans [BUGFIX]
				static id
				for (id = 1; id <= g_maxplayers; id++)
				{
					// Only those of them who arent zombies or survivor
					if (!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS)
						continue;
					
					// Switch to CT
					if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
					{
						remove_task(id+TASK_TEAM)
						fm_cs_set_user_team(id, FM_CS_TEAM_CT)
						fm_user_team_update(id)
					}
				}
				
				// Stop the loop and prevent other game modes from being given a chance [BUGFIX]
				break;
			}
		}
		
		// The game mode was not given a chance then continue the loop
		else continue;
	}
	
	// No game mode has started then start our good old infection mode [BUGFIX]
	if (!g_modestarted)
		start_infection_mode(0, MODE_NONE)
}

// Start the default infection mode
start_infection_mode(id, mode)
{
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id
	
	// Single Infection Mode
	g_currentmode = MODE_INFECTION
	g_lastmode = MODE_INFECTION
	
	// Allow Infection
	g_allowinfection = true
	
	// Choose player randomly?
	if (mode == MODE_NONE)
		id = fnGetRandomAlive(random_num(1, iPlayersnum))
	
	// Turn player into the first zombie
	zombieme(id, 0, 0, 0, 0)
	
	// Remember id for calling our forward later
	forward_id = id
	
	// Remaining players should be humans (CTs)
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Not alive
		if (!g_isalive[id])
			continue;
		
		// First zombie
		if (g_zombie[id])
			continue;
		
		// Switch to CT
		if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
		{
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
	}
	
	// Show First Zombie HUD notice
	set_hudmessage(255, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 5.0, 1.0, 1.0, -1)
	ShowSyncHudMsg(0, g_MsgSync[0], "%L",LANG_PLAYER, "NOTICE_FIRST", g_playername[forward_id])
	
	// Start ambience sounds
	if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
	{
		remove_task(TASK_AMBIENCESOUNDS)
		set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
	}
	
	// Mode fully started!
	g_modestarted = true
	
	// No more a new round
	g_newround = false
	
	// Round start forward
	ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_INFECTION, forward_id);
}

// Zombie Me Function (player id, infector, turn into a nemesis, silent mode, deathmsg and rewards, turn into assassin)
zombieme(id, infector, classid, silentmode, rewards)
{
	// User infect attempt forward
	ExecuteForward(g_forwards[INFECT_ATTEMP], g_fwDummyResult, id, infector, classid)
	
	// One or more plugins blocked the infection. Only allow this after making sure it's
	// not going to leave us with no zombies. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first zombie e.g.
	if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetZombies() > g_lastplayerleaving)
		return;
	
	// Pre user infect forward
	ExecuteForward(g_forwards[INFECTED_PRE], g_fwDummyResult, id, infector, classid)
	
	// Show zombie class menu if they haven't chosen any (e.g. just connected)
	if (g_zombieclassnext[id] == ZCLASS_NONE && get_pcvar_num(cvar_zclasses))
		set_task(0.2, "show_menu_zclass", id)
	
	// Set selected zombie class
	g_zombieclass[id] = g_zombieclassnext[id]
	
	// If no class selected yet, use the first (default) one
	if (g_zombieclass[id] == ZCLASS_NONE) g_zombieclass[id] = 0
	
	// Way to go...
	g_zombie[id] = true
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	g_firstzombie[id] = false
	
	// Remove aura (bugfix)
	remove_task(id+TASK_AURA)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	// Reset burning duration counter (bugfix)
	g_burning_duration[id] = 0
	
	// Show deathmsg and reward infector?
	if (rewards && infector)
	{
		// Send death notice and fix the "dead" attrib on scoreboard
		SendDeathMsg(infector, id)
		FixDeadAttrib(id)
		
		// Reward frags, deaths, health, and ammo packs
		UpdateFrags(infector, id, get_pcvar_num(cvar_fragsinfect), 1, 1)
		g_ammopacks[infector] += get_pcvar_num(cvar_ammoinfect)
		fm_set_user_health(infector, pev(infector, pev_health) + get_pcvar_num(cvar_zombiebonushp))
	}
	
	// Cache speed, knockback, and name for player's class
	g_zombie_spd[id] = float(ArrayGetCell(g_zclass_spd, g_zombieclass[id]))
	g_zombie_knockback[id] = Float:ArrayGetCell(g_zclass_kb, g_zombieclass[id])
	ArrayGetString(g_zclass_name, g_zombieclass[id], g_zombie_classname[id], charsmax(g_zombie_classname[]))
	
	// Set zombie attributes based on the mode
	static sound[64]
	if (!silentmode)
	{
		if (classid == NEMESIS)
		{
			// Nemesis
			g_zm_special[id] = NEMESIS
			
			// Set health [0 = auto]
			if (get_pcvar_num(cvar_nemhp) == 0)
			{
				if (get_pcvar_num(cvar_nembasehp) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_nembasehp) * fnGetAlive())
			}
			else
				fm_set_user_health(id, get_pcvar_num(cvar_nemhp))
			
			// Set gravity, unless frozen
			if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_nemgravity))
		}
		
		else if (classid == ASSASSIN)
		{
			// Assassin
			g_zm_special[id] = ASSASSIN
			
			// Set health [0 = auto]
			if (get_pcvar_num(cvar_assassinhp) == 0)
			{
				if (get_pcvar_num(cvar_assassinbasehp) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_assassinbasehp) * fnGetAlive())
			}
			else
				fm_set_user_health(id, get_pcvar_num(cvar_assassinhp))
			
			// Set gravity, unless frozen
			if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_assassingravity))
		}
		
		else if (classid == PREDATOR)
		{
			// predator
			g_zm_special[id] = PREDATOR
			set_task(1.0, "turn_invisible", id)
			
			// Set health [0 = auto]
			if (get_pcvar_num(cvar_predatorhp) == 0)
			{
				if (get_pcvar_num(cvar_predatorbasehp) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_predatorbasehp) * fnGetAlive())
			}
			else
				fm_set_user_health(id, get_pcvar_num(cvar_predatorhp))
			
			// Set gravity, unless frozen
			if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_predatorgravity))
		}
		
		else if (classid == BOMBARDIER)
		{
			// bombardier
			g_zm_special[id] = BOMBARDIER
			
			// Set health [0 = auto]
			if (get_pcvar_num(cvar_bombardierhp) == 0)
			{
				if (get_pcvar_num(cvar_bombardierbasehp) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_bombardierbasehp) * fnGetAlive())
			}
			else fm_set_user_health(id, get_pcvar_num(cvar_bombardierhp))

			set_task(1.0, "give_items", id)
						
			// Set gravity, unless frozen
			if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_bombardiergravity))
		}
		
		else if ((fnGetZombies() == 1) && g_zm_special[id] <= 0)
		{
			// First zombie
			g_firstzombie[id] = true
			
			// Set health and gravity, unless frozen
			fm_set_user_health(id, floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zombiefirsthp)))
			if (!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
		}
		else
		{
			// Infected by someone
			
			// Set health and gravity, unless frozen
			fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id]))
			if (!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Show Infection HUD notice
			set_hudmessage(255, 0, 0, HUD_INFECT_X, HUD_INFECT_Y, 0, 0.0, 5.0, 1.0, 1.0, -1)
			
			if (infector) // infected by someone?
				ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT2", g_playername[id], g_playername[infector])
			else
				ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT", g_playername[id])
		}
	}
	else
	{
		// Silent mode, no HUD messages, no infection sounds
		
		// Set health and gravity, unless frozen
		if(silentmode != 2) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id])) // Nao mudar HP na hora que escolhe outra classe
		if (!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
	}
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	
	// Switch to T
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_T) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		if (g_zm_special[id] == NEMESIS)
		{
			iRand = random_num(0, ArraySize(model_nemesis) - 1)
			ArrayGetString(model_nemesis, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_nemesis, iRand))
		}
		else if (g_zm_special[id] == ASSASSIN)
		{
			iRand = random_num(0, ArraySize(model_assassin) - 1)
			ArrayGetString(model_assassin, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_assassin, iRand))
		}
		else if (g_zm_special[id] == PREDATOR)
		{
			iRand = random_num(0, ArraySize(model_predator) - 1)
			ArrayGetString(model_predator, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_predator, iRand))
		}
		else if (g_zm_special[id] == BOMBARDIER)
		{
			iRand = random_num(0, ArraySize(model_bombardier) - 1)
			ArrayGetString(model_bombardier, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_bombardier, iRand))
		}
		else
		{
			if (get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				iRand = random_num(0, ArraySize(model_admin_zombie) - 1)
				ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
			}
			else
			{
				iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
				ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
			}
		}
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Nemesis glow / remove glow on player model entity, unless frozen
		if (!g_frozen[id])
		{
			if (g_zm_special[id] == NEMESIS && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0 , 0, kRenderNormal, 25)
			else if (g_zm_special[id] == NEMESIS && !(get_pcvar_num(cvar_nemglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0 , 0, kRenderNormal, 25)
				
			else if (g_zm_special[id] == ASSASSIN && get_pcvar_num(cvar_assassinglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0 , 0, kRenderNormal, 25)
			else if (g_zm_special[id] == ASSASSIN && !(get_pcvar_num(cvar_assassinglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0 , 0, kRenderNormal, 25)
			
			else if (g_zm_special[id] == PREDATOR && get_pcvar_num(cvar_predatorglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0 , 0, kRenderNormal, 25)
			else if (g_zm_special[id] == PREDATOR && !(get_pcvar_num(cvar_predatorglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0 , 0, kRenderNormal, 25)
			
			else if (g_zm_special[id] == BOMBARDIER && get_pcvar_num(cvar_bombardierglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0 , 0, kRenderNormal, 25)
			else if (g_zm_special[id] == BOMBARDIER && !(get_pcvar_num(cvar_bombardierglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0 , 0, kRenderNormal, 25)
				
			else if (g_zm_special[id] <= 0)
				fm_set_rendering(g_ent_playermodel[id])
		}
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (g_zm_special[id] == NEMESIS)
		{
			size = ArraySize(model_nemesis)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_nemesis, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_nemesis, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_nemesis, iRand))
			}
		}
		
		else if (g_zm_special[id] == ASSASSIN)
		{
			size = ArraySize(model_assassin)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_assassin, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_assassin, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_assassin, iRand))
			}
		}
		
		else if (g_zm_special[id] == PREDATOR)
		{
			size = ArraySize(model_predator)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_predator, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_predator, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_predator, iRand))
			}
		}
		
		else if (g_zm_special[id] == BOMBARDIER)
		{
			size = ArraySize(model_bombardier)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_bombardier, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_bombardier, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_bombardier, iRand))
			}
		}
		
		else
		{
			if (get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				size = ArraySize(model_admin_zombie)
				for (i = 0; i < size; i++)
				{
					ArrayGetString(model_admin_zombie, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(0, size - 1)
					ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
				}
			}
			else
			{
				for (i = ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]); i < ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]); i++)
				{
					ArrayGetString(g_zclass_playermodel, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
					ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
				}
			}
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Nemesis glow / remove glow, unless frozen
		if (!g_frozen[id])
		{
			if (g_zm_special[id] == NEMESIS && get_pcvar_num(cvar_nemglow))
				fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
			else if (g_zm_special[id] == NEMESIS && !(get_pcvar_num(cvar_nemglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_zm_special[id] == ASSASSIN && get_pcvar_num(cvar_assassinglow))
				fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
			else if (g_zm_special[id] == ASSASSIN && !(get_pcvar_num(cvar_assassinglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
			else if (g_zm_special[id] == PREDATOR && get_pcvar_num(cvar_predatorglow))
				fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
			else if (g_zm_special[id] == PREDATOR && !(get_pcvar_num(cvar_predatorglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
			else if (g_zm_special[id] == BOMBARDIER && get_pcvar_num(cvar_bombardierglow))
				fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
			else if (g_zm_special[id] == BOMBARDIER && !(get_pcvar_num(cvar_bombardierglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_zm_special[id] <= 0)
				fm_set_rendering(id)
		}
	}
	
	// Remove any zoom (bugfix)
	cs_set_user_zoom(id, CS_RESET_ZOOM, 1)
	
	// Remove armor
	set_pev(id, pev_armorvalue, 0.0)
	
	// Drop weapons when infected
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip zombies from guns and give them a knife
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	
	// Fancy effects
	infection_effects(id)
	
	// Nemesis aura task
	if (g_zm_special[id] == NEMESIS && get_pcvar_num(cvar_nemaura) || g_zm_special[id] == ASSASSIN && get_pcvar_num(cvar_assassinaura) 
	|| g_zm_special[id] == PREDATOR && get_pcvar_num(cvar_predatoraura) || g_zm_special[id] == BOMBARDIER && get_pcvar_num(cvar_bombardieraura))
		set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
		
	// Give Zombies Night Vision?
	if (get_pcvar_num(cvar_nvggive))
	{
		g_nvision[id] = true
		
		if (!g_isbot[id])
		{
			// Turn on Night Vision automatically?
			if (get_pcvar_num(cvar_nvggive) == 1)
			{
				g_nvisionenabled[id] = true
				
				// Custom nvg?
				if (get_pcvar_num(cvar_customnvg))
				{
					remove_task(id+TASK_NVISION)
					set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
				}
				else
					set_user_gnvision(id, 1)
			}
			// Turn off nightvision when infected (bugfix)
			else if (g_nvisionenabled[id])
			{
				if (get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
				else set_user_gnvision(id, 0)
				g_nvisionenabled[id] = false
			}
		}
		else
			cs_set_user_nvg(id, 1); // turn on NVG for bots
	}
	// Disable nightvision when infected (bugfix)
	else if (g_nvision[id])
	{
		if (g_isbot[id]) cs_set_user_nvg(id, 0) // Turn off NVG for bots
		if (get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
		else if (g_nvisionenabled[id]) set_user_gnvision(id, 0)
		g_nvision[id] = false
		g_nvisionenabled[id] = false
	}
	
	// Set custom FOV?
	if (get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0)
	{
		message_begin(MSG_ONE, g_msgid[SET_FOV], _, id)
		write_byte(get_pcvar_num(cvar_zombiefov)) // fov angle
		message_end()
	}
	
	// Call the bloody task
	if (g_zm_special[id] <= 0 && get_pcvar_num(cvar_zombiebleeding))
		set_task(0.7, "make_blood", id+TASK_BLOOD, _, _, "b")
	
	// Idle sounds task
	if (g_zm_special[id] <= 0)
		set_task(random_float(50.0, 70.0), "zombie_play_idle", id+TASK_BLOOD, _, _, "b")
	
	// Turn off zombie's flashlight
	turn_off_flashlight(id)
	
	// Post user infect forward
	ExecuteForward(g_forwards[INFECTED_POST], g_fwDummyResult, id, infector, classid)
	
	// Last Zombie Check
	fnCheckLastZombie()
}

public give_items(id)
{
	fm_give_item(id, "weapon_hegrenade")
	cs_set_user_bpammo(id, CSW_HEGRENADE, 200)
}

// Function Human Me (player id, turn into a survivor, silent mode)
humanme(id, classid, silentmode)
{
	// User humanize attempt forward
	ExecuteForward(g_forwards[HUMANIZE_ATTEMP], g_fwDummyResult, id, classid)
	
	// One or more plugins blocked the "humanization". Only allow this after making sure it's
	// not going to leave us with no humans. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first survivor e.g.
	if (g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetHumans() > g_lastplayerleaving)
		return;
	
	// Pre user humanize forward
	ExecuteForward(g_forwards[HUMANIZED_PRE], g_fwDummyResult, id, classid)
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_NVISION)
	
	// Reset some vars
	g_zombie[id] = false
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	g_firstzombie[id] = false
	g_canbuy[id] = true
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	
	// Remove survivor/sniper/berserker's aura (bugfix)
	remove_task(id+TASK_AURA)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	// Reset burning duration counter (bugfix)
	g_burning_duration[id] = 0
	
	// Drop previous weapons
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip off from weapons
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")

	// Set human attributes based on the mode
	if (classid == SURVIVOR)
	{
		// Survivor
		g_hm_special[id] = SURVIVOR
		
		// Set Health [0 = auto]
		if (get_pcvar_num(cvar_survhp) == 0)
		{
			if (get_pcvar_num(cvar_survbasehp) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_humanhp) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_survbasehp) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_survhp))
		
		// Set gravity, unless frozen
		if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_survgravity))
		
		// Give survivor his own weapon
		static survweapon[32]
		get_pcvar_string(cvar_survweapon, survweapon, charsmax(survweapon))
		fm_give_item(id, survweapon)
		ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[cs_weapon_name_to_id(survweapon)], AMMOTYPE[cs_weapon_name_to_id(survweapon)], MAXBPAMMO[cs_weapon_name_to_id(survweapon)])
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the survivor a nice aura
		if (get_pcvar_num(cvar_survaura))
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Survivor bots will also need nightvision to see in the dark
		if (g_isbot[id])
		{
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else if (classid == SNIPER)
	{
		// Sniper
		g_hm_special[id] = SNIPER
		
		// Set Health [0 = auto]
		if (get_pcvar_num(cvar_sniperhp) == 0)
		{
			if (get_pcvar_num(cvar_sniperbasehp) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_humanhp) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_sniperbasehp) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_sniperhp))
		
		// Set gravity, unless frozen
		if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_snipergravity))
		
		// Give sniper his own weapon and fill the ammo
		fm_give_item(id, "weapon_awp")
		ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_AWP], AMMOTYPE[CSW_AWP], MAXBPAMMO[CSW_AWP])
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the sniper a nice aura
		if (get_pcvar_num(cvar_sniperaura))
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Sniper bots will also need nightvision to see in the dark
		if (g_isbot[id])
		{
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else if (classid == BERSERKER)
	{
		// Berserker
		g_hm_special[id] = BERSERKER
		
		// Set Health [0 = auto]
		if (get_pcvar_num(cvar_berserkerhp) == 0)
		{
			if (get_pcvar_num(cvar_berserkerbasehp) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_humanhp) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_berserkerbasehp) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_berserkerhp))
		
		// Set gravity, unless frozen
		if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_berserkergravity))
		
		fm_give_item(id, "weapon_knife")

		g_currentweapon[id] = CSW_KNIFE
		replace_weapon_models(id, g_currentweapon[id])
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the berserker a nice aura
		if (get_pcvar_num(cvar_berserkeraura))
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Berserker bots will also need nightvision to see in the dark
		if (g_isbot[id])
		{
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else if (classid == WESKER)
	{
		// Wesker
		g_hm_special[id] = WESKER
		
		// Set Health [0 = auto]
		if (get_pcvar_num(cvar_weskerhp) == 0)
		{
			if (get_pcvar_num(cvar_weskerbasehp) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_humanhp) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_weskerbasehp) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_weskerhp))
		
		// Set gravity, unless frozen
		if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_weskergravity))
		
		// Give wesker his own weapon and fill the ammo
		fm_give_item(id, "weapon_deagle")
		ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_DEAGLE], AMMOTYPE[CSW_DEAGLE], MAXBPAMMO[CSW_DEAGLE])
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the wesker a nice aura
		if (get_pcvar_num(cvar_weskeraura))
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Wesker bots will also need nightvision to see in the dark
		if (g_isbot[id])
		{
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else
	{
		// Human taking an antidote
		
		// Set health
		fm_set_user_health(id, get_pcvar_num(cvar_humanhp))
		
		// Set gravity, unless frozen
		if (!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_humangravity))
		
		// Show custom buy menu?
		if (get_pcvar_num(cvar_buycustom))
			set_task(0.2, "show_menu_buy1", id+TASK_SPAWN)
		
		// Silent mode = no HUD messages, no antidote sound
		if (!silentmode)
		{
			// Antidote sound
			static sound[64]
			ArrayGetString(sound_antidote, random_num(0, ArraySize(sound_antidote) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_ITEM, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Show Antidote HUD notice
			set_hudmessage(10, 255, 235, HUD_INFECT_X, HUD_INFECT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
			ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_ANTIDOTE", g_playername[id])
		}
	}
	
	// Switch to CT
	if (fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	// Custom models stuff
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		if (g_hm_special[id] == SURVIVOR)
		{
			iRand = random_num(0, ArraySize(model_survivor) - 1)
			ArrayGetString(model_survivor, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_survivor, iRand))
		}
		else if (g_hm_special[id] == SNIPER)
		{
			iRand = random_num(0, ArraySize(model_sniper) - 1)
			ArrayGetString(model_sniper, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_sniper, iRand))
		}
		else if (g_hm_special[id] == BERSERKER)
		{
			iRand = random_num(0, ArraySize(model_berserker) - 1)
			ArrayGetString(model_berserker, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_berserker, iRand))
		}
		else if (g_hm_special[id] == WESKER)
		{
			iRand = random_num(0, ArraySize(model_wesker) - 1)
			ArrayGetString(model_wesker, iRand, g_playermodel[id], charsmax(g_playermodel[]))
			if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_wesker, iRand))
		}
		else
		{
			if (get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				iRand = random_num(0, ArraySize(model_admin_human) - 1)
				ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
			}
			else if (get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]))
			{
				iRand = random_num(0, ArraySize(model_vip_human) - 1)
				ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
			}
			else
			{
				iRand = random_num(0, ArraySize(model_human) - 1)
				ArrayGetString(model_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human, iRand))
			}
		}
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
		
		// Set survivor glow / remove glow on player model entity, unless frozen
		if (!g_frozen[id])
		{
			if (g_hm_special[id] == SURVIVOR && get_pcvar_num(cvar_survglow)) 
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 250, 250, kRenderNormal, 25)
			else if (g_hm_special[id] == SURVIVOR && !(get_pcvar_num(cvar_survglow))) 
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_hm_special[id] == SNIPER && get_pcvar_num(cvar_sniperglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_snipercolor[0]), get_pcvar_num(cvar_snipercolor[1]), get_pcvar_num(cvar_snipercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == SNIPER && !(get_pcvar_num(cvar_sniperglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)

			else if (g_hm_special[id] == BERSERKER && get_pcvar_num(cvar_berserkerglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_berserkercolor[0]), get_pcvar_num(cvar_berserkercolor[1]), get_pcvar_num(cvar_berserkercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == BERSERKER && !(get_pcvar_num(cvar_berserkerglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_hm_special[id] == WESKER && get_pcvar_num(cvar_weskerglow))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_weskercolor[0]), get_pcvar_num(cvar_weskercolor[1]), get_pcvar_num(cvar_weskercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == WESKER && !(get_pcvar_num(cvar_weskerglow)))
				fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
			else if (g_hm_special[id] <= 0)
				fm_set_rendering(g_ent_playermodel[id])
		}
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (g_hm_special[id] == SURVIVOR)
		{
			size = ArraySize(model_survivor)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_survivor, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_survivor, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_survivor, iRand))
			}
		}
		else if (g_hm_special[id] == SNIPER)
		{
			size = ArraySize(model_sniper)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_sniper, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_sniper, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_sniper, iRand))
			}
		}
		else if (g_hm_special[id] == BERSERKER)
		{
			size = ArraySize(model_berserker)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_berserker, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_berserker, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_berserker, iRand))
			}
		}
		else if (g_hm_special[id] == WESKER)
		{
			size = ArraySize(model_wesker)
			for (i = 0; i < size; i++)
			{
				ArrayGetString(model_wesker, i, tempmodel, charsmax(tempmodel))
				if (equal(currentmodel, tempmodel)) already_has_model = true
			}
			
			if (!already_has_model)
			{
				iRand = random_num(0, size - 1)
				ArrayGetString(model_wesker, iRand, g_playermodel[id], charsmax(g_playermodel[]))
				if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_wesker, iRand))
			}
		}
		else
		{
			if (get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]))
			{
				size = ArraySize(model_admin_human)
				for (i = 0; i < size; i++)
				{
					ArrayGetString(model_admin_human, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(0, size - 1)
					ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
				}
			}
			else if (get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]))
			{
				size = ArraySize(model_vip_human)
				for (i = 0; i < size; i++)
				{
					ArrayGetString(model_vip_human, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(0, size - 1)
					ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
				}
			}
			else
			{
				size = ArraySize(model_human)
				for (i = 0; i < size; i++)
				{
					ArrayGetString(model_human, i, tempmodel, charsmax(tempmodel))
					if (equal(currentmodel, tempmodel)) already_has_model = true
				}
				
				if (!already_has_model)
				{
					iRand = random_num(0, size - 1)
					ArrayGetString(model_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if (g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human, iRand))
				}
			}
		}
		
		// Need to change the model?
		if (!already_has_model)
		{
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
		
		// Set survivor glow / remove glow, unless frozen
		if (!g_frozen[id])
		{
			if (g_hm_special[id] == SURVIVOR && get_pcvar_num(cvar_survglow)) 
				fm_set_rendering(id, kRenderFxGlowShell, 0, 250, 250, kRenderNormal, 25)
			else if (g_hm_special[id] == SURVIVOR && !(get_pcvar_num(cvar_survglow))) 
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_hm_special[id] == SNIPER && get_pcvar_num(cvar_sniperglow))
				fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_snipercolor[0]), get_pcvar_num(cvar_snipercolor[1]), get_pcvar_num(cvar_snipercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == SNIPER && !(get_pcvar_num(cvar_sniperglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)

			else if (g_hm_special[id] == BERSERKER && get_pcvar_num(cvar_berserkerglow))
				fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_berserkercolor[0]), get_pcvar_num(cvar_berserkercolor[1]), get_pcvar_num(cvar_berserkercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == BERSERKER && !(get_pcvar_num(cvar_berserkerglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
				
			else if (g_hm_special[id] == WESKER && get_pcvar_num(cvar_weskerglow))
				fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_weskercolor[0]), get_pcvar_num(cvar_weskercolor[1]), get_pcvar_num(cvar_weskercolor[2]), kRenderNormal, 25)
			else if (g_hm_special[id] == WESKER && !(get_pcvar_num(cvar_weskerglow)))
				fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
			else if (g_hm_special[id] <= 0)
				fm_set_rendering(id)
		}
	}
	
	// Restore FOV?
	if (get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0)
	{
		message_begin(MSG_ONE, g_msgid[SET_FOV], _, id)
		write_byte(90) // angle
		message_end()
	}
	
	// Disable nightvision
	if (g_isbot[id]) cs_set_user_nvg(id, 0)
	else if (!get_pcvar_num(cvar_customnvg) && g_nvisionenabled[id]) set_user_gnvision(id, 0)
	
	// Post user humanize forward
	ExecuteForward(g_forwards[HUMANIZED_POST], g_fwDummyResult, id, classid)
	
	// Last Zombie Check
	fnCheckLastZombie()
}

/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/

public cache_cvars()
{
	g_cached_zombiesilent = get_pcvar_num(cvar_zombiesilent)
	g_cached_customflash = get_pcvar_num(cvar_customflash)
	g_cached_humanspd = get_pcvar_float(cvar_humanspd)
	g_cached_nemspd = get_pcvar_float(cvar_nemspd)
	g_cached_survspd = get_pcvar_float(cvar_survspd)
	g_cached_leapzombies = get_pcvar_num(cvar_leapzombies)
	g_cached_leapzombiescooldown = get_pcvar_float(cvar_leapzombiescooldown)
	g_cached_leapnemesis = get_pcvar_num(cvar_leapnemesis)
	g_cached_leapnemesiscooldown = get_pcvar_float(cvar_leapnemesiscooldown)
	g_cached_leapsurvivor = get_pcvar_num(cvar_leapsurvivor)
	g_cached_leapsurvivorcooldown = get_pcvar_float(cvar_leapsurvivorcooldown)
	g_cached_sniperspd = get_pcvar_float(cvar_sniperspd)
	g_cached_leapsniper = get_pcvar_num(cvar_leapsniper)
	g_cached_leapsnipercooldown = get_pcvar_float(cvar_leapsnipercooldown)
	g_cached_assassinspd = get_pcvar_float(cvar_assassinspd)
	g_cached_leapassassin = get_pcvar_num(cvar_leapassassin)
	g_cached_leapassassincooldown = get_pcvar_float(cvar_leapassassincooldown)
	g_cached_predatorspd = get_pcvar_float(cvar_predatorspd)
	g_cached_leappredator = get_pcvar_num(cvar_leappredator)
	g_cached_leappredatorcooldown = get_pcvar_float(cvar_leappredatorcooldown)
	g_cached_bombardierspd = get_pcvar_float(cvar_bombardierspd)
	g_cached_leapbombardier = get_pcvar_num(cvar_leapbombardier)
	g_cached_leapbombardiercooldown = get_pcvar_float(cvar_leapbombardiercooldown)
	g_cached_berserkerspd = get_pcvar_float(cvar_berserkerspd)
	g_cached_leapberserker = get_pcvar_num(cvar_leapberserker)
	g_cached_leapberserkercooldown = get_pcvar_float(cvar_leapberserkercooldown)
	g_cached_weskerspd = get_pcvar_float(cvar_weskerspd)
	g_cached_leapwesker = get_pcvar_num(cvar_leapwesker)
	g_cached_leapweskercooldown = get_pcvar_float(cvar_leapweskercooldown)
}

load_customization_from_files()
{
	new i
	
	// Section Access Flags
	new user_access[40]
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "ADMIN MENU OF CLASSES", user_access, charsmax(user_access)); g_access_flag[ACCESS_ADMIN_MENU] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "ADMIN MENU OF MODES", user_access, charsmax(user_access)); g_access_flag[ACCESS_ADMIN_MENU2] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "ADMIN MENU MAIN ACCESS", user_access, charsmax(user_access)); g_access_flag[ACCESS_ADMIN_MENU3] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE INFECTION", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_INFECTION] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE NEMESIS", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_NEMESIS] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE SURVIVOR", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_SURVIVOR] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE ASSASSIN", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_ASSASSIN] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE SNIPER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_SNIPER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE PREDATOR", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_PREDATOR] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE BERSERKER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_BERSERKER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE BOMBARDIER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_BOMBARDIER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE WESKER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_WESKER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE SWARM", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_SWARM] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE MULTI", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_MULTI] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE PLAGUE", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_PLAGUE] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "START MODE LNJ", user_access, charsmax(user_access)); g_access_flag[ACCESS_MODE_LNJ] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE ZOMBIE", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_ZOMBIE] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE HUMAN", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_HUMAN] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE NEMESIS", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_NEMESIS] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE SURVIVOR", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_SURVIVOR] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE ASSASSIN", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_ASSASSIN] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE SNIPER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_SNIPER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE PREDATOR", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_PREDATOR] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE BERSERKER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_BERSERKER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE BOMBARDIER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_BOMBARDIER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "MAKE WESKER", user_access, charsmax(user_access)); g_access_flag[ACCESS_MAKE_WESKER] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "RESPAWN PLAYERS", user_access, charsmax(user_access)); g_access_flag[ACCESS_RESPAWN_PLAYERS] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "ADMIN MODELS", user_access, charsmax(user_access)); g_access_flag[ACCESS_ADMIN_MODELS] = read_flags(user_access)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", "VIP MODELS", user_access, charsmax(user_access)); g_access_flag[ACCESS_VIP_MODELS] = read_flags(user_access)
	
	// Player Models
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "HUMAN", model_human)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "NEMESIS", model_nemesis)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "SURVIVOR", model_survivor)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ASSASSIN", model_assassin)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "SNIPER", model_sniper)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "PREDATOR", model_predator)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "BERSERKER", model_berserker)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "BOMBARDIER", model_bombardier)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "WESKER", model_wesker)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN ZOMBIE", model_admin_zombie)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN HUMAN", model_admin_human)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "VIP HUMAN", model_vip_human)
	
	g_force_consistency = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "FORCE CONSISTENCY", g_force_consistency)
	g_same_models_for_all = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "SAME MODELS FOR ALL", g_same_models_for_all)

	if (g_same_models_for_all) 
	{
		new linedata[1024], key[40]
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ZOMBIE", g_zclass_playermodel)
	
		for (i = 0; i < ArraySize(g_zclass_playermodel); i++)
		{
			ArrayGetString(g_zclass_playermodel, i, key, charsmax(key))
			
			// Precache model and retrieve its modelindex
			formatex(linedata, charsmax(linedata), "models/player/%s/%s.mdl", key, key)
			ArrayPushCell(g_zclass_modelindex, engfunc(EngFunc_PrecacheModel, linedata))
			if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, linedata)
			if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, linedata)
		}
		
	}

	// Weapon Models
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE HUMAN", model_vknife_human, charsmax(model_vknife_human));
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE HUMAN", model_pknife_human, charsmax(model_pknife_human));
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE NEMESIS", model_vknife_nemesis, charsmax(model_vknife_nemesis))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_M249 SURVIVOR", model_vm249_survivor, charsmax(model_vm249_survivor))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_M249 SURVIVOR", model_pm249_survivor, charsmax(model_pm249_survivor))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE ASSASSIN", model_vknife_assassin, charsmax(model_vknife_assassin))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_AWP SNIPER", model_vawp_sniper, charsmax(model_vawp_sniper))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_AWP SNIPER", model_pawp_sniper, charsmax(model_pawp_sniper))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE PREDATOR", model_vknife_predator, charsmax(model_vknife_predator))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE BERSERKER", model_vknife_berserker, charsmax(model_vknife_berserker))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE BERSERKER", model_pknife_berserker, charsmax(model_pknife_berserker))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE BOMBARDIER", model_vknife_bombardier, charsmax(model_vknife_bombardier))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_DEAGLE WESKER", model_vdeagle_wesker, charsmax(model_vdeagle_wesker))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_DEAGLE WESKER", model_pdeagle_wesker, charsmax(model_pdeagle_wesker))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE ADMIN HUMAN", model_vknife_admin_human, charsmax(model_vknife_admin_human))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE ADMIN HUMAN", model_pknife_admin_human, charsmax(model_pknife_admin_human))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE VIP HUMAN", model_vknife_vip_human, charsmax(model_vknife_vip_human))	
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE VIP HUMAN", model_pknife_vip_human, charsmax(model_pknife_vip_human))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE ADMIN ZOMBIE", model_vknife_admin_zombie, charsmax(model_vknife_admin_zombie))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "GRENADE INFECT", model_grenade_infect, charsmax(model_grenade_infect))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "GRENADE FIRE", model_grenade_fire, charsmax(model_grenade_fire))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "GRENADE FROST", model_grenade_frost, charsmax(model_grenade_frost))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "GRENADE FLARE", model_grenade_flare, charsmax(model_grenade_flare))
				
	// Grenade Sprites
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "TRAIL", sprite_grenade_trail, charsmax(sprite_grenade_trail))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "RING", sprite_grenade_ring, charsmax(sprite_grenade_ring))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "FIRE", sprite_grenade_fire, charsmax(sprite_grenade_fire))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "SMOKE", sprite_grenade_smoke, charsmax(sprite_grenade_smoke))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "GLASS", sprite_grenade_glass, charsmax(sprite_grenade_glass))
	
	// Sounds
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "WIN ZOMBIES", sound_win_zombies)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "WIN HUMANS", sound_win_humans)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "WIN NO ONE", sound_win_no_one)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE INFECT", zombie_infect)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE PAIN", zombie_pain)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "NEMESIS PAIN", nemesis_pain)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ASSASSIN PAIN", assassin_pain)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "PREDATOR PAIN", predator_pain)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "BOMBARDIER PAIN", bombardier_pain)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE DIE", zombie_die)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE FALL", zombie_die)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MISS SLASH", zombie_miss_slash)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MISS WALL", zombie_miss_wall)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE HIT NORMAL", zombie_hit_normal)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE HIT STAB", zombie_hit_stab)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE IDLE", zombie_idle)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE IDLE LAST", zombie_idle_last)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MADNESS", zombie_madness)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND NEMESIS", sound_nemesis)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND SURVIVOR", sound_survivor)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND ASSASSIN", sound_assassin)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND SNIPER", sound_sniper)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND PREDATOR", sound_predator)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND BERSERKER", sound_berserker)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND BOMBARDIER", sound_bombardier)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND WESKER", sound_wesker)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND SWARM", sound_swarm)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND MULTI", sound_multi)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND PLAGUE", sound_plague)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ROUND LNJ", sound_lnj)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE INFECT EXPLODE", grenade_infect)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE INFECT PLAYER", grenade_infect_player)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FIRE EXPLODE", grenade_fire)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FIRE PLAYER", grenade_fire_player)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FROST EXPLODE", grenade_frost)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FROST PLAYER", grenade_frost_player)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FROST BREAK", grenade_frost_break)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "GRENADE FLARE", grenade_flare)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ANTIDOTE", sound_antidote)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "THUNDER", sound_thunder)
	
	// Ambience Sounds
	g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "INFECTION ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "INFECTION SOUNDS", sound_ambience1)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "INFECTION DURATIONS", sound_ambience1_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "NEMESIS ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "NEMESIS SOUNDS", sound_ambience2)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "NEMESIS DURATIONS", sound_ambience2_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SURVIVOR ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SURVIVOR SOUNDS", sound_ambience3)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SURVIVOR DURATIONS", sound_ambience3_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_SWARM] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SWARM ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_SWARM])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SWARM]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SWARM SOUNDS", sound_ambience4)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SWARM DURATIONS", sound_ambience4_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PLAGUE ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PLAGUE SOUNDS", sound_ambience5)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PLAGUE DURATIONS", sound_ambience5_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SNIPER ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SNIPER SOUNDS", sound_ambience6)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "SNIPER DURATIONS", sound_ambience6_duration)
	}

	g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ASSASSIN ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ASSASSIN SOUNDS", sound_ambience7)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "ASSASSIN DURATIONS", sound_ambience7_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_LNJ] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "LNJ ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_LNJ])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_LNJ]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "LNJ SOUNDS", sound_ambience8)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "LNJ DURATIONS", sound_ambience8_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BERSERKER ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BERSERKER SOUNDS", sound_ambience9)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BERSERKER DURATIONS", sound_ambience9_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PREDATOR ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PREDATOR SOUNDS", sound_ambience10)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "PREDATOR DURATIONS", sound_ambience10_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_WESKER] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "WESKER ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_WESKER])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_WESKER]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "WESKER SOUNDS", sound_ambience11)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "WESKER DURATIONS", sound_ambience11_duration)
	}
	
	g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BOMBARDIER ENABLE", g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER])
	if (g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER]) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BOMBARDIER SOUNDS", sound_ambience12)
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", "BOMBARDIER DURATIONS", sound_ambience12_duration)
	}
	
	// Buy Menu Weapons
	new wpn_ids[32]
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "PRIMARY", g_primary_items)
	for (i = 0; i < ArraySize(g_primary_items); i++)
	{
		ArrayGetString(g_primary_items, i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_primary_weaponids, cs_weapon_name_to_id(wpn_ids))
	}	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "SECONDARY", g_secondary_items)
	for (i = 0; i < ArraySize(g_secondary_items); i++)
	{
		ArrayGetString(g_secondary_items, i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_secondary_weaponids, cs_weapon_name_to_id(wpn_ids))
	}
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "ADDITIONAL ITEMS", g_additional_items)

	// Extra Items: Weapons and their costs
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "NAMES", g_extraweapon_names)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "ITEMS", g_extraweapon_items)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "COSTS", g_extraweapon_costs)	
	
	// Hard Coded Items Costs
	g_extra_costs2[EXTRA_NVISION] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "NIGHT VISION", g_extra_costs2[EXTRA_NVISION])
	g_extra_costs2[EXTRA_ANTIDOTE] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "ANTIDOTE", g_extra_costs2[EXTRA_ANTIDOTE])
	g_extra_costs2[EXTRA_MADNESS] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "ZOMBIE MADNESS", g_extra_costs2[EXTRA_MADNESS])
	g_extra_costs2[EXTRA_INFBOMB] = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "INFECTION BOMB", g_extra_costs2[EXTRA_INFBOMB])

	
	// Weather Effects
	g_ambience_rain = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "RAIN", g_ambience_rain)
	g_ambience_snow = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "SNOW", g_ambience_snow)
	g_ambience_fog = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG", g_ambience_fog)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG_DENSITY", g_fog_density, charsmax(g_fog_density))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG_COLOR", g_fog_color, charsmax(g_fog_color))
	
	g_sky_enable = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Custom Skies", "ENABLE", g_sky_enable)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Custom Skies", "SKY NAMES", g_sky_names)
	
	if(g_sky_enable)
	{
		// Choose random sky and precache sky files
		new path[128], skyname[32], g_SkyArrayIndex
		g_SkyArrayIndex = random_num(0, ArraySize(g_sky_names) - 1)
		ArrayGetString(g_sky_names, g_SkyArrayIndex, skyname, charsmax(skyname))
		formatex(path, charsmax(path), "gfx/env/%sbk.tga", skyname)
		precache_generic(path)
		formatex(path, charsmax(path), "gfx/env/%sdn.tga", skyname)
		precache_generic(path)
		formatex(path, charsmax(path), "gfx/env/%sft.tga", skyname)
		precache_generic(path)
		formatex(path, charsmax(path), "gfx/env/%slf.tga", skyname)
		precache_generic(path)
		formatex(path, charsmax(path), "gfx/env/%srt.tga", skyname)
		precache_generic(path)
		formatex(path, charsmax(path), "gfx/env/%sup.tga", skyname)
		precache_generic(path)
	}

	// Lightning Lights Cycle
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Lightning Lights Cycle", "LIGHTS", lights_thunder)
	
	// Zombie Decals
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Zombie Decals", "DECALS", zombie_decals)
	
	// Knockback Power for Weapons
	for(i = 1; i < sizeof WEAPONENTNAMES; i++)
	{
		new buffer[32]
		if (!strlen(WEAPONENTNAMES[i])) continue;
				
		format(buffer, charsmax(buffer), "%s", WEAPONENTNAMES[i])
		strtoupper(buffer)
		amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Knockback Power for Weapons", buffer, kb_weapon_power[i])
	}
			
			
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Objective Entities", "CLASSNAMES", g_objective_ents)
	
	new szValue[40]
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "MODELCHANGE DELAY", szValue, charsmax(szValue))
	g_modelchange_delay = str_to_float(szValue)

	g_handle_models_on_separate_ent = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "HANDLE MODELS ON SEPARATE ENT", g_handle_models_on_separate_ent)
	g_set_modelindex_offset = amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "SET MODELINDEX OFFSET", g_set_modelindex_offset)
}
// Register Ham Forwards for CZ bots
public register_ham_czbots(id)
{
	// Make sure it's a CZ bot and it's still connected
	if (g_hamczbots || !g_isconnected[id] || !get_pcvar_num(cvar_botquota))
		return;
	
	RegisterHamFromEntity(Ham_Spawn, id, "fw_PlayerSpawn_Post", 1)
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled")
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled_Post", 1)
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage")
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage_Post", 1)
	RegisterHamFromEntity(Ham_TraceAttack, id, "fw_TraceAttack")
	
	// Ham forwards for CZ bots succesfully registered
	g_hamczbots = true
	
	// If the bot has already spawned, call the forward manually for him
	if (is_user_alive(id)) fw_PlayerSpawn_Post(id)
}

// Disable minmodels task
public disable_minmodels(id)
{
	if (!g_isconnected[id]) return;
	client_cmd(id, "cl_minmodels 0")
}

// Bots automatically buy extra items
public bot_buy_extras(taskid)
{
	// Nemesis, Survivor, Sniper and Berserker bots have nothing to buy by default
	if (!g_isalive[ID_SPAWN] || g_hm_special[ID_SPAWN] > 0 && g_hm_special[ID_SPAWN] < MAX_SPECIALS_HUMANS || g_zm_special[ID_SPAWN] > 0 && g_zm_special[ID_SPAWN] < MAX_SPECIALS_ZOMBIES)
		return;
	
	if (!g_zombie[ID_SPAWN]) // human bots
	{
		// Attempt to buy Night Vision
		buy_extra_item(ID_SPAWN, EXTRA_NVISION)
		
		// Attempt to buy a weapon
		buy_extra_item(ID_SPAWN, random_num(EXTRA_WEAPONS_STARTID, EXTRAS_CUSTOM_STARTID-1))
	}
	else // zombie bots
	{
		// Attempt to buy an Antidote
		buy_extra_item(ID_SPAWN, EXTRA_ANTIDOTE)
	}
}

// Refill BP Ammo Task
public refill_bpammo(const args[], id)
{
	// Player died or turned into a zombie
	if (!g_isalive[id] || g_zombie[id])
		return;
	
	set_msg_block(g_msgid[AMMO_PICKUP], BLOCK_ONCE)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[REFILL_WEAPONID], AMMOTYPE[REFILL_WEAPONID], MAXBPAMMO[REFILL_WEAPONID])
}

// Balance Teams Task
balance_teams()
{
	// Get amount of users playing
	static iPlayersnum
	iPlayersnum = fnGetPlaying()
	
	// No players, don't bother
	if (iPlayersnum < 1) return;
	
	// Split players evenly
	static iTerrors, iMaxTerrors, id, team[33]
	iMaxTerrors = iPlayersnum/2
	iTerrors = 0
	
	// First, set everyone to CT
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Skip if not connected
		if (!g_isconnected[id])
			continue;
		
		team[id] = fm_cs_get_user_team(id)
		
		// Skip if not playing
		if (team[id] == FM_CS_TEAM_SPECTATOR || team[id] == FM_CS_TEAM_UNASSIGNED)
			continue;
		
		// Set team
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		team[id] = FM_CS_TEAM_CT
	}
	
	// Then randomly set half of the players to Terrorists
	while (iTerrors < iMaxTerrors)
	{
		// Keep looping through all players
		if (++id > g_maxplayers) id = 1
		
		// Skip if not connected
		if (!g_isconnected[id])
			continue;
		
		// Skip if not playing or already a Terrorist
		if (team[id] != FM_CS_TEAM_CT)
			continue;
		
		// Random chance
		if (random_num(0, 1))
		{
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			team[id] = FM_CS_TEAM_T
			iTerrors++
		}
	}
}

// Welcome Message Task
public welcome_msg()
{
	// Show mod info
	zp_colored_print(0, "^x01**** ^x04%s^x01 ****", g_modname)
	zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "NOTICE_INFO1")
	if (!get_pcvar_num(cvar_infammo)) zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "NOTICE_INFO2")

	// Show T-virus HUD notice
	set_hudmessage(0, 125, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 3.0, 2.0, 1.0, -1)
	ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_VIRUS_FREE")
}

// Respawn Player Task
public respawn_player_task(taskid)
{
	// Get player's team
	static team
	team = fm_cs_get_user_team(ID_SPAWN)
	
	// Respawn player automatically if allowed on current round
	if ((!g_endround && team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED && !g_isalive[ID_SPAWN] && g_currentmode != MODE_SURVIVOR || get_pcvar_num(cvar_allowrespawnsurv)) && (g_currentmode != MODE_SWARM || get_pcvar_num(cvar_allowrespawnswarm))
	&& (g_currentmode != MODE_NEMESIS || get_pcvar_num(cvar_allowrespawnnem)) && (g_currentmode != MODE_PLAGUE || get_pcvar_num(cvar_allowrespawnplague)) && (g_currentmode != MODE_SNIPER || get_pcvar_num(cvar_allowrespawnsniper)) 
	&& (g_currentmode != MODE_ASSASSIN || get_pcvar_num(cvar_allowrespawnassassin)) && (g_currentmode != MODE_PREDATOR || get_pcvar_num(cvar_allowrespawnpredator)) && (g_currentmode != MODE_BOMBARDIER || get_pcvar_num(cvar_allowrespawnbombardier))
	&& (g_currentmode != MODE_LNJ || get_pcvar_num(cvar_allowrespawnlnj)) && (g_currentmode != MODE_BERSERKER || get_pcvar_num(cvar_allowrespawnberserker)) && (g_currentmode != MODE_WESKER || get_pcvar_num(cvar_allowrespawnwesker)) && (!(g_currentmode > MODE_LNJ) || (g_deathmatchmode > 0)))
	{
		// Infection rounds = none of the above
		if (!get_pcvar_num(cvar_allowrespawninfection) && (g_currentmode == MODE_INFECTION || g_currentmode == MODE_MULTI))
			return;
		 
		// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
		if (g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[ID_SPAWN] = true
		else if (g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR) g_respawn_as_zombie[ID_SPAWN] = false
		
		respawn_player_manually(ID_SPAWN)
	}
}

// Respawn Player Manually (called after respawn checks are done)
respawn_player_manually(id)
{
	// Set proper team before respawning, so that the TeamInfo message that's sent doesn't confuse PODBots
	if (g_respawn_as_zombie[id])
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
	else
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
	
	// Respawning a player has never been so easy
	ExecuteHamB(Ham_CS_RoundRespawn, id)
}

// Check Round Task -check that we still have both zombies and humans on a round-
check_round(leaving_player)
{
	// Round ended or make_a_zombie task still active
	if (g_endround || task_exists(TASK_MAKEZOMBIE))
		return;
	
	// Get alive players count
	static iPlayersnum, id
	iPlayersnum = fnGetAlive()
	
	// Last alive player, don't bother
	if (iPlayersnum < 2)
		return;
	
	// Last zombie disconnecting
	if (g_zombie[leaving_player] && fnGetZombies() == 1)
	{
		// Only one CT left, don't bother
		if (fnGetHumans() == 1 && fnGetCTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player ) { /* keep looping */ }
		
		// Show last zombie left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_ZOMBIE_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Nemesis, Assassin or just a zombie?
		switch(g_zm_special[leaving_player])
		{
			case NEMESIS: zombieme(id, 0, NEMESIS, 0, 0)
			case ASSASSIN: zombieme(id, 0, ASSASSIN, 0, 0)
			case PREDATOR: zombieme(id, 0, PREDATOR, 0, 0)
			case BOMBARDIER: zombieme(id, 0, BOMBARDIER, 0, 0)
			default: zombieme(id, 0, 0, 0, 0)
		}
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		// If Specials, set chosen player's health to that of the one who's leaving
		if (get_pcvar_num(cvar_keephealthondisconnect) && g_zm_special[leaving_player] > 0 && g_zm_special[leaving_player] < MAX_SPECIALS_ZOMBIES)
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
	
	// Last human disconnecting
	else if (!g_zombie[leaving_player] && fnGetHumans() == 1)
	{
		// Only one T left, don't bother
		if (fnGetZombies() == 1 && fnGetTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player ) { /* keep looping */ }
		
		// Show last human left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_HUMAN_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Survivor, Sniper, berserker or just a human?
		switch (g_hm_special[leaving_player])
		{
			case SURVIVOR: humanme(id, SURVIVOR, 0)
			case SNIPER: humanme(id, SNIPER, 0)
			case BERSERKER: humanme(id, BERSERKER, 0)
			case WESKER: humanme(id, WESKER, 0)
			default: humanme(id, 0, 0)
		}
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		if (get_pcvar_num(cvar_keephealthondisconnect) && (g_hm_special[leaving_player] > 0 && g_hm_special[leaving_player] < MAX_SPECIALS_HUMANS))
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
}

// Lighting Effects Task
public lighting_effects()
{
	// Cache some CVAR values at every 5 secs
	cache_cvars()
	
	// Get lighting style
	static lighting[2]
	get_pcvar_string(cvar_lighting, lighting, charsmax(lighting))
	strtolower(lighting)
	
	// Lighting disabled? ["0"]
	if (lighting[0] == '0')
		return;
	
	// Darkest light settings?
	if (lighting[0] >= 'a' && lighting[0] <= 'd')
	{
		static thunderclap_in_progress, Float:thunder
		thunderclap_in_progress = task_exists(TASK_THUNDER)
		thunder = get_pcvar_float(cvar_thunder)
		
		// Set thunderclap tasks if not existant
		if (thunder > 0.0 && !task_exists(TASK_THUNDER_PRE) && !thunderclap_in_progress)
		{
			g_lights_i = 0
			ArrayGetString(lights_thunder, random_num(0, ArraySize(lights_thunder) - 1), g_lights_cycle, charsmax(g_lights_cycle))
			g_lights_cycle_len = strlen(g_lights_cycle)
			set_task(thunder, "thunderclap", TASK_THUNDER_PRE)
		}
		
		// Set lighting only when no thunderclaps are going on
		if (!thunderclap_in_progress) engfunc(EngFunc_LightStyle, 0, (g_currentmode == MODE_ASSASSIN) ? "a" : lighting) // no lighting in assassin round
	}
	else
	{
		// Remove thunderclap tasks
		remove_task(TASK_THUNDER_PRE)
		remove_task(TASK_THUNDER)
		
		// Set lighting
		engfunc(EngFunc_LightStyle, 0, (g_currentmode == MODE_ASSASSIN) ? "a" : lighting) // no lighting in assassin round
	}
}

// Thunderclap task
public thunderclap()
{
	// Play thunder sound
	if (g_lights_i == 0)
	{
		static sound[64]
		ArrayGetString(sound_thunder, random_num(0, ArraySize(sound_thunder) - 1), sound, charsmax(sound))
		PlaySound(sound)
	}
	
	// Set lighting
	static light[2]
	light[0] = g_lights_cycle[g_lights_i]
	engfunc(EngFunc_LightStyle, 0, light)
	
	g_lights_i++
	
	// Lighting cycle end?
	if (g_lights_i >= g_lights_cycle_len)
	{
		remove_task(TASK_THUNDER)
		lighting_effects()
	}
	// Lighting cycle start?
	else if (!task_exists(TASK_THUNDER))
		set_task(0.1, "thunderclap", TASK_THUNDER, _, _, "b")
}

// Ambience Sound Effects Task
public ambience_sound_effects(taskid)
{
	// Play a random sound depending on the round
	static sound[64], iRand, duration, str_duration[32]
	
	// Check for current game mode
	switch (g_currentmode)
	{
		case MODE_INFECTION:
		{
			iRand = random_num(0, ArraySize(sound_ambience1) - 1)
			ArrayGetString(sound_ambience1, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience1_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_NEMESIS:
		{
			iRand = random_num(0, ArraySize(sound_ambience2) - 1)
			ArrayGetString(sound_ambience2, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience2_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_ASSASSIN:
		{
			iRand = random_num(0, ArraySize(sound_ambience7) - 1)
			ArrayGetString(sound_ambience7, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience7_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_PREDATOR:
		{
			iRand = random_num(0, ArraySize(sound_ambience10) - 1)
			ArrayGetString(sound_ambience10, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience10_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_BOMBARDIER:
		{
			iRand = random_num(0, ArraySize(sound_ambience12) - 1)
			ArrayGetString(sound_ambience12, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience12_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_SURVIVOR:
		{
			iRand = random_num(0, ArraySize(sound_ambience3) - 1)
			ArrayGetString(sound_ambience3, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience3_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_SNIPER:
		{
			iRand = random_num(0, ArraySize(sound_ambience6) - 1)
			ArrayGetString(sound_ambience6, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience6_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_BERSERKER:
		{
			iRand = random_num(0, ArraySize(sound_ambience9) - 1)
			ArrayGetString(sound_ambience9, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience9_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_WESKER:
		{
			iRand = random_num(0, ArraySize(sound_ambience11) - 1)
			ArrayGetString(sound_ambience11, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience11_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_SWARM:
		{
			iRand = random_num(0, ArraySize(sound_ambience4) - 1)
			ArrayGetString(sound_ambience4, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience4_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_MULTI:
		{
			iRand = random_num(0, ArraySize(sound_ambience1) - 1)
			ArrayGetString(sound_ambience1, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience1_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_PLAGUE:
		{
			iRand = random_num(0, ArraySize(sound_ambience5) - 1)
			ArrayGetString(sound_ambience5, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience5_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
		case MODE_LNJ:
		{
			iRand = random_num(0, ArraySize(sound_ambience8) - 1)
			ArrayGetString(sound_ambience8, iRand, sound, charsmax(sound))
			ArrayGetString(sound_ambience8_duration, iRand, str_duration, charsmax(str_duration))
			duration = str_to_num(str_duration)
		}
	}
	
	// Play it on clients
	PlaySound(sound)
	
	// Set the task for when the sound is done playing
	set_task(float(duration), "ambience_sound_effects", TASK_AMBIENCESOUNDS)
}

// Ambience Sounds Stop Task
ambience_sound_stop() client_cmd(0, "mp3 stop; stopsound");

// Flashlight Charge Task
public flashlight_charge(taskid)
{
	// Drain or charge?
	if (g_flashlight[ID_CHARGE])
		g_flashbattery[ID_CHARGE] -= get_pcvar_num(cvar_flashdrain)
	else
		g_flashbattery[ID_CHARGE] += get_pcvar_num(cvar_flashcharge)
	
	// Battery fully charged
	if (g_flashbattery[ID_CHARGE] >= 100)
	{
		// Don't exceed 100%
		g_flashbattery[ID_CHARGE] = 100
		
		// Update flashlight battery on HUD
		message_begin(MSG_ONE, g_msgid[FLASH_BAT], _, ID_CHARGE)
		write_byte(100) // battery
		message_end()
		
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Battery depleted
	if (g_flashbattery[ID_CHARGE] <= 0)
	{
		// Turn it off
		g_flashlight[ID_CHARGE] = false
		g_flashbattery[ID_CHARGE] = 0
		
		// Play flashlight toggle sound
		emit_sound(ID_CHARGE, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on HUD
		message_begin(MSG_ONE, g_msgid[FLASHLIGHT], _, ID_CHARGE)
		write_byte(0) // toggle
		write_byte(0) // battery
		message_end()
		
		// Remove flashlight task for this player
		remove_task(ID_CHARGE+TASK_FLASH)
	}
	else
	{
		// Update flashlight battery on HUD
		message_begin(MSG_ONE_UNRELIABLE, g_msgid[FLASH_BAT], _, ID_CHARGE)
		write_byte(g_flashbattery[ID_CHARGE]) // battery
		message_end()
	}
}

// Remove Spawn Protection Task
public remove_spawn_protection(taskid)
{
	// Not alive
	if (!g_isalive[ID_SPAWN])
		return;
	
	// Remove spawn protection
	g_nodamage[ID_SPAWN] = false
	set_pev(ID_SPAWN, pev_takedamage, DAMAGE_AIM)
	set_pev(ID_SPAWN, pev_effects, pev(ID_SPAWN, pev_effects) & ~EF_NODRAW)
}

// Hide Player's Money Task
public task_hide_money(taskid)
{
	// Not alive
	if (!g_isalive[ID_SPAWN])
		return;
	
	// Hide money
	message_begin(MSG_ONE, g_msgid[HIDE_WEAPON], _, ID_SPAWN)
	write_byte(HIDE_MONEY) // what to hide bitsum
	message_end()
	
	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgid[CROSSHAIR], _, ID_SPAWN)
	write_byte(0) // toggle
	message_end()
}

// Turn Off Flashlight and Restore Batteries
turn_off_flashlight(id)
{
	// Restore batteries for the next use
	fm_cs_set_user_batteries(id, 100)
	
	// Check if flashlight is on
	if (pev(id, pev_effects) & EF_DIMLIGHT)
	{
		// Turn it off
		set_pev(id, pev_impulse, IMPULSE_FLASHLIGHT)
	}
	else
	{
		// Clear any stored flashlight impulse (bugfix)
		set_pev(id, pev_impulse, 0)
	}
	
	// Turn off custom flashlight
	if (g_cached_customflash)
	{
		// Turn it off
		g_flashlight[id] = false
		g_flashbattery[id] = 100
		
		// Update flashlight HUD
		message_begin(MSG_ONE, g_msgid[FLASHLIGHT], _, id)
		write_byte(0) // toggle
		write_byte(100) // battery
		message_end()
		
		// Remove previous tasks
		remove_task(id+TASK_CHARGE)
		remove_task(id+TASK_FLASH)
	}
}

// Some one aimed at someone
public event_show_status(id)
{
	// Not a bot and is still connected
	if (!g_isbot[id] && g_isconnected[id] && get_pcvar_num(cvar_aiminfo)) 
	{
		// Retrieve the aimed player's id
		static aimid
		aimid = read_data(2)
		
		// Only show friends status ?
		if (g_zombie[id] == g_zombie[aimid])
		{
			static class[32], red, blue
			
			// Format the class name according to the player's team
			if (g_zombie[id])
			{
				red = 255
				blue = 0
				
				switch(g_zm_special[aimid])
				{
					case NEMESIS: formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, "CLASS_NEMESIS")
					case ASSASSIN: formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, "CLASS_ASSASSIN")
					case PREDATOR: formatex(class, charsmax(class), "%L Predator", id, "CLASS_CLASS")
					case BOMBARDIER: formatex(class, charsmax(class), "%L Bombardier", id, "CLASS_CLASS")
					default: formatex(class, charsmax(class), "%L %s", id, "CLASS_CLASS", g_zombie_classname[aimid])
				}
			}
			else
			{
				red = 0
				blue = 255
				
				switch(g_hm_special[aimid])
				{
					case SURVIVOR: formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, "CLASS_SURVIVOR")
					case SNIPER: formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, "CLASS_SNIPER")
					case BERSERKER: formatex(class, charsmax(class), "%L Berserker", id, "CLASS_CLASS")
					case WESKER: formatex(class, charsmax(class), "%L Wesker", id, "CLASS_CLASS")
					default: formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, "CLASS_HUMAN")
				}
				
			}
			
			// Show the notice
			set_hudmessage(red, 50, blue, -1.0, 0.60, 1, 0.01, 3.0, 0.01, 0.01, -1)
			ShowSyncHudMsg(id, g_MsgSync[2],"%L", id, "AIM_INFO", g_playername[aimid], class, pev(aimid, pev_health), pev(aimid, pev_armorvalue), g_ammopacks[aimid])
		}
	}
}

// Remove the aim-info message
public event_hide_status(id)
{
	ClearSyncHud(id, g_MsgSync[2])
}

// Infection Bomb Explosion
infection_explode(ent)
{
	// Round ended (bugfix)
	if (g_endround) return;
	
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast(originF)
	
	// Infection nade explode sound
	static sound[64]
	ArrayGetString(grenade_infect, random_num(0, ArraySize(grenade_infect) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Get attacker
	static attacker
	attacker = pev(ent, pev_owner)
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive non-spawnprotected humans
		if (!is_user_valid_alive(victim) || g_zombie[victim] || g_nodamage[victim])
			continue;
		
		// Last human is killed
		if (fnGetHumans() == 1 || g_zm_special[attacker] == BOMBARDIER || !g_allowinfection)
		{
			ExecuteHamB(Ham_Killed, victim, attacker, 0)
			continue;
		}
		
		// Infected victim's sound
		ArrayGetString(grenade_infect_player, random_num(0, ArraySize(grenade_infect_player) - 1), sound, charsmax(sound))
		emit_sound(victim, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Turn into zombie
		zombieme(victim, attacker, 0, 1, 1)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Fire Grenade Explosion
fire_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast2(originF)
	
	// Fire nade explode sound
	static sound[64]
	ArrayGetString(grenade_fire, random_num(0, ArraySize(grenade_fire) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim])
			continue;
			
		ExecuteForward(g_forwards[BURN_PRE], g_fwDummyResult, victim);
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) continue;
		
		// Heat icon?
		if (get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[DAMAGE], _, victim)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_BURN) // damage type
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		if (g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) // fire duration (nemesis/assassin is fire resistant)
			g_burning_duration[victim] += get_pcvar_num(cvar_fireduration)
		else
			g_burning_duration[victim] += get_pcvar_num(cvar_fireduration) * 5
		
		if(g_burning_duration[victim] > 0) ExecuteForward(g_forwards[BURN_POST], g_fwDummyResult, victim);
		
		// Set burning task on victim if not present
		if (!task_exists(victim+TASK_BURN))
			set_task(0.2, "burning_flame", victim+TASK_BURN, _, _, "b")
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Frost Grenade Explosion
frost_explode(ent)
{
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast3(originF)
	
	// Frost nade explode sound
	static sound[64]
	ArrayGetString(grenade_frost, random_num(0, ArraySize(grenade_frost) - 1), sound, charsmax(sound))
	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Collisions
	static victim
	victim = -1
	
	while ((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0)
	{		
		// Only effect alive unfrozen zombies
		if (!is_user_valid_alive(victim) || g_nodamage[victim] || !g_zombie[victim] || g_frozen[victim]) continue;
			
		ExecuteForward(g_forwards[FROZEN_PRE], g_fwDummyResult, victim);
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) continue;

		// Nemesis and Assassin shouldn't be frozen
		if (g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES)
		{
			// Get player's origin
			static origin2[3]
			get_user_origin(victim, origin2)
			
			// Broken glass sound
			ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
			emit_sound(victim, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Glass shatter
			message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
			write_byte(TE_BREAKMODEL) // TE id
			write_coord(origin2[0]) // x
			write_coord(origin2[1]) // y
			write_coord(origin2[2]+24) // z
			write_coord(16) // size x
			write_coord(16) // size y
			write_coord(16) // size z
			write_coord(random_num(-50, 50)) // velocity x
			write_coord(random_num(-50, 50)) // velocity y
			write_coord(25) // velocity z
			write_byte(10) // random velocity
			write_short(g_glassSpr) // model
			write_byte(10) // count
			write_byte(25) // life
			write_byte(BREAK_GLASS) // flags
			message_end()
			
			continue;
		}
		
		// Freeze icon?
		if (get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[DAMAGE], _, victim)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_DROWN) // damage type - DMG_FREEZE
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		// Light blue glow while frozen
		if (g_handle_models_on_separate_ent)
			fm_set_rendering(g_ent_playermodel[victim], kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		else
			fm_set_rendering(victim, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		
		// Freeze sound
		ArrayGetString(grenade_frost_player, random_num(0, ArraySize(grenade_frost_player) - 1), sound, charsmax(sound))
		emit_sound(victim, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, victim)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Prevent from jumping
		if (pev(victim, pev_flags) & FL_ONGROUND)
			set_pev(victim, pev_gravity, 999999.9) // set really high
		else
			set_pev(victim, pev_gravity, 0.000001) // no gravity
		
		// Set a task to remove the freeze
		g_frozen[victim] = true;
		ExecuteForward(g_forwards[FROZEN_POST], g_fwDummyResult, victim);
		set_task(get_pcvar_float(cvar_freezeduration), "remove_freeze", victim)
	}
	
	// Get rid of the grenade
	engfunc(EngFunc_RemoveEntity, ent)
}

// Remove freeze task
public remove_freeze(id)
{
	// Not alive or not frozen anymore
	if (!g_isalive[id] || !g_frozen[id])
		return;
	
	// Unfreeze
	g_frozen[id] = false;
	
	// Restore gravity
	if (g_zombie[id])
	{
		switch(g_zm_special[id])
		{
			case NEMESIS: set_pev(id, pev_gravity, get_pcvar_float(cvar_nemgravity))
			case ASSASSIN: set_pev(id, pev_gravity, get_pcvar_float(cvar_assassingravity))
			case PREDATOR: set_pev(id, pev_gravity, get_pcvar_float(cvar_predatorgravity))
			case BOMBARDIER: set_pev(id, pev_gravity, get_pcvar_float(cvar_bombardiergravity))
			default: set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
		}
	}
	else
	{
		switch(g_hm_special[id])
		{
			case SURVIVOR: set_pev(id, pev_gravity, get_pcvar_float(cvar_survgravity))
			case SNIPER: set_pev(id, pev_gravity, get_pcvar_float(cvar_snipergravity))
			case BERSERKER: set_pev(id, pev_gravity, get_pcvar_float(cvar_berserkergravity))
			case WESKER: set_pev(id, pev_gravity, get_pcvar_float(cvar_weskergravity))
			default: set_pev(id, pev_gravity, get_pcvar_float(cvar_humangravity))
		}
	}
	
	// Restore rendering
	if (g_handle_models_on_separate_ent)
	{
		// Nemesis, Assassin, Survivor, Sniper and Berserker glow / remove glow on player model entity
		if (g_zm_special[id] == NEMESIS && get_pcvar_num(cvar_nemglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == NEMESIS && !(get_pcvar_num(cvar_nemglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
		else if (g_zm_special[id] == ASSASSIN && get_pcvar_num(cvar_assassinglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == ASSASSIN && !(get_pcvar_num(cvar_assassinglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)	
			
		else if (g_zm_special[id] == PREDATOR && get_pcvar_num(cvar_predatorglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == PREDATOR && !(get_pcvar_num(cvar_predatorglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)	
			
		else if (g_zm_special[id] == BOMBARDIER && get_pcvar_num(cvar_bombardierglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == BOMBARDIER && !(get_pcvar_num(cvar_bombardierglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)	
		
		else if (g_hm_special[id] == SURVIVOR && get_pcvar_num(cvar_survglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 250, 250, kRenderNormal, 25)
		else if (g_hm_special[id] == SURVIVOR && !(get_pcvar_num(cvar_survglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
		
		else if (g_hm_special[id] == SNIPER && get_pcvar_num(cvar_sniperglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_snipercolor[0]), get_pcvar_num(cvar_snipercolor[1]), get_pcvar_num(cvar_snipercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == SNIPER && !(get_pcvar_num(cvar_sniperglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)

		else if (g_hm_special[id] == BERSERKER && get_pcvar_num(cvar_berserkerglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_berserkercolor[0]), get_pcvar_num(cvar_berserkercolor[1]), get_pcvar_num(cvar_berserkercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == BERSERKER && !(get_pcvar_num(cvar_berserkerglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
		else if (g_hm_special[id] == WESKER && get_pcvar_num(cvar_weskerglow))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, get_pcvar_num(cvar_weskercolor[0]), get_pcvar_num(cvar_weskercolor[1]), get_pcvar_num(cvar_weskercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == WESKER && !(get_pcvar_num(cvar_weskerglow)))
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
		
		else
			fm_set_rendering(g_ent_playermodel[id])
	}
	else
	{
		// Nemesis, Assassin, Survivor, Sniper and Berserker glow / remove glow
		if (g_zm_special[id] == NEMESIS && get_pcvar_num(cvar_nemglow))
			fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == NEMESIS && !(get_pcvar_num(cvar_nemglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
		else if (g_zm_special[id] == ASSASSIN && get_pcvar_num(cvar_assassinglow))
			fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == ASSASSIN && !(get_pcvar_num(cvar_assassinglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)	
		
		else if (g_zm_special[id] == PREDATOR && get_pcvar_num(cvar_predatorglow))
			fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == PREDATOR && !(get_pcvar_num(cvar_predatorglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
		else if (g_zm_special[id] == BOMBARDIER && get_pcvar_num(cvar_bombardierglow))
			fm_set_rendering(id, kRenderFxGlowShell, 250, 0, 0, kRenderNormal, 25)
		else if (g_zm_special[id] == BOMBARDIER && !(get_pcvar_num(cvar_bombardierglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
		
		else if (g_hm_special[id] == SURVIVOR && get_pcvar_num(cvar_survglow))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 250, 250, kRenderNormal, 25)
		else if (g_hm_special[id] == SURVIVOR && !(get_pcvar_num(cvar_survglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
		
		else if (g_hm_special[id] == SNIPER && get_pcvar_num(cvar_sniperglow))
			fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_snipercolor[0]), get_pcvar_num(cvar_snipercolor[1]), get_pcvar_num(cvar_snipercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == SNIPER && !(get_pcvar_num(cvar_sniperglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)

		else if (g_hm_special[id] == BERSERKER && get_pcvar_num(cvar_berserkerglow))
			fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_berserkercolor[0]), get_pcvar_num(cvar_berserkercolor[1]), get_pcvar_num(cvar_berserkercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == BERSERKER && !(get_pcvar_num(cvar_berserkerglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
			
		else if (g_hm_special[id] == WESKER && get_pcvar_num(cvar_weskerglow))
			fm_set_rendering(id, kRenderFxGlowShell, get_pcvar_num(cvar_weskercolor[0]), get_pcvar_num(cvar_weskercolor[1]), get_pcvar_num(cvar_weskercolor[2]), kRenderNormal, 25)
		else if (g_hm_special[id] == WESKER && !(get_pcvar_num(cvar_weskerglow)))
			fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 25)
		
		else
			fm_set_rendering(id)
	}
	
	// Gradually remove screen's blue tint
	message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, id)
	write_short(UNIT_SECOND) // duration
	write_short(0) // hold time
	write_short(FFADE_IN) // fade type
	write_byte(0) // red
	write_byte(50) // green
	write_byte(200) // blue
	write_byte(100) // alpha
	message_end()
	
	// Broken glass sound
	static sound[64]
	ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
	emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	// Get player's origin
	static origin2[3]
	get_user_origin(id, origin2)
	
	// Glass shatter
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
	write_byte(TE_BREAKMODEL) // TE id
	write_coord(origin2[0]) // x
	write_coord(origin2[1]) // y
	write_coord(origin2[2]+24) // z
	write_coord(16) // size x
	write_coord(16) // size y
	write_coord(16) // size z
	write_coord(random_num(-50, 50)) // velocity x
	write_coord(random_num(-50, 50)) // velocity y
	write_coord(25) // velocity z
	write_byte(10) // random velocity
	write_short(g_glassSpr) // model
	write_byte(10) // count
	write_byte(25) // life
	write_byte(BREAK_GLASS) // flags
	message_end()
	
	ExecuteForward(g_forwards[USER_UNFROZEN], g_fwDummyResult, id);
}

// Remove Stuff Task
public remove_stuff()
{
	static ent
	
	// Remove rotating doors
	if (get_pcvar_num(cvar_removedoors) > 0)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door_rotating")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Remove all doors
	if (get_pcvar_num(cvar_removedoors) > 1)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Triggered lights
	if (!get_pcvar_num(cvar_triggered))
	{
		ent = -1
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "light")) != 0)
		{
			dllfunc(DLLFunc_Use, ent, 0); // turn off the light
			set_pev(ent, pev_targetname, 0) // prevent it from being triggered
		}
	}
}
// Set Custom Weapon Models
replace_weapon_models(id, weaponid)
{
	switch (weaponid)
	{
		case CSW_KNIFE: // Custom knife models
		{
			if (g_zombie[id]) // Zombies
			{
				switch(g_zm_special[id])
				{
					case NEMESIS: set_pev(id, pev_viewmodel2, model_vknife_nemesis)
					case ASSASSIN: set_pev(id, pev_viewmodel2, model_vknife_assassin)
					case PREDATOR: set_pev(id, pev_viewmodel2, model_vknife_predator)
					case BOMBARDIER: set_pev(id, pev_viewmodel2, model_vknife_bombardier)
					default: 
					{
						// Admin knife models?
						if (get_pcvar_num(cvar_adminknifemodelszombie) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])
							set_pev(id, pev_viewmodel2, model_vknife_admin_zombie)
						else {
							static clawmodel[100]
							ArrayGetString(g_zclass_clawmodel, g_zombieclass[id], clawmodel, charsmax(clawmodel))
							format(clawmodel, charsmax(clawmodel), "models/zombie_plague/%s", clawmodel)
							set_pev(id, pev_viewmodel2, clawmodel)
						}
					}
				}
				set_pev(id, pev_weaponmodel2, "") // Remover a P_ model dos ZMS
			}
			else
			{
				if (g_hm_special[id] == BERSERKER)
				{
					set_pev(id, pev_viewmodel2, model_vknife_berserker)
					set_pev(id, pev_weaponmodel2, model_pknife_berserker)
				}
				else if (get_pcvar_num(cvar_adminknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])
				{
					set_pev(id, pev_viewmodel2, model_vknife_admin_human)
					set_pev(id, pev_weaponmodel2, model_pknife_admin_human)
				}
				else if (get_pcvar_num(cvar_vipknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])
				{
					set_pev(id, pev_viewmodel2, model_vknife_vip_human)
					set_pev(id, pev_weaponmodel2, model_pknife_vip_human)
				}
				else
				{
					set_pev(id, pev_viewmodel2, model_vknife_human)
					set_pev(id, pev_weaponmodel2, model_pknife_human)
				}
			}
		}
		case CSW_M249: // Survivor's M249
		{
			if (g_hm_special[id] == SURVIVOR) {
				set_pev(id, pev_viewmodel2, model_vm249_survivor)
				set_pev(id, pev_weaponmodel2, model_pm249_survivor)
			}
		}
		case CSW_AWP: // Sniper's AWP
		{
			if (g_hm_special[id] == SNIPER) {
				set_pev(id, pev_viewmodel2, model_vawp_sniper)
				set_pev(id, pev_weaponmodel2, model_pawp_sniper)
			}
		}
		case CSW_DEAGLE: // Wesker's Deagle
		{
			if (g_hm_special[id] == WESKER) {
				set_pev(id, pev_viewmodel2, model_vdeagle_wesker)
				set_pev(id, pev_weaponmodel2, model_pdeagle_wesker)
			}
				
		}
		case CSW_HEGRENADE: // Infection bomb or fire grenade
		{
			if (g_zombie[id]) set_pev(id, pev_viewmodel2, model_grenade_infect)
			else set_pev(id, pev_viewmodel2, model_grenade_fire)
		}
		case CSW_FLASHBANG: // Frost grenade
		{
			set_pev(id, pev_viewmodel2, model_grenade_frost)
		}
		case CSW_SMOKEGRENADE: // Flare grenade
		{
			set_pev(id, pev_viewmodel2, model_grenade_flare)
		}
		
	}
	
	// Update model on weaponmodel ent
	if (g_handle_models_on_separate_ent) fm_set_weaponmodel_ent(id)
}

// Reset Player Vars
reset_vars(id, resetall)
{
	g_zombie[id] = false
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	g_firstzombie[id] = false
	g_lastzombie[id] = false
	g_lasthuman[id] = false
	g_frozen[id] = false
	g_nodamage[id] = false
	g_respawn_as_zombie[id] = false
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	g_flashlight[id] = false
	g_flashbattery[id] = 100
	g_canbuy[id] = true
	g_burning_duration[id] = 0
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	
	if (resetall)
	{
		g_ammopacks[id] = get_pcvar_num(cvar_startammopacks)
		g_zombieclass[id] = ZCLASS_NONE
		g_zombieclassnext[id] = ZCLASS_NONE
		g_damagedealt[id] = 0
		WPN_AUTO_ON = 0
	}
}

// Set spectators nightvision
public spec_nvision(id)
{
	// Not connected, alive, or bot
	if (!g_isconnected[id] || g_isalive[id] || g_isbot[id])
		return;
	
	// Give Night Vision?
	if (get_pcvar_num(cvar_nvggive))
	{
		g_nvision[id] = true
		
		// Turn on Night Vision automatically?
		if (get_pcvar_num(cvar_nvggive) == 1)
		{
			g_nvisionenabled[id] = true
			
			// Custom nvg?
			if (get_pcvar_num(cvar_customnvg))
			{
				remove_task(id+TASK_NVISION)
				set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
			}
			else
				set_user_gnvision(id, 1)
		}
	}
}

// Show HUD Task
public ShowHUD(taskid)
{
	static id
	id = ID_SHOWHUD;
	
	// Player died?
	if (!g_isalive[id])
	{
		// Get spectating target
		id = pev(id, PEV_SPEC_TARGET)
		
		// Target not alive
		if (!g_isalive[id]) return;
	}
	
	// Format classname
	static class[32], rgb[3]
	
	if (g_zombie[id]) // zombies
	{		
		switch(g_hud_color[1][id])
		{
			case 0: rgb = { 255, 255, 255 }
			case 1: rgb = { 255, 0, 0 }
			case 2: rgb = { 0, 255, 0 }
			case 3: rgb = { 0, 0, 255 }
			case 4: rgb = { 0, 255, 255 }
			case 5: rgb = { 255, 0, 255 }
			case 6: rgb = { 255, 255, 0 }
			case 7: rgb = { 255, 69, 0 }
			case 8: rgb = { 0, 100, 255 }
			case 9: rgb = { 255, 0, 100 }
		}
		
		switch(g_zm_special[id])
		{
			case NEMESIS: formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_NEMESIS")
			case ASSASSIN: formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_ASSASSIN")
			case PREDATOR: formatex(class, charsmax(class), "Predator")
			case BOMBARDIER: formatex(class, charsmax(class), "Bombardier")
			default: copy(class, charsmax(class), g_zombie_classname[id])
		}
	}
	else // humans
	{
		switch(g_hud_color[0][id])
		{
			case 0: rgb = { 255, 255, 255 }
			case 1: rgb = { 255, 0, 0 }
			case 2: rgb = { 0, 255, 0 }
			case 3: rgb = { 0, 0, 255 }
			case 4: rgb = { 0, 255, 255 }
			case 5: rgb = { 255, 0, 255 }
			case 6: rgb = { 255, 255, 0 }
			case 7: rgb = { 255, 69, 0 }
			case 8: rgb = { 0, 100, 255 }
			case 9: rgb = { 255, 0, 100 }
		}
		
		switch(g_hm_special[id])
		{
			case SURVIVOR: formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_SURVIVOR")
			case SNIPER: formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_SNIPER")
			case BERSERKER: formatex(class, charsmax(class), "Berserker")
			case WESKER: formatex(class, charsmax(class), "Wesker")
			default: formatex(class, charsmax(class), "%L", ID_SHOWHUD, "CLASS_HUMAN")
		}
	}
	
	// Spectating someone else?
	if (id != ID_SHOWHUD)
	{
		// Show name, health, class, and ammo packs and armor
		set_hudmessage(rgb[0], rgb[1], rgb[2], HUD_SPECT_X, HUD_SPECT_Y, 1, 6.0, 1.1, 0.0, 0.0, -1)
		ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "%L %s^nHP: %d - %L %s - %L %d - %L %d", ID_SHOWHUD, "SPECTATING", g_playername[id],
		pev(id, pev_health), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", g_ammopacks[id], ID_SHOWHUD, "ARMOR", pev(id, pev_armorvalue))
	}
	else
	{
		if(g_hud_type[ID_SHOWHUD] == 0)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.78, 0.18, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %d]^n[%L %s]^n[%L %d]^n[Colete: %i]^n[Mortes: %d]^n[Frags: %i]^n[Velocidade: %d]^n[%s]", id, "ZOMBIE_ATTRIB1", pev(ID_SHOWHUD, pev_health), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", g_ammopacks[ID_SHOWHUD], get_user_armor(id), get_user_deaths(id), get_user_frags(id), fm_get_speed(id), mode_names[g_Mode]);
		}
		else if(g_hud_type[ID_SHOWHUD] == 1)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.02, 0.9, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "HP: %d - %L %s - %L %d", get_user_health(ID_SHOWHUD), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", g_ammopacks[ID_SHOWHUD])
		}
		else if(g_hud_type[ID_SHOWHUD] == 2)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], -1.0, 0.60, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %d]^n[%L %s]^n[%L %d]^n[Colete: %i]^n[Mortes: %d]^n[Frags: %i]^n[Velocidade: %d]^n[%s]", id, "ZOMBIE_ATTRIB1", pev(ID_SHOWHUD, pev_health), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", g_ammopacks[ID_SHOWHUD], get_user_armor(id), get_user_deaths(id), get_user_frags(id), fm_get_speed(id), mode_names[g_Mode]);
		}
		else if(g_hud_type[ID_SHOWHUD] == 3)
		{
			new player_name[32]; get_user_name(ID_SHOWHUD, player_name, 31)
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.57, 0.75, 1, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%s]^n[HP] [%d] - [CT] [%d]^n[%L] [%s] - [%L] [%d]^n[Modo Atual] [%s]",player_name, get_user_health(ID_SHOWHUD),get_user_armor(ID_SHOWHUD), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", g_ammopacks[ID_SHOWHUD], mode_names[g_Mode])
		}
	}
}

// Play idle zombie sounds
public zombie_play_idle(taskid)
{
	// Round ended/new one starting
	if (g_endround || g_newround)
		return;
	
	static sound[64]
	
	// Last zombie?
	if (g_lastzombie[ID_BLOOD])
	{
		ArrayGetString(zombie_idle_last, random_num(0, ArraySize(zombie_idle_last) - 1), sound, charsmax(sound))
		emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else
	{
		ArrayGetString(zombie_idle, random_num(0, ArraySize(zombie_idle) - 1), sound, charsmax(sound))
		emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
}

// Madness Over Task
public madness_over(taskid)
{
	g_nodamage[ID_BLOOD] = false
	set_pev(ID_BLOOD, pev_takedamage, DAMAGE_AIM)
	static sound[64]
	ArrayGetString(zombie_madness, random_num(0, ArraySize(zombie_madness) - 1), sound, charsmax(sound))
	emit_sound(ID_BLOOD, CHAN_VOICE, sound, 0.0, ATTN_NORM, 0, PITCH_NORM)
	remove_task(ID_BLOOD+TASK_BLOOD)
}

// Place user at a random spawn
do_random_spawn(id, regularspawns = 0)
{
	static hull, sp_index, i
	
	// Get whether the player is crouching
	hull = (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN
	
	// Use regular spawns?
	if (!regularspawns)
	{
		// No spawns?
		if (!g_spawnCount)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if (i >= g_spawnCount) i = 0
			
			// Free spawn space?
			if (is_hull_vacant(g_spawns[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns[i])
				break;
			}
			
			// Loop completed, no free space found
			if (i == sp_index) break;
		}
	}
	else
	{
		// No spawns?
		if (!g_spawnCount2)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount2 - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if (i >= g_spawnCount2) i = 0
			
			// Free spawn space?
			if (is_hull_vacant(g_spawns2[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns2[i])
				break;
			}
			
			// Loop completed, no free space found
			if (i == sp_index) break;
		}
	}
}

// Get Zombies -returns alive zombies number-
fnGetZombies()
{
	static iZombies, id
	iZombies = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zombie[id])
			iZombies++
	}
	
	return iZombies;
}

// Get Humans -returns alive humans number-
fnGetHumans()
{
	static iHumans, id
	iHumans = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && !g_zombie[id])
			iHumans++
	}
	
	return iHumans;
}

// Get Nemesis -returns alive nemesis number-
fnGetNemesis()
{
	static iNemesis, id
	iNemesis = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zm_special[id] == NEMESIS)
			iNemesis++
	}
	
	return iNemesis;
}

// Get Survivors -returns alive survivors number-
fnGetSurvivors()
{
	static iSurvivors, id
	iSurvivors = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_hm_special[id] == SURVIVOR)
			iSurvivors++
	}
	
	return iSurvivors;
}

// Get Snipers -returns alive snipers number-
fnGetSnipers()
{
	static iSnipers, id
	iSnipers = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_hm_special[id] == SNIPER)
			iSnipers++
	}
	
	return iSnipers;
}
// Get Assassins -returns alive assassin numbers-
fnGetAssassin()
{
	static iAssassin, id
	iAssassin = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zm_special[id] == ASSASSIN)
			iAssassin++
	}
	
	return iAssassin;
}

// Get Predators -returns alive predator numbers-
fnGetPredator()
{
	static iPredator, id
	iPredator = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zm_special[id] == PREDATOR)
			iPredator++
	}
	
	return iPredator;
}

// Get Bombardiers -returns alive bombardier numbers-
fnGetBombardier()
{
	static iBombardier, id
	iBombardier = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_zm_special[id] == BOMBARDIER)
			iBombardier++
	}
	
	return iBombardier;
}

// Get Berserkers -returns alive berserkers number-
fnGetBerserkers()
{
	static iBerserkers, id
	iBerserkers = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_hm_special[id] == BERSERKER)
			iBerserkers++
	}
	
	return iBerserkers;
}

// Get Weskers -returns alive weskers number-
fnGetWeskers()
{
	static iWeskers, id
	iWeskers = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id] && g_hm_special[id] == WESKER)
			iWeskers++
	}
	
	return iWeskers;
}

// Get Alive -returns alive players number-
fnGetAlive()
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
			iAlive++
	}
	
	return iAlive;
}

// Get Random Alive -returns index of alive player number n -
fnGetRandomAlive(n)
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
			iAlive++
		
		if (iAlive == n)
			return id;
	}
	
	return -1;
}

// Get Playing -returns number of users playing-
fnGetPlaying()
{
	static iPlaying, id, team
	iPlaying = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{
			team = fm_cs_get_user_team(id)
			
			if (team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED)
				iPlaying++
		}
	}
	
	return iPlaying;
}

// Get CTs -returns number of CTs connected-
fnGetCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
		}
	}
	
	return iCTs;
}

// Get Ts -returns number of Ts connected-
fnGetTs()
{
	static iTs, id
	iTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isconnected[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
				iTs++
		}
	}
	
	return iTs;
}

// Get Alive CTs -returns number of CTs alive-
fnGetAliveCTs()
{
	static iCTs, id
	iCTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
				iCTs++
		}
	}
	
	return iCTs;
}

// Get Alive Ts -returns number of Ts alive-
fnGetAliveTs()
{
	static iTs, id
	iTs = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if (g_isalive[id])
		{			
			if (fm_cs_get_user_team(id) == FM_CS_TEAM_T)
				iTs++
		}
	}
	
	return iTs;
}

// Last Zombie Check -check for last zombie and set its flag-
fnCheckLastZombie()
{
	static id
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Last zombie
		if (g_isalive[id] && g_zombie[id] && g_zm_special[id] <= 0 && fnGetZombies() == 1)
		{
			if (!g_lastzombie[id])
			{
				// Last zombie forward
				ExecuteForward(g_forwards[USER_LAST_ZOMBIE], g_fwDummyResult, id);
			}
			g_lastzombie[id] = true
		}
		else
			g_lastzombie[id] = false
		
		// Last human
		if (g_isalive[id] && !g_zombie[id] && g_hm_special[id] <= 0 && fnGetHumans() == 1)
		{
			if (!g_lasthuman[id])
			{
				// Last human forward
				ExecuteForward(g_forwards[USER_LAST_HUMAN], g_fwDummyResult, id);
				
				// Reward extra hp
				fm_set_user_health(id, pev(id, pev_health) + get_pcvar_num(cvar_humanlasthp))
			}
			g_lasthuman[id] = true
		}
		else
			g_lasthuman[id] = false
	}
}

// Save player's stats to database
save_stats(id)
{
	// Check whether there is another record already in that slot
	if (db_name[id][0] && !equal(g_playername[id], db_name[id]))
	{
		// If DB size is exceeded, write over old records
		if (db_slot_i >= sizeof db_name)
			db_slot_i = g_maxplayers+1
		
		// Move previous record onto an additional save slot
		copy(db_name[db_slot_i], charsmax(db_name[]), db_name[id])
		db_ammopacks[db_slot_i] = db_ammopacks[id]
		db_zombieclass[db_slot_i] = db_zombieclass[id]
		db_slot_i++
	}
	
	// Now save the current player stats
	copy(db_name[id], charsmax(db_name[]), g_playername[id]) // name
	db_ammopacks[id] = g_ammopacks[id] // ammo packs
	db_zombieclass[id] = g_zombieclassnext[id] // zombie class
}

// Load player's stats from database (if a record is found)
load_stats(id)
{
	// Look for a matching record
	static i
	for (i = 0; i < sizeof db_name; i++)
	{
		if (equal(g_playername[id], db_name[i]))
		{
			// Bingo!
			g_ammopacks[id] = db_ammopacks[i]
			g_zombieclass[id] = db_zombieclass[i]
			g_zombieclassnext[id] = db_zombieclass[i]
			return;
		}
	}
}

// Checks if a player is allowed to be zombie
allowed_zombie(id)
{
	if ((g_zombie[id] && g_zm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be human
allowed_human(id)
{
	if ((!g_zombie[id] && g_hm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be survivor
allowed_survivor(id)
{
	if (g_endround || g_hm_special[id] == SURVIVOR || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be nemesis
allowed_nemesis(id)
{
	if (g_endround || g_zm_special[id] == NEMESIS || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to respawn
allowed_respawn(id)
{
	static team
	team = fm_cs_get_user_team(id)
	
	if (g_endround || team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED || g_isalive[id])
		return false;
	
	return true;
}

// Checks if swarm mode is allowed
allowed_swarm()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG))
		return false;
	
	return true;
}

// Checks if multi infection mode is allowed
allowed_multi()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) < 2 || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) >= fnGetAlive())
		return false;
	
	return true;
}

// Checks if plague mode is allowed
allowed_plague()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) < 1
	|| fnGetAlive()-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) < 1)
		return false;
	
	return true;
}

// Checks if a player is allowed to be sniper
allowed_sniper(id)
{
	if (g_endround || g_hm_special[id] == SNIPER || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}
// Checks if a player ia sllowed to be assassin
allowed_assassin(id)
{
	if (g_endround || g_zm_special[id] == ASSASSIN || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player ia sllowed to be predator
allowed_predator(id)
{
	if (g_endround || g_zm_special[id] == PREDATOR || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}


// Checks if a player is allowed to be berserker
allowed_berserker(id)
{
	if (g_endround || g_hm_special[id] == BERSERKER || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be wesker
allowed_wesker(id)
{
	if (g_endround || g_hm_special[id] == WESKER || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player ia sllowed to be bombardier
allowed_bombardier(id)
{
	if (g_endround || g_zm_special[id] == BOMBARDIER || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if armageddon mode is allowed
allowed_lnj()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2)
		return false;
	
	return true;
}

// Checks if a custom game mode is allowed
allowed_custom_game()
{
	if (g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2)
		return false;
	
	return true;
}

// Admin Command. zp_zombie
command_zombie(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_INFECT")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_INFECT")
	}
	
	// Log to Zombie Plague Advance  log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_INFECT", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first zombie
		remove_task(TASK_MAKEZOMBIE)
		start_infection_mode(player, MODE_SET)
	}
	else
	{
		// Just infect
		zombieme(player, 0, 0, 0, 0)
	}
}

// Admin Command. zp_human
command_human(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_DISINFECT")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_DISINFECT")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_DISINFECT", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Turn to human
	humanme(player, 0, 0)
}

// Admin Command. zp_survivor
command_survivor(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_SURVIVAL")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_SURVIVAL")
	}
	
	 // Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_SURVIVAL", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first survivor
		remove_task(TASK_MAKEZOMBIE)
		start_survivor_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Survivor
		humanme(player, SURVIVOR, 0)
	}
}

// Admin Command. zp_nemesis
command_nemesis(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_NEMESIS")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_NEMESIS")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_NEMESIS", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}

	// New round?
	if (g_newround)
	{
		// Set as first nemesis
		remove_task(TASK_MAKEZOMBIE)
		start_nemesis_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Nemesis
		zombieme(player, 0, NEMESIS, 0, 0)
	}
}

// Admin Command. zp_respawn
command_respawn(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_RESPAWN")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_RESPAWN")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_RESPAWN", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Respawn as zombie?
	if (g_currentmode > MODE_LNJ) // Custom round ?
	{
		if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	else // Normal round
	{
		if (get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	
	// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
	if (g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[player] = true
	else if (g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR ) g_respawn_as_zombie[player] = false
	
	respawn_player_manually(player);
}

// Admin Command. zp_swarm
command_swarm(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_SWARM")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_SWARM")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "CMD_SWARM", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Call Swarm Mode
	remove_task(TASK_MAKEZOMBIE)
	start_swarm_mode(0, MODE_SET)
}

// Admin Command. zp_multi
command_multi(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_MULTI")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_MULTI")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER,"CMD_MULTI", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Call Multi Infection
	remove_task(TASK_MAKEZOMBIE)
	start_multi_mode(0, MODE_SET)
}

// Admin Command. zp_plague
command_plague(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_PLAGUE")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_PLAGUE")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER,"CMD_PLAGUE", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Call Plague Mode
	remove_task(TASK_MAKEZOMBIE)
	start_plague_mode(0, MODE_SET)
}

// Admin Command. zp_sniper
command_sniper(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_SNIPER")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_SNIPER")
	}
	
	 // Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_SNIPER", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first sniper
		remove_task(TASK_MAKEZOMBIE)
		start_sniper_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Sniper
		humanme(player, SNIPER, 0)
	}
}
// Admin command: Assassin
command_assassin(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s %L", g_playername[player], LANG_PLAYER, "CMD_ASSASSIN")
		case 2: client_print(0, print_chat, "ADMIN %s - %s %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_ASSASSIN")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER,"CMD_ASSASSIN", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first assassin
		remove_task(TASK_MAKEZOMBIE)
		start_assassin_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Assassin
		zombieme(player, 0, ASSASSIN, 0, 0)
	}
}

// Admin command: predator
command_predator(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s Virou Predator", g_playername[player])
		case 2: client_print(0, print_chat, "ADMIN %s - %s Foi Convertido a Predator", g_playername[id], g_playername[player])
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s Virou Predator (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first predator
		remove_task(TASK_MAKEZOMBIE)
		start_predator_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a predator
		zombieme(player, 0, PREDATOR, 0, 0)
	}
}

// Admin command: bombardier
command_bombardier(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s Virou Bombardier", g_playername[player])
		case 2: client_print(0, print_chat, "ADMIN %s - %s Foi Convertido a Bombardier", g_playername[id], g_playername[player])
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s Virou Bombardier (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first bombardier
		remove_task(TASK_MAKEZOMBIE)
		start_bombardier_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a bombardier
		zombieme(player, 0, BOMBARDIER, 0, 0)
	}
}


// Admin Command. zp_berserker
command_berserker(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s Virou Berserker", g_playername[player])
		case 2: client_print(0, print_chat, "ADMIN %s - %s Foi Convertido a Berserker", g_playername[id], g_playername[player])
	}
	
	 // Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - Virou Berserker (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first berserker
		remove_task(TASK_MAKEZOMBIE)
		start_berserker_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Berserker
		humanme(player, BERSERKER, 0)
	}
}

// Admin Command. zp_wesker
command_wesker(id, player)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %s Virou Wesker", g_playername[player])
		case 2: client_print(0, print_chat, "ADMIN %s - %s Virou Wesker", g_playername[id], g_playername[player])
	}
	
	 // Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %s Virou Wesker (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// New round?
	if (g_newround)
	{
		// Set as first wesker
		remove_task(TASK_MAKEZOMBIE)
		start_wesker_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Wesker
		humanme(player, WESKER, 0)
	}
}


// Admin Command. zp_lnj
command_lnj(id)
{
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L", LANG_PLAYER, "CMD_LNJ")
		case 2: client_print(0, print_chat, "ADMIN %s - %L", g_playername[id], LANG_PLAYER, "CMD_LNJ")
	}
	
	// Log to Zombie Plague log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "CMD_LNJ", fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Call Armageddon Mode
	remove_task(TASK_MAKEZOMBIE)
	start_lnj_mode(0, MODE_SET)
}

// Admin command for a custom game mode
command_custom_game(gameid, id)
{
	// Retrieve the game mode name as it will be used
	static buffer[32]
	ArrayGetString(g_gamemode_name, (gameid - MAX_GAME_MODES), buffer, charsmax(buffer))
	
	// Show activity?
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: client_print(0, print_chat, "ADMIN - %L %s", LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
		case 2: client_print(0, print_chat, "ADMIN %s - %L %s", g_playername[id], LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
	}
	
	// Log to Zombie Plague Advance log file?
	if (get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16] 
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "ADMIN %s <%s><%s> - %L %s (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "MENU_ADMIN2_CUSTOM", buffer, fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_advance.log", logdata)
	}
	
	// Remove make a zombie task
	remove_task(TASK_MAKEZOMBIE)
	
	// No more a new round
	g_newround = false
	
	// Current game mode and last game mode are equal to the game mode id
	g_currentmode = gameid
	g_lastmode = gameid
	
	// Check whether or not to allow infection during this game mode
	g_allowinfection = (ArrayGetCell(g_gamemode_allow, (gameid - MAX_GAME_MODES)) == 1) ? true : false
	
	// Check the death match mode required by the game mode
	g_deathmatchmode = ArrayGetCell(g_gamemode_dm, (gameid - MAX_GAME_MODES))
	
	// Our custom game mode has fully started
	g_modestarted = true
	
	// Execute our round start forward with the game mode id [BUGFIX]
	ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, gameid, 0)
	
	// Execute our game mode selected forward
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, gameid, id)
}

/*================================================================================
 [Custom Natives]
=================================================================================*/

// Native: zp_get_user_zombie
public native_get_user_zombie(id)
{
	return g_zombie[id];
}

// Native: zp_get_user_nemesis
public native_get_user_nemesis(id)
{
	return g_zm_special[id] == NEMESIS;
}

// Native: zp_get_user_survivor
public native_get_user_survivor(id)
{
	return g_hm_special[id] == SURVIVOR;
}

public native_get_user_first_zombie(id)
{
	return g_firstzombie[id];
}

public native_get_human_special_class(id)
{
	return (!g_zombie[id] && g_hm_special[id] > 0)
}

public native_get_zombie_special_class(id)
{
	return (g_zombie[id] && g_zm_special[id] > 0)
}

// Native: zp_get_user_last_zombie
public native_get_user_last_zombie(id)
{
	return g_lastzombie[id];
}

// Native: zp_get_user_last_human
public native_get_user_last_human(id)
{
	return g_lasthuman[id];
}

public native_get_user_madness(id)
{
	return g_nodamage[id];
}

// Native: zp_get_user_zombie_class
public native_get_user_zombie_class(id)
{
	if(g_zm_special[id] > 0) // Evita Bug com outras classes de zm
		return -1
	
	return g_zombieclass[id];
}

// Native: zp_get_user_next_class
public native_get_user_next_class(id)
{
	if(g_zm_special[id] > 0) // Evita Bug com outras classes de zm
		return -1
	
	return g_zombieclassnext[id];
}

// Native: zp_set_user_zombie_class
public native_set_user_zombie_class(id, classid)
{
	if (classid < 0 || classid >= g_zclass_i)
		return 0;
	
	g_zombieclassnext[id] = classid
	return 1;
}

// Native: zp_get_user_ammo_packs
public native_get_user_ammo_packs(id)
{
	return g_ammopacks[id];
}

// Native: zp_set_user_ammo_packs
public native_set_user_ammo_packs(id, amount)
{
	g_ammopacks[id] = amount;
}

public native_get_user_frozen(id)
{
	return g_frozen[id];
}

public native_get_user_burn(id)
{
	return g_burning_duration[id] > 0
}

public native_get_user_infectnade(id)
{
	return (g_zombie[id] && g_zm_special[id] <= 0 && user_has_weapon(id, CSW_HEGRENADE));
}

// Native: zp_get_zombie_maxhealth
public native_get_zombie_maxhealth(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	if (g_zombie[id] && g_zm_special[id] <= 0)
	{
		if (g_firstzombie[id])
			return floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zombiefirsthp))
		else
			return ArrayGetCell(g_zclass_hp, g_zombieclass[id])
	}
	return -1;
}

// Native: zp_get_user_batteries
public native_get_user_batteries(id)
{
	return g_flashbattery[id];
}

// Native: zp_set_user_batteries
public native_set_user_batteries(id, value)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return;
	
	g_flashbattery[id] = clamp(value, 0, 100);
	
	if (g_cached_customflash)
	{
		// Set the flashlight charge task to update battery status
		remove_task(id+TASK_CHARGE)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	}
}

// Native: zp_get_user_nightvision
public native_get_user_nightvision(id)
{
	return g_nvision[id];
}

// Native: zp_set_user_nightvision
public native_set_user_nightvision(id, set)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return;
	
	if (set)
	{
		g_nvision[id] = true
		
		if (!g_isbot[id])
		{
			g_nvisionenabled[id] = true
			
			// Custom nvg?
			if (get_pcvar_num(cvar_customnvg))
			{
				remove_task(id+TASK_NVISION)
				set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
			}
			else
				set_user_gnvision(id, 1)
		}
		else
			cs_set_user_nvg(id, 1)
	}
	else
	{
		// Turn off NVG for bots
		if (g_isbot[id]) cs_set_user_nvg(id, 0);
		if (get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
		else if (g_nvisionenabled[id]) set_user_gnvision(id, 0)
		g_nvision[id] = false
		g_nvisionenabled[id] = false
	}
}

public native_set_user_madness(id, set)
{
	if (!g_pluginenabled)
		return;
	
	if(set)
	{
		if(g_nodamage[id]) 
			return;
		
		g_nodamage[id] = true
		set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
		set_task(get_pcvar_float(cvar_madnessduration), "madness_over", id+TASK_BLOOD)
		set_pev(id, pev_takedamage, DAMAGE_NO)
			
		static sound[64]
		ArrayGetString(zombie_madness, random_num(0, ArraySize(zombie_madness) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else
	{
		madness_over(id+TASK_BLOOD)
		set_pev(id, pev_takedamage, DAMAGE_AIM)
	}
}


public native_set_user_frozen(id, set)
{
	if (!g_pluginenabled)
		return;
	
	static sound[64]
	if(set)
	{
		// Only effect alive unfrozen zombies
		if (!is_user_valid_alive(id) || g_nodamage[id] || !g_zombie[id] || g_frozen[id]) return;
			
		ExecuteForward(g_forwards[FROZEN_PRE], g_fwDummyResult, id);
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) return;

		// Specials Zombies shouldn't be frozen
		if (g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES)
		{
			// Get player's origin
			static origin2[3]
			get_user_origin(id, origin2)
			
			// Broken glass sound
			ArrayGetString(grenade_frost_break, random_num(0, ArraySize(grenade_frost_break) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Glass shatter
			message_begin(MSG_PVS, SVC_TEMPENTITY, origin2)
			write_byte(TE_BREAKMODEL) // TE id
			write_coord(origin2[0]) // x
			write_coord(origin2[1]) // y
			write_coord(origin2[2]+24) // z
			write_coord(16) // size x
			write_coord(16) // size y
			write_coord(16) // size z
			write_coord(random_num(-50, 50)) // velocity x
			write_coord(random_num(-50, 50)) // velocity y
			write_coord(25) // velocity z
			write_byte(10) // random velocity
			write_short(g_glassSpr) // model
			write_byte(10) // count
			write_byte(25) // life
			write_byte(BREAK_GLASS) // flags
			message_end()
			
			return;
		}
		
		// Freeze icon?
		if (get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[DAMAGE], _, id)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_DROWN) // damage type - DMG_FREEZE
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		// Light blue glow while frozen
		if (g_handle_models_on_separate_ent)
			fm_set_rendering(g_ent_playermodel[id], kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		else
			fm_set_rendering(id, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		
		// Freeze sound
		ArrayGetString(grenade_frost_player, random_num(0, ArraySize(grenade_frost_player) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgid[SCREEN_FADE], _, id)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Prevent from jumping
		if (pev(id, pev_flags) & FL_ONGROUND)
			set_pev(id, pev_gravity, 999999.9) // set really high
		else
			set_pev(id, pev_gravity, 0.000001) // no gravity
		
		// Set a task to remove the freeze
		g_frozen[id] = true;
		ExecuteForward(g_forwards[FROZEN_POST], g_fwDummyResult, id);
		set_task(get_pcvar_float(cvar_freezeduration), "remove_freeze", id)
	}
	else
	{
		remove_freeze(id)
	}
}

public native_set_user_burn(id, set)
{
	if (!g_pluginenabled)
		return;
	
	if(set)
	{
		// Only effect alive zombies
		if (!is_user_valid_alive(id) || !g_zombie[id] || g_nodamage[id])
			return;
			
		ExecuteForward(g_forwards[BURN_PRE], g_fwDummyResult, id);
		if (g_fwDummyResult >= ZP_PLUGIN_HANDLED) return;
		
		// Heat icon?
		if (get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[DAMAGE], _, id)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_BURN) // damage type
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		if (g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) // fire duration (nemesis/assassin is fire resistant)
			g_burning_duration[id] += get_pcvar_num(cvar_fireduration)
		else
			g_burning_duration[id] += get_pcvar_num(cvar_fireduration) * 5
		
		if(g_burning_duration[id] > 0) ExecuteForward(g_forwards[BURN_POST], g_fwDummyResult, id);
		
		// Set burning task on id if not present
		if (!task_exists(id+TASK_BURN))
			set_task(0.2, "burning_flame", id+TASK_BURN, _, _, "b")
	}
	else
	{
		g_burning_duration[id] = 0
	}
}

public native_set_user_infectnade(id, set)
{
	if(!g_pluginenabled || !g_zombie[id]) 
		return
	
	if(set) fm_give_item(id, "weapon_hegrenade");
	else cs_set_user_bpammo(id, CSW_HEGRENADE, 0), client_cmd(id, "lastinv")
	
}


// Native: zp_infect_user
public native_infect_user(id, infector, silent, rewards)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be zombie
	if (!allowed_zombie(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first zombie
		remove_task(TASK_MAKEZOMBIE)
		start_infection_mode(id, MODE_SET)
	}
	else
	{
		// Just infect (plus some checks)
		zombieme(id, is_user_valid_alive(infector) ? infector : 0, 0, (silent == 1) ? 1 : 0, (rewards == 1) ? 1 : 0)
	}
	
	return 1;
}

// Native: zp_disinfect_user
public native_disinfect_user(id, silent)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be human
	if (!allowed_human(id))
		return 0;
	
	// Turn to human
	humanme(id, 0, (silent == 1) ? 1 : 0)
	return 1;
}

// Native: zp_make_user_nemesis
public native_make_user_nemesis(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be nemesis
	if (!allowed_nemesis(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first nemesis
		remove_task(TASK_MAKEZOMBIE)
		start_nemesis_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Nemesis
		zombieme(id, 0, NEMESIS, 0, 0)
	}
	
	return 1;
}

// Native: zp_make_user_survivor
public native_make_user_survivor(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be survivor
	if (!allowed_survivor(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first survivor
		remove_task(TASK_MAKEZOMBIE)
		start_survivor_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Survivor
		humanme(id, SURVIVOR, 0)
	}
	
	return 1;
}

// Native: zp_respawn_user
public native_respawn_user(id, team)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Invalid player
	if (!is_user_valid_connected(id))
		return 0;
	
	// Respawn not allowed
	if (!allowed_respawn(id))
		return 0;
	
	// Respawn as zombie?
	g_respawn_as_zombie[id] = (team == ZP_TEAM_ZOMBIE) ? true : false
	
	// Respawnish!
	respawn_player_manually(id)
	return 1;
}

// Native: zp_force_buy_extra_item
public native_force_buy_extra_item(id, itemid, ignorecost)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	if (itemid < 0 || itemid >= g_extraitem_i)
		return 0;
	
	buy_extra_item(id, itemid, ignorecost)
	return 1;
}

// Native: zp_get_user_sniper
public native_get_user_sniper(id)
{
	return g_hm_special[id] == SNIPER;
}

// Native: zp_make_user_sniper
public native_make_user_sniper(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be sniper
	if (!allowed_sniper(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first sniper
		remove_task(TASK_MAKEZOMBIE)
		start_sniper_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Sniper
		humanme(id, SNIPER, 0)
	}
	
	return 1;
}

// Native: zp_get_user_assassin
public native_get_user_assassin(id)
{
	return g_zm_special[id] == ASSASSIN;
}

 // Native: zp_make_user_assassin
public native_make_user_assassin(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be assassin
	if (!allowed_assassin(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first assassin
		remove_task(TASK_MAKEZOMBIE)
		start_assassin_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Assassin
		zombieme(id, 0, ASSASSIN, 0, 0)
	}
	
	return 1;
}

// Native: zp_get_user_predator
public native_get_user_predator(id)
{
	return g_zm_special[id] == PREDATOR;
}

 // Native: zp_make_user_predator
public native_make_user_predator(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be predator
	if (!allowed_predator(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first predator
		remove_task(TASK_MAKEZOMBIE)
		start_predator_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a predator
		zombieme(id, 0, PREDATOR, 0, 0)
	}
	
	return 1;
}

// Native: zp_get_user_bombardier
public native_get_user_bombardier(id)
{
	return g_zm_special[id] == BOMBARDIER;
}

 // Native: zp_make_user_bombardier
public native_make_user_bombardier(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be bombardier
	if (!allowed_bombardier(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first bombardier
		remove_task(TASK_MAKEZOMBIE)
		start_bombardier_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a bombardier
		zombieme(id, 0, BOMBARDIER, 0, 0)
	}
	
	return 1;
}

// Native: zp_get_user_berserker
public native_get_user_berserker(id)
{
	return g_hm_special[id] == BERSERKER;
}

// Native: zp_get_user_wesker
public native_get_user_wesker(id)
{
	return g_hm_special[id] == WESKER;
}

// Native: zp_make_user_berserker
public native_make_user_berserker(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be berserker
	if (!allowed_berserker(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first berserker
		remove_task(TASK_MAKEZOMBIE)
		start_berserker_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Berserker
		humanme(id, BERSERKER, 0)
	}
	
	return 1;
}

// Native: zp_make_user_wesker
public native_make_user_wesker(id)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Not allowed to be wesker
	if (!allowed_wesker(id))
		return 0;
	
	// New round?
	if (g_newround)
	{
		// Set as first wesker
		remove_task(TASK_MAKEZOMBIE)
		start_wesker_mode(id, MODE_SET)
	}
	else
	{
		// Turn player into a Wesker
		humanme(id, WESKER, 0)
	}
	
	return 1;
}

// Native: zp_get_user_model
public native_get_user_model(plugin_id, param_nums)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Insufficient number of arguments
	if (param_nums != 3)
		return -1;
	
	// Retrieve the player's index
	static id; id = get_param(1)
	
	// Not an alive player or invalid player
	if (!is_user_valid_alive(id))
		return 0;
	
	// Retrieve the player's current model
	static current_model[32]
	fm_cs_get_user_model(id, current_model, charsmax(current_model))
	
	// Copy the model name into the array passed
	set_string(2, current_model, get_param(3))
	
	return 1;
}
// Native: zp_override_user_model
public native_override_user_model(id, const newmodel[], modelindex)
{
	// ZP disabled
	if (!g_pluginenabled)
		return false;
	
	if (!is_user_valid_connected(id))
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}
	
	// Strings passed byref
	param_convert(2)
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	
	// Custom models stuff
	static currentmodel[32]
	
	if (g_handle_models_on_separate_ent)
	{
		// Set the right model
		copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
		if (g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if (!equal(currentmodel, newmodel))
		{
			copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
			if (g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
			
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if (g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
	}
	return true;
}

// Native: zp_get_current_mode
public native_get_current_mode()
{
	return g_currentmode
}

// Native: zp_has_round_started
public native_has_round_started()
{
	if (g_newround) return 0; // not started
	if (g_modestarted) return 1; // started
	return 2; // starting
}

// Native: zp_is_nemesis_round
public native_is_nemesis_round()
{
	return (g_currentmode == MODE_NEMESIS);
}

// Native: zp_is_survivor_round
public native_is_survivor_round()
{
	return (g_currentmode == MODE_SURVIVOR);
}

// Native: zp_is_swarm_round
public native_is_swarm_round()
{
	return (g_currentmode == MODE_SWARM);
}

// Native: zp_is_plague_round
public native_is_plague_round()
{
	return (g_currentmode == MODE_PLAGUE);
}

// Native: zp_get_zombie_count
public native_get_zombie_count()
{
	return fnGetZombies();
}

// Native: zp_get_human_count
public native_get_human_count()
{
	return fnGetHumans();
}

// Native: zp_get_nemesis_count
public native_get_nemesis_count()
{
	return fnGetNemesis();
}

// Native: zp_get_survivor_count
public native_get_survivor_count()
{
	return fnGetSurvivors();
}

// Native: zp_is_sniper_round
public native_is_sniper_round()
{
	return (g_currentmode == MODE_SNIPER);
}

// Native: zp_get_sniper_count
public native_get_sniper_count()
{
	return fnGetSnipers();
}

// Native: zp_is_assassin_round
public native_is_assassin_round()
{
	return (g_currentmode == MODE_ASSASSIN);
}

// Native: zp_get_assassin_count
public native_get_assassin_count()
{
	return fnGetAssassin();
}

// Native: zp_is_predator_round
public native_is_predator_round()
{
	return (g_currentmode == MODE_PREDATOR);
}

// Native: zp_get_predator_count
public native_get_predator_count()
{
	return fnGetPredator();
}

// Native: zp_is_bombardier_round
public native_is_bombardier_round()
{
	return (g_currentmode == MODE_BOMBARDIER);
}

// Native: zp_get_bombardier_count
public native_get_bombardier_count()
{
	return fnGetBombardier();
}


// Native: zp_is_berserker_round
public native_is_berserker_round()
{
	return (g_currentmode == MODE_BERSERKER);
}

// Native: zp_is_wesker_round
public native_is_wesker_round()
{
	return (g_currentmode == MODE_WESKER);
}

// Native: zp_get_berserker_count
public native_get_berserker_count()
{
	return fnGetBerserkers();
}

// Native: zp_get_wesker_count
public native_get_wesker_count()
{
	return fnGetWeskers();
}

// Native: zp_is_lnj_round
public native_is_lnj_round()
{
	return (g_currentmode == MODE_LNJ);
}

// Native: zp_register_game_mode
public native_register_game_mode(const name[], flags, chance, allow, dm_mode)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if (!g_arrays_created)
		return -1;
		
	// Strings passed byref
	param_convert(1)
	
	// Add the game mode
	ArrayPushString(g_gamemode_name, name)
	ArrayPushCell(g_gamemode_flag, flags)
	ArrayPushCell(g_gamemode_chance, chance)
	ArrayPushCell(g_gamemode_allow, allow)
	ArrayPushCell(g_gamemode_dm, dm_mode)
	
	// Increase registered game modes counter
	g_gamemodes_i++
	
	// Return id under which we registered the game mode
	return (g_gamemodes_i-1);
}
public native_extra_item_textadd(plugin_id, num_params)
{
	static text[32]
	get_string(1, text, charsmax(text))	
	format(g_AdditionalMenuText, charsmax(g_AdditionalMenuText), "%s%s", g_AdditionalMenuText, text)
}

public native_zombie_class_textadd(plugin_id, num_params)
{
	static text[32]
	get_string(1, text, charsmax(text))	
	format(g_AdditionalMenuText2, charsmax(g_AdditionalMenuText2), "%s%s", g_AdditionalMenuText2, text)
}

// Native: zp_register_extra_item
public native_register_extra_item(const name[], cost, team)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if (!g_arrays_created)
		return -1;
	
	// For backwards compatibility
	if (team == ZP_TEAM_ANY)
		team = ZP_TEAM_ZOMBIE|ZP_TEAM_HUMAN
	
	// Strings passed byref
	param_convert(1)
	
	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	// Override extra items data with our customizations
	new i, buffer[32], size = ArraySize(g_extraitem2_realname)
	for (i = 0; i < size; i++)
	{
		ArrayGetString(g_extraitem2_realname, i, buffer, charsmax(buffer))
		
		// Check if this is the intended item to override
		if (!equal(name, buffer))
			continue;
		
		// Remove new item flag
		ArraySetCell(g_extraitem_new, g_extraitem_i, 0)
		
		// Replace caption
		ArrayGetString(g_extraitem2_name, i, buffer, charsmax(buffer))
		ArraySetString(g_extraitem_name, g_extraitem_i, buffer)
		
		// Replace cost
		buffer[0] = ArrayGetCell(g_extraitem2_cost, i)
		ArraySetCell(g_extraitem_cost, g_extraitem_i, buffer[0])
		
		// Replace team
		buffer[0] = ArrayGetCell(g_extraitem2_team, i)
		ArraySetCell(g_extraitem_team, g_extraitem_i, buffer[0])
	}
	
	// Increase registered items counter
	g_extraitem_i++
	
	// Return id under which we registered the item
	return (g_extraitem_i-1);
}

// Function: zp_register_extra_item (to be used within this plugin only)
native_register_extra_item2(const name[], cost, team)
{
	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	// Increase registered items counter
	g_extraitem_i++
}

// Native: zp_register_zombie_class
public native_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback)
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if (!g_arrays_created)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	param_convert(4)
	
	// Add the class
	ArrayPushString(g_zclass_name, name)
	ArrayPushString(g_zclass_info, info)
	
	// Using same zombie models for all classes?
	if (g_same_models_for_all)
	{
		ArrayPushCell(g_zclass_modelsstart, 0)
		ArrayPushCell(g_zclass_modelsend, ArraySize(g_zclass_playermodel))
	}
	else
	{
		ArrayPushCell(g_zclass_modelsstart, ArraySize(g_zclass_playermodel))
		ArrayPushString(g_zclass_playermodel, model)
		ArrayPushCell(g_zclass_modelsend, ArraySize(g_zclass_playermodel))
		ArrayPushCell(g_zclass_modelindex, -1)
	}
	
	ArrayPushString(g_zclass_clawmodel, clawmodel)
	ArrayPushCell(g_zclass_hp, hp)
	ArrayPushCell(g_zclass_spd, speed)
	ArrayPushCell(g_zclass_grav, gravity)
	ArrayPushCell(g_zclass_kb, knockback)
	
	// Set temporary new class flag
	ArrayPushCell(g_zclass_new, 1)
	
	// Override zombie classes data with our customizations
	new i, k, buffer[32], Float:buffer2, nummodels_custom, nummodels_default, prec_mdl[100], size = ArraySize(g_zclass2_realname)
	for (i = 0; i < size; i++)
	{
		ArrayGetString(g_zclass2_realname, i, buffer, charsmax(buffer))
		
		// Check if this is the intended class to override
		if (!equal(name, buffer))
			continue;
		
		// Remove new class flag
		ArraySetCell(g_zclass_new, g_zclass_i, 0)
		
		// Replace caption
		ArrayGetString(g_zclass2_name, i, buffer, charsmax(buffer))
		ArraySetString(g_zclass_name, g_zclass_i, buffer)
		
		// Replace info
		ArrayGetString(g_zclass2_info, i, buffer, charsmax(buffer))
		ArraySetString(g_zclass_info, g_zclass_i, buffer)
		
		// Replace models, unless using same models for all classes
		if (!g_same_models_for_all)
		{
			nummodels_custom = ArrayGetCell(g_zclass2_modelsend, i) - ArrayGetCell(g_zclass2_modelsstart, i)
			nummodels_default = ArrayGetCell(g_zclass_modelsend, g_zclass_i) - ArrayGetCell(g_zclass_modelsstart, g_zclass_i)
			
			// Replace each player model and model index
			for (k = 0; k < min(nummodels_custom, nummodels_default); k++)
			{
				ArrayGetString(g_zclass2_playermodel, ArrayGetCell(g_zclass2_modelsstart, i) + k, buffer, charsmax(buffer))
				ArraySetString(g_zclass_playermodel, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k, buffer)
				
				// Precache player model and replace its modelindex with the real one
				formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", buffer, buffer)
				ArraySetCell(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k, engfunc(EngFunc_PrecacheModel, prec_mdl))
				if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
				if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
			}
			
			// We have more custom models than what we can accommodate,
			// Let's make some space...
			if (nummodels_custom > nummodels_default)
			{
				for (k = nummodels_default; k < nummodels_custom; k++)
				{
					ArrayGetString(g_zclass2_playermodel, ArrayGetCell(g_zclass2_modelsstart, i) + k, buffer, charsmax(buffer))
					ArrayInsertStringAfter(g_zclass_playermodel, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k - 1, buffer)
					
					// Precache player model and retrieve its modelindex
					formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", buffer, buffer)
					ArrayInsertCellAfter(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k - 1, engfunc(EngFunc_PrecacheModel, prec_mdl))
					if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
					if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
				}
				
				// Fix models end index for this class
				ArraySetCell(g_zclass_modelsend, g_zclass_i, ArrayGetCell(g_zclass_modelsend, g_zclass_i) + (nummodels_custom - nummodels_default))
			}
			
			/* --- Not needed since classes can't have more than 1 default model for now ---
			// We have less custom models than what this class has by default,
			// Get rid of those extra entries...
			if (nummodels_custom < nummodels_default)
			{
				for (k = nummodels_custom; k < nummodels_default; k++)
				{
					ArrayDeleteItem(g_zclass_playermodel, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + nummodels_custom)
				}
				
				// Fix models end index for this class
				ArraySetCell(g_zclass_modelsend, g_zclass_i, ArrayGetCell(g_zclass_modelsend, g_zclass_i) - (nummodels_default - nummodels_custom))
			}
			*/
		}
		
		// Replace clawmodel
		ArrayGetString(g_zclass2_clawmodel, i, buffer, charsmax(buffer))
		ArraySetString(g_zclass_clawmodel, g_zclass_i, buffer)
		
		// Precache clawmodel
		formatex(prec_mdl, charsmax(prec_mdl), "models/zombie_plague/%s", buffer)
		engfunc(EngFunc_PrecacheModel, prec_mdl)
		
		// Replace health
		buffer[0] = ArrayGetCell(g_zclass2_hp, i)
		ArraySetCell(g_zclass_hp, g_zclass_i, buffer[0])
		
		// Replace speed
		buffer[0] = ArrayGetCell(g_zclass2_spd, i)
		ArraySetCell(g_zclass_spd, g_zclass_i, buffer[0])
		
		// Replace gravity
		buffer2 = Float:ArrayGetCell(g_zclass2_grav, i)
		ArraySetCell(g_zclass_grav, g_zclass_i, buffer2)
		
		// Replace knockback
		buffer2 = Float:ArrayGetCell(g_zclass2_kb, i)
		ArraySetCell(g_zclass_kb, g_zclass_i, buffer2)
	}
	
	// If class was not overriden with customization data
	if (ArrayGetCell(g_zclass_new, g_zclass_i))
	{
		// If not using same models for all classes
		if (!g_same_models_for_all)
		{
			// Precache default class model and replace modelindex with the real one
			formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", model, model)
			ArraySetCell(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i), engfunc(EngFunc_PrecacheModel, prec_mdl))
			if (g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
			if (g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
		}
		
		// Precache default clawmodel
		formatex(prec_mdl, charsmax(prec_mdl), "models/zombie_plague/%s", clawmodel)
		engfunc(EngFunc_PrecacheModel, prec_mdl)
	}
	
	// Increase registered classes counter
	g_zclass_i++
	
	// Return id under which we registered the class
	return (g_zclass_i-1);
}

// Native: zp_get_extra_item_id
public native_get_extra_item_id(const name[])
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every item
	static i, item_name[32]
	for (i = 0; i < g_extraitem_i; i++)
	{
		ArrayGetString(g_extraitem_name, i, item_name, charsmax(item_name))
		
		// Check if this is the item to retrieve
		if (equali(name, item_name))
			return i;
	}
	
	return -1;
}

// Native: zp_get_zombie_class_id
public native_get_zombie_class_id(const name[])
{
	// ZPA disabled
	if (!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every class
	static i, class_name[32]
	for (i = 0; i < g_zclass_i; i++)
	{
		ArrayGetString(g_zclass_name, i, class_name, charsmax(class_name))
		
		// Check if this is the class to retrieve
		if (equali(name, class_name))
			return i;
	}
	
	return -1;
}

/*================================================================================
 [Custom Messages]
=================================================================================*/

// Custom Night Vision
public set_user_nvision(taskid)
{
	// Get player's origin
	static origin[3]
	get_user_origin(ID_NVISION, origin)
	
	// Nightvision message
	message_begin(MSG_ONE_UNRELIABLE, SVC_TEMPENTITY, _, ID_NVISION)
	write_byte(TE_DLIGHT) // TE id
	write_coord(origin[0]) // x
	write_coord(origin[1]) // y
	write_coord(origin[2]) // z
	write_byte(get_pcvar_num(cvar_nvgsize)) // radius
	
	// Nemesis / Madness / Spectator in nemesis round
	if (g_zm_special[ID_NVISION] == NEMESIS || (g_zombie[ID_NVISION] && g_nodamage[ID_NVISION]) || (!g_isalive[ID_NVISION] && g_currentmode == MODE_NEMESIS))
	{
		write_byte(get_pcvar_num(cvar_nemnvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_nemnvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_nemnvgcolor[2])) // b
	}
	// Assassin / Spectator in assassin round
	else if (g_zm_special[ID_NVISION] == ASSASSIN || (!g_isalive[ID_NVISION] && g_currentmode == MODE_ASSASSIN))
	{
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[2])) // b
	}
	
	// Predator / Spectator in predator round
	else if (g_zm_special[ID_NVISION] == PREDATOR || (!g_isalive[ID_NVISION] && g_currentmode == MODE_PREDATOR))
	{
		write_byte(get_pcvar_num(cvar_predatornvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_predatornvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_predatornvgcolor[2])) // b
	}
	
	// Bombardier / Spectator in bombardier round
	else if (g_zm_special[ID_NVISION] == BOMBARDIER || (!g_isalive[ID_NVISION] && g_currentmode == MODE_BOMBARDIER))
	{
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[2])) // b
	}

	// Human / Spectator in normal round
	else if (!g_zombie[ID_NVISION] || !g_isalive[ID_NVISION])
	{
		switch(g_nv_color[0][ID_NVISION])
		{
			case 0: g_nvrgb = { 255, 255, 255 }
			case 1: g_nvrgb = { 255, 0, 0 }
			case 2: g_nvrgb = { 0, 255, 0 }
			case 3: g_nvrgb = { 0, 0, 255 }
			case 4: g_nvrgb = { 0, 255, 255 }
			case 5: g_nvrgb = { 255, 0, 255 }
			case 6: g_nvrgb = { 255, 255, 0 }
		}
		
		write_byte(g_nvrgb[0]) // r
		write_byte(g_nvrgb[1]) // g
		write_byte(g_nvrgb[2]) // b
	}
	// Zombie
	else
	{
		switch(g_nv_color[1][ID_NVISION])
		{
			case 0: g_nvrgb = { 255, 255, 255 }
			case 1: g_nvrgb = { 255, 0, 0 }
			case 2: g_nvrgb = { 0, 255, 0 }
			case 3: g_nvrgb = { 0, 0, 255 }
			case 4: g_nvrgb = { 0, 255, 255 }
			case 5: g_nvrgb = { 255, 0, 255 }
			case 6: g_nvrgb = { 255, 255, 0 }
		}
		
		write_byte(g_nvrgb[0]) // r
		write_byte(g_nvrgb[1]) // g
		write_byte(g_nvrgb[2]) // b
	}
	
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Game Nightvision
set_user_gnvision(id, toggle)
{
	// Toggle NVG message
	message_begin(MSG_ONE, g_msgid[NVG_TOGGLE], _, id)
	write_byte(toggle) // toggle
	message_end()
}

// Custom Flashlight
public set_user_flashlight(taskid)
{
	// Get player and aiming origins
	static Float:originF[3], Float:destoriginF[3]
	pev(ID_FLASH, pev_origin, originF)
	fm_get_aim_origin(ID_FLASH, destoriginF)
	
	// Max distance check
	if (get_distance_f(originF, destoriginF) > get_pcvar_float(cvar_flashdist))
		return;
	
	// Send to all players?
	if (get_pcvar_num(cvar_flashshowall))
		engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, destoriginF, 0)
	else
		message_begin(MSG_ONE_UNRELIABLE, SVC_TEMPENTITY, _, ID_FLASH)
	
	// Flashlight
	write_byte(TE_DLIGHT) // TE id
	engfunc(EngFunc_WriteCoord, destoriginF[0]) // x
	engfunc(EngFunc_WriteCoord, destoriginF[1]) // y
	engfunc(EngFunc_WriteCoord, destoriginF[2]) // z
	
	switch(g_lantern_color[ID_FLASH])
	{
		case 0: g_lant_rgb = { 255, 255, 255 }
		case 1: g_lant_rgb = { 255, 0, 0 }
		case 2: g_lant_rgb = { 0, 255, 0 }
		case 3: g_lant_rgb = { 0, 0, 255 }
		case 4: g_lant_rgb = { 0, 255, 255 }
		case 5: g_lant_rgb = { 255, 0, 255 }
		case 6: g_lant_rgb = { 255, 255, 0 }
	}

	
	// Different flashlight in assassin round ?
	if (g_currentmode == MODE_ASSASSIN)
	{
		write_byte(get_pcvar_num(cvar_flashsize2)) // radius
		write_byte(g_lant_rgb[0]) // r
		write_byte(g_lant_rgb[1]) // g
		write_byte(g_lant_rgb[2]) // b
	}
	else
	{
		write_byte(get_pcvar_num(cvar_flashsize)) // radius
		write_byte(g_lant_rgb[0]) // r
		write_byte(g_lant_rgb[1]) // g
		write_byte(g_lant_rgb[2]) // b
	}
		
	write_byte(3) // life
	write_byte(0) // decay rate
	message_end()
}

// Infection special effects
infection_effects(id)
{
	// Screen fade? (unless frozen)
	if (!g_frozen[id] && get_pcvar_num(cvar_infectionscreenfade))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgid[SCREEN_FADE], _, id)
		write_short(UNIT_SECOND) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		
		switch(g_zm_special[id])
		{
			case NEMESIS:
			{
				write_byte(get_pcvar_num(cvar_nemnvgcolor[0])) // r
				write_byte(get_pcvar_num(cvar_nemnvgcolor[1])) // g
				write_byte(get_pcvar_num(cvar_nemnvgcolor[2])) // b
			}
			case ASSASSIN:
			{
				write_byte(get_pcvar_num(cvar_assassinnvgcolor[0])) // r
				write_byte(get_pcvar_num(cvar_assassinnvgcolor[1])) // g
				write_byte(get_pcvar_num(cvar_assassinnvgcolor[2])) // b
			}
			case PREDATOR:
			{
				write_byte(get_pcvar_num(cvar_predatornvgcolor[0])) // r
				write_byte(get_pcvar_num(cvar_predatornvgcolor[1])) // g
				write_byte(get_pcvar_num(cvar_predatornvgcolor[2])) // b
			}
			case BOMBARDIER:
			{
				write_byte(get_pcvar_num(cvar_bombardiernvgcolor[0])) // r
				write_byte(get_pcvar_num(cvar_bombardiernvgcolor[1])) // g
				write_byte(get_pcvar_num(cvar_bombardiernvgcolor[2])) // b
			}
			default:
			{
				switch(g_nv_color[1][id])
				{
					case 0: g_nvrgb = { 255, 255, 255 }
					case 1: g_nvrgb = { 255, 0, 0 }
					case 2: g_nvrgb = { 0, 255, 0 }
					case 3: g_nvrgb = { 0, 0, 255 }
					case 4: g_nvrgb = { 0, 255, 255 }
					case 5: g_nvrgb = { 255, 0, 255 }
					case 6: g_nvrgb = { 255, 255, 0 }
				}
				
				write_byte(g_nvrgb[0]) // r
				write_byte(g_nvrgb[1]) // g
				write_byte(g_nvrgb[2]) // b
			}
		}
		write_byte (255) // alpha
		message_end()
	}
	
	// Screen shake?
	if (get_pcvar_num(cvar_infectionscreenshake))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgid[SCREEN_SHAKE], _, id)
		write_short(UNIT_SECOND*75) // amplitude
		write_short(UNIT_SECOND*5) // duration
		write_short(UNIT_SECOND*75) // frequency
		message_end()
	}
	
	// Infection icon?
	if (get_pcvar_num(cvar_hudicons))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgid[DAMAGE], _, id)
		write_byte(0) // damage save
		write_byte(0) // damage take
		write_long(DMG_NERVEGAS) // damage type - DMG_RADIATION
		write_coord(0) // x
		write_coord(0) // y
		write_coord(0) // z
		message_end()
	}
	
	// Get player's origin
	static origin[3]
	get_user_origin(id, origin)
	
	// Tracers?
	if (get_pcvar_num(cvar_infectiontracers))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_IMPLOSION) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_byte(128) // radius
		write_byte(20) // count
		write_byte(3) // duration
		message_end()
	}
	
	// Particle burst?
	if (get_pcvar_num(cvar_infectionparticles))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_PARTICLEBURST) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_short(50) // radius
		write_byte(70) // color
		write_byte(3) // duration (will be randomized a bit)
		message_end()
	}
	
	// Light sparkle?
	if (get_pcvar_num(cvar_infectionsparkle))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_DLIGHT) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_byte(20) // radius
		write_byte(get_pcvar_num(cvar_nvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_nvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_nvgcolor[2])) // b
		write_byte(2) // life
		write_byte(0) // decay rate
		message_end()
	}
}

// Nemesis/madness aura task
public zombie_aura(taskid)
{
	// Not nemesis, not in zombie madness
	if (g_zm_special[ID_AURA] <= 0 && !g_nodamage[ID_AURA])
	{
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Get player's origin
	static origin[3]
	get_user_origin(ID_AURA, origin)
	
	// Colored Aura
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
	write_byte(TE_DLIGHT) // TE id
	write_coord(origin[0]) // x
	write_coord(origin[1]) // y
	write_coord(origin[2]) // z
	write_byte(get_pcvar_num(cvar_nemauraradius)) // radius
	
	// Different aura color for assassin
	if (g_zm_special[ID_AURA] == ASSASSIN)
	{
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_assassinnvgcolor[2])) // b
	}
	// Different aura color for predator
	if (g_zm_special[ID_AURA] == PREDATOR)
	{
		write_byte(get_pcvar_num(cvar_predatornvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_predatornvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_predatornvgcolor[2])) // b
	}
	// Different aura color for bombardier
	if (g_zm_special[ID_AURA] == BOMBARDIER)
	{
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_bombardiernvgcolor[2])) // b
	}
	else // Aura color for nemesis
	{
		write_byte(get_pcvar_num(cvar_nemnvgcolor[0])) // r
		write_byte(get_pcvar_num(cvar_nemnvgcolor[1])) // g
		write_byte(get_pcvar_num(cvar_nemnvgcolor[2])) // b
	}
	
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Survivor/Sniper/Berserker aura task
public human_aura(taskid)
{
	// Not survivor or sniper
	if (g_hm_special[ID_AURA] <= 0)
	{
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Get player's origin
	static origin[3]
	get_user_origin(ID_AURA, origin)
	
	// Colored Aura
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
	write_byte(TE_DLIGHT) // TE id
	write_coord(origin[0]) // x
	write_coord(origin[1]) // y
	write_coord(origin[2]) // z
	
	// Set aura for sniper
	if (g_hm_special[ID_AURA] == SNIPER)
	{
		write_byte(get_pcvar_num(cvar_sniperauraradius)) // radius
		write_byte(get_pcvar_num(cvar_snipercolor[0])) // r
		write_byte(get_pcvar_num(cvar_snipercolor[1])) // g
		write_byte(get_pcvar_num(cvar_snipercolor[2])) // b
	}
	else if (g_hm_special[ID_AURA] == BERSERKER)
	{
		write_byte(get_pcvar_num(cvar_berserkerauraradius)) // radius
		write_byte(get_pcvar_num(cvar_berserkercolor[0])) // r
		write_byte(get_pcvar_num(cvar_berserkercolor[1])) // g
		write_byte(get_pcvar_num(cvar_berserkercolor[2])) // b
	}
	else if (g_hm_special[ID_AURA] == WESKER)
	{
		write_byte(get_pcvar_num(cvar_weskerauraradius)) // radius
		write_byte(get_pcvar_num(cvar_weskercolor[0])) // r
		write_byte(get_pcvar_num(cvar_weskercolor[1])) // g
		write_byte(get_pcvar_num(cvar_weskercolor[2])) // b
	}
	else // Set it for survivor
	{
		write_byte(get_pcvar_num(cvar_surv_aura_radius)) // radius
		write_byte(get_pcvar_num(cvar_surv_aura[0])) // r
		write_byte(get_pcvar_num(cvar_surv_aura[1])) // g
		write_byte(get_pcvar_num(cvar_surv_aura[2])) // b
	}
		
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Make zombies leave footsteps and bloodstains on the floor
public make_blood(taskid)
{
	// Only bleed when moving on ground
	if (!(pev(ID_BLOOD, pev_flags) & FL_ONGROUND) || fm_get_speed(ID_BLOOD) < 80)
		return;
	
	// Get user origin
	static Float:originF[3]
	pev(ID_BLOOD, pev_origin, originF)
	
	// If ducking set a little lower
	if (pev(ID_BLOOD, pev_bInDuck))
		originF[2] -= 18.0
	else
		originF[2] -= 36.0
	
	// Send the decal message
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_WORLDDECAL) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	new num[32]
	ArrayGetString(zombie_decals, random_num(0, ArraySize(zombie_decals) - 1), num, charsmax(num))
	write_byte(str_to_num(num) + (g_czero * 12)) // random decal number (offsets +12 for CZ)
	message_end()
}

// Flare Lighting Effects
flare_lighting(entity, duration)
{
	// Get origin and color
	static Float:originF[3], color[3]
	pev(entity, pev_origin, originF)
	pev(entity, PEV_FLARE_COLOR, color)
	
	if (g_currentmode == MODE_ASSASSIN)
	{	
		// Lighting in assassin round is different
		engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
		write_byte(TE_DLIGHT) // TE id
		engfunc(EngFunc_WriteCoord, originF[0]) // x
		engfunc(EngFunc_WriteCoord, originF[1]) // y
		engfunc(EngFunc_WriteCoord, originF[2]) // z
		write_byte(get_pcvar_num(cvar_flaresize2)) // radius
		write_byte(color[0]) // r
		write_byte(color[1]) // g
		write_byte(color[2]) // b
		write_byte(51) //life
		write_byte((duration < 2) ? 3 : 0) //decay rate
		message_end()
	}
	else
	{
		// Lighting
		engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
		write_byte(TE_DLIGHT) // TE id
		engfunc(EngFunc_WriteCoord, originF[0]) // x
		engfunc(EngFunc_WriteCoord, originF[1]) // y
		engfunc(EngFunc_WriteCoord, originF[2]) // z
		write_byte(get_pcvar_num(cvar_flaresize)) // radius
		write_byte(color[0]) // r
		write_byte(color[1]) // g
		write_byte(color[2]) // b
		write_byte(51) //life
		write_byte((duration < 2) ? 3 : 0) //decay rate
		message_end()
	}
	
	// Sparks
	engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_SPARKS) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	message_end()
}

// Burning Flames
public burning_flame(taskid)
{
	// Get player origin and flags
	static origin[3], flags
	get_user_origin(ID_BURN, origin)
	flags = pev(ID_BURN, pev_flags)
	
	// Madness mode - in water - burning stopped
	if (g_nodamage[ID_BURN] || (flags & FL_INWATER) || g_burning_duration[ID_BURN] < 1)
	{
		// Smoke sprite
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_SMOKE) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]-50) // z
		write_short(g_smokeSpr) // sprite
		write_byte(random_num(15, 20)) // scale
		write_byte(random_num(10, 20)) // framerate
		message_end()
		
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Randomly play burning zombie scream sounds (not for nemesis or assassin)
	if (g_zm_special[ID_BURN] <= 0 && !random_num(0, 20))
	{
		static sound[64]
		ArrayGetString(grenade_fire_player, random_num(0, ArraySize(grenade_fire_player) - 1), sound, charsmax(sound))
		emit_sound(ID_BURN, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	
	// Fire slow down, unless nemesis
	if (g_zm_special[ID_BURN] <= 0 && (flags & FL_ONGROUND) && get_pcvar_float(cvar_fireslowdown) > 0.0)
	{
		static Float:velocity[3]
		pev(ID_BURN, pev_velocity, velocity)
		xs_vec_mul_scalar(velocity, get_pcvar_float(cvar_fireslowdown), velocity)
		set_pev(ID_BURN, pev_velocity, velocity)
	}
	
	// Get player's health
	static health
	health = pev(ID_BURN, pev_health)
	
	// Take damage from the fire
	if (health - floatround(get_pcvar_float(cvar_firedamage), floatround_ceil) > 0)
		fm_set_user_health(ID_BURN, health - floatround(get_pcvar_float(cvar_firedamage), floatround_ceil))
	
	// Flame sprite
	message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
	write_byte(TE_SPRITE) // TE id
	write_coord(origin[0]+random_num(-5, 5)) // x
	write_coord(origin[1]+random_num(-5, 5)) // y
	write_coord(origin[2]+random_num(-10, 10)) // z
	write_short(g_flameSpr) // sprite
	write_byte(random_num(5, 10)) // scale
	write_byte(200) // brightness
	message_end()
	
	// Decrease burning duration counter
	g_burning_duration[ID_BURN]--
}

// Infection Bomb: Blast
create_blast(const Float:originF[3])
{
	// Smallest ring
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
	write_byte(0) // red
	write_byte(250) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
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
	write_byte(0) // red
	write_byte(250) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
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
	write_byte(0) // red
	write_byte(250) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Fire Grenade: Fire Blast
create_blast2(const Float:originF[3])
{
	// Smallest ring
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
	write_byte(200) // red
	write_byte(100) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
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
	write_byte(200) // red
	write_byte(50) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
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
	write_byte(200) // red
	write_byte(0) // green
	write_byte(0) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Frost Grenade: Freeze Blast
create_blast3(const Float:originF[3])
{
	// Smallest ring
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
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Medium ring
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
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
	
	// Largest ring
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
	write_byte(0) // red
	write_byte(100) // green
	write_byte(200) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Fix Dead Attrib on scoreboard
FixDeadAttrib(id)
{
	message_begin(MSG_BROADCAST, g_msgid[SCORE_ATTRIB])
	write_byte(id) // id
	write_byte(0) // attrib
	message_end()
}

// Send Death Message for infections
SendDeathMsg(attacker, victim)
{
	message_begin(MSG_BROADCAST, g_msgid[DEATH_MSG])
	write_byte(attacker) // killer
	write_byte(victim) // victim
	write_byte(1) // headshot flag
	write_string("infection") // killer's weapon
	message_end()
}

// Update Player Frags and Deaths
UpdateFrags(attacker, victim, frags, deaths, scoreboard)
{
	// Set attacker frags
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) + frags))
	
	// Set victim deaths
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) + deaths)
	
	// Update scoreboard with attacker and victim info
	if (scoreboard)
	{
		message_begin(MSG_BROADCAST, g_msgid[SCORE_INFO])
		write_byte(attacker) // id
		write_short(pev(attacker, pev_frags)) // frags
		write_short(cs_get_user_deaths(attacker)) // deaths
		write_short(0) // class?
		write_short(fm_cs_get_user_team(attacker)) // team
		message_end()
		
		message_begin(MSG_BROADCAST, g_msgid[SCORE_INFO])
		write_byte(victim) // id
		write_short(pev(victim, pev_frags)) // frags
		write_short(cs_get_user_deaths(victim)) // deaths
		write_short(0) // class?
		write_short(fm_cs_get_user_team(victim)) // team
		message_end()
	}
}

// Remove Player Frags (when Nemesis/Survivor/Sniper/Berserker ignore_frags cvar is enabled)
RemoveFrags(attacker, victim)
{
	// Remove attacker frags
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) - 1))
	
	// Remove victim deaths
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) - 1)
}

// Plays a sound on clients
stock PlaySound(const sound[])
{
	if (equal(sound[strlen(sound)-4], ".mp3"))
		client_cmd(0, "mp3 play ^"sound/%s^"", sound)
	else
		client_cmd(0, "spk ^"%s^"", sound)
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
// Note: I still need to make something like gungame's LANG_PLAYER_C to avoid unintended
// argument replacement when a function passes -1 (it will be considered a LANG_PLAYER)
zp_colored_print(target, const message[], any:...)
{
	static buffer[512], i, argscount
	argscount = numargs()
	
	// Send to everyone
	if (!target)
	{
		static player
		for (player = 1; player <= g_maxplayers; player++)
		{
			// Not connected
			if (!g_isconnected[player])
				continue;
			
			// Remember changed arguments
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
			// Replace LANG_PLAYER with player id
			for (i = 2; i < argscount; i++)
			{
				if (getarg(i) == LANG_PLAYER)
				{
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}
			
			// Format message for player
			vformat(buffer, charsmax(buffer), message, 3)
			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgid[SAY_TEXT], _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for (i = 0; i < changedcount; i++)
				setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	// Send to specific target
	else
	{
		// Format message for player
		vformat(buffer, charsmax(buffer), message, 3)
		
		// Send it
		message_begin(MSG_ONE, g_msgid[SAY_TEXT], _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}

/*================================================================================
 [Stocks]
=================================================================================*/

// Set an entity's key value (from fakemeta_util)
stock fm_set_kvd(entity, const key[], const value[], const classname[])
{
	set_kvd(0, KV_ClassName, classname)
	set_kvd(0, KV_KeyName, key)
	set_kvd(0, KV_Value, value)
	set_kvd(0, KV_fHandled, 0)

	dllfunc(DLLFunc_KeyValue, entity, 0)
}

// Set entity's rendering type (from fakemeta_util)
stock fm_set_rendering(entity, fx = kRenderFxNone, r = 255, g = 255, b = 255, render = kRenderNormal, amount = 16)
{
	static Float:color[3]
	color[0] = float(r)
	color[1] = float(g)
	color[2] = float(b)
	
	set_pev(entity, pev_renderfx, fx)
	set_pev(entity, pev_rendercolor, color)
	set_pev(entity, pev_rendermode, render)
	set_pev(entity, pev_renderamt, float(amount))
}

// Get entity's speed (from fakemeta_util)
stock fm_get_speed(entity)
{
	static Float:velocity[3]
	pev(entity, pev_velocity, velocity)
	
	return floatround(vector_length(velocity));
}

// Get entity's aim origins (from fakemeta_util)
stock fm_get_aim_origin(id, Float:origin[3])
{
	static Float:origin1F[3], Float:origin2F[3]
	pev(id, pev_origin, origin1F)
	pev(id, pev_view_ofs, origin2F)
	xs_vec_add(origin1F, origin2F, origin1F)

	pev(id, pev_v_angle, origin2F);
	engfunc(EngFunc_MakeVectors, origin2F)
	global_get(glb_v_forward, origin2F)
	xs_vec_mul_scalar(origin2F, 9999.0, origin2F)
	xs_vec_add(origin1F, origin2F, origin2F)

	engfunc(EngFunc_TraceLine, origin1F, origin2F, 0, id, 0)
	get_tr2(0, TR_vecEndPos, origin)
}

// Find entity by its owner (from fakemeta_util)
stock fm_find_ent_by_owner(entity, const classname[], owner)
{
	while ((entity = engfunc(EngFunc_FindEntityByString, entity, "classname", classname)) && pev(entity, pev_owner) != owner) { /* keep looping */ }
	return entity;
}

// Set player's health (from fakemeta_util)
stock fm_set_user_health(id, health)
{
	(health > 0) ? set_pev(id, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, id);
}

// Give an item to a player (from fakemeta_util)
stock fm_give_item(id, const item[])
{
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, item))
	if (!pev_valid(ent)) return;
	
	static Float:originF[3]
	pev(id, pev_origin, originF)
	set_pev(ent, pev_origin, originF)
	set_pev(ent, pev_spawnflags, pev(ent, pev_spawnflags) | SF_NORESPAWN)
	dllfunc(DLLFunc_Spawn, ent)
	
	static save
	save = pev(ent, pev_solid)
	dllfunc(DLLFunc_Touch, ent, id)
	if (pev(ent, pev_solid) != save)
		return;
	
	engfunc(EngFunc_RemoveEntity, ent)
}

// Strip user weapons (from fakemeta_util)
stock fm_strip_user_weapons(id)
{
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "player_weaponstrip"))
	if (!pev_valid(ent)) return;
	
	dllfunc(DLLFunc_Spawn, ent)
	dllfunc(DLLFunc_Use, ent, id)
	engfunc(EngFunc_RemoveEntity, ent)
}

// Collect random spawn points
stock load_spawns()
{
	// Check for CSDM spawns of the current map
	new cfgdir[32], mapname[32], filepath[100], linedata[64]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(filepath, charsmax(filepath), "%s/csdm/%s.spawns.cfg", cfgdir, mapname)
	
	// Load CSDM spawns if present
	if (file_exists(filepath))
	{
		new csdmdata[10][6], file = fopen(filepath,"rt")
		
		while (file && !feof(file))
		{
			fgets(file, linedata, charsmax(linedata))
			
			// invalid spawn
			if (!linedata[0] || str_count(linedata,' ') < 2) continue;
			
			// get spawn point data
			parse(linedata,csdmdata[0],5,csdmdata[1],5,csdmdata[2],5,csdmdata[3],5,csdmdata[4],5,csdmdata[5],5,csdmdata[6],5,csdmdata[7],5,csdmdata[8],5,csdmdata[9],5)
			
			// origin
			g_spawns[g_spawnCount][0] = floatstr(csdmdata[0])
			g_spawns[g_spawnCount][1] = floatstr(csdmdata[1])
			g_spawns[g_spawnCount][2] = floatstr(csdmdata[2])
			
			// increase spawn count
			g_spawnCount++
			if (g_spawnCount >= sizeof g_spawns) break;
		}
		if (file) fclose(file)
	}
	else
	{
		// Collect regular spawns
		collect_spawns_ent("info_player_start")
		collect_spawns_ent("info_player_deathmatch")
	}
	
	// Collect regular spawns for non-random spawning unstuck
	collect_spawns_ent2("info_player_start")
	collect_spawns_ent2("info_player_deathmatch")
}

// Collect spawn points from entity origins
stock collect_spawns_ent(const classname[])
{
	new ent = -1
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0)
	{
		// get origin
		new Float:originF[3]
		pev(ent, pev_origin, originF)
		g_spawns[g_spawnCount][0] = originF[0]
		g_spawns[g_spawnCount][1] = originF[1]
		g_spawns[g_spawnCount][2] = originF[2]
		
		// increase spawn count
		g_spawnCount++
		if (g_spawnCount >= sizeof g_spawns) break;
	}
}

// Collect spawn points from entity origins
stock collect_spawns_ent2(const classname[])
{
	new ent = -1
	while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0)
	{
		// get origin
		new Float:originF[3]
		pev(ent, pev_origin, originF)
		g_spawns2[g_spawnCount2][0] = originF[0]
		g_spawns2[g_spawnCount2][1] = originF[1]
		g_spawns2[g_spawnCount2][2] = originF[2]
		
		// increase spawn count
		g_spawnCount2++
		if (g_spawnCount2 >= sizeof g_spawns2) break;
	}
}

// Drop primary/secondary weapons
stock drop_weapons(id, dropwhat)
{
	// Get user weapons
	static weapons[32], num, i, weaponid
	num = 0 // reset passed weapons count (bugfix)
	get_user_weapons(id, weapons, num)
	
	// Loop through them and drop primaries or secondaries
	for (i = 0; i < num; i++)
	{
		// Prevent re-indexing the array
		weaponid = weapons[i]
		
		if ((dropwhat == 1 && ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)) || (dropwhat == 2 && ((1<<weaponid) & SECONDARY_WEAPONS_BIT_SUM)))
		{
			// Get weapon entity
			static wname[32], weapon_ent
			get_weaponname(weaponid, wname, charsmax(wname))
			weapon_ent = fm_find_ent_by_owner(-1, wname, id)
			
			// Hack: store weapon bpammo on PEV_ADDITIONAL_AMMO
			set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, cs_get_user_bpammo(id, weaponid))
			
			// Player drops the weapon and looses his bpammo
			engclient_cmd(id, "drop", wname)
			cs_set_user_bpammo(id, weaponid, 0)
		}
	}
}

// Stock by (probably) Twilight Suzuka -counts number of chars in a string
stock str_count(const str[], searchchar)
{
	new count, i, len = strlen(str)
	
	for (i = 0; i <= len; i++)
	{
		if (str[i] == searchchar)
			count++
	}
	
	return count;
}

// Checks if a space is vacant (credits to VEN)
stock is_hull_vacant(Float:origin[3], hull)
{
	engfunc(EngFunc_TraceHull, origin, origin, 0, hull, 0, 0)
	
	if (!get_tr2(0, TR_StartSolid) && !get_tr2(0, TR_AllSolid) && get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Check if a player is stuck (credits to VEN)
stock is_player_stuck(id)
{
	static Float:originF[3]
	pev(id, pev_origin, originF)
	
	engfunc(EngFunc_TraceHull, originF, originF, 0, (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN, id, 0)
	
	if (get_tr2(0, TR_StartSolid) || get_tr2(0, TR_AllSolid) || !get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Simplified get_weaponid (CS only)
stock cs_weapon_name_to_id(const weapon[])
{
	static i
	for (i = 0; i < sizeof WEAPONENTNAMES; i++)
	{
		if (equal(weapon, WEAPONENTNAMES[i]))
			return i;
	}
	
	return 0;
}

// Get User Current Weapon Entity
stock fm_cs_get_current_weapon_ent(id)
{
	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}

// Get Weapon Entity's Owner
stock fm_cs_get_weapon_ent_owner(ent)
{
	return get_pdata_cbase(ent, OFFSET_WEAPONOWNER, OFFSET_LINUX_WEAPONS);
}

// Set User Deaths
stock fm_cs_set_user_deaths(id, value)
{
	set_pdata_int(id, OFFSET_CSDEATHS, value, OFFSET_LINUX)
}

// Get User Team
stock fm_cs_get_user_team(id)
{
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

// Set a Player's Team
stock fm_cs_set_user_team(id, team)
{
	set_pdata_int(id, OFFSET_CSTEAMS, team, OFFSET_LINUX)
}

// Set User Money
stock fm_cs_set_user_money(id, value)
{
	set_pdata_int(id, OFFSET_CSMONEY, value, OFFSET_LINUX)
}

// Set User Flashlight Batteries
stock fm_cs_set_user_batteries(id, value)
{
	set_pdata_int(id, OFFSET_FLASHLIGHT_BATTERY, value, OFFSET_LINUX)
}

// Update Player's Team on all clients (adding needed delays)
stock fm_user_team_update(id)
{
	static Float:current_time
	current_time = get_gametime()
	
	if (current_time - g_teams_targettime >= 0.1)
	{
		set_task(0.1, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = current_time + 0.1
	}
	else
	{
		set_task((g_teams_targettime + 0.1) - current_time, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = g_teams_targettime + 0.1
	}
}

// Send User Team Message
public fm_cs_set_user_team_msg(taskid)
{
	// Note to self: this next message can now be received by other plugins
	
	// Set the switching team flag
	g_switchingteam = true
	
	// Tell everyone my new team
	emessage_begin(MSG_ALL, g_msgid[TEAM_INFO])
	ewrite_byte(ID_TEAM) // player
	ewrite_string(CS_TEAM_NAMES[fm_cs_get_user_team(ID_TEAM)]) // team
	emessage_end()
	
	// Done switching team
	g_switchingteam = false
}

// Set the precached model index (updates hitboxes server side)
stock fm_cs_set_user_model_index(id, value)
{
	set_pdata_int(id, OFFSET_MODELINDEX, value, OFFSET_LINUX)
}

// Set Player Model on Entity
stock fm_set_playermodel_ent(id)
{
	// Make original player entity invisible without hiding shadows or firing effects
	fm_set_rendering(id, kRenderFxNone, 255, 255, 255, kRenderTransTexture, 1)
	
	// Format model string
	static model[100]
	formatex(model, charsmax(model), "models/player/%s/%s.mdl", g_playermodel[id], g_playermodel[id])
	
	// Set model on entity or make a new one if unexistant
	if (!pev_valid(g_ent_playermodel[id]))
	{
		g_ent_playermodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if (!pev_valid(g_ent_playermodel[id])) return;
		
		set_pev(g_ent_playermodel[id], pev_classname, MODEL_ENT_CLASSNAME)
		set_pev(g_ent_playermodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_playermodel[id], pev_aiment, id)
		set_pev(g_ent_playermodel[id], pev_owner, id)
	}
	
	engfunc(EngFunc_SetModel, g_ent_playermodel[id], model)
}

// Set Weapon Model on Entity
stock fm_set_weaponmodel_ent(id)
{
	// Get player's p_ weapon model
	static model[100]
	pev(id, pev_weaponmodel2, model, charsmax(model))
	
	// Set model on entity or make a new one if unexistant
	if (!pev_valid(g_ent_weaponmodel[id]))
	{
		g_ent_weaponmodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if (!pev_valid(g_ent_weaponmodel[id])) return;
		
		set_pev(g_ent_weaponmodel[id], pev_classname, WEAPON_ENT_CLASSNAME)
		set_pev(g_ent_weaponmodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_weaponmodel[id], pev_aiment, id)
		set_pev(g_ent_weaponmodel[id], pev_owner, id)
	}
	
	engfunc(EngFunc_SetModel, g_ent_weaponmodel[id], model)
}

// Remove Custom Model Entities
stock fm_remove_model_ents(id)
{
	// Remove "playermodel" ent if present
	if (pev_valid(g_ent_playermodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_playermodel[id])
		g_ent_playermodel[id] = 0
	}
	// Remove "weaponmodel" ent if present
	if (pev_valid(g_ent_weaponmodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_weaponmodel[id])
		g_ent_weaponmodel[id] = 0
	}
}

// Set User Model
public fm_cs_set_user_model(taskid)
{
	set_user_info(ID_MODEL, "model", g_playermodel[ID_MODEL])
}

// Get User Model -model passed byref-
stock fm_cs_get_user_model(player, model[], len)
{
	get_user_info(player, "model", model, len)
}

// Update Player's Model on all clients (adding needed delays)
public fm_user_model_update(taskid)
{
	static Float:current_time
	current_time = get_gametime()
	
	if (current_time - g_models_targettime >= g_modelchange_delay)
	{
		fm_cs_set_user_model(taskid)
		g_models_targettime = current_time
	}
	else
	{
		set_task((g_models_targettime + g_modelchange_delay) - current_time, "fm_cs_set_user_model", taskid)
		g_models_targettime = g_models_targettime + g_modelchange_delay
	}
}

public zp_round_started(mode, id)
{
	// Update var with Mode num
	g_Mode = mode
	
	// An unofficial mode
	if(!(1 <= mode < (sizeof(mode_names) - 1)))
	g_Mode = sizeof(mode_names) - 1
}

// Predator Powers
public turn_invisible(id) 
{
	if(g_zm_special[id] == PREDATOR)
		fm_set_rendering(id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAlpha, 20)
}

// Meun bkplayer
public menu_bkplayer(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wConfiguracoes do Jogador:", "menu_bkplayer_handler")
	
	menu_additem(menu, "\wConfiguracoes da Hud", "1", 0)
	menu_additem(menu, "\wConfiguracoes da Nightvision", "2", 0)
	menu_additem(menu, "\wCor da Lanterna", "3", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_bkplayer_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1: menu_hud_config(id)
		case 2: menu_nightvision(id)
		case 3: menu_flashlight_color(id)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public menu_hud_config(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wConfiguracoes da Hud:", "menu_hud_config_handler")
	
	menu_additem(menu, "\wMudar o Tipo de Hud", "1", 0)
	menu_additem(menu, "\wMudar a Cor da Hud \y[Humanos]", "2", 0)
	menu_additem(menu, "\wMudar a Cor da Hud \r[Zombies]", "3", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}
public menu_hud_config_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_bkplayer(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1: menu_hud_config_type(id);
		case 2: menu_hud_hm_color(id)
		case 3: menu_hud_zm_color(id)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public menu_hud_zm_color(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wCor da Hud \r[Zombies]\w:", "menu_hud_zm_color_handler")
	
	menu_additem(menu, "\wBranco", "1", 0)
	menu_additem(menu, "\wVermelho", "2", 0)
	menu_additem(menu, "\wVerde", "3", 0)
	menu_additem(menu, "\wAzul", "4", 0)
	menu_additem(menu, "\wCiano", "5", 0)
	menu_additem(menu, "\wRosa", "6", 0)
	menu_additem(menu, "\wAmarelo", "7", 0)
	menu_additem(menu, "\wLaranja", "8", 0)
	menu_additem(menu, "\wCiano Escuro", "9", 0)
	menu_additem(menu, "\wRoxo", "10", 0)

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_hud_zm_color_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_hud_config(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_hud_color[1][id] = key-1
	
	menu_destroy(menu)
	menu_hud_config(id)
	return PLUGIN_HANDLED
	
}

public menu_hud_hm_color(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wCor da Hud \y[Humano]\w:", "menu_hud_hm_color_handler")
	
	menu_additem(menu, "\wBranco", "1", 0)
	menu_additem(menu, "\wVermelho", "2", 0)
	menu_additem(menu, "\wVerde", "3", 0)
	menu_additem(menu, "\wAzul", "4", 0)
	menu_additem(menu, "\wCiano", "5", 0)
	menu_additem(menu, "\wRosa", "6", 0)
	menu_additem(menu, "\wAmarelo", "7", 0)
	menu_additem(menu, "\wLaranja", "8", 0)
	menu_additem(menu, "\wCiano Escuro", "9", 0)
	menu_additem(menu, "\wRoxo", "10", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_hud_hm_color_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_hud_config(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_hud_color[0][id] = key-1
	
	menu_destroy(menu)
	menu_hud_config(id)
	return PLUGIN_HANDLED
	
}

public menu_hud_config_type(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wTipo de Hud:", "menu_hud_config_type_handler")
	
	menu_additem(menu, "\wNormal", "1", 0)
	menu_additem(menu, "\wClassico", "2", 0)
	menu_additem(menu, "\wCentralizado", "3", 0)
	menu_additem(menu, "\wEstilo AnthRax", "4", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_hud_config_type_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_hud_config(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_hud_type[id] = key-1
	
	menu_destroy(menu)
	menu_hud_config(id)
	return PLUGIN_HANDLED
	
}

public menu_flashlight_color(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wCor da Lanterna:", "menu_flashlight_color_handler")
	
	menu_additem(menu, "\wBranco", "1", 0)
	menu_additem(menu, "\wVermelho", "2", 0)
	menu_additem(menu, "\wVerde", "3", 0)
	menu_additem(menu, "\wAzul", "4", 0)
	menu_additem(menu, "\wCiano", "5", 0)
	menu_additem(menu, "\wRosa", "6", 0)
	menu_additem(menu, "\wAmarelo", "7", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_flashlight_color_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_bkplayer(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_lantern_color[id] = key-1
	
	menu_destroy(menu)
	menu_bkplayer(id)
	return PLUGIN_HANDLED
	
}

public menu_nightvision(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wConfiguracoes da Nightvision:", "menu_nightvision_handler")
	
	menu_additem(menu, "\wCor da Nightvision \r[Zombies]", "1", 0)
	menu_additem(menu, "\wCor da Nightvision \y[Humanos]", "2", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_nightvision_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_bkplayer(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1: menu_night_zm_color(id);
		case 2: menu_night_hm_color(id)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}

public menu_night_hm_color(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wCor da Nightvision \y[Humano]\w:", "menu_night_hm_color_handler")
	
	menu_additem(menu, "\wBranco", "1", 0)
	menu_additem(menu, "\wVermelho", "2", 0)
	menu_additem(menu, "\wVerde", "3", 0)
	menu_additem(menu, "\wAzul", "4", 0)
	menu_additem(menu, "\wCiano", "5", 0)
	menu_additem(menu, "\wRosa", "6", 0)
	menu_additem(menu, "\wAmarelo", "7", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_night_hm_color_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_nightvision(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_nv_color[0][id] = key-1
	
	menu_destroy(menu)
	menu_nightvision(id)
	return PLUGIN_HANDLED
	
}

public menu_night_zm_color(id)
{
	new menu = menu_create("\r[\dBkplayer\r] \wCor da Nightvision \r[Zombie]\w:", "menu_night_zm_color_handler")
	
	menu_additem(menu, "\wBranco", "1", 0)
	menu_additem(menu, "\wVermelho", "2", 0)
	menu_additem(menu, "\wVerde", "3", 0)
	menu_additem(menu, "\wAzul", "4", 0)
	menu_additem(menu, "\wCiano", "5", 0)
	menu_additem(menu, "\wRosa", "6", 0)
	menu_additem(menu, "\wAmarelo", "7", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_night_zm_color_handler(id, menu, item)
{
	if (item == MENU_EXIT)
	{
		menu_destroy(menu)
		menu_nightvision(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	g_nv_color[1][id] = key-1
	
	menu_destroy(menu)
	menu_nightvision(id)
	return PLUGIN_HANDLED
	
}

// Carregar linha de .ini sem risco de svc_bad
stock amx_load_setting_int(const filename[], const setting_section[], setting_key[], return_value)
{
	if (strlen(filename) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty filename")
		return false;
	}
	
	if (strlen(setting_section) < 1 || strlen(setting_key) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty section/key")
		return false;
	}
	
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, filename)
	
	// File not present
	if (!file_exists(path))
		return false;
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	// File can't be opened
	if (!file)
		return false;
	
	// Set up some vars to hold parsing info
	new linedata[1024], section[64]
	
	// Seek to setting's section
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// New section starting
		if (linedata[0] == '[')
		{
			// Store section name without braces
			copyc(section, charsmax(section), linedata[1], ']')
			
			// Is this our setting's section?
			if (equal(section, setting_section))
				break;
		}
	}
	
	// Section not found
	if (!equal(section, setting_section))
	{
		fclose(file)
		return false;
	}
	
	// Set up some vars to hold parsing info
	new key[64], current_value[32]
	
	// Seek to setting's key
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		// Section ended?
		if (linedata[0] == '[')
			break;
		
		// Get key and value
		strtok(linedata, key, charsmax(key), current_value, charsmax(current_value), '=')
		
		// Trim spaces
		trim(key)
		trim(current_value)
		
		// Is this our setting's key?
		if (equal(key, setting_key))
		{
			// Return int by reference
			return_value = str_to_num(current_value)
			
			// Values succesfully retrieved
			fclose(file)
			return return_value
		}
	}
	
	// Key not found
	fclose(file)
	return false;
}

public amx_load_setting_float(const filename[], const setting_section[], setting_key[], Float:return_value)
{
	if (strlen(filename) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty filename")
		return false;
	}

	if (strlen(setting_section) < 1 || strlen(setting_key) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty section/key")
		return false;
	}
	
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, filename)
	
	// File not present
	if (!file_exists(path))
		return false;
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	// File can't be opened
	if (!file)
		return false;
	
	// Set up some vars to hold parsing info
	new linedata[1024], section[64]
	
	// Seek to setting's section
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// New section starting
		if (linedata[0] == '[')
		{
			// Store section name without braces
			copyc(section, charsmax(section), linedata[1], ']')
			
			// Is this our setting's section?
			if (equal(section, setting_section))
				break;
		}
	}
	
	// Section not found
	if (!equal(section, setting_section))
	{
		fclose(file)
		return false;
	}
	
	// Set up some vars to hold parsing info
	new key[64], current_value[32]
	
	// Seek to setting's key
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		// Section ended?
		if (linedata[0] == '[')
			break;
		
		// Get key and value
		strtok(linedata, key, charsmax(key), current_value, charsmax(current_value), '=')
		
		// Trim spaces
		trim(key)
		trim(current_value)
		
		// Is this our setting's key?
		if (equal(key, setting_key))
		{
			// Return float by reference
			return_value = str_to_float(current_value)
			
			// Values succesfully retrieved
			fclose(file)
			return true;
		}
	}
	
	// Key not found
	fclose(file)
	return false;
}

public amx_load_setting_string_arr(const filename[], const setting_section[], setting_key[], Array:array_handle)
{
	if (strlen(filename) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty filename")
		return false;
	}

	if (strlen(setting_section) < 1 || strlen(setting_key) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty section/key")
		return false;
	}
	
	if (array_handle == Invalid_Array)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Array not initialized")
		return false;
	}
	
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, filename)
	
	// File not present
	if (!file_exists(path))
		return false;
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	// File can't be opened
	if (!file)
		return false;
	
	// Set up some vars to hold parsing info
	new linedata[1024], section[64]
	
	// Seek to setting's section
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// New section starting
		if (linedata[0] == '[')
		{
			// Store section name without braces
			copyc(section, charsmax(section), linedata[1], ']')
			
			// Is this our setting's section?
			if (equal(section, setting_section))
				break;
		}
	}
	
	// Section not found
	if (!equal(section, setting_section))
	{
		fclose(file)
		return false;
	}
	
	// Set up some vars to hold parsing info
	new key[64], values[1024], current_value[128]
	
	// Seek to setting's key
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		// Section ended?
		if (linedata[0] == '[')
			break;
		
		// Get key and values
		strtok(linedata, key, charsmax(key), values, charsmax(values), '=')
		
		// Trim spaces
		trim(key)
		trim(values)
		
		// Is this our setting's key?
		if (equal(key, setting_key))
		{
			// Parse values
			while (values[0] != 0 && strtok(values, current_value, charsmax(current_value), values, charsmax(values), ','))
			{
				// Trim spaces
				trim(current_value)
				trim(values)
				
				// Add to array
				ArrayPushString(array_handle, current_value)
			}
			
			// Values succesfully retrieved
			fclose(file)
			return true;
		}
	}
	
	// Key not found
	fclose(file)
	return false;
}


public amx_load_setting_string(const filename[], const setting_section[], setting_key[], return_string[], string_size)
{
	if (strlen(filename) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty filename")
		return false;
	}

	if (strlen(setting_section) < 1 || strlen(setting_key) < 1)
	{
		log_error(AMX_ERR_NATIVE, "[ZP] Can't load settings: empty section/key")
		return false;
	}
	
	// Build customization file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, filename)
	
	// File not present
	if (!file_exists(path))
		return false;
	
	// Open customization file for reading
	new file = fopen(path, "rt")
	
	// File can't be opened
	if (!file)
		return false;
	
	// Set up some vars to hold parsing info
	new linedata[1024], section[64]
	
	// Seek to setting's section
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// New section starting
		if (linedata[0] == '[')
		{
			// Store section name without braces
			copyc(section, charsmax(section), linedata[1], ']')
			
			// Is this our setting's section?
			if (equal(section, setting_section))
				break;
		}
	}
	
	// Section not found
	if (!equal(section, setting_section))
	{
		fclose(file)
		return false;
	}
	
	// Set up some vars to hold parsing info
	new key[64], current_value[128]
	
	// Seek to setting's key
	while (!feof(file))
	{
		// Read one line at a time
		fgets(file, linedata, charsmax(linedata))
		
		// Replace newlines with a null character to prevent headaches
		replace(linedata, charsmax(linedata), "^n", "")
		
		// Blank line or comment
		if (!linedata[0] || linedata[0] == ';') continue;
		
		// Section ended?
		if (linedata[0] == '[')
			break;
		
		// Get key and value
		strtok(linedata, key, charsmax(key), current_value, charsmax(current_value), '=')
		
		// Trim spaces
		trim(key)
		trim(current_value)
		
		// Is this our setting's key?
		if (equal(key, setting_key))
		{
			formatex(return_string, string_size, "%s", current_value)
			
			// Values succesfully retrieved
			fclose(file)
			return true;
		}
	}
	
	// Key not found
	fclose(file)
	return false;
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang1046\\ f0\\ fs16 \n\\ par }
*/
