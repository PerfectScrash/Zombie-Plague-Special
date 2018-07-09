/*===========================================================================================================================
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////// ZOMBIE PLAGUE SPECIAL ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	Zombie Plague Special is a unofficial version edited in ZPA 1.6.1's core using a stable,
	improved and optimized code which avoids server crashes and reduce lag. 
	And Some modes are added like Berserker (Knifer), Predator (NightCrawler),
	Bombardier (From ZP Shade), Wesker (From Zombie Apocalipse), Spy and Dragon

	Game Play Modes:
		- Normal Modes: Simple Infection, Multiple Infection, Swarm Mode, Plague Mode, Armageddon
		- Special Modes: Nemesis, Survivor, Assassin, Sniper, Berserker, Predator, Wesker, Bombardier, Spy, Dragon
		- Custom Modes (If Enable): Assassin Vs Sniper, Nightmare
	
	Special Classes Descriptions:
		- Nemesis: Classic Zombie with more health, glow and aura
		- Survivor: Classic Human with a M249 + Unlimited clip
		- Assassin: Classic Zombie with a darkness map in your round
		- Sniper: Classic Human with a Very Strong AWP can kill a zombie with one bullet
		- Berserker: Human with samurai sword like Ninja.
		- Predator: Invisible Zombie that when takes shot he returns to be visible again for a few seconds.
		- Wesker: From Zombie Apocalipse. Human with Deagle more Damage
		- Bombardier: From Zombie Plague Shade. Zombie with infinities kill bombs
		- Spy: Human with Simmilar Predator's Habilities and More Damage with M3 Shotgun
		- Dragon: Can Fly and Unleash Fire and Ice
		
	Credits:
		- MeRcyLeZZ: for original zp version
		- ROKronoS: for idea of Bombardier Mod
		- abdul-rehman and ZPA Team: for zpa version and some special mods
		- Junin: For Spy mode Idea
		- Perfect Scrash: For Adding New Modes, fix and Optimizing Code
		
	Official Link of Mod:
		https://forums.alliedmods.net/showthread.php?t=260845
		
	Change log:
		* 1.0:
			- First Post
		* 2.0:
			- Removed Another mods (Dragon/Padre/Chuck Noris)
			- Added New Natives and Forwards
			- Fixed Bug of Of Special Zombies using zombie classes's skills
			- Optmizied code
			- Removed .ini of extra itens and zombie classes
			- Added p_  model for Special Humans
			- Added Wesker & Bombardier Mod
		* 2.0 Fix:
			- Fixed Berserker Knife Model
		* 2.1:
			- Fixed Ambiences Sounds
			- Added native zp_get_last_mode()
		* 2.2:
			- Added Spy Mode
			- Re-added Dragon Mode
			- Fixed Lang
			- Optimized code
			- Fixed Small Bug off Predator's Power when Handle Models Separate is enable
			- Fixed Predator's Glow cvar
		* 2.3:
			- Added New Natives
			- Fixed Small bug on Open zombie class after infection
			- Added Bot Suppot of Dragon Skills (Unleash Fire & Ice Only not for Fly)
			- Etc
		* 2.4:
			- Added New Natives
			- Fixed Bot Extra Item Support
			- Readded .ini for zombie classes and extra itens (This file is auto create)
			- Added Some Cvars
			- Etc.
		* 2.4.1:
			- Optimized Code
			- Added cvar "zp_choose_zclass_instantanly"
			- You can turn off the special class (Nemesis/Survivor/Sniper/Etc..) you want if you have not liked
			- Added native lost on include (zp_override_user_model)
			- Etc
		* 2.5:
			- Optimized Code
			- Added .ini file of Custom Game Modes
			- Added Bot Suppot for Bombardier Grenade
			- Etc
		* 3.0:
			- Optimized Code
			- Fixed Fog
			- Fixed Knockback
			- Added Some Natives (zp_register_human_special/zp_register_zombie_special/Etc)
			- Etc
		* 3.0 Fix:
			- Fixed Make Custom Zombie Special Menu
		* 3.1:
			- Fixed AnthRax Hud style
			- Fixed Bug of Predator and Spy not turn invisible to those who play in Software Mode
			- Fixed Choose Zombie Class instantanly
			- Fixed Some Error Logs
			- Added Native (zp_get_special_class_name)
		
		* 3.2:
			- Fixed Choose Zombie Class instantanly when frozen
			- Fixed Zombie class save when have some characters
			- Fixed zombie pain free

============================================================================================================================*/

/*================================================================================
 [Plugin Customization]
=================================================================================*/
new const ZP_CUSTOMIZATION_FILE[] = "zombie_plague_special.ini"
new const ZP_ZOMBIECLASSES_FILE[] = "zpsp_zombieclasses.ini"
new const ZP_EXTRAITEMS_FILE[] = "zpsp_extraitems.ini"
new const ZP_CUSTOM_GM_FILE[] = "zpsp_gamemodes.ini"
new const ZP_SPECIAL_CLASSES_FILE[] = "zpsp_special_classes.ini"

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
#include <engine>
#include <hamsandwich>
#include <xs>
#include <amx_settings_api>

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/
new const mode_langs[][] =
{
	"MODE_NONE",
	"MODE_INFECTION",
	"CLASS_NEMESIS", 
	"CLASS_ASSASSIN", 
	"CLASS_PREDATOR", 
	"CLASS_BOMBARDIER",
	"CLASS_DRAGON",
	"CLASS_SURVIVOR", 
	"CLASS_SNIPER", 
	"CLASS_BERSERKER", 
	"CLASS_WESKER", 
	"CLASS_SPY",
	"MODE_SWARM",
	"MODE_MULTI",
	"MODE_PLAGUE",
	"MODE_LNJ",
	"MODE_UNDEFNIED"
}
	

new const hm_special_class_langs[][] = { "CLASS_HUMAN", "CLASS_SURVIVOR", "CLASS_SNIPER", "CLASS_BERSERKER", "CLASS_WESKER", "CLASS_SPY", "NONE" }
new const zm_special_class_langs[][] = { "CLASS_ZOMBIE", "CLASS_NEMESIS", "CLASS_ASSASSIN", "CLASS_PREDATOR", "CLASS_BOMBARDIER", "CLASS_DRAGON", "NONE" }

// Access flags
enum
{
	ACCESS_ADMIN_MENU = 0,
	ACCESS_ADMIN_MENU2,
	ACCESS_ADMIN_MENU3,
	ACCESS_ADMIN_MODELS,
	ACCESS_VIP_MODELS,
	ACCESS_RESPAWN_PLAYERS,
	ACCESS_MODE_INFECTION,
	ACCESS_MODE_SWARM,
	ACCESS_MODE_MULTI,
	ACCESS_MODE_PLAGUE,
	ACCESS_MODE_LNJ,
	ACCESS_MODE_NEMESIS,
	ACCESS_MODE_SURVIVOR,
	ACCESS_MODE_SNIPER,
	ACCESS_MODE_ASSASSIN,
	ACCESS_MODE_BERSERKER,
	ACCESS_MODE_PREDATOR,
	ACCESS_MODE_WESKER,
	ACCESS_MODE_BOMBARDIER,
	ACCESS_MODE_SPY,
	ACCESS_MODE_DRAGON,	
	ACCESS_MAKE_ZOMBIE,
	ACCESS_MAKE_HUMAN,
	ACCESS_MAKE_NEMESIS,
	ACCESS_MAKE_SURVIVOR,
	ACCESS_MAKE_SNIPER,
	ACCESS_MAKE_ASSASSIN,
	ACCESS_MAKE_BERSERKER,
	ACCESS_MAKE_PREDATOR,
	ACCESS_MAKE_WESKER,
	ACCESS_MAKE_BOMBARDIER,
	ACCESS_MAKE_SPY,
	ACCESS_MAKE_DRAGON,
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
enum { EXTRA_NVISION = 0, EXTRA_ANTIDOTE, EXTRA_MADNESS, EXTRA_INFBOMB, EXTRA_WEAPONS_STARTID }

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
	MODE_DRAGON,
	MODE_SURVIVOR,
	MODE_SNIPER,
	MODE_BERSERKER,
	MODE_WESKER,
	MODE_SPY,
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
const ZP_TEAM_PREDATOR = (1<<7)
const ZP_TEAM_BERSERKER = (1<<6)    // 64
const ZP_TEAM_WESKER = (1<<8)
const ZP_TEAM_BOMBARDIER = (1<<9)
const ZP_TEAM_SPY = (1<<10)
const ZP_TEAM_DRAGON = (1<<11)
#define MAX_CLASSES 12 // Max Classes on All

new const ZP_TEAM_NAMES[MAX_CLASSES][] = { "ZOMBIE", "HUMAN", "NEMESIS", "SURVIVOR", "SNIPER", "ASSASSIN", "BERSERKER", "PREDATOR", "WESKER",
"BOMBARDIER", "SPY", "DRAGON" }

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
new Float:NADE_EXPLOSION_RADIUS

// HACK: pev_ field used to store additional ammo on weapons
const PEV_ADDITIONAL_AMMO = pev_iuser1

// HACK: pev_ field used to store custom nade types and their values
const PEV_NADE_TYPE = pev_flTimeStepSound
const NADE_TYPE_INFECTION = 1111
const NADE_TYPE_NAPALM = 2222
const NADE_TYPE_FROST = 3333
const NADE_TYPE_FLARE = 4444
const PEV_FLARE_COLOR = pev_punchangle
const PEV_FLARE_dur = pev_flSwimTime

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
	AMBIENCE_SOUNDS_SPY,
	AMBIENCE_SOUNDS_BOMBARDIER,
	AMBIENCE_SOUNDS_DRAGON,
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
	ACTION_MAKE_SPY,
	ACTION_MAKE_DRAGON,
	ACTION_RESPAWN_PLAYER
}

// Custom forward return values
const ZP_PLUGIN_HANDLED = 97
const ZP_PLUGIN_SUPERCEDE = 98

/*================================================================================
 [Global Variables]
=================================================================================*/
enum { NEMESIS = 1, ASSASSIN, PREDATOR, BOMBARDIER, DRAGON, MAX_SPECIALS_ZOMBIES }
enum { SURVIVOR = 1, SNIPER, BERSERKER, WESKER, SPY, MAX_SPECIALS_HUMANS }

new Array:g_hm_special_realname, Array:g_hm_special_name, Array:g_hm_special_model, Array:g_hm_special_modelindex, Array:g_hm_special_health, Array:g_hm_special_speed, Array:g_hm_special_uclip,
Array:g_hm_special_gravity, Array:g_hm_special_leap, Array:g_hm_special_leap_f, Array:g_hm_special_ignorefrag, Array:g_hm_special_ignoreammo, Array:g_hm_special_flags,
Array:g_hm_special_leap_h, Array:g_hm_special_leap_c, Array:g_hm_specials, Array:g_hm_special_respawn, Array:g_hm_special_painfree,
Array:g_hm_special_aurarad, Array:g_hm_special_glow, Array:g_hm_special_r, Array:g_hm_special_g, Array:g_hm_special_b
new g_hm_specials_i = MAX_SPECIALS_HUMANS

new Array:g_zm_special_realname, Array:g_zm_special_name, Array:g_zm_special_model, Array:g_zm_special_painsound, Array:g_zm_special_knifemodel, Array:g_zm_special_modelindex, Array:g_zm_special_health, Array:g_zm_special_speed, Array:g_zm_special_knockback,
Array:g_zm_special_gravity, Array:g_zm_special_leap, Array:g_zm_special_leap_f, Array:g_zm_special_ignorefrag, Array:g_zm_special_ignoreammo, Array:g_zm_special_flags,
Array:g_zm_special_leap_h, Array:g_zm_special_leap_c, Array:g_zm_specials, Array:g_zm_special_respawn, Array:g_zm_special_painfree,
Array:g_zm_special_aurarad, Array:g_zm_special_glow, Array:g_zm_special_r, Array:g_zm_special_g, Array:g_zm_special_b
new g_zm_specials_i = MAX_SPECIALS_ZOMBIES

new g_zm_special[33], g_hm_special[33] // Special Classs (Nemesis/Survivor/Sniper/Assassin/etc)
new g_hud_type[33], g_hud_color[2][33], g_lantern_color[33], g_lant_rgb[3], g_nv_color[2][33], g_nvrgb[3] // User configs Vars

// Player vars
new g_zombie[33], g_firstzombie[33], g_lastzombie[33], g_lasthuman[33], g_frozen[33], g_nodamage[33], g_respawn_as_zombie[33]
new g_nvision[33], g_nvisionenabled[33], g_zombieclass[33], g_zombieclassnext[33], g_flashlight[33], g_flashbattery[33] = { 100, ... }
new g_canbuy[33], g_ammopacks[33], g_damagedealt[33], Float:g_lastleaptime[33], Float:g_lastflashtime[33], g_playermodel[33][32], g_bot_extra_count[33]
new g_menu_data[33][6], g_ent_playermodel[33], g_ent_weaponmodel[33], g_burning_dur[33], Float:g_current_maxspeed[33], g_user_custom_speed[33]

// Game vars
new g_pluginenabled, g_newround, g_endround, g_modestarted, g_allowinfection, g_deathmatchmode, g_currentmode, g_lastmode 
new g_scorezombies, g_scorehumans, g_spawnCount, g_spawnCount2, Float:g_spawns[MAX_CSDM_SPAWNS][3], Float:g_spawns2[MAX_CSDM_SPAWNS][3] 
new g_lights_i, g_lights_cycle[32], g_lights_cycle_len, Float:g_models_targettime, Float:g_teams_targettime, g_MsgSync[3]
new g_trailSpr, g_exploSpr, g_flameSpr, g_smokeSpr, g_glassSpr, g_modname[32], g_freezetime, g_maxplayers, g_czero
new g_hamczbots, g_fwSpawn, g_fwPrecacheSound, g_infbombcounter, g_antidotecounter, g_madnesscounter, g_arrays_created
new g_lastplayerleaving, g_switchingteam, g_zm_special_enable[MAX_SPECIALS_ZOMBIES], g_hm_special_enable[MAX_SPECIALS_HUMANS]

// Message IDs vars
new g_msgScoreInfo, g_msgNVGToggle, g_msgScoreAttrib, g_msgAmmoPickup, g_msgScreenFade, g_msgDeathMsg, g_msgSetFOV, g_msgFlashlight, g_msgFlashBat, 
g_msgTeamInfo, g_msgDamage, g_msgHideWeapon, g_msgCrosshair, g_msgScreenShake, g_msgCurWeapon

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
new Array:g_gamemode_realname, Array:g_gamemode_name, Array:g_gamemode_enable, Array:g_gamemode_flag, Array:g_gamemode_chance, Array:g_gamemode_allow, Array:g_gamemode_dm, Array:g_gamemodes_new, g_gamemodes_i = MAX_GAME_MODES

// Extra Items vars
new Array:g_extraitem_realname, Array:g_extraitem_name, Array:g_extraitem_cost, Array:g_extraitem_team, g_extraitem_i, g_AdditionalMenuText[32], Array:g_extraitem_new

// Zombie Classes vars
new Array:g_zclass_real_name, Array:g_zclass_name, Array:g_zclass_info, Array:g_zclass_modelsstart, Array:g_zclass_modelsend, Array:g_zclass_playermodel, g_AdditionalMenuText2[32]
new Array:g_zclass_modelindex, Array:g_zclass_clawmodel, Array:g_zclass_hp, Array:g_zclass_spd, Array:g_zclass_grav, Array:g_zclass_kb, g_zclass_i

// For zombie classes file parsing
new Array:g_zclass2_realname, Array:g_zclass2_name, Array:g_zclass2_info, Array:g_zclass2_modelsstart, Array:g_zclass2_modelsend, Array:g_zclass2_playermodel,
Array:g_zclass2_clawmodel, Array:g_zclass2_hp, Array:g_zclass2_spd, Array:g_zclass2_grav, Array:g_zclass2_kb, Array:g_zclass_new

// Customization vars
new g_access_flag[MAX_ACCESS_FLAGS], Array:model_zm_special[MAX_SPECIALS_ZOMBIES], Array:model_human[MAX_SPECIALS_HUMANS], Array:g_modelindex_human[MAX_SPECIALS_HUMANS], Array:model_admin_zombie, Array:model_admin_human, Array:model_vip_human,
Array:g_modelindex_zm_sp[MAX_SPECIALS_ZOMBIES], g_same_models_for_all, Array:g_modelindex_admin_zombie, Array:g_modelindex_admin_human, Array:g_modelindex_vip_human,
model_vknife_zm_special[MAX_SPECIALS_ZOMBIES][64], model_v_weapon_human[MAX_SPECIALS_HUMANS][64], model_p_weapon_human[MAX_SPECIALS_HUMANS][64], model_grenade_infect[64], model_grenade_fire[64], model_grenade_frost[64], model_grenade_flare[64],
model_vknife_admin_human[64], model_pknife_admin_human[64], model_vknife_vip_human[64], model_pknife_vip_human[64], model_vknife_admin_zombie[64], sprite_grenade_trail[64], sprite_grenade_ring[64], sprite_grenade_fire[64],
sprite_grenade_smoke[64], sprite_grenade_glass[64], Array:sound_win_zombies, Array:sound_win_humans, Array:sound_win_no_one, Array:zombie_infect, Array:zombie_idle,
Array:zombie_pain[MAX_SPECIALS_ZOMBIES], Array:zombie_die, Array:zombie_fall, Array:zombie_miss_wall, Array:zombie_hit_normal, Array:zombie_hit_stab, g_ambience_rain,
Array:zombie_idle_last, Array:zombie_madness, Array:grenade_infect,
Array:grenade_infect_player, Array:grenade_fire, Array:grenade_fire_player, Array:grenade_frost, Array:grenade_frost_player, Array:grenade_frost_break, Array:grenade_flare, Array:sound_antidote, Array:sound_thunder, 
Array:g_primary_items, Array:g_secondary_items, Array:g_additional_items, Array:g_primary_weaponids, Array:g_secondary_weaponids, 
Array:g_extraweapon_names, Array:g_extraweapon_items, Array:g_extraweapon_costs, g_extra_costs2[EXTRA_WEAPONS_STARTID], g_ambience_snow, g_ambience_fog, g_fog_density[10], g_fog_color[12], g_sky_enable,
Array:g_sky_names, Array:lights_thunder, Array:zombie_decals, Array:g_objective_ents, Float:g_modelchange_delay, g_set_modelindex_offset, g_handle_models_on_separate_ent,
Float:kb_weapon_power[31] = { -1.0, ... }, Array:zombie_miss_slash, g_force_consistency, g_choosed_zclass[33],
g_ambience_sounds[MAX_AMBIENCE_SOUNDS], Array:sound_mod[MAX_GAME_MODES], Array:sound_ambience[MAX_AMBIENCE_SOUNDS], Array:sound_ambience_duration[MAX_AMBIENCE_SOUNDS]

// CVAR pointers
new cvar_lighting, cvar_zombiefov, cvar_removemoney, cvar_thunder, cvar_deathmatch, cvar_customnvg, cvar_hitzones, cvar_flashsize[2], cvar_ammodamage, cvar_zombiearmor, cvar_chosse_instantanly,
cvar_flashdrain, cvar_zombiebleeding, cvar_removedoors, cvar_customflash, cvar_randspawn, cvar_ammoinfect, cvar_toggle, cvar_knockbackpower, cvar_freezeduration, cvar_triggered, cvar_flashcharge,
cvar_firegrenades, cvar_frostgrenades, cvar_logcommands, cvar_spawnprotection, cvar_nvgsize, cvar_flareduration, cvar_zclasses, cvar_extraitems, cvar_showactivity, cvar_warmup, cvar_flashdist, cvar_flarecolor, cvar_fireduration, cvar_firedamage,
cvar_flaregrenades, cvar_knockbackducking, cvar_knockbackdamage, cvar_knockbackzvel, cvar_multiratio, cvar_flaresize[2], cvar_spawndelay, cvar_extraantidote, cvar_extramadness,
cvar_extraweapons, cvar_extranvision, cvar_nvggive, cvar_preventconsecutive, cvar_botquota, cvar_buycustom, cvar_fireslowdown, cvar_sniperfraggore, cvar_nemfraggore, cvar_humansurvive, cvar_antidote_minzms,
cvar_extrainfbomb, cvar_knockback, cvar_fragsinfect, cvar_fragskill, cvar_humanarmor, cvar_zombiesilent, cvar_removedropped, cvar_huddisplay, cvar_allow_buy_no_start,
cvar_plagueratio, cvar_blocksuicide, cvar_knockbackdist,  cvar_respawnonsuicide, cvar_respawnafterlast, cvar_statssave, cvar_adminmodelshuman, cvar_vipmodelshuman,
cvar_adminmodelszombie, cvar_blockpushables, cvar_respawnworldspawnkill, cvar_madnessduration, cvar_plaguenemnum, cvar_plaguenemhpmulti, cvar_plaguesurvhpmulti,
cvar_survweapon, cvar_plaguesurvnum, cvar_infectionscreenfade, cvar_infectionscreenshake, cvar_infectionsparkle, cvar_infectiontracers, cvar_infectionparticles, cvar_infbomblimit,
cvar_flashshowall, cvar_hudicons, cvar_startammopacks, cvar_randweapons, cvar_antidotelimit, cvar_madnesslimit, cvar_adminknifemodelshuman, cvar_vipknifemodelshuman, cvar_adminknifemodelszombie, cvar_keephealthondisconnect, 
cvar_lnjnemhpmulti, cvar_lnjsurvhpmulti,  cvar_lnjratio, cvar_lnjrespsurv, cvar_lnjrespnem , cvar_frozenhit, cvar_aiminfo, cvar_human_unstuck, cvar_bot_buyitem_interval, cvar_bot_maxitem,
cvar_mod_chance[MAX_GAME_MODES], cvar_mod_minplayers[MAX_GAME_MODES], cvar_mod_enable[MAX_GAME_MODES], cvar_mod_allow_respawn[MAX_GAME_MODES], 
cvar_leap_hm_allow[MAX_SPECIALS_HUMANS], cvar_leap_hm_cooldown[MAX_SPECIALS_HUMANS], cvar_leap_hm_force[MAX_SPECIALS_HUMANS], cvar_leap_hm_height[MAX_SPECIALS_HUMANS],
cvar_hm_basehp[MAX_SPECIALS_HUMANS], cvar_hm_spd[MAX_SPECIALS_HUMANS], cvar_hm_glow[MAX_SPECIALS_HUMANS], cvar_hm_auraradius[MAX_SPECIALS_HUMANS], cvar_hm_aura[MAX_SPECIALS_HUMANS], cvar_hm_painfree[MAX_SPECIALS_HUMANS],
cvar_hm_respawn[MAX_SPECIALS_HUMANS], cvar_hm_health[MAX_SPECIALS_HUMANS], cvar_hm_ignore_frags[MAX_SPECIALS_HUMANS], cvar_hmgravity[MAX_SPECIALS_HUMANS], cvar_hm_ignore_ammo[MAX_SPECIALS_HUMANS], cvar_hm_damage[MAX_SPECIALS_HUMANS], cvar_hm_infammo[MAX_SPECIALS_HUMANS],
cvar_leap_zm_allow[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_cooldown[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_force[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_height[MAX_SPECIALS_ZOMBIES], cvar_zm_ignore_ammo[MAX_SPECIALS_ZOMBIES],
cvar_zm_spd[MAX_SPECIALS_ZOMBIES], cvar_zm_glow[MAX_SPECIALS_ZOMBIES], cvar_zm_aura[MAX_SPECIALS_ZOMBIES], cvar_zm_auraradius, cvar_zm_painfree[MAX_SPECIALS_ZOMBIES], cvar_zm_damage[MAX_SPECIALS_ZOMBIES],
cvar_zm_respawn[MAX_SPECIALS_ZOMBIES],cvar_zm_basehp[MAX_SPECIALS_ZOMBIES], cvar_zm_health[MAX_SPECIALS_ZOMBIES], cvar_zmgravity[MAX_SPECIALS_ZOMBIES], cvar_zmsp_knockback[MAX_SPECIALS_ZOMBIES], cvar_zm_ignore_frags[MAX_SPECIALS_ZOMBIES]

new frostsprite, cvar_dragon_power_distance, cvar_dragon_power_cooldown, cvar_dragon_flyspped,  Float:gLastUseCmd[33]


// CVARS with arrays
new cvar_flashcolor[3], cvar_flashcolor2[3], cvar_hm_red[MAX_SPECIALS_HUMANS], cvar_hm_green[MAX_SPECIALS_HUMANS], cvar_hm_blue[MAX_SPECIALS_HUMANS],
cvar_zm_red[MAX_SPECIALS_ZOMBIES], cvar_zm_green[MAX_SPECIALS_ZOMBIES], cvar_zm_blue[MAX_SPECIALS_ZOMBIES]

// Cached stuff for players
new g_isconnected[33], g_isalive[33], g_isbot[33], g_currentweapon[33], g_playername[33][32], Float:g_spd[33], Float:g_custom_leap_cooldown[33], Float:g_zombie_knockback[33], g_zombie_classname[33][32]
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && g_isalive[%1])

// Cached CVARs
new g_cached_customflash, g_cached_zombiesilent,
Float:g_hm_cached_spd[MAX_SPECIALS_HUMANS], g_hm_cached_leap[MAX_SPECIALS_HUMANS], Float:g_hm_cached_cooldown[MAX_SPECIALS_HUMANS],
Float:g_zm_cached_spd[MAX_SPECIALS_ZOMBIES], g_zm_cached_leap[MAX_SPECIALS_ZOMBIES], Float:g_zm_cached_cooldown[MAX_SPECIALS_ZOMBIES]

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
	register_native("zp_get_user_dragon", "native_get_user_dragon", 1)
	register_native("zp_make_user_dragon", "native_make_user_dragon", 1)
	register_native("zp_get_user_berserker", "native_get_user_berserker", 1)
	register_native("zp_make_user_berserker", "native_make_user_berserker", 1)
	register_native("zp_get_user_wesker", "native_get_user_wesker", 1)
	register_native("zp_make_user_wesker", "native_make_user_wesker", 1)
	register_native("zp_get_user_spy", "native_get_user_spy", 1)
	register_native("zp_make_user_spy", "native_make_user_spy", 1)
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
	register_native("zp_is_dragon_round", "native_is_dragon_round", 1)
	register_native("zp_get_dragon_count", "native_get_dragon_count", 1)
	register_native("zp_is_berserker_round", "native_is_berserker_round", 1)
	register_native("zp_get_berserker_count", "native_get_berserker_count", 1)
	register_native("zp_is_wesker_round", "native_is_wesker_round", 1)
	register_native("zp_get_wesker_count", "native_get_wesker_count", 1)
	register_native("zp_is_spy_round", "native_is_spy_round", 1)
	register_native("zp_get_spy_count", "native_get_spy_count", 1)
	register_native("zp_is_lnj_round", "native_is_lnj_round", 1)
	register_native("zp_get_current_mode", "native_get_current_mode", 1)
	register_native("zp_get_last_mode", "native_get_last_mode", 1)
	
	// External additions natives
	register_native("zp_register_game_mode", "native_register_game_mode", 1)
	register_native("zp_register_extra_item", "native_register_extra_item", 1)
	register_native("zp_register_zombie_class", "native_register_zombie_class", 1)
	register_native("zp_get_extra_item_id", "native_get_extra_item_id", 1)
	register_native("zp_get_zombie_class_id", "native_get_zombie_class_id", 1)
	
	// New Natives
	register_native("zp_get_user_madness", "native_get_user_madness", 1)
	register_native("zp_set_user_madness", "native_set_user_madness", 1)
	register_native("zp_get_user_burn", "native_get_user_burn", 1)
	register_native("zp_set_user_burn", "native_set_user_burn", 1)
	register_native("zp_get_user_frozen", "native_get_user_frozen", 1)
	register_native("zp_set_user_frozen", "native_set_user_frozen", 1)
	register_native("zp_get_user_infectnade", "native_get_user_infectnade", 1)
	register_native("zp_set_user_infectnade", "native_set_user_infectnade", 1)
	register_native("zp_extra_item_textadd", "native_extra_item_textadd", 1)
	register_native("zp_zombie_class_textadd", "native_zombie_class_textadd", 1)
	register_native("zp_get_human_special_class", "native_get_human_special_class", 1)
	register_native("zp_get_zombie_special_class", "native_get_zombie_special_class", 1)
	
	// New Natives (2.3 or High Available)
	register_native("zp_set_user_rendering", "native_set_rendering", 1)
	register_native("zp_reset_user_rendering", "native_reset_user_rendering", 1)
	register_native("zp_get_extra_item_cost", "native_get_extra_item_cost", 1)
	register_native("zp_get_extra_item_name", "native_get_extra_item_name")
	register_native("zp_set_user_maxspeed", "native_set_user_maxspeed", 1)
	register_native("zp_get_user_maxspeed", "native_get_user_maxspeed", 1)
	register_native("zp_reset_user_maxspeed", "native_reset_user_maxspeed", 1)
	
	// New Natives (2.4 or High Available)
	register_native("zp_set_extra_damage", "native_set_extra_damage", 1)
	register_native("zp_set_extra_item_team", "native_set_extra_item_team", 1)
	register_native("zp_set_extra_item_cost", "native_set_extra_item_cost", 1)
	register_native("zp_set_extra_item_name", "native_set_extra_item_name", 1)
	register_native("zp_get_zombie_class_info", "native_get_zombie_class_info")
	register_native("zp_get_zombie_class_name", "native_get_zombie_class_name")
	register_native("zp_set_zombie_class_info", "native_set_zombie_class_info", 1)
	register_native("zp_set_zombie_class_name", "native_set_zombie_class_name", 1)
	register_native("zp_has_round_ended", "native_has_round_ended", 1)
	register_native("zp_get_extra_item_realname", "native_get_extra_item_realname")
	register_native("zp_get_current_mode_name", "native_get_current_mode_name")
	
	// New Natives (3.0 or High Available)
	register_native("zp_register_human_special", "native_register_human_special", 1)
	register_native("zp_register_zombie_special", "native_register_zombie_special", 1)
	register_native("zp_make_user_special", "native_make_user_special", 1)
	register_native("zp_set_custom_game_mod", "native_set_custom_game_mod", 1)
	register_native("zp_get_special_count", "native_get_special_count", 1)
	register_native("zp_reset_player_model", "native_reset_player_model", 1)
	
	// New Natives (3.1 or High Available)
	register_native("zp_get_special_class_name", "native_special_class_name")
}
	
public plugin_precache()
{
	// Register earlier to show up in plugins list properly after plugin disable/error at loading
	register_plugin("Zombie Plague Special", "3.0", "MeRcyLeZZ | @bdul! | [P]erfect [S]crash")
	
	// To switch plugin on/off
	cvar_toggle = register_cvar("zp_on", "1")
	
	// Plugin disabled?
	if(!get_pcvar_num(cvar_toggle)) return;
	g_pluginenabled = true
	
	new i, x, buffer[150]
	
	// Initialize a few dynamically sized arrays (alright, maybe more than just a few...)
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++) {
		model_human[i] = ArrayCreate(32, 1)
		g_modelindex_human[i] = ArrayCreate(1, 1)
	}
	
	for(i = 0; i < MAX_SPECIALS_ZOMBIES; i++) {
		zombie_pain[i] = ArrayCreate(64, 1)
		if(i > 0) {
			model_zm_special[i] = ArrayCreate(32, 1)
			g_modelindex_zm_sp[i] = ArrayCreate(1, 1)
		}
	}
	for(i = 0; i < MAX_AMBIENCE_SOUNDS; i++) {
		sound_ambience[i] = ArrayCreate(64, 1)
		sound_ambience_duration[i] = ArrayCreate(64, 1)
	}
	for(i = 2; i < MAX_GAME_MODES; i++) {
		sound_mod[i] = ArrayCreate(64, 1)
	}

	model_admin_human = ArrayCreate(32, 1)
	model_vip_human = ArrayCreate(32, 1)
	model_admin_zombie = ArrayCreate(32, 1)
	g_modelindex_admin_human = ArrayCreate(1, 1)
	g_modelindex_vip_human = ArrayCreate(1, 1)
	g_modelindex_admin_zombie = ArrayCreate(1, 1)
	sound_win_zombies = ArrayCreate(64, 1)
	sound_win_humans = ArrayCreate(64, 1)
	sound_win_no_one = ArrayCreate(64, 1)
	zombie_infect = ArrayCreate(64, 1)
	zombie_die = ArrayCreate(64, 1)
	zombie_fall = ArrayCreate(64, 1)
	zombie_miss_slash = ArrayCreate(64, 1)
	zombie_miss_wall = ArrayCreate(64, 1)
	zombie_hit_normal = ArrayCreate(64, 1)
	zombie_hit_stab = ArrayCreate(64, 1)
	zombie_idle = ArrayCreate(64, 1)
	zombie_idle_last = ArrayCreate(64, 1)
	zombie_madness = ArrayCreate(64, 1)
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
	g_gamemode_realname = ArrayCreate(32, 1)
	g_gamemode_name = ArrayCreate(32, 1)
	g_gamemode_flag = ArrayCreate(1, 1)
	g_gamemode_chance = ArrayCreate(1, 1)
	g_gamemode_allow = ArrayCreate(1, 1)
	g_gamemode_dm = ArrayCreate(1, 1)
	g_gamemode_enable = ArrayCreate(1, 1)
	g_gamemodes_new = ArrayCreate(1, 1)
	g_extraitem_name = ArrayCreate(32, 1)
	g_extraitem_realname = ArrayCreate(32, 1)
	g_extraitem_cost = ArrayCreate(1, 1)
	g_extraitem_team = ArrayCreate(1, 1)
	g_extraitem_new = ArrayCreate(1, 1)
	g_zclass_real_name = ArrayCreate(32, 1)
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
	g_hm_special_realname = ArrayCreate(32, 1)
	g_hm_special_name = ArrayCreate(32, 1)
	g_hm_special_model = ArrayCreate(32, 1)
	g_hm_special_modelindex = ArrayCreate(1, 1)
	g_hm_special_health = ArrayCreate(1, 1)
	g_hm_special_speed = ArrayCreate(1, 1)
	g_hm_special_gravity = ArrayCreate(1, 1)
	g_hm_special_flags = ArrayCreate(1, 1)
	g_hm_special_leap = ArrayCreate(1, 1)
	g_hm_special_leap_f = ArrayCreate(1, 1)
	g_hm_special_leap_h = ArrayCreate(1, 1)
	g_hm_special_leap_c = ArrayCreate(1, 1)
	g_hm_special_uclip = ArrayCreate(1, 1)
	g_hm_special_ignorefrag = ArrayCreate(1, 1)
	g_hm_special_ignoreammo = ArrayCreate(1, 1)
	g_hm_special_respawn = ArrayCreate(1, 1)
	g_hm_special_painfree = ArrayCreate(1, 1)
	g_hm_special_aurarad = ArrayCreate(1, 1)
	g_hm_special_glow = ArrayCreate(1, 1)
	g_hm_special_r = ArrayCreate(1, 1)
	g_hm_special_g = ArrayCreate(1, 1)
	g_hm_special_b = ArrayCreate(1, 1)
	g_hm_specials = ArrayCreate(1, 1)
	g_zm_special_realname = ArrayCreate(32, 1)
	g_zm_special_name = ArrayCreate(32, 1)
	g_zm_special_model = ArrayCreate(32, 1)
	g_zm_special_knifemodel = ArrayCreate(64, 1)
	g_zm_special_painsound = ArrayCreate(64, 1)
	g_zm_special_modelindex = ArrayCreate(1, 1)
	g_zm_special_health = ArrayCreate(1, 1)
	g_zm_special_speed = ArrayCreate(1, 1)
	g_zm_special_gravity = ArrayCreate(1, 1)
	g_zm_special_flags = ArrayCreate(1, 1)
	g_zm_special_leap = ArrayCreate(1, 1)
	g_zm_special_leap_f = ArrayCreate(1, 1)
	g_zm_special_leap_h = ArrayCreate(1, 1)
	g_zm_special_leap_c = ArrayCreate(1, 1)
	g_zm_special_knockback = ArrayCreate(1, 1)
	g_zm_special_ignorefrag = ArrayCreate(1, 1)
	g_zm_special_ignoreammo = ArrayCreate(1, 1)
	g_zm_special_respawn = ArrayCreate(1, 1)
	g_zm_special_painfree = ArrayCreate(1, 1)
	g_zm_special_aurarad = ArrayCreate(1, 1)
	g_zm_special_glow = ArrayCreate(1, 1)
	g_zm_special_r = ArrayCreate(1, 1)
	g_zm_special_g = ArrayCreate(1, 1)
	g_zm_special_b = ArrayCreate(1, 1)
	g_zm_specials = ArrayCreate(1, 1)
	
	// Allow registering stuff now
	g_arrays_created = true
	
	// Load customization data
	load_customization_from_files()
	
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
	
	new tmodel_buffer[150]
	
	// Custom player models
	for (i = 0; i < ArraySize(model_admin_zombie); i++)
	{
		ArrayGetString(model_admin_zombie, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_admin_zombie, engfunc(EngFunc_PrecacheModel, buffer))
		if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", buffer, buffer)
		if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
	}
	for (i = 0; i < ArraySize(model_admin_human); i++)
	{
		ArrayGetString(model_admin_human, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_admin_human, engfunc(EngFunc_PrecacheModel, buffer))
		if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", buffer, buffer)
		if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
	}
	for (i = 0; i < ArraySize(model_vip_human); i++)
	{
		ArrayGetString(model_vip_human, i, buffer, charsmax(buffer))
		format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
		ArrayPushCell(g_modelindex_vip_human, engfunc(EngFunc_PrecacheModel, buffer))
		if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
		if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
		formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", buffer, buffer)
		if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
	}

	for (x = 1; x < MAX_SPECIALS_ZOMBIES; x++)
	{
		if(g_zm_special_enable[x]) {
			for (i = 0; i < ArraySize(model_zm_special[x]); i++)
			{
				ArrayGetString(model_zm_special[x], i, buffer, charsmax(buffer))
				format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
				ArrayPushCell(g_modelindex_zm_sp[x], engfunc(EngFunc_PrecacheModel, buffer))
				if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
				if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
				formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", buffer, buffer)
				if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
			}
			engfunc(EngFunc_PrecacheModel, model_vknife_zm_special[x])
			if(x == DRAGON) frostsprite = engfunc(EngFunc_PrecacheModel, "sprites/frost_explode.spr")
		}
	}
	for (x = 0; x < MAX_SPECIALS_HUMANS; x++)
	{
		if(g_hm_special_enable[x] || x == 0) {
			for (i = 0; i < ArraySize(model_human[x]); i++)
			{
				ArrayGetString(model_human[x], i, buffer, charsmax(buffer))
				format(buffer, charsmax(buffer), "models/player/%s/%s.mdl", buffer, buffer)
				ArrayPushCell(g_modelindex_human[x], engfunc(EngFunc_PrecacheModel, buffer))
				if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, buffer)
				if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, buffer)
				formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", buffer, buffer)
				if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
			}
			engfunc(EngFunc_PrecacheModel, model_v_weapon_human[x])
			engfunc(EngFunc_PrecacheModel, model_p_weapon_human[x])
		}
	}

	// Custom weapon models
	engfunc(EngFunc_PrecacheModel, model_grenade_infect)
	engfunc(EngFunc_PrecacheModel, model_grenade_fire)
	engfunc(EngFunc_PrecacheModel, model_grenade_frost)
	engfunc(EngFunc_PrecacheModel, model_grenade_flare)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_human)
	engfunc(EngFunc_PrecacheModel, model_pknife_admin_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_vip_human)
	engfunc(EngFunc_PrecacheModel, model_pknife_vip_human)
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_zombie)
	
	
	// Custom sprites for grenades
	g_trailSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_trail)
	g_exploSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_ring)
	g_flameSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_fire)
	g_smokeSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_smoke)
	g_glassSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_glass)
	
	
	// Custom sounds
	for (i = 0; i < ArraySize(sound_win_zombies); i++) {
		ArrayGetString(sound_win_zombies, i, buffer, charsmax(buffer))
		precache_ambience(buffer)
	}
	for (i = 0; i < ArraySize(sound_win_humans); i++) {
		ArrayGetString(sound_win_humans, i, buffer, charsmax(buffer))
		precache_ambience(buffer)
	}
	for (i = 0; i < ArraySize(sound_win_no_one); i++) {
		ArrayGetString(sound_win_no_one, i, buffer, charsmax(buffer))
		precache_ambience(buffer)
	}
	for (i = 0; i < ArraySize(zombie_infect); i++) {
		ArrayGetString(zombie_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	
	for(x = 0; x < MAX_SPECIALS_ZOMBIES; x++) {
		if(g_zm_special_enable[x] || x == 0) {
			for (i = 0; i < ArraySize(zombie_pain[x]); i++) {
				ArrayGetString(zombie_pain[x], i, buffer, charsmax(buffer))
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	for (i = 0; i < ArraySize(zombie_die); i++) {
		ArrayGetString(zombie_die, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_fall); i++) {
		ArrayGetString(zombie_fall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_slash); i++) {
		ArrayGetString(zombie_miss_slash, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_miss_wall); i++) {
		ArrayGetString(zombie_miss_wall, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_normal); i++) {
		ArrayGetString(zombie_hit_normal, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_hit_stab); i++) {
		ArrayGetString(zombie_hit_stab, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle); i++) {
		ArrayGetString(zombie_idle, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_idle_last); i++) {
		ArrayGetString(zombie_idle_last, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(zombie_madness); i++) {
		ArrayGetString(zombie_madness, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for(x = 2; x < MAX_GAME_MODES; x++) {
		for (i = 0; i < ArraySize(sound_mod[x]); i++) {
			ArrayGetString(sound_mod[x], i, buffer, charsmax(buffer))
			precache_ambience(buffer)
		}
	}
	for (i = 0; i < ArraySize(grenade_infect); i++) {
		ArrayGetString(grenade_infect, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_infect_player); i++) {
		ArrayGetString(grenade_infect_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire); i++) {
		ArrayGetString(grenade_fire, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_fire_player); i++) {
		ArrayGetString(grenade_fire_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost); i++) {
		ArrayGetString(grenade_frost, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_player); i++) {
		ArrayGetString(grenade_frost_player, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_frost_break); i++) {
		ArrayGetString(grenade_frost_break, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(grenade_flare); i++) {
		ArrayGetString(grenade_flare, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_antidote); i++) {
		ArrayGetString(sound_antidote, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}
	for (i = 0; i < ArraySize(sound_thunder); i++) {
		ArrayGetString(sound_thunder, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer)
	}

	// Ambience Sounds
	for(x = 0; x < MAX_AMBIENCE_SOUNDS; x++) {
		if(g_ambience_sounds[x]) {
			for (i = 0; i < ArraySize(sound_ambience[x]); i++) {
				ArrayGetString(sound_ambience[x], i, buffer, charsmax(buffer))
				precache_ambience(buffer)
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
	if(pev_valid(ent))
	{
		engfunc(EngFunc_SetOrigin, ent, Float:{8192.0,8192.0,8192.0})
		dllfunc(DLLFunc_Spawn, ent)
	}
	
	// Weather/ambience effects
	if(g_ambience_fog)
	{
		ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_fog"))
		if(pev_valid(ent))
		{
			fm_set_kvd(ent, "density", g_fog_density, "env_fog")
			fm_set_kvd(ent, "rendercolor", g_fog_color, "env_fog")
		}
	}
	if(g_ambience_rain) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_rain"))
	if(g_ambience_snow) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_snow"))
	
	// Prevent some entities from spawning
	g_fwSpawn = register_forward(FM_Spawn, "fw_Spawn")
	
	// Prevent hostage sounds from being precached
	g_fwPrecacheSound = register_forward(FM_PrecacheSound, "fw_PrecacheSound")
}

public plugin_init()
{
	// Plugin disabled?
	if(!g_pluginenabled) return;
	
	// No zombie classes?
	if(!g_zclass_i) set_fail_state("No zombie classes loaded!")
	
	// Print the number of registered Game Modes (if any)
	if(g_gamemodes_i > MAX_GAME_MODES)
		server_print("[ZP] Total Registered Custom Game Modes: %d", g_gamemodes_i - MAX_GAME_MODES)
	
	if(g_hm_specials_i >= MAX_SPECIALS_HUMANS)
		server_print("[ZP] Total Registered Custom Special Humans: %d", g_hm_specials_i - MAX_SPECIALS_HUMANS)
	
	if(g_zm_specials_i >= MAX_SPECIALS_ZOMBIES)
		server_print("[ZP] Total Registered Custom Special Zombies: %d", g_zm_specials_i - MAX_SPECIALS_ZOMBIES)
	
	// Print the number of registered Zombie Classes
	server_print("[ZP] Total Registered Zombie Classes: %d", g_zclass_i)
	
	// Print the number of registered Extra Items
	server_print("[ZP] Total Registered Extra Items: %d", g_extraitem_i)
	
	// Language files
	register_dictionary("zombie_plague_special.txt")
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_event("StatusValue", "event_show_status", "be", "1=2", "2!0")
	register_event("StatusValue", "event_hide_status", "be", "1=1", "2=0")
	register_logevent("logevent_round_start",2, "1=Round_Start")
	register_logevent("logevent_round_end", 2, "1=Round_End")
	register_event("AmmoX", "event_ammo_x", "be")

	for (new i = 0; i < MAX_AMBIENCE_SOUNDS; i++) if(g_ambience_sounds[i]) register_event("30", "event_intermission", "a")
	
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
		if(WEAPONENTNAMES[i][0]) RegisterHam(Ham_Item_Deploy, WEAPONENTNAMES[i], "fw_Item_Deploy_Post", 1)
	
	// FM Forwards
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect")
	register_forward(FM_ClientDisconnect, "fw_ClientDisconnect_Post", 1)
	register_forward(FM_ClientKill, "fw_ClientKill")
	register_forward(FM_EmitSound, "fw_EmitSound")
	if(!g_handle_models_on_separate_ent) register_forward(FM_SetClientKeyValue, "fw_SetClientKeyValue")
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
	register_concmd("zp_spy", "cmd_spy", _, "<target> - Turn someone into a Spy", 0)
	register_concmd("zp_dragon", "cmd_dragon", _, "<target> - Turn someone into an Dragon", 0)
	register_concmd("zp_lnj", "cmd_lnj", _, " - Start Apocalypse Mode", 0)
	
	// Message IDs
	g_msgScoreInfo = get_user_msgid("ScoreInfo")
	g_msgTeamInfo = get_user_msgid("TeamInfo")
	g_msgDeathMsg = get_user_msgid("DeathMsg")
	g_msgScoreAttrib = get_user_msgid("ScoreAttrib")
	g_msgSetFOV = get_user_msgid("SetFOV")
	g_msgScreenFade = get_user_msgid("ScreenFade")
	g_msgScreenShake = get_user_msgid("ScreenShake")
	g_msgNVGToggle = get_user_msgid("NVGToggle")
	g_msgFlashlight = get_user_msgid("Flashlight")
	g_msgFlashBat = get_user_msgid("FlashBat")
	g_msgAmmoPickup = get_user_msgid("AmmoPickup")
	g_msgDamage = get_user_msgid("Damage")
	g_msgHideWeapon = get_user_msgid("HideWeapon")
	g_msgCrosshair = get_user_msgid("Crosshair")
	g_msgCurWeapon = get_user_msgid("CurWeapon")
	
	// Message hooks
	register_message(g_msgCurWeapon, "message_cur_weapon")
	register_message(get_user_msgid("Money"), "message_money")
	register_message(get_user_msgid("Health"), "message_health")
	register_message(get_user_msgid("Battery"), "message_armor")
	register_message(g_msgFlashBat, "message_flashbat")
	register_message(g_msgScreenFade, "message_screenfade")
	register_message(g_msgNVGToggle, "message_nvgtoggle")
	if(g_handle_models_on_separate_ent) register_message(get_user_msgid("ClCorpse"), "message_clcorpse")
	register_message(get_user_msgid("WeapPickup"), "message_weappickup")
	register_message(g_msgAmmoPickup, "message_ammopickup")
	register_message(get_user_msgid("Scenario"), "message_scenario")
	register_message(get_user_msgid("HostagePos"), "message_hostagepos")
	register_message(get_user_msgid("TextMsg"), "message_textmsg")
	register_message(get_user_msgid("SendAudio"), "message_sendaudio")
	register_message(get_user_msgid("TeamScore"), "message_teamscore")
	register_message(g_msgTeamInfo, "message_teaminfo")

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
	cvar_human_unstuck = register_cvar("zp_allow_human_unstuck", "1")
	cvar_bot_maxitem = register_cvar("zp_bot_max_extra_for_round", "5")
	cvar_bot_buyitem_interval = register_cvar("zp_bot_buy_extra_interval", "20.0")
	cvar_huddisplay = register_cvar("zp_hud_display", "1")
	cvar_allow_buy_no_start = register_cvar("zp_allow_buy_extra_before_start", "1")
	cvar_chosse_instantanly = register_cvar("zp_choose_zclass_instantanly", "1")
	
	// CVARS - Deathmatch
	cvar_deathmatch = register_cvar("zp_deathmatch", "0")
	cvar_spawndelay = register_cvar("zp_spawn_delay", "5")
	cvar_spawnprotection = register_cvar("zp_spawn_protection", "5")
	cvar_respawnonsuicide = register_cvar("zp_respawn_on_suicide", "0")
	cvar_respawnafterlast = register_cvar("zp_respawn_after_last_human", "1")
	cvar_mod_allow_respawn[MODE_INFECTION] = register_cvar("zp_infection_allow_respawn", "1")
	cvar_mod_allow_respawn[MODE_NEMESIS] = register_cvar("zp_nem_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SURVIVOR] = register_cvar("zp_surv_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SWARM] = register_cvar("zp_swarm_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_PLAGUE] = register_cvar("zp_plague_allow_respawn", "0")
	cvar_zm_respawn[0] = register_cvar("zp_respawn_zombies", "1")
	cvar_hm_respawn[0] = register_cvar("zp_respawn_humans", "1")
	cvar_zm_respawn[NEMESIS] = register_cvar("zp_respawn_nemesis", "1")
	cvar_hm_respawn[SURVIVOR] = register_cvar("zp_respawn_survivors", "1")
	cvar_mod_allow_respawn[MODE_SNIPER] = register_cvar("zp_sniper_allow_respawn", "0")
	cvar_hm_respawn[SNIPER] = register_cvar("zp_respawn_snipers", "1")
	cvar_mod_allow_respawn[MODE_ASSASSIN] = register_cvar("zp_assassin_allow_respawn", "0")
	cvar_zm_respawn[ASSASSIN] = register_cvar("zp_respawn_assassins", "1")
	cvar_mod_allow_respawn[MODE_PREDATOR] = register_cvar("zp_predator_allow_respawn", "0")
	cvar_zm_respawn[PREDATOR] = register_cvar("zp_respawn_predators", "1")
	cvar_mod_allow_respawn[MODE_BOMBARDIER] = register_cvar("zp_bombardier_allow_respawn", "0")
	cvar_zm_respawn[BOMBARDIER] = register_cvar("zp_respawn_bombardiers", "1")
	cvar_mod_allow_respawn[MODE_DRAGON] = register_cvar("zp_dragon_allow_respawn", "0")
	cvar_zm_respawn[DRAGON] = register_cvar("zp_respawn_dragons", "1")
	cvar_mod_allow_respawn[MODE_BERSERKER] = register_cvar("zp_berserker_allow_respawn", "0")
	cvar_hm_respawn[BERSERKER] = register_cvar("zp_respawn_berserkers", "1")
	cvar_mod_allow_respawn[MODE_WESKER] = register_cvar("zp_wesker_allow_respawn", "0")
	cvar_hm_respawn[WESKER] = register_cvar("zp_respawn_weskers", "1")
	cvar_mod_allow_respawn[MODE_SPY] = register_cvar("zp_spy_allow_respawn", "0")
	cvar_hm_respawn[SPY] = register_cvar("zp_respawn_spys", "1")
	cvar_mod_allow_respawn[MODE_LNJ] = register_cvar("zp_lnj_allow_respawn", "0")
	cvar_lnjrespsurv = register_cvar("zp_lnj_respawn_surv", "0")
	cvar_lnjrespnem= register_cvar("zp_lnj_respawn_nem", "0")
	
	// CVARS - Extra Items
	cvar_extraitems = register_cvar("zp_extra_items", "1")
	cvar_extraweapons = register_cvar("zp_extra_weapons", "1")
	cvar_extranvision = register_cvar("zp_extra_nvision", "1")
	cvar_extraantidote = register_cvar("zp_extra_antidote", "1")
	cvar_antidotelimit = register_cvar("zp_extra_antidote_limit", "999")
	cvar_extramadness = register_cvar("zp_extra_madness", "1")
	cvar_madnesslimit = register_cvar("zp_extra_madness_limit", "999")
	cvar_madnessduration = register_cvar("zp_extra_madness_dur", "5.0")
	cvar_extrainfbomb = register_cvar("zp_extra_infbomb", "1")
	cvar_infbomblimit = register_cvar("zp_extra_infbomb_limit", "999")
	cvar_antidote_minzms = register_cvar("zp_extra_antidote_min_zms", "5")

	
	// CVARS - Flashlight and Nightvision
	cvar_nvggive = register_cvar("zp_nvg_give", "1")
	cvar_customnvg = register_cvar("zp_nvg_custom", "1")
	cvar_nvgsize = register_cvar("zp_nvg_size", "80")
	cvar_zm_red[0] = register_cvar("zp_zombie_madness_color_R", "255")
	cvar_zm_green[0] = register_cvar("zp_zombie_madness_color_G", "0")
	cvar_zm_blue[0] = register_cvar("zp_zombie_madness_color_B", "0")
	cvar_zm_red[NEMESIS] = register_cvar("zp_nem_color_R", "150")
	cvar_zm_green[NEMESIS] = register_cvar("zp_nem_color_G", "0")
	cvar_zm_blue[NEMESIS] = register_cvar("zp_nem_color_B", "0")
	cvar_zm_red[ASSASSIN] = register_cvar("zp_assassin_color_R", "250")
	cvar_zm_green[ASSASSIN] = register_cvar("zp_assassin_color_G", "250")
	cvar_zm_blue[ASSASSIN] = register_cvar("zp_assassin_color_B", "0")
	cvar_zm_red[PREDATOR] = register_cvar("zp_predator_color_R", "250")
	cvar_zm_green[PREDATOR] = register_cvar("zp_predator_color_G", "250")
	cvar_zm_blue[PREDATOR] = register_cvar("zp_predator_color_B", "250")
	cvar_zm_red[BOMBARDIER] = register_cvar("zp_bombardier_color_R", "0")
	cvar_zm_green[BOMBARDIER] = register_cvar("zp_bombardier_color_G", "250")
	cvar_zm_blue[BOMBARDIER] = register_cvar("zp_bombardier_color_B", "0")
	cvar_zm_red[DRAGON] = register_cvar("zp_dragon_color_R", "255")
	cvar_zm_green[DRAGON] = register_cvar("zp_dragon_color_G", "69")
	cvar_zm_blue[DRAGON] = register_cvar("zp_dragon_color_B", "0")
	cvar_customflash = register_cvar("zp_flash_custom", "0")
	cvar_flashsize[0] = register_cvar("zp_flash_size", "10")
	cvar_flashsize[1] = register_cvar("zp_flash_size_assassin", "7")
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
	cvar_zmsp_knockback[NEMESIS] = register_cvar("zp_knockback_nemesis", "0.25")
	cvar_zmsp_knockback[ASSASSIN] = register_cvar("zp_knockback_assassin", "0.25")
	cvar_zmsp_knockback[PREDATOR] = register_cvar("zp_knockback_predator", "0.25")
	cvar_zmsp_knockback[BOMBARDIER] = register_cvar("zp_knockback_bombardier", "0.25")
	cvar_zmsp_knockback[DRAGON] = register_cvar("zp_knockback_dragon", "0.25")
	
	// CVARS - Leap
	cvar_leap_zm_allow[0] = register_cvar("zp_leap_zombies", "0")
	cvar_leap_zm_force[0] = register_cvar("zp_leap_zombies_force", "500")
	cvar_leap_zm_height[0] = register_cvar("zp_leap_zombies_height", "300")
	cvar_leap_zm_cooldown[0] = register_cvar("zp_leap_zombies_cooldown", "5.0")
	cvar_leap_zm_allow[NEMESIS] = register_cvar("zp_leap_nemesis", "1")
	cvar_leap_zm_force[NEMESIS] = register_cvar("zp_leap_nemesis_force", "500")
	cvar_leap_zm_height[NEMESIS] = register_cvar("zp_leap_nemesis_height", "300")
	cvar_leap_zm_cooldown[NEMESIS] = register_cvar("zp_leap_nemesis_cooldown", "5.0")
	cvar_leap_hm_allow[SURVIVOR] = register_cvar("zp_leap_survivor", "0")
	cvar_leap_hm_force[SURVIVOR] = register_cvar("zp_leap_survivor_force", "500")
	cvar_leap_hm_height[SURVIVOR] = register_cvar("zp_leap_survivor_height", "300")
	cvar_leap_hm_cooldown[SURVIVOR] = register_cvar("zp_leap_survivor_cooldown", "5.0")
	cvar_leap_hm_allow[SNIPER] = register_cvar("zp_leap_sniper", "0")
	cvar_leap_hm_force[SNIPER] = register_cvar("zp_leap_sniper_force", "500")
	cvar_leap_hm_height[SNIPER] = register_cvar("zp_leap_sniper_height", "300")
	cvar_leap_hm_cooldown[SNIPER] = register_cvar("zp_leap_sniper_cooldown", "5.0")
	cvar_leap_zm_allow[ASSASSIN] = register_cvar("zp_leap_assassin", "0")
	cvar_leap_zm_force[ASSASSIN] = register_cvar("zp_leap_assassin_force", "500")
	cvar_leap_zm_height[ASSASSIN] = register_cvar("zp_leap_assassin_height", "300")
	cvar_leap_zm_cooldown[ASSASSIN] = register_cvar("zp_leap_assassin_cooldown", "5.0")
	cvar_leap_zm_allow[PREDATOR] = register_cvar("zp_leap_predator", "0")
	cvar_leap_zm_force[PREDATOR] = register_cvar("zp_leap_predator_force", "500")
	cvar_leap_zm_height[PREDATOR] = register_cvar("zp_leap_predator_height", "300")
	cvar_leap_zm_cooldown[PREDATOR] = register_cvar("zp_leap_predator_cooldown", "5.0")
	cvar_leap_zm_allow[BOMBARDIER] = register_cvar("zp_leap_bombardier", "0")
	cvar_leap_zm_force[BOMBARDIER] = register_cvar("zp_leap_bombardier_force", "500")
	cvar_leap_zm_height[BOMBARDIER] = register_cvar("zp_leap_bombardier_height", "300")
	cvar_leap_zm_cooldown[BOMBARDIER] = register_cvar("zp_leap_bombardier_cooldown", "5.0")
	cvar_leap_zm_allow[DRAGON] = register_cvar("zp_leap_dragon", "0")
	cvar_leap_zm_force[DRAGON] = register_cvar("zp_leap_dragon_force", "500")
	cvar_leap_zm_height[DRAGON] = register_cvar("zp_leap_dragon_height", "300")
	cvar_leap_zm_cooldown[DRAGON] = register_cvar("zp_leap_dragon_cooldown", "5.0")
	cvar_leap_hm_allow[BERSERKER] = register_cvar("zp_leap_berserker", "0")
	cvar_leap_hm_force[BERSERKER] = register_cvar("zp_leap_berserker_force", "500")
	cvar_leap_hm_height[BERSERKER] = register_cvar("zp_leap_berserker_height", "300")
	cvar_leap_hm_cooldown[BERSERKER] = register_cvar("zp_leap_berserker_cooldown", "5.0")
	cvar_leap_hm_allow[WESKER] = register_cvar("zp_leap_wesker", "0")
	cvar_leap_hm_force[WESKER] = register_cvar("zp_leap_wesker_force", "500")
	cvar_leap_hm_height[WESKER] = register_cvar("zp_leap_wesker_height", "300")
	cvar_leap_hm_cooldown[WESKER] = register_cvar("zp_leap_wesker_cooldown", "5.0")
	cvar_leap_hm_allow[SPY] = register_cvar("zp_leap_spy", "0")
	cvar_leap_hm_force[SPY] = register_cvar("zp_leap_spy_force", "500")
	cvar_leap_hm_height[SPY] = register_cvar("zp_leap_spy_height", "300")
	cvar_leap_hm_cooldown[SPY] = register_cvar("zp_leap_spy_cooldown", "5.0")
	
	// CVARS - Humans
	cvar_hm_health[0] = register_cvar("zp_human_health", "100")
	cvar_hm_basehp[0] = register_cvar("zp_human_last_extrahp", "0")
	cvar_hm_spd[0] = register_cvar("zp_human_speed", "240")
	cvar_hmgravity[0] = register_cvar("zp_human_gravity", "1.0")
	cvar_humanarmor = register_cvar("zp_human_armor_protect", "1")
	cvar_hm_infammo[0] = register_cvar("zp_human_unlimited_ammo", "0")
	cvar_ammodamage = register_cvar("zp_human_damage_reward", "500")
	cvar_fragskill = register_cvar("zp_human_frags_for_kill", "1")
	
	// CVARS - Custom Grenades
	cvar_firegrenades = register_cvar("zp_fire_grenades", "1")
	cvar_fireduration = register_cvar("zp_fire_dur", "10")
	cvar_firedamage = register_cvar("zp_fire_damage", "5")
	cvar_fireslowdown = register_cvar("zp_fire_slowdown", "0.5")
	cvar_frostgrenades = register_cvar("zp_frost_grenades", "1")
	cvar_freezeduration = register_cvar("zp_frost_dur", "3")
	cvar_frozenhit = register_cvar("zp_frost_hit", "1")
	cvar_flaregrenades = register_cvar("zp_flare_grenades","1")
	cvar_flareduration = register_cvar("zp_flare_dur", "60")
	cvar_flaresize[0] = register_cvar("zp_flare_size", "25")
	cvar_flarecolor = register_cvar("zp_flare_color", "5")
	cvar_flaresize[1] = register_cvar("zp_flare_size_assassin", "15")
	
	// CVARS - Zombies
	cvar_zm_health[0] = register_cvar("zp_zombie_first_hp", "2.0")
	cvar_zombiearmor = register_cvar("zp_zombie_armor", "0.75")
	cvar_hitzones = register_cvar("zp_zombie_hitzones", "0")
	cvar_zm_basehp[0] = register_cvar("zp_zombie_infect_health", "100")
	cvar_zombiefov = register_cvar("zp_zombie_fov", "110")
	cvar_zombiesilent = register_cvar("zp_zombie_silent", "1")
	cvar_zm_painfree[0] = register_cvar("zp_zombie_painfree", "2")
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
	cvar_zm_auraradius = register_cvar("zp_zombies_aura_size", "21")
	
	// CVARS - Nemesis
	cvar_mod_enable[MODE_NEMESIS] = register_cvar("zp_nem_enabled", "1")
	cvar_mod_chance[MODE_NEMESIS] = register_cvar("zp_nem_chance", "20")
	cvar_mod_minplayers[MODE_NEMESIS] = register_cvar("zp_nem_min_players", "0")
	cvar_zm_health[NEMESIS] = register_cvar("zp_nem_health", "0")
	cvar_zm_basehp[NEMESIS] = register_cvar("zp_nem_base_health", "0")
	cvar_zm_spd[NEMESIS] = register_cvar("zp_nem_speed", "250")
	cvar_zmgravity[NEMESIS] = register_cvar("zp_nem_gravity", "0.5")
	cvar_zm_damage[NEMESIS] = register_cvar("zp_nem_damage", "250")
	cvar_zm_glow[NEMESIS] = register_cvar("zp_nem_glow", "1")
	cvar_zm_aura[NEMESIS] = register_cvar("zp_nem_aura", "1")	
	cvar_zm_painfree[NEMESIS] = register_cvar("zp_nem_painfree", "0")
	cvar_zm_ignore_frags[NEMESIS] = register_cvar("zp_nem_ignore_frags", "1")
	cvar_zm_ignore_ammo[NEMESIS] = register_cvar("zp_nem_ignore_rewards", "1")
	
	// CVARS - Survivor
	cvar_mod_enable[MODE_SURVIVOR] = register_cvar("zp_surv_enabled", "1")
	cvar_mod_chance[MODE_SURVIVOR] = register_cvar("zp_surv_chance", "20")
	cvar_mod_minplayers[MODE_SURVIVOR] = register_cvar("zp_surv_min_players", "0")
	cvar_hm_health[SURVIVOR] = register_cvar("zp_surv_health", "0")
	cvar_hm_basehp[SURVIVOR] = register_cvar("zp_surv_base_health", "0")
	cvar_hm_spd[SURVIVOR] = register_cvar("zp_surv_speed", "230")
	cvar_hmgravity[SURVIVOR] = register_cvar("zp_surv_gravity", "1.25")
	cvar_hm_glow[SURVIVOR] = register_cvar("zp_surv_glow", "1")
	cvar_hm_aura[SURVIVOR] = register_cvar("zp_surv_aura", "1")
	cvar_hm_damage[SURVIVOR] = register_cvar("zp_surv_damage_mult", "3.0")
	cvar_hm_red[SURVIVOR] = register_cvar("zp_surv_aura_R", "0")
	cvar_hm_green[SURVIVOR] = register_cvar("zp_surv_aura_G", "250")
	cvar_hm_blue[SURVIVOR] = register_cvar("zp_surv_aura_B", "250")
	cvar_hm_painfree[SURVIVOR] = register_cvar("zp_surv_painfree", "1")
	cvar_hm_ignore_frags[SURVIVOR] = register_cvar("zp_surv_ignore_frags", "1")
	cvar_hm_ignore_ammo[SURVIVOR] = register_cvar("zp_surv_ignore_rewards", "1")
	cvar_survweapon = register_cvar("zp_surv_weapon", "weapon_m249")
	cvar_hm_infammo[SURVIVOR] = register_cvar("zp_surv_unlimited_ammo", "2")
	cvar_hm_auraradius[SURVIVOR] =  register_cvar("zp_surv_aura_size", "35")

	
	// CVARS - Swarm Mode
	cvar_mod_enable[MODE_SWARM] = register_cvar("zp_swarm_enabled", "1")
	cvar_mod_chance[MODE_SWARM] = register_cvar("zp_swarm_chance", "20")
	cvar_mod_minplayers[MODE_SWARM] = register_cvar("zp_swarm_min_players", "0")
	
	// CVARS - Multi Infection
	cvar_mod_enable[MODE_MULTI] = register_cvar("zp_multi_enabled", "1")
	cvar_mod_chance[MODE_MULTI] = register_cvar("zp_multi_chance", "20")
	cvar_mod_minplayers[MODE_MULTI] = register_cvar("zp_multi_min_players", "0")
	cvar_multiratio = register_cvar("zp_multi_ratio", "0.15")
	
	// CVARS - Plague Mode
	cvar_mod_enable[MODE_PLAGUE] = register_cvar("zp_plague_enabled", "1")
	cvar_mod_chance[MODE_PLAGUE] = register_cvar("zp_plague_chance", "30")
	cvar_mod_minplayers[MODE_PLAGUE] = register_cvar("zp_plague_min_players", "0")
	cvar_plagueratio = register_cvar("zp_plague_ratio", "0.5")
	cvar_plaguenemnum = register_cvar("zp_plague_nem_number", "1")
	cvar_plaguenemhpmulti = register_cvar("zp_plague_nem_hp_multi", "0.5")
	cvar_plaguesurvnum = register_cvar("zp_plague_surv_number", "1")
	cvar_plaguesurvhpmulti = register_cvar("zp_plague_surv_hp_multi", "0.5")
	
	// CVARS - Sniper
	cvar_mod_enable[MODE_SNIPER] = register_cvar("zp_sniper_enabled", "1")
	cvar_mod_chance[MODE_SNIPER] = register_cvar("zp_sniper_chance", "20")
	cvar_mod_minplayers[MODE_SNIPER] = register_cvar("zp_sniper_min_players", "0")
	cvar_hm_health[SNIPER] = register_cvar("zp_sniper_health", "0")
	cvar_hm_basehp[SNIPER] = register_cvar("zp_sniper_base_health", "0")
	cvar_hm_spd[SNIPER] = register_cvar("zp_sniper_speed", "230")
	cvar_hmgravity[SNIPER] = register_cvar("zp_sniper_gravity", "0.75")
	cvar_hm_glow[SNIPER] = register_cvar("zp_sniper_glow", "1")
	cvar_hm_aura[SNIPER] = register_cvar("zp_sniper_aura", "1")
	cvar_hm_painfree[SNIPER] = register_cvar("zp_sniper_painfree", "1")
	cvar_hm_ignore_frags[SNIPER] = register_cvar("zp_sniper_ignore_frags", "1")
	cvar_hm_ignore_ammo[SNIPER] = register_cvar("zp_sniper_ignore_rewards", "1")
	cvar_hm_damage[SNIPER] = register_cvar("zp_sniper_damage", "5000.0")
	cvar_hm_infammo[SNIPER] = register_cvar("zp_sniper_unlimited_ammo", "2")
	cvar_hm_auraradius[SNIPER] = register_cvar("zp_sniper_aura_size", "25")
	cvar_hm_red[SNIPER] = register_cvar("zp_sniper_aura_color_R", "200")
	cvar_hm_green[SNIPER] = register_cvar("zp_sniper_aura_color_G", "200")
	cvar_hm_blue[SNIPER] = register_cvar("zp_sniper_aura_color_B", "0")
	
	// CVARS - Assassin
	cvar_mod_enable[MODE_ASSASSIN] = register_cvar("zp_assassin_enabled", "1")
	cvar_mod_chance[MODE_ASSASSIN] = register_cvar("zp_assassin_chance", "20")
	cvar_mod_minplayers[MODE_ASSASSIN] = register_cvar("zp_assassin_min_players", "0")
	cvar_zm_health[ASSASSIN] = register_cvar("zp_assassin_health", "0")
	cvar_zm_basehp[ASSASSIN] = register_cvar("zp_assassin_base_health", "0")
	cvar_zm_spd[ASSASSIN] = register_cvar("zp_assassin_speed", "250")
	cvar_zmgravity[ASSASSIN] = register_cvar("zp_assassin_gravity", "0.5")
	cvar_zm_damage[ASSASSIN] = register_cvar("zp_assassin_damage", "250")
	cvar_zm_glow[ASSASSIN] = register_cvar("zp_assassin_glow", "1")
	cvar_zm_aura[ASSASSIN] = register_cvar("zp_assassin_aura", "1")	
	cvar_zm_painfree[ASSASSIN] = register_cvar("zp_assassin_painfree", "0")
	cvar_zm_ignore_frags[ASSASSIN] = register_cvar("zp_assassin_ignore_frags", "1")
	cvar_zm_ignore_ammo[ASSASSIN] = register_cvar("zp_assassin_ignore_rewards", "1")
	
	// CVARS - Predator
	cvar_mod_enable[MODE_PREDATOR] = register_cvar("zp_predator_enabled", "1")
	cvar_mod_chance[MODE_PREDATOR] = register_cvar("zp_predator_chance", "20")
	cvar_mod_minplayers[MODE_PREDATOR] = register_cvar("zp_predator_min_players", "0")
	cvar_zm_health[PREDATOR] = register_cvar("zp_predator_health", "0")
	cvar_zm_basehp[PREDATOR] = register_cvar("zp_predator_base_health", "0")
	cvar_zm_spd[PREDATOR] = register_cvar("zp_predator_speed", "250")
	cvar_zmgravity[PREDATOR] = register_cvar("zp_predator_gravity", "0.5")
	cvar_zm_damage[PREDATOR] = register_cvar("zp_predator_damage", "250")
	cvar_zm_glow[PREDATOR] = register_cvar("zp_predator_glow", "0")
	cvar_zm_aura[PREDATOR] = register_cvar("zp_predator_aura", "0")	
	cvar_zm_painfree[PREDATOR] = register_cvar("zp_predator_painfree", "0")
	cvar_zm_ignore_frags[PREDATOR] = register_cvar("zp_predator_ignore_frags", "1")
	cvar_zm_ignore_ammo[PREDATOR] = register_cvar("zp_predator_ignore_rewards", "1")
	
	// CVARS - Bombardier
	cvar_mod_enable[MODE_BOMBARDIER] = register_cvar("zp_bombardier_enabled", "1")
	cvar_mod_chance[MODE_BOMBARDIER] = register_cvar("zp_bombardier_chance", "20")
	cvar_mod_minplayers[MODE_BOMBARDIER] = register_cvar("zp_bombardier_min_players", "0")
	cvar_zm_health[BOMBARDIER] = register_cvar("zp_bombardier_health", "0")
	cvar_zm_basehp[BOMBARDIER] = register_cvar("zp_bombardier_base_health", "0")
	cvar_zm_spd[BOMBARDIER] = register_cvar("zp_bombardier_speed", "250")
	cvar_zmgravity[BOMBARDIER] = register_cvar("zp_bombardier_gravity", "0.5")
	cvar_zm_damage[BOMBARDIER] = register_cvar("zp_bombardier_damage", "250")
	cvar_zm_glow[BOMBARDIER] = register_cvar("zp_bombardier_glow", "1")
	cvar_zm_aura[BOMBARDIER] = register_cvar("zp_bombardier_aura", "1")	
	cvar_zm_painfree[BOMBARDIER] = register_cvar("zp_bombardier_painfree", "0")
	cvar_zm_ignore_frags[BOMBARDIER] = register_cvar("zp_bombardier_ignore_frags", "1")
	cvar_zm_ignore_ammo[BOMBARDIER] = register_cvar("zp_bombardier_ignore_rewards", "1")
	
	// CVARS - Dragon
	cvar_mod_enable[MODE_DRAGON] = register_cvar("zp_dragon_enabled", "1")
	cvar_mod_chance[MODE_DRAGON] = register_cvar("zp_dragon_chance", "20")
	cvar_mod_minplayers[MODE_DRAGON] = register_cvar("zp_dragon_min_players", "0")
	cvar_zm_health[DRAGON] = register_cvar("zp_dragon_health", "0")
	cvar_zm_basehp[DRAGON] = register_cvar("zp_dragon_base_health", "0")
	cvar_zm_spd[DRAGON] = register_cvar("zp_dragon_speed", "250")
	cvar_zmgravity[DRAGON] = register_cvar("zp_dragon_gravity", "0.5")
	cvar_zm_damage[DRAGON] = register_cvar("zp_dragon_damage", "250")
	cvar_zm_glow[DRAGON] = register_cvar("zp_dragon_glow", "1")
	cvar_zm_aura[DRAGON] = register_cvar("zp_dragon_aura", "1")	
	cvar_zm_painfree[DRAGON] = register_cvar("zp_dragon_painfree", "0")
	cvar_zm_ignore_frags[DRAGON] = register_cvar("zp_dragon_ignore_frags", "1")
	cvar_zm_ignore_ammo[DRAGON] = register_cvar("zp_dragon_ignore_rewards", "1")
	cvar_dragon_flyspped = register_cvar("zp_dragon_fly_speed", "300")
	cvar_dragon_power_distance = register_cvar("zp_dragon_power_distance", "1000")
	cvar_dragon_power_cooldown = register_cvar("zp_dragon_power_cooldown", "10.0")

	// CVARS - Berserker
	cvar_mod_enable[MODE_BERSERKER] = register_cvar("zp_berserker_enabled", "1")
	cvar_mod_chance[MODE_BERSERKER] = register_cvar("zp_berserker_chance", "20")
	cvar_mod_minplayers[MODE_BERSERKER] = register_cvar("zp_berserker_min_players", "0")
	cvar_hm_health[BERSERKER] = register_cvar("zp_berserker_health", "0")
	cvar_hm_basehp[BERSERKER] = register_cvar("zp_berserker_base_health", "0")
	cvar_hm_spd[BERSERKER] = register_cvar("zp_berserker_speed", "230")
	cvar_hmgravity[BERSERKER] = register_cvar("zp_berserker_gravity", "0.75")
	cvar_hm_glow[BERSERKER] = register_cvar("zp_berserker_glow", "1")
	cvar_hm_aura[BERSERKER] = register_cvar("zp_berserker_aura", "1")
	cvar_hm_painfree[BERSERKER] = register_cvar("zp_berserker_painfree", "1")
	cvar_hm_ignore_frags[BERSERKER] = register_cvar("zp_berserker_ignore_frags", "1")
	cvar_hm_ignore_ammo[BERSERKER] = register_cvar("zp_berserker_ignore_rewards", "1")
	cvar_hm_damage[BERSERKER] = register_cvar("zp_berserker_damage", "5000.0")
	cvar_hm_auraradius[BERSERKER] = register_cvar("zp_berserker_aura_size", "25")
	cvar_hm_red[BERSERKER] = register_cvar("zp_berserker_aura_color_R", "200")
	cvar_hm_green[BERSERKER] = register_cvar("zp_berserker_aura_color_G", "200")
	cvar_hm_blue[BERSERKER] = register_cvar("zp_berserker_aura_color_B", "0")	
	
	// CVARS - Wesker
	cvar_mod_enable[MODE_WESKER] = register_cvar("zp_wesker_enabled", "1")
	cvar_mod_chance[MODE_WESKER] = register_cvar("zp_wesker_chance", "20")
	cvar_mod_minplayers[MODE_WESKER] = register_cvar("zp_wesker_min_players", "0")
	cvar_hm_health[WESKER] = register_cvar("zp_wesker_health", "0")
	cvar_hm_basehp[WESKER] = register_cvar("zp_wesker_base_health", "0")
	cvar_hm_spd[WESKER] = register_cvar("zp_wesker_speed", "230")
	cvar_hmgravity[WESKER] = register_cvar("zp_wesker_gravity", "0.75")
	cvar_hm_glow[WESKER] = register_cvar("zp_wesker_glow", "1")
	cvar_hm_aura[WESKER] = register_cvar("zp_wesker_aura", "1")
	cvar_hm_painfree[WESKER] = register_cvar("zp_wesker_painfree", "1")
	cvar_hm_ignore_frags[WESKER] = register_cvar("zp_wesker_ignore_frags", "1")
	cvar_hm_ignore_ammo[WESKER] = register_cvar("zp_wesker_ignore_rewards", "1")
	cvar_hm_damage[WESKER] = register_cvar("zp_wesker_damage_multi", "6.0")
	cvar_hm_auraradius[WESKER] = register_cvar("zp_wesker_aura_size", "25")
	cvar_hm_infammo[WESKER] = register_cvar("zp_wesker_unlimited_ammo", "2")
	cvar_hm_red[WESKER] = register_cvar("zp_wesker_aura_color_R", "200")
	cvar_hm_green[WESKER] = register_cvar("zp_wesker_aura_color_G", "200")
	cvar_hm_blue[WESKER] = register_cvar("zp_wesker_aura_color_B", "0")	
	
	// CVARS - Spy
	cvar_mod_enable[MODE_SPY] = register_cvar("zp_spy_enabled", "1")
	cvar_mod_chance[MODE_SPY] = register_cvar("zp_spy_chance", "20")
	cvar_mod_minplayers[MODE_SPY] = register_cvar("zp_spy_min_players", "0")
	cvar_hm_health[SPY] = register_cvar("zp_spy_health", "0")
	cvar_hm_basehp[SPY] = register_cvar("zp_spy_base_health", "0")
	cvar_hm_spd[SPY] = register_cvar("zp_spy_speed", "230")
	cvar_hmgravity[SPY] = register_cvar("zp_spy_gravity", "0.75")
	cvar_hm_glow[SPY] = register_cvar("zp_spy_glow", "0")
	cvar_hm_aura[SPY] = register_cvar("zp_spy_aura", "1")
	cvar_hm_painfree[SPY] = register_cvar("zp_spy_painfree", "1")
	cvar_hm_ignore_frags[SPY] = register_cvar("zp_spy_ignore_frags", "1")
	cvar_hm_ignore_ammo[SPY] = register_cvar("zp_spy_ignore_rewards", "1")
	cvar_hm_damage[SPY] = register_cvar("zp_spy_damage_multi", "6.0")
	cvar_hm_auraradius[SPY] = register_cvar("zp_spy_aura_size", "15")
	cvar_hm_infammo[SPY] = register_cvar("zp_spy_unlimited_ammo", "2")
	cvar_hm_red[SPY] = register_cvar("zp_spy_aura_color_R", "0")
	cvar_hm_green[SPY] = register_cvar("zp_spy_aura_color_G", "0")
	cvar_hm_blue[SPY] = register_cvar("zp_spy_aura_color_B", "250")

	// CVARS - LNJ Mode
	cvar_mod_enable[MODE_LNJ] = register_cvar("zp_lnj_enabled", "1")
	cvar_mod_chance[MODE_LNJ] = register_cvar("zp_lnj_chance", "30")
	cvar_mod_minplayers[MODE_LNJ] = register_cvar("zp_lnj_min_players", "0")
	cvar_lnjnemhpmulti = register_cvar("zp_lnj_nem_hp_multi", "2.0")
	cvar_lnjsurvhpmulti = register_cvar("zp_lnj_surv_hp_multi", "4.0")
	cvar_lnjratio = register_cvar("zp_lnj_ratio", "0.5")
	
	// CVARS - Others
	cvar_logcommands = register_cvar("zp_logcommands", "1")
	cvar_showactivity = get_cvar_pointer("amx_show_activity")
	cvar_botquota = get_cvar_pointer("bot_quota")
	register_cvar("zombie_plague_special", "3.2", FCVAR_SERVER|FCVAR_SPONLY)
	set_cvar_string("zombie_plague_special", "3.2")
	
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
	if(g_sky_enable)
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
	
	// Get Max Players
	g_maxplayers = get_maxplayers()
	
	// Reserved saving slots starts on maxplayers+1
	db_slot_i = g_maxplayers+1
	
	// Check if it's a CZ server
	new mymod[6]
	get_modname(mymod, charsmax(mymod))
	if(equal(mymod, "czero")) g_czero = 1
}

public plugin_cfg()
{
	// Plugin disabled?
	if(!g_pluginenabled) return;
	
	// Get configs dir
	new cfgdir[32]
	get_configsdir(cfgdir, charsmax(cfgdir))
	
	// Execute config file (zombie_plague_special.cfg)
	server_cmd("exec %s/zombie_plague_special.cfg", cfgdir)
	
	// Prevent any more stuff from registering
	g_arrays_created = false
	
	// Save customization data
	save_customization()
	
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
	
	// Freezetime begins
	g_freezetime = true
	
	// Show welcome message and T-Virus notice
	remove_task(TASK_WELCOMEMSG)
	set_task(2.0, "welcome_msg", TASK_WELCOMEMSG)
	
	// Set a new "Make Zombie Task"
	remove_task(TASK_MAKEZOMBIE)
	set_task(2.0 + get_pcvar_float(cvar_warmup), "make_zombie_task", TASK_MAKEZOMBIE)
	
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
	if(current_time - lastendtime < 0.5) return;
	lastendtime = current_time
	
	if(get_pcvar_num(cvar_chosse_instantanly)) {
		for(new i = 1; i <= g_maxplayers; i++) 
			g_choosed_zclass[i] = false
	}

	// Temporarily save player stats?
	if(get_pcvar_num(cvar_statssave))
	{
		static id, team
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not connected
			if(!g_isconnected[id])
				continue;
			
			team = fm_cs_get_user_team(id)
			
			// Not playing
			if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
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
	if(!fnGetZombies())
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
	else if(!fnGetHumans())
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
	else if(get_pcvar_num(cvar_humansurvive))
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
	if(g_zombie[id] || g_hm_special[id] == BERSERKER)
		return;
	
	// Get ammo type
	static type
	type = read_data(1)
	
	// Unknown ammo type
	if(type >= sizeof AMMOWEAPON)
		return;
	
	// Get weapon's id
	static weapon
	weapon = AMMOWEAPON[type]
	
	// Primary and secondary only
	if(MAXBPAMMO[weapon] <= 2)
		return;
	
	// Get ammo amount
	static amount
	amount = read_data(2)
	
	static update
	update = false

	if(g_hm_special[id] < MAX_SPECIALS_HUMANS) {
		if(get_pcvar_num(cvar_hm_infammo[g_hm_special[id]])) {
			update = true
		}
		else update = false
	}
	else {
		if(ArrayGetCell(g_hm_special_uclip, g_hm_special[id]-MAX_SPECIALS_HUMANS) > 0) {
			update = true
		}
		else update = false
	}
	
	// Unlimited BP Ammo?
	if(update)
	{
		if(amount < MAXBPAMMO[weapon])
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
	if(g_isbot[id] && amount <= BUYAMMO[weapon]) {
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
	if(!pev_valid(entity)) return FMRES_IGNORED;
	
	// Get classname
	new classname[32], objective[32], size = ArraySize(g_objective_ents)
	pev(entity, pev_classname, classname, charsmax(classname))
	
	// Check whether it needs to be removed
	for (new i = 0; i < size; i++) {
		ArrayGetString(g_objective_ents, i, objective, charsmax(objective))
		if(equal(classname, objective)) {
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
	if(equal(sound, "hostage", 7))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Ham Player Spawn Post Forward
public fw_PlayerSpawn_Post(id)
{
	// Not alive or didn't join a team yet
	if(!is_user_alive(id) || !fm_cs_get_user_team(id))
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
	if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id)
	
	// Hide money?
	if(get_pcvar_num(cvar_removemoney))
		set_task(0.4, "task_hide_money", id+TASK_SPAWN)
	
	// Respawn player if he dies because of a worldspawn kill?
	if(get_pcvar_num(cvar_respawnworldspawnkill))
		set_task(2.0, "respawn_player_task", id+TASK_SPAWN)
	
	// Check whether to transform the player before spawning
	if(!g_newround)
	{
		// Respawn as a zombie ?
		if(g_respawn_as_zombie[id])
		{
			// Reset player vars
			reset_vars(id, 0)
			
			// Respawn as a nemesis on LNJ round ?
			if(g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespnem))
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
			if(g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespsurv))
			{
				// Make him survivor right away
				humanme(id, SURVIVOR, 0)
				
				// Apply the survivor health multiplier
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti)))
			}
		}
		
		// Execute our player spawn post forward
		if(g_zombie[id] || g_hm_special[id] == SURVIVOR)
		{
			ExecuteForward(g_forwards[PLAYER_SPAWN_POST], g_fwDummyResult, id);
			return;
		}
	}
	
	// Reset player vars
	reset_vars(id, 0)
	
	// Show custom buy menu?
	if(get_pcvar_num(cvar_buycustom))
		set_task(0.2, "show_menu_buy1", id+TASK_SPAWN)
	
	// Set health and gravity
	fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]))
	set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[0]))
	
	// Switch to CT if spawning mid-round
	if(!g_newround && fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	reset_player_models(id)
	reset_user_rendering(id)
	
	// Bots stuff
	if(g_isbot[id])
	{
		// Turn off NVG for bots
		cs_set_user_nvg(id, 0)
		
		// Automatically buy extra items/weapons after first zombie is chosen
		if(get_pcvar_num(cvar_extraitems) && get_pcvar_num(cvar_bot_maxitem) > 0) {
			g_bot_extra_count[id] = 0
			set_task(get_pcvar_float(cvar_bot_buyitem_interval) + g_newround ? get_pcvar_float(cvar_warmup) : 0.0, "bot_buy_extras", id+TASK_SPAWN)
		}
	}
	
	// Enable spawn protection for humans spawning mid-round
	if(!g_newround && get_pcvar_float(cvar_spawnprotection) > 0.0)
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
	if(g_cached_customflash)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	
	// Replace weapon models (bugfix)
	static weapon_ent; weapon_ent = fm_cs_get_current_weapon_ent(id)
	if(pev_valid(weapon_ent)) replace_weapon_models(id, cs_get_weapon_id(weapon_ent))
	
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
	if(get_pcvar_num(cvar_nvggive) == 0 && g_nvision[victim])
	{
		if(get_pcvar_num(cvar_customnvg)) remove_task(victim+TASK_NVISION)
		else if(g_nvisionenabled[victim]) set_user_gnvision(victim, 0)
		g_nvision[victim] = false
		g_nvisionenabled[victim] = false
	}
	
	// Turn off nightvision when killed (bugfix)
	if(get_pcvar_num(cvar_nvggive) == 2 && g_nvision[victim] && g_nvisionenabled[victim])
	{
		if(get_pcvar_num(cvar_customnvg)) remove_task(victim+TASK_NVISION)
		else set_user_gnvision(victim, 0)
		g_nvisionenabled[victim] = false
	}
	
	// Turn off custom flashlight when killed
	if(g_cached_customflash)
	{
		// Turn it off
		g_flashlight[victim] = false
		g_flashbattery[victim] = 100
		
		// Remove previous tasks
		remove_task(victim+TASK_CHARGE)
		remove_task(victim+TASK_FLASH)
	}
	
	// Stop bleeding/burning/aura when killed
	if(g_zombie[victim] || g_hm_special[victim] > 0)
	{
		remove_task(victim+TASK_BLOOD)
		remove_task(victim+TASK_AURA)
		remove_task(victim+TASK_BURN)
	}
	
	if(is_user_valid_connected(attacker)) {
		// Nemesis and Assassin explode! or when killed by a Assassin victim is cut in pieces
		if(g_zm_special[victim] > 0 || g_zm_special[attacker] == ASSASSIN && get_pcvar_num(cvar_nemfraggore))
			SetHamParamInteger(3, 2)
	}
	
	// Get deathmatch mode status and whether the player killed himself
	static selfkill
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false
	
	// Make sure that the player was not killed by a non-player entity or through self killing
	if(!selfkill)
	{
		// Ignore Nemesis/Survivor/Sniper/Berserker Frags?
		if(g_zombie[attacker] && g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES) {
			if(get_pcvar_num(cvar_zm_ignore_frags[g_zm_special[attacker]]))
				RemoveFrags(attacker, victim)
		}
		else if(g_zombie[attacker] && g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_ignorefrag, g_zm_special[attacker]-MAX_SPECIALS_ZOMBIES) > 0)
				RemoveFrags(attacker, victim)
		}
		
		if(!g_zombie[attacker] && g_hm_special[attacker] > 0 && g_hm_special[attacker] < MAX_SPECIALS_HUMANS) {
			if(get_pcvar_num(cvar_hm_ignore_frags[g_hm_special[attacker]]))
				RemoveFrags(attacker, victim)
		}
		else if(!g_zombie[attacker] && g_hm_special[attacker] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_ignorefrag, g_hm_special[attacker]-MAX_SPECIALS_HUMANS))
				RemoveFrags(attacker, victim)
		}
				
		// Zombie/nemesis/assassin killed human, reward ammo packs
		if(g_zombie[attacker] && g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES) {
			if(!get_pcvar_num(cvar_zm_ignore_ammo[g_zm_special[attacker]]))
				g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
		}
		else if(g_zombie[attacker] && g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_ignoreammo, g_zm_special[attacker]-MAX_SPECIALS_ZOMBIES) <= 0)
				g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
		}
	
		// Human killed zombie, add up the extra frags for kill
		if(!g_zombie[attacker] && get_pcvar_num(cvar_fragskill) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragskill) - 1, 0, 0)
		
		// Zombie killed human, add up the extra frags for kill
		if(g_zombie[attacker] && get_pcvar_num(cvar_fragsinfect) > 1)
			UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragsinfect) - 1, 0, 0)
			
		// When killed by a Sniper victim explodes
		if(g_hm_special[attacker] == SNIPER && (g_currentweapon[attacker] == CSW_AWP) && get_pcvar_num(cvar_sniperfraggore) && g_zombie[victim])
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
	if(get_pcvar_num(cvar_deathmatch) || ((g_currentmode > MODE_LNJ) && (g_deathmatchmode > 0)))
	{
		// Respawn on suicide?
		if(selfkill && !get_pcvar_num(cvar_respawnonsuicide))
			return;
		
		// Respawn if only the last human is left?
		if(!get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() <= 1)
			return;
		
		// Respawn if human/zombie/nemesis/assassin/survivor/sniper/berserker/wesker/spy/dragon?
		if(!g_zombie[victim] && g_hm_special[victim] < MAX_SPECIALS_HUMANS) {
			if(!get_pcvar_num(cvar_hm_respawn[g_hm_special[victim]]))
				return;
		}
		else if(!g_zombie[victim] && g_hm_special[victim] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_respawn, g_hm_special[victim]-MAX_SPECIALS_HUMANS) <= 0)
				return;
		}
		
		if(g_zombie[victim] && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) {
			if(!get_pcvar_num(cvar_zm_respawn[g_zm_special[victim]]))
				return;
		}
		else if(!g_zombie[victim] && g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_respawn, g_zm_special[victim]-MAX_SPECIALS_ZOMBIES) <= 0)
				return;
		}
		
		// Respawn as zombie?
		if((g_currentmode > MODE_LNJ) && (g_deathmatchmode > 0)) // Custom round ?
		{
			if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
				g_respawn_as_zombie[victim] = true
		}
		else if(get_pcvar_num(cvar_deathmatch) > 0) // Normal round
		{
			if(get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
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
	if(victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if(g_newround || g_endround || g_currentmode == MODE_NONE)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if(g_nodamage[victim] || (g_frozen[victim] && !(get_pcvar_num(cvar_frozenhit))))
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if(is_user_alive(attacker) && fm_cs_get_user_team(attacker) == fm_cs_get_user_team(victim))
		return HAM_SUPERCEDE;
	
	// Attacker is human...
	if(!g_zombie[attacker])
	{
		switch(g_hm_special[attacker])
		{
			case SURVIVOR: if(g_currentweapon[attacker] == CSW_M249) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[SURVIVOR]))
			case SNIPER: if(g_currentweapon[attacker] == CSW_AWP) SetHamParamFloat(4, get_pcvar_float(cvar_hm_damage[SNIPER]))
			case BERSERKER: if(g_currentweapon[attacker] == CSW_KNIFE) SetHamParamFloat(4, get_pcvar_float(cvar_hm_damage[BERSERKER]))
			case WESKER: if(g_currentweapon[attacker] == CSW_DEAGLE) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[WESKER]))
			case SPY: if(g_currentweapon[attacker] == CSW_M3) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[SPY]))
		}
		
		// Armor multiplier for the final damage on normal zombies
		if(g_zm_special[attacker] <= 0 && g_hm_special[attacker] <= 0)
		{
			damage *= get_pcvar_float(cvar_zombiearmor)
			SetHamParamFloat(4, damage)
		}
		
		if(g_zm_special[victim] == PREDATOR)
		{
			if(get_pcvar_num(cvar_zm_glow[PREDATOR])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 250, 250, 250, kRenderNormal, 15)
			else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 15)
			set_task(1.0, "turn_invisible", victim)
		}
		
		
		// Reward ammo packs
		if(g_zombie[attacker] && g_hm_special[attacker] > 0 && g_hm_special[attacker] < MAX_SPECIALS_HUMANS) {
			if(!get_pcvar_num(cvar_hm_ignore_ammo[g_hm_special[attacker]]))
				g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
		}
		if(g_hm_special[attacker] > 0 && g_hm_special[attacker] >= MAX_SPECIALS_HUMANS)
		{
			if(ArrayGetCell(g_hm_special_ignoreammo, g_hm_special[attacker]-MAX_SPECIALS_HUMANS) <= 0) 
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
		}
		else if(g_hm_special[attacker] <= 0 || (g_hm_special[attacker] > 0 && g_hm_special[attacker] < MAX_SPECIALS_HUMANS && !get_pcvar_num(cvar_hm_ignore_ammo[g_hm_special[attacker]])))
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
	if(damage_type & DMG_HEGRENADE)
		return HAM_SUPERCEDE;
	
	// Nemesis/Assassin?
	if(g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES)
	{
		// Ignore nemesis/assassin damage override if damage comes from a 3rd party entity
		// (to prevent this from affecting a sub-plugin's rockets e.g.)
		if(inflictor == attacker)
			SetHamParamFloat(4, get_pcvar_float(cvar_zm_damage[g_zm_special[attacker]]))

		return HAM_IGNORED;
	}
	
	if(g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES)
		return HAM_IGNORED;
	
	if(g_hm_special[victim] == SPY)
	{
		if(get_pcvar_num(cvar_hm_glow[SPY])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[SPY]), get_pcvar_num(cvar_hm_green[SPY]), get_pcvar_num(cvar_hm_blue[SPY]), kRenderNormal, 15)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 15)
		set_task(1.0, "turn_invisible", victim)
	}
	
	// Last human or infection not allowed
	if(!g_allowinfection || fnGetHumans() == 1)
		return HAM_IGNORED; // human is killed
	
	// Does human armor need to be reduced before infecting?
	if(get_pcvar_num(cvar_humanarmor))
	{
		// Get victim armor
		static Float:armor
		pev(victim, pev_armorvalue, armor)
		
		// Block the attack if he has some
		if(armor > 0.0)
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
	if(g_zombie[victim])
	{
		if(g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_painfree, g_zm_special[victim]-MAX_SPECIALS_ZOMBIES) <= 0) 
				return;
		}
		else if(g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) {
			if(!get_pcvar_num(cvar_zm_painfree[g_zm_special[victim]]))
				return;
		}
		else {
			switch (get_pcvar_num(cvar_zm_painfree[0])) {
				case 0: return;
				case 2: if(!g_lastzombie[victim]) return;
			}
		}
	}
	else
	{
		if(g_hm_special[victim] <= 0)		
			return;

		if(g_hm_special[victim] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_painfree, g_hm_special[victim]-MAX_SPECIALS_HUMANS) <= 0) 
				return;
		}
		else {
			if(!get_pcvar_num(cvar_hm_painfree[g_hm_special[victim]]))
				return;
		}

	}
	
	// Set pain shock free offset
	set_pdata_float(victim, OFFSET_PAINSHOCK, 1.0, OFFSET_LINUX)
}

// Ham Trace Attack Forward
public fw_TraceAttack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type)
{
	// Non-player damage or self damage
	if(victim == attacker || !is_user_valid_connected(attacker))
		return HAM_IGNORED;
	
	// New round starting or round ended
	if(g_newround || g_endround)
		return HAM_SUPERCEDE;
	
	// Victim shouldn't take damage or victim is frozen
	if(g_nodamage[victim] || (g_frozen[victim] && !get_pcvar_num(cvar_frozenhit)))
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if(g_zombie[attacker] == g_zombie[victim])
		return HAM_SUPERCEDE;
	
	// Victim isn't a zombie or not bullet damage, nothing else to do here
	if(!g_zombie[victim] || !(damage_type & DMG_BULLET))
		return HAM_IGNORED;
	
	// If zombie hitzones are enabled, check whether we hit an allowed one
	if(get_pcvar_num(cvar_hitzones) && g_zm_special[victim] <= 0 && !(get_pcvar_num(cvar_hitzones) & (1<<get_tr2(tracehandle, TR_iHitgroup))))
		return HAM_SUPERCEDE;
	
	// Knockback disabled, nothing else to do here
	if(!get_pcvar_num(cvar_knockback))
		return HAM_IGNORED;
	
	// Specials knockback disabled, nothing else to do here	
	if(g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) {
		if(get_pcvar_float(cvar_zmsp_knockback[g_zm_special[victim]]) == 0.0) 
			return HAM_IGNORED;
	}
	else if(g_zombie_knockback[victim] == 0.0) 
		return HAM_IGNORED;

	// Get whether the victim is in a crouch state
	static ducking
	ducking = pev(victim, pev_flags) & (FL_DUCKING | FL_ONGROUND) == (FL_DUCKING | FL_ONGROUND)
	
	// Zombie knockback when ducking disabled
	if(ducking && get_pcvar_float(cvar_knockbackducking) == 0.0)
		return HAM_IGNORED;
	
	// Get distance between players
	static origin1[3], origin2[3]
	get_user_origin(victim, origin1)
	get_user_origin(attacker, origin2)
	
	// Max distance exceeded
	if(get_distance(origin1, origin2) > get_pcvar_num(cvar_knockbackdist))
		return HAM_IGNORED;
	
	// Get victim's velocity
	static Float:velocity[3]
	pev(victim, pev_velocity, velocity)
	
	// Use damage on knockback calculation
	if(get_pcvar_num(cvar_knockbackdamage))
		xs_vec_mul_scalar(direction, damage, direction)
	
	// Use weapon power on knockback calculation
	if(get_pcvar_num(cvar_knockbackpower) && kb_weapon_power[g_currentweapon[attacker]] > 0.0)
		xs_vec_mul_scalar(direction, kb_weapon_power[g_currentweapon[attacker]], direction)
	
	// Apply ducking knockback multiplier
	if(ducking)
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_knockbackducking), direction)
	
	// Apply zombie class/nemesis knockback multiplier
	if(g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES || g_zm_special[victim] <= 0) {
		xs_vec_mul_scalar(direction, g_zombie_knockback[victim], direction) 
	}
	else {
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_zmsp_knockback[g_zm_special[victim]]), direction)
	}
	
	// Add up the new vector
	xs_vec_add(velocity, direction, direction)
	
	// Should knockback also affect vertical velocity?
	if(!get_pcvar_num(cvar_knockbackzvel))
		direction[2] = velocity[2]
	
	// Set the knockback'd victim's velocity
	set_pev(victim, pev_velocity, direction)
	
	return HAM_IGNORED;
}

// Ham Use Stationary Gun Forward
public fw_UseStationary(entity, caller, activator, use_type)
{
	// Prevent zombies from using stationary guns
	if(use_type == USE_USING && is_user_valid_connected(caller) && g_zombie[caller])
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Use Stationary Gun Post Forward
public fw_UseStationary_Post(entity, caller, activator, use_type)
{
	// Someone stopped using a stationary gun
	if(use_type == USE_STOPPED && is_user_valid_connected(caller))
		replace_weapon_models(caller, g_currentweapon[caller]) // replace weapon models (bugfix)
}

// Ham Use Pushable Forward
public fw_UsePushable()
{
	// Prevent speed bug with pushables?
	if(get_pcvar_num(cvar_blockpushables))
		return HAM_SUPERCEDE;
	
	return HAM_IGNORED;
}

// Ham Weapon Touch Forward
public fw_TouchWeapon(weapon, id)
{
	// Not a player
	if(!is_user_valid_connected(id))
		return HAM_IGNORED;
	
	// Dont pickup weapons if zombie, survivor, sniper and (+PODBot MM fix)
	if(g_zombie[id] || (g_hm_special[id] > 0))
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
	if(extra_ammo)
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
	if(!pev_valid(weapon_ent))
		return
	
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
	if(g_zombie[owner] && !((1<<weaponid) & ZOMBIE_ALLOWED_WEAPONS_BITSUM))
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
	if(!g_pluginenabled) return;
	
	// Player joined
	g_isconnected[id] = true
	g_zombieclassnext[id] = ZCLASS_NONE
	
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	// Initialize player vars
	reset_vars(id, 1)
	g_hud_color[0][id] = 4
	g_hud_color[1][id] = 6
	
	// Load player stats?
	if(get_pcvar_num(cvar_statssave)) load_stats(id)
	
	// Set some tasks for humans only
	if(!is_user_bot(id))
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
		if(!g_hamczbots && cvar_botquota)
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
	if(g_isalive[id]) check_round(id)
	
	// Temporarily save player stats?
	if(get_pcvar_num(cvar_statssave)) save_stats(id)
	
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
	
	if(g_handle_models_on_separate_ent)
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
	if(get_pcvar_num(cvar_blocksuicide))
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Emit Sound Forward
public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch)
{
	// Block all those unneeeded hostage sounds
	if(sample[0] == 'h' && sample[1] == 'o' && sample[2] == 's' && sample[3] == 't' && sample[4] == 'a' && sample[5] == 'g' && sample[6] == 'e')
		return FMRES_SUPERCEDE;
	
	// Replace these next sounds for zombies only
	if(!is_user_valid_connected(id) || !g_zombie[id])
		return FMRES_IGNORED;
	
	static sound[64]
	
	// Zombie being hit
	if(sample[7] == 'b' && sample[8] == 'h' && sample[9] == 'i' && sample[10] == 't')
	{
		if(g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
			ArrayGetString(zombie_pain[g_zm_special[id]], random_num(0, ArraySize(zombie_pain[g_zm_special[id]]) - 1), sound, charsmax(sound))
		}
		else {
			ArrayGetString(g_zm_special_painsound, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, sound, charsmax(sound))
		}		
			
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie attacks with knife
	if(sample[8] == 'k' && sample[9] == 'n' && sample[10] == 'i')
	{
		if(sample[14] == 's' && sample[15] == 'l' && sample[16] == 'a') // slash
		{
			ArrayGetString(zombie_miss_slash, random_num(0, ArraySize(zombie_miss_slash) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
		if(sample[14] == 'h' && sample[15] == 'i' && sample[16] == 't') // hit
		{
			if(sample[17] == 'w') // wall
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
		if(sample[14] == 's' && sample[15] == 't' && sample[16] == 'a') // stab
		{
			ArrayGetString(zombie_hit_stab, random_num(0, ArraySize(zombie_hit_stab) - 1), sound, charsmax(sound))
			emit_sound(id, channel, sound, volume, attn, flags, pitch)
			return FMRES_SUPERCEDE;
		}
	}
	
	// Zombie dies
	if(sample[7] == 'd' && ((sample[8] == 'i' && sample[9] == 'e') || (sample[8] == 'e' && sample[9] == 'a')))
	{
		ArrayGetString(zombie_die, random_num(0, ArraySize(zombie_die) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie falls off
	if(sample[10] == 'f' && sample[11] == 'a' && sample[12] == 'l' && sample[13] == 'l')
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
	if(key[0] == 'm' && key[1] == 'o' && key[2] == 'd' && key[3] == 'e' && key[4] == 'l')
		return FMRES_SUPERCEDE;
	
	return FMRES_IGNORED;
}

// Forward Client User Info Changed -prevent players from changing models-
public fw_ClientUserInfoChanged(id)
{
	// Cache player's name
	get_user_name(id, g_playername[id], charsmax(g_playername[]))
	
	if(!g_handle_models_on_separate_ent)
	{
		// Get current model
		static currentmodel[32]
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// If they're different, set model again
		if(!equal(currentmodel, g_playermodel[id]) && !task_exists(id+TASK_MODEL))
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
	if(strlen(model) < 8)
		return;
	
	// Remove weapons?
	if(get_pcvar_float(cvar_removedropped) > 0.0)
	{
		// Get entity's classname
		static classname[10]
		pev(entity, pev_classname, classname, charsmax(classname))
		
		// Check if it's a weapon box
		if(equal(classname, "weaponbox"))
		{
			// They get automatically removed when thinking
			set_pev(entity, pev_nextthink, get_gametime() + get_pcvar_float(cvar_removedropped))
			return;
		}
	}
	
	// Narrow down our matches a bit
	if(model[7] != 'w' || model[8] != '_')
		return;
	
	// Get damage time of grenade
	static Float:dmgtime
	pev(entity, pev_dmgtime, dmgtime)
	
	// Grenade not yet thrown
	if(dmgtime == 0.0)
		return;
	
	// Get whether grenade's owner is a zombie
	if(g_zombie[pev(entity, pev_owner)])
	{
		if(model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_extrainfbomb)) // Infection Bomb
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
	else if(model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_firegrenades)) // Napalm Grenade
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
	else if(model[9] == 'f' && model[10] == 'l' && get_pcvar_num(cvar_frostgrenades)) // Frost Grenade
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
	else if(model[9] == 's' && model[10] == 'm' && get_pcvar_num(cvar_flaregrenades)) // Flare
	{
		// Build flare's color
		static rgb[3]
		switch (get_pcvar_num(cvar_flarecolor))
		{
			case 0: rgb = { 250, 250, 250 } // white
			case 1: rgb = { 250, 0, 0 } // red
			case 2: rgb = { 0, 250, 0 } // green
			case 3: rgb = { 0, 0, 250 } // blue
			case 4: // random (all colors)
			{
				rgb[0] = random_num(50,200) // r
				rgb[1] = random_num(50,200) // g
				rgb[2] = random_num(50,200) // b
			}
			case 5: // random (r,g,b)
			{
				switch (random_num(0, 7)) {
					case 0: rgb = { 250, 250, 250 } // white
					case 1: rgb = { 250, 0, 0 } // red
					case 2: rgb = { 0, 250, 0 } // green
					case 3: rgb = { 0, 0, 250 } // blue
					case 4: rgb = { 0, 250, 250 } // cyan
					case 5: rgb = { 250, 0, 250 } // pink
					case 6: rgb = { 250, 250, 0 } // yellow
					case 7: rgb = { 255, 69, 0 } // orange
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
	if(!pev_valid(entity)) return HAM_IGNORED;
	
	// Get damage time of grenade
	static Float:dmgtime, Float:current_time
	pev(entity, pev_dmgtime, dmgtime)
	current_time = get_gametime()
	
	// Check if it's time to go off
	if(dmgtime > current_time)
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
			duration = pev(entity, PEV_FLARE_dur)
			
			// Already went off, do lighting loop for the duration of PEV_FLARE_dur
			if(duration > 0)
			{
				// Check whether this is the last loop
				if(duration == 1)
				{
					// Get rid of the flare entity
					engfunc(EngFunc_RemoveEntity, entity)
					return HAM_SUPERCEDE;
				}
				
				// Light it up!
				flare_lighting(entity, duration)
				
				// Set time for next loop
				set_pev(entity, PEV_FLARE_dur, --duration)
				set_pev(entity, pev_dmgtime, current_time + 5.0)
			}
			// Light up when it's stopped on ground
			else if((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10)
			{
				// Flare sound
				static sound[64]
				ArrayGetString(grenade_flare, random_num(0, ArraySize(grenade_flare) - 1), sound, charsmax(sound))
				emit_sound(entity, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				// Set duration and start lightning loop on next think
				set_pev(entity, PEV_FLARE_dur, 1 + get_pcvar_num(cvar_flareduration)/5)
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
	if(!g_isalive[id])
		return;
		
	if(g_zombie[id] && g_zm_special[id] == DRAGON && (get_uc(handle,UC_Buttons) & IN_RELOAD))
		use_cmd(id)
	
	// This logic looks kinda weird, but it should work in theory...
	// p = g_zombie[id], q = g_hm_special[id] == SURVIVOR, r = g_cached_customflash
	// ¬(p v q v (¬p ^ r)) <==> ¬p ^ ¬q ^ (p v ¬r)
	if(!g_zombie[id] && g_hm_special[id] <= 0 && (g_zombie[id] || !g_cached_customflash))
		return;
	
	// Check if it's a flashlight impulse
	if(get_uc(handle, UC_Impulse) != IMPULSE_FLASHLIGHT)
		return;
	
	// Block it I say!
	set_uc(handle, UC_Impulse, 0)
	
	// Should human's custom flashlight be turned on?
	if(!g_zombie[id] && g_hm_special[id] <= 0 && g_flashbattery[id] > 2 && get_gametime() - g_lastflashtime[id] > 1.2)
	{
		// Prevent calling flashlight too quickly (bugfix)
		g_lastflashtime[id] = get_gametime()
		
		// Toggle custom flashlight
		g_flashlight[id] = !(g_flashlight[id])
		
		// Play flashlight toggle sound
		emit_sound(id, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on the HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, id)
		write_byte(g_flashlight[id]) // toggle
		write_byte(g_flashbattery[id]) // battery
		message_end()
		
		// Remove previous tasks
		remove_task(id+TASK_CHARGE)
		remove_task(id+TASK_FLASH)
		
		// Set the flashlight charge task
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
		
		// Call our custom flashlight task if enabled
		if(g_flashlight[id]) set_task(0.1, "set_user_flashlight", id+TASK_FLASH, _, _, "b")
	}
}

// Forward Player PreThink
public fw_PlayerPreThink(id)
{
	// Not alive
	if(!g_isalive[id])
		return;
	
	// Silent footsteps for zombies/assassins ?
	if((g_cached_zombiesilent && g_zombie[id] && g_zm_special[id] <= 0))
		set_pev(id, pev_flTimeStepSound, STEPTIME_SILENT)
	
	// Set Player MaxSpeed
	if(g_frozen[id])
	{
		set_pev(id, pev_velocity, Float:{0.0,0.0,0.0}) // stop motion
		set_pev(id, pev_maxspeed, 1.0) // prevent from moving
		return; // shouldn't leap while frozen
	}
	else if(g_freezetime) {
		return; // shouldn't leap while in freezetime
	}
	else
	{
		if(g_user_custom_speed[id]) 
			set_pev(id, pev_maxspeed, g_current_maxspeed[id])
		else if(g_zombie[id] && g_zm_special[id] < MAX_SPECIALS_ZOMBIES)
			set_pev(id, pev_maxspeed, g_zm_special[id] > 0 ? g_zm_cached_spd[g_zm_special[id]] : g_spd[id])
		else if(!g_zombie[id] && g_hm_special[id] >= MAX_SPECIALS_HUMANS || g_zombie[id] && g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) 
			set_pev(id, pev_maxspeed, g_spd[id])
		else 
			set_pev(id, pev_maxspeed, g_hm_cached_spd[g_hm_special[id]])

	}
	
	// --- Check if player should leap ---
	
	// Check if proper CVARs are enabled and retrieve leap settings
	static Float:cooldown, Float:current_time
	if(g_zombie[id])
	{
		if(g_zm_special[id] <= 0) {
			switch (g_zm_cached_leap[0])
			{
				case 0: return;
				case 2: if(!g_firstzombie[id]) return;
				case 3: if(!g_lastzombie[id]) return;
			}
			cooldown = g_zm_cached_cooldown[0]
		}
		else {
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				if(ArrayGetCell(g_zm_special_leap, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) <= 0)
					return;
			}		
			else if(g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(!g_zm_cached_leap[g_zm_special[id]]) 
					return;
			}
			
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) 
				cooldown = g_custom_leap_cooldown[id]
			else 
				cooldown = g_zm_cached_cooldown[g_zm_special[id]]
		}
	}
	else
	{
		if(g_hm_special[id] <= 0)
			return

		else if(g_hm_special[id] < MAX_SPECIALS_HUMANS) {
			if(!g_hm_cached_leap[g_hm_special[id]] && g_hm_special[id] > 0)
				return;
		}
		else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_leap, g_hm_special[id]-MAX_SPECIALS_HUMANS) <= 0)
				return;
		}

		
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) 
			cooldown = g_custom_leap_cooldown[id]
		else 
			cooldown = g_hm_cached_cooldown[g_hm_special[id]]
	}
	
	current_time = get_gametime()
	
	// Cooldown not over yet
	if(current_time - g_lastleaptime[id] < cooldown)
		return;
	
	// Not doing a longjump (don't perform check for bots, they leap automatically)
	if(!g_isbot[id] && !(pev(id, pev_button) & (IN_JUMP | IN_DUCK) == (IN_JUMP | IN_DUCK)))
		return;
	
	// Not on ground or not enough speed
	if(!(pev(id, pev_flags) & FL_ONGROUND) || fm_get_speed(id) < 80)
		return;
	
	static Float:velocity[3]

	if(g_zombie[id])
	{
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			velocity_by_aim(id, ArrayGetCell(g_zm_special_leap_f, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), velocity)
			velocity[2] = Float:ArrayGetCell(g_zm_special_leap_h, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)
		}
		else {
			velocity_by_aim(id, get_pcvar_num(cvar_leap_zm_force[g_zm_special[id]]), velocity)
			velocity[2] = get_pcvar_float(cvar_leap_zm_height[g_zm_special[id]])
		}
	}
	else
	{
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			velocity_by_aim(id, ArrayGetCell(g_hm_special_leap_f, g_hm_special[id]-MAX_SPECIALS_HUMANS), velocity)
			velocity[2] = Float:ArrayGetCell(g_hm_special_leap_h, g_hm_special[id]-MAX_SPECIALS_HUMANS)
		}
		else {
			velocity_by_aim(id, get_pcvar_num(cvar_leap_hm_force[g_hm_special[id]]), velocity)
			velocity[2] = get_pcvar_float(cvar_leap_hm_height[g_hm_special[id]])
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
	if(g_nvision[id])
	{
		// Enable-disable
		g_nvisionenabled[id] = !(g_nvisionenabled[id])
		
		// Custom nvg?
		if(get_pcvar_num(cvar_customnvg))
		{
			remove_task(id+TASK_NVISION)
			if(g_nvisionenabled[id]) set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
		}
		else
			set_user_gnvision(id, g_nvisionenabled[id])
	}
	
	return PLUGIN_HANDLED;
}

// Weapon Drop
public clcmd_drop(id)
{
	// Survivor/Sniper/Berserker/Wesker/Spy should stick with its weapon
	if(g_hm_special[id] > 0)
		return PLUGIN_HANDLED

	return PLUGIN_CONTINUE;
}

// Buy BP Ammo
public clcmd_buyammo(id)
{
	// Not alive or infinite ammo setting enabled
	if(!g_isalive[id] || get_pcvar_num(cvar_hm_infammo[0]))
		return PLUGIN_HANDLED;
	
	// Not human
	if(g_zombie[id])
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_HUMAN_ONLY")
		return PLUGIN_HANDLED;
	}
	
	// Not enough ammo packs
	if(g_ammopacks[id] < 1)
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
		if(MAXBPAMMO[weaponid] > 2)
		{
			// Get current ammo of the weapon
			currentammo = cs_get_user_bpammo(id, weaponid)
			
			// Give additional ammo
			ExecuteHamB(Ham_GiveAmmo, id, BUYAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
			
			// Check whether we actually refilled the weapon's ammo
			if(cs_get_user_bpammo(id, weaponid) - currentammo > 0) refilled = true
		}
	}
	
	// Weapons already have full ammo
	if(!refilled) return PLUGIN_HANDLED;
	
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
	if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
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
	if(get_pcvar_num(cvar_buycustom))
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_BUY")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_BUY")
	
	// 2. Extra items
	if(get_pcvar_num(cvar_extraitems) && g_isalive[id])
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_EXTRABUY")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_EXTRABUY")
	
	// 3. Zombie class
	if(get_pcvar_num(cvar_zclasses))
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id,"MENU_ZCLASS")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id,"MENU_ZCLASS")
		
	// 4. Destravar
	if(g_zombie[id] || !g_zombie[id] && get_pcvar_num(cvar_human_unstuck))
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id,"MENU_UNSTUCK")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id,"MENU_UNSTUCK")
	

	// 5. Opcoes Pessoais
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w %L^n^n", id,"MENU_PERSONAL_OPTIONS")
	
	
	// 7. Join spec
	if(!g_isalive[id] || !get_pcvar_num(cvar_blocksuicide) || (userflags & g_access_flag[ACCESS_ADMIN_MENU]))
		len += formatex(menu[len], charsmax(menu) - len, "\r7.\w %L^n^n", id, "MENU_SPECTATOR")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d7. %L^n^n", id, "MENU_SPECTATOR")
	
	// 9. Admin menu
	if(userflags & g_access_flag[ACCESS_ADMIN_MENU3])
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
	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0)
		return;
	
	// Bots pick their weapons randomly / Random weapons setting enabled
	if(get_pcvar_num(cvar_randweapons) || g_isbot[id])
	{
		buy_primary_weapon(id, random_num(0, ArraySize(g_primary_items) - 1))
		menu_buy2(id, random_num(0, ArraySize(g_secondary_items) - 1))
		return;
	}
	
	// Automatic selection enabled for player and menu called on spawn event
	if(WPN_AUTO_ON && taskid > g_maxplayers)
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
	static special_name[128]
	if(g_zombie[id] && g_zm_special[id] >= MAX_SPECIALS_ZOMBIES)
		ArrayGetString(g_zm_special_name, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS)
		ArrayGetString(g_hm_special_name, g_hm_special[id]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
	else
		formatex(special_name, charsmax(special_name), "%L", id, g_zombie[id] ? zm_special_class_langs[g_zm_special[id]] : hm_special_class_langs[g_hm_special[id]])
	
	// Title
	formatex(menu, charsmax(menu), "%L [%s]\r", id, "MENU_EXTRA_TITLE", special_name)
	menuid = menu_create(menu, "menu_extras")
	
	// Item List
	for (item = 0; item < g_extraitem_i; item++)
	{
		g_AdditionalMenuText[0] = 0
		
		// Retrieve item's team
		team = ArrayGetCell(g_extraitem_team, item)
		
		// Item not available to player's team/class
		if((g_zombie[id] && g_zm_special[id] <= 0 && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && g_hm_special[id] <= 0 && !(team & ZP_TEAM_HUMAN)) || (g_zm_special[id] == NEMESIS && !(team & ZP_TEAM_NEMESIS))
		|| (g_hm_special[id] == SURVIVOR && !(team & ZP_TEAM_SURVIVOR)) || (g_hm_special[id] >= MAX_SPECIALS_HUMANS && !(team & ZP_TEAM_HUMAN)) || (g_hm_special[id] == SNIPER && !(team & ZP_TEAM_SNIPER)) || (g_zm_special[id] == ASSASSIN && !(team & ZP_TEAM_ASSASSIN)) 
		|| (g_hm_special[id] == BERSERKER && !(team & ZP_TEAM_BERSERKER) || (g_zm_special[id] == PREDATOR && !(team & ZP_TEAM_PREDATOR)) || (g_hm_special[id] == WESKER && !(team & ZP_TEAM_WESKER)))
		|| (g_zm_special[id] == BOMBARDIER && !(team & ZP_TEAM_BOMBARDIER)) || (g_hm_special[id] == SPY && !(team & ZP_TEAM_SPY)) || (g_zm_special[id] == DRAGON && !(team & ZP_TEAM_DRAGON)) || (g_zm_special[id] >= MAX_SPECIALS_ZOMBIES && !(team & MAX_SPECIALS_ZOMBIES))) 
			continue;
		
		// Check if it's one of the hardcoded items, check availability, set translated caption
		switch (item)
		{
			case EXTRA_NVISION:
			{
				if(!get_pcvar_num(cvar_extranvision)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "NightVision")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA1")
			}
			case EXTRA_ANTIDOTE:
			{
				if(!get_pcvar_num(cvar_extraantidote) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "T-Virus Antidote")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA2")
			}
			case EXTRA_MADNESS:
			{
				if(!get_pcvar_num(cvar_extramadness) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "Zombie Madness")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA3")
			}
			case EXTRA_INFBOMB:
			{
				if(!get_pcvar_num(cvar_extrainfbomb) || g_infbombcounter >= get_pcvar_num(cvar_infbomblimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "Infection Bomb")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA4")
			}
			default:
			{				
				if(item >= EXTRA_WEAPONS_STARTID && item <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
			}
		}
		
		// Item selected Pre forward
		ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, item);
						
		// Not Show the Item Extra
		if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue;
			
		// Add Item Name and Cost
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED || g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, item)) 
			formatex(menu, charsmax(menu), "\d%s \d[%d] \d%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)
		else 
			formatex(menu, charsmax(menu), "%s \r[%d] \w%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)

		buffer[0] = item
		buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// No items to display?
	if(menu_items(menuid) <= 0)
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id ,"CMD_NOT_EXTRAS")
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
	if(!g_isconnected[id]) // Nao Abrir o Menu se for nemesis
		return;
	
	// Bots pick their zombie class randomly
	if(g_isbot[id]) {
		g_zombieclassnext[id] = random_num(0, g_zclass_i - 1)
		g_choosed_zclass[id] = true
		zombieme(id, 0, 0, 2, 0)
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
		if(g_fwDummyResult < ZP_PLUGIN_SUPERCEDE)
		{
			// Add to menu
			if(class == g_zombieclassnext[id])
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
	if(!g_isconnected[id])
		return;
	
	// No custom game modes registered ?
	if(g_gamemodes_i == MAX_GAME_MODES)
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
		if((get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (game - MAX_GAME_MODES))) && allowed_custom_game() && ArrayGetCell(g_gamemode_enable, (game - MAX_GAME_MODES)) > 0)
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
	
	if(userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN1")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN1")

	menu_additem(menu, szText, "1")
	
	if(userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN2")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN2")

	if(g_zm_special_enable[NEMESIS]) menu_additem(menu, szText, "2")
	
	if(userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN3")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN3")

	if(g_hm_special_enable[SURVIVOR]) menu_additem(menu, szText, "3")
	
	if(userflags & (g_access_flag[ACCESS_MODE_SNIPER] | g_access_flag[ACCESS_MAKE_SNIPER]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN8")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN8")

	if(g_hm_special_enable[SNIPER]) menu_additem(menu, szText, "4")
	
	if(userflags & (g_access_flag[ACCESS_MODE_ASSASSIN] | g_access_flag[ACCESS_MAKE_ASSASSIN]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN9")
	else
		formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN9")

	if(g_zm_special_enable[ASSASSIN]) menu_additem(menu, szText, "5")
	
	if(userflags & (g_access_flag[ACCESS_MODE_BERSERKER] | g_access_flag[ACCESS_MAKE_BERSERKER]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN13")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN13")

	if(g_hm_special_enable[BERSERKER]) menu_additem(menu, szText, "6")
	
	if(userflags & (g_access_flag[ACCESS_MODE_PREDATOR] | g_access_flag[ACCESS_MAKE_PREDATOR]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN11")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN11")

	if(g_zm_special_enable[PREDATOR]) menu_additem(menu, szText, "7")
	
	if(userflags & (g_access_flag[ACCESS_MODE_WESKER] | g_access_flag[ACCESS_MAKE_WESKER]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN14")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN14")

	if(g_hm_special_enable[WESKER]) menu_additem(menu, szText, "8")
	
	if(userflags & (g_access_flag[ACCESS_MODE_BOMBARDIER] | g_access_flag[ACCESS_MAKE_BOMBARDIER]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN12")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN12")

	if(g_zm_special_enable[BOMBARDIER]) menu_additem(menu, szText, "9")
	
	if(userflags & (g_access_flag[ACCESS_MODE_SPY] | g_access_flag[ACCESS_MAKE_SPY]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN15")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN15")

	if(g_hm_special_enable[SPY]) menu_additem(menu, szText, "10")
	
	if(userflags & (g_access_flag[ACCESS_MODE_DRAGON] | g_access_flag[ACCESS_MAKE_DRAGON]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN16")
	else
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN16")

	if(g_zm_special_enable[DRAGON]) menu_additem(menu, szText, "11")
	
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
	if((userflags & g_access_flag[ACCESS_MODE_MULTI]) && allowed_multi())
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_ADMIN6")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_ADMIN6")
		
	// 2. Swarm mode command
	if((userflags & g_access_flag[ACCESS_MODE_SWARM]) && allowed_swarm())
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU_ADMIN5")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU_ADMIN5")
	
	if(g_zm_special_enable[NEMESIS] && g_hm_special_enable[SURVIVOR]) {
		// 3. Plague mode command
		if((userflags & g_access_flag[ACCESS_MODE_PLAGUE]) && allowed_plague())
			len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id, "MENU_ADMIN7")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id, "MENU_ADMIN7")
		
		// 4. Armageddon mode command
		if((userflags & g_access_flag[ACCESS_MODE_LNJ]) && allowed_lnj())
			len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id, "MENU_ADMIN10")
		else
			len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id, "MENU_ADMIN10")
	}

	// 9. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r9.\w %L", id, "MENU_EXIT")
	
	// 0. Back
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_BACK")
	
	show_menu(id, KEYSMENU, menu, -1, "Menu2 Admin")
}

// Admin Menu 3
show_menu3_admin(id)
{
	static menu[999], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n^n", id, "MENU3_ADMIN_TITLE")
	
	// 1. Admin menu of classes
	if(userflags & g_access_flag[ACCESS_ADMIN_MENU])
		len += formatex(menu[len], charsmax(menu) - len, "\r1.\w %L^n", id, "MENU_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d1. %L^n", id, "MENU_ADMIN")
		
	// 2. Main Modes admin menu
	if(userflags & g_access_flag[ACCESS_ADMIN_MENU2])
		len += formatex(menu[len], charsmax(menu) - len, "\r2.\w %L^n", id, "MENU2_ADMIN")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d2. %L^n", id, "MENU2_ADMIN")
	
	// 3. Custom modes admin menu
	if(userflags & g_access_flag[ACCESS_ADMIN_MENU3])
		len += formatex(menu[len], charsmax(menu) - len, "\r3.\w %L^n", id, "MENU_ADMIN_CUSTOM")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d3. %L^n", id, "MENU_ADMIN_CUSTOM")
		
	// 4. Respawn Player
	if(userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])
		len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id, "MENU_ADMIN4")
	else
		len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id, "MENU_ADMIN4")
	
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w %L^n", id, "MENU_ADMIN_CUSTOM_SP_H")
	len += formatex(menu[len], charsmax(menu) - len, "\r6.\w %L^n^n", id, "MENU_ADMIN_CUSTOM_SP_Z")

	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_EXIT")
	
	show_menu(id, KEYSMENU, menu, -1, "Menu3 Admin")
}

public show_menu_make_special(id, zombie)
{
	// Player disconnected
	if(!g_isconnected[id])
		return;
	
	// No custom game modes registered ?
	if(g_hm_specials_i == MAX_SPECIALS_HUMANS && !zombie || g_zm_specials_i == MAX_SPECIALS_ZOMBIES && zombie)
	{
		// Print a message
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_CUSTOM_SP")
		
		// Show the main admin menu and stop
		show_menu3_admin(id)
		return;
	}
	
	// Create vars necessary for displaying the game modes menu
	static menuid, menu[128], i, szTempid[10], buffer[32]
	
	if(zombie)
	{
		// Title
		formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_SP_Z")
		menuid = menu_create(menu, "custom_zm_sp_handler")
		
		// Game mode List
		for (i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++)
		{
			// Retrieve the game mode's name
			ArrayGetString(g_zm_special_name, (i - MAX_SPECIALS_ZOMBIES), buffer, charsmax(buffer))
			
			// Check for access flags and other conditions
			if(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, i-MAX_SPECIALS_ZOMBIES))
				formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
			else
				formatex(menu, charsmax(menu), "\d%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
			
			// Add the item to the menu
			num_to_str(i, szTempid, 9);
			menu_additem(menuid, menu, szTempid)
		}
	}
	else {
		// Title
		formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_SP_H")
		menuid = menu_create(menu, "custom_hm_sp_handler")
		
		// Game mode List
		for (i = MAX_SPECIALS_HUMANS; i < g_hm_specials_i; i++)
		{
			// Retrieve the game mode's name
			ArrayGetString(g_hm_special_name, (i - MAX_SPECIALS_HUMANS), buffer, charsmax(buffer))
			
			// Check for access flags and other conditions
			if(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, i-MAX_SPECIALS_HUMANS))
				formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
			else
				formatex(menu, charsmax(menu), "\d%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
			
			// Add the item to the menu
			num_to_str(i, szTempid, 9);
			menu_additem(menuid, menu, szTempid)
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

public custom_hm_sp_handler(id, menuid, item)
{
	// Player wants to exit the menu
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	PL_ACTION = str_to_num(data)
	
	if(!(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, PL_ACTION-MAX_SPECIALS_HUMANS))) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	make_user_sp_pl(id, 0)
	return PLUGIN_CONTINUE
}

public custom_zm_sp_handler(id, menuid, item)
{
	// Player wants to exit the menu
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	PL_ACTION = str_to_num(data)
	
	if(!(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, PL_ACTION-MAX_SPECIALS_ZOMBIES))) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	make_user_sp_pl(id, 1)
	return PLUGIN_CONTINUE
}

public make_user_sp_pl(id, zombie) {
	
	new menu[256], special_name[128], player, szTempid[10]
	if(zombie)
		ArrayGetString(g_zm_special_name, PL_ACTION-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else
		ArrayGetString(g_hm_special_name, PL_ACTION-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
	
	formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", special_name)
	new menuid = menu_create(menu, zombie ? "make_custom_zm_sp" : "make_custom_hm_sp")

	// Player List
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Skip if not connected
		if(!g_isconnected[player])
			continue;
		
		if(g_zombie[player] && g_zm_special[player] >= MAX_SPECIALS_ZOMBIES)
			ArrayGetString(g_zm_special_name, g_zm_special[player]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
		else if(!g_zombie[player] && g_hm_special[player] >= MAX_SPECIALS_HUMANS)
			ArrayGetString(g_hm_special_name, g_hm_special[player]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
		else
			formatex(special_name, charsmax(special_name), "%L", id, g_zombie[player] ? zm_special_class_langs[g_zm_special[player]] : hm_special_class_langs[g_hm_special[player]])

		// Format text depending on the action to take
		if(allowed_special(player, zombie, PL_ACTION))
			formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
		else
			formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
		
		// Add player
		num_to_str(player, szTempid, 9);
		menu_additem(menuid, menu, szTempid)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK")
	menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT")
	menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT")
	menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	menu_display(id, menuid)
	
	return PLUGIN_CONTINUE
}

public make_custom_hm_sp(id, menuid, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_make_special(id, 0)
		return PLUGIN_HANDLED;
	}
	
	if(!(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, PL_ACTION-MAX_SPECIALS_HUMANS))) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu_make_special(id, 0)
		return PLUGIN_HANDLED;
	}
	
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	new player = str_to_num(data)
	
	if(allowed_special(player, 0, PL_ACTION))
		command_custom_special(id, player, PL_ACTION, 0)
	else
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")

	make_user_sp_pl(id, 0)
	return PLUGIN_HANDLED;
}

public make_custom_zm_sp(id, menuid, item)
{
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		show_menu_make_special(id, 1)
		return PLUGIN_HANDLED;
	}
	
	if(!(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, PL_ACTION-MAX_SPECIALS_ZOMBIES))) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu_make_special(id, 1)
		return PLUGIN_HANDLED;
	}
	
	
	new data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	new player = str_to_num(data)
	
	if(allowed_special(player, 1, PL_ACTION))
		command_custom_special(id, player, PL_ACTION, 1)
	else
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")

	make_user_sp_pl(id, 1)
	return PLUGIN_HANDLED;
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
		case ACTION_MAKE_PREDATOR: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN11")
		case ACTION_MAKE_BOMBARDIER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN12")
		case ACTION_MAKE_BERSERKER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN13")
		case ACTION_MAKE_WESKER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN14")
		case ACTION_MAKE_SPY: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN15")
		case ACTION_MAKE_DRAGON: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN16")
		case ACTION_RESPAWN_PLAYER: formatex(menu, charsmax(menu), "%L\r", id, "MENU_ADMIN4")

	}
	menuid = menu_create(menu, "menu_player_list")
	new special_name[128]
	
	// Player List
	for (player = 1; player <= g_maxplayers; player++)
	{
		// Skip if not connected
		if(!g_isconnected[player])
			continue;
			
		if(g_zombie[player] && g_zm_special[player] >= MAX_SPECIALS_ZOMBIES)
			ArrayGetString(g_zm_special_name, g_zm_special[player]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
		else if(!g_zombie[player] && g_hm_special[player] >= MAX_SPECIALS_HUMANS)
			ArrayGetString(g_hm_special_name, g_hm_special[player]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
		else
			formatex(special_name, charsmax(special_name), "%L", id, g_zombie[player] ? zm_special_class_langs[g_zm_special[player]] : hm_special_class_langs[g_hm_special[player]])

		// Format text depending on the action to take
		switch (PL_ACTION)
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if(g_zombie[player])
				{
					if(allowed_human(player) && (userflags & g_access_flag[ACCESS_MAKE_HUMAN]))
						formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
					else
						formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
				}
				else
				{
					if(allowed_zombie(player) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE])))
						formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
					else
						formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if(allowed_special(player, 1, NEMESIS) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if(allowed_special(player, 0, SURVIVOR) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SNIPER: // Sniper command
			{
				if(allowed_special(player, 0, SNIPER) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SNIPER]) : (userflags & g_access_flag[ACCESS_MAKE_SNIPER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_ASSASSIN: // Assassin command
			{
				if(allowed_special(player, 1, ASSASSIN) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_ASSASSIN]) : (userflags & g_access_flag[ACCESS_MAKE_ASSASSIN])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_PREDATOR:
			{
				if(allowed_special(player, 1, PREDATOR) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_PREDATOR]) : (userflags & g_access_flag[ACCESS_MAKE_PREDATOR])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_BOMBARDIER:
			{
				if(allowed_special(player, 1, BOMBARDIER) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BOMBARDIER]) : (userflags & g_access_flag[ACCESS_MAKE_BOMBARDIER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_BERSERKER: // Berserker command
			{
				if(allowed_special(player, 0, BERSERKER) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_BERSERKER]) : (userflags & g_access_flag[ACCESS_MAKE_BERSERKER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_WESKER: // Wesker command
			{
				if(allowed_special(player, 0, WESKER) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_WESKER]) : (userflags & g_access_flag[ACCESS_MAKE_WESKER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SPY: // Spy command
			{
				if(allowed_special(player, 0, SPY) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_SPY]) : (userflags & g_access_flag[ACCESS_MAKE_SPY])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_DRAGON:
			{
				if(allowed_special(player, 1, DRAGON) && (g_newround ? (userflags & g_access_flag[ACCESS_MODE_DRAGON]) : (userflags & g_access_flag[ACCESS_MAKE_DRAGON])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else
					formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}		
			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if(allowed_respawn(player) && (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])) formatex(menu, charsmax(menu), "%s", g_playername[player])
				else formatex(menu, charsmax(menu), "\d%s", g_playername[player])
			}			
			
		}
		
		// Add player
		buffer[0] = player
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
			if(get_pcvar_num(cvar_buycustom))
			{
				// Disable the remember selection setting
				WPN_AUTO_ON = 0
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "BUY_ENABLED")
				
				// Show menu if player hasn't yet bought anything
				if(g_canbuy[id]) show_menu_buy1(id)
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		}
		case 1: // Extra Items
		{
			// Extra items enabled?
			if(get_pcvar_num(cvar_extraitems))
			{
				// Check whether the player is able to buy anything
				if(g_newround && !get_pcvar_num(cvar_allow_buy_no_start)) zp_colored_print(id, "^x04[ZP]^x01 %L", id, "WAIT_ROUND_BEGINS")
				else if(g_endround) zp_colored_print(id, "^x04[ZP]^x01 %L", id, "ROUND_ENDED")
				else if(g_isalive[id]) show_menu_extras(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_EXTRAS")
		}
		case 2: // Zombie Classes
		{
			if(get_pcvar_num(cvar_zclasses)) show_menu_zclass(id) // Zombie classes enabled?
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ZCLASSES")
		}
		case 3: // Unstuck
		{
			// Check if player is stuck
			if(g_isalive[id])
			{
				if(!g_zombie[id] && !get_pcvar_num(cvar_human_unstuck))
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_ZOMBIE_ONLY")
				else {
					if(is_player_stuck(id))
					{
						// Move to an initial spawn
						if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
						else do_random_spawn(id, 1) // regular spawn
					}
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_STUCK")
				}
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		}
		case 4:  {
			show_menu_personal(id) // Personal Options
		}
		case 6: // Join Spectator
		{
			// Player alive?
			if(g_isalive[id])
			{
				// Prevent abuse by non-admins if block suicide setting is enabled
				if(get_pcvar_num(cvar_blocksuicide) && !(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU])) {
					zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					return PLUGIN_HANDLED;
				}
				
				// Check that we still have both humans and zombies to keep the round going
				check_round(id)
				
				// Kill him before he switches team
				dllfunc(DLLFunc_ClientKill, id)
			}
			
			// Temporarily save player stats?
			if(get_pcvar_num(cvar_statssave)) save_stats(id)
			
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
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3]) show_menu3_admin(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
	}
	
	return PLUGIN_HANDLED;
}

// Buy Menu 1
public menu_buy1(id, key)
{
	// Zombies, survivors or snipers get no guns
	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0)
		return PLUGIN_HANDLED;
	
	// Special keys / weapon list exceeded
	if(key >= MENU_KEY_AUTOSELECT || WPN_SELECTION >= WPN_MAXIDS)
	{
		switch (key)
		{
			case MENU_KEY_AUTOSELECT: // toggle auto select
			{
				WPN_AUTO_ON = 1 - WPN_AUTO_ON
			}
			case MENU_KEY_NEXT: // next/back
			{
				if(WPN_STARTID+7 < WPN_MAXIDS) WPN_STARTID += 7
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
	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0)
		return PLUGIN_HANDLED;
	
	// Special keys / weapon list exceeded
	if(key >= ArraySize(g_secondary_items))
	{
		// Toggle autoselect
		if(key == MENU_KEY_AUTOSELECT)
			WPN_AUTO_ON = 1 - WPN_AUTO_ON
		
		// Reshow menu unless user exited
		if(key != MENU_KEY_EXIT)
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
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Dead players are not allowed to buy items
	if(!g_isalive[id])
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
	
	if((g_zombie[id] && g_zm_special[id] <= 0 && !(team & ZP_TEAM_ZOMBIE)) || (!g_zombie[id] && g_hm_special[id] <= 0 && !(team & ZP_TEAM_HUMAN)) || (g_zm_special[id] == NEMESIS && !(team & ZP_TEAM_NEMESIS))
	|| (g_hm_special[id] == SURVIVOR && !(team & ZP_TEAM_SURVIVOR)) || (g_hm_special[id] >= MAX_SPECIALS_HUMANS && !(team & ZP_TEAM_HUMAN)) || (g_hm_special[id] == SNIPER && !(team & ZP_TEAM_SNIPER)) || (g_zm_special[id] == ASSASSIN && !(team & ZP_TEAM_ASSASSIN)) 
	|| (g_hm_special[id] == BERSERKER && !(team & ZP_TEAM_BERSERKER) || (g_zm_special[id] == PREDATOR && !(team & ZP_TEAM_PREDATOR)) || (g_hm_special[id] == WESKER && !(team & ZP_TEAM_WESKER)))
	|| (g_zm_special[id] == BOMBARDIER && !(team & ZP_TEAM_BOMBARDIER)) || (g_hm_special[id] == SPY && !(team & ZP_TEAM_SPY)) || (g_zm_special[id] == DRAGON && !(team & ZP_TEAM_DRAGON)) || (g_zm_special[id] >= MAX_SPECIALS_ZOMBIES && !(team & MAX_SPECIALS_ZOMBIES))) 
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for unavailable items
	if((itemid == EXTRA_NVISION && !get_pcvar_num(cvar_extranvision)) || (itemid == EXTRA_ANTIDOTE && (!get_pcvar_num(cvar_extraantidote) 
	|| g_antidotecounter >= get_pcvar_num(cvar_antidotelimit))) || (itemid == EXTRA_MADNESS && (!get_pcvar_num(cvar_extramadness) 
	|| g_madnesscounter >= get_pcvar_num(cvar_madnesslimit))) || (itemid == EXTRA_INFBOMB && (!get_pcvar_num(cvar_extrainfbomb)  || g_endround || g_newround && !get_pcvar_num(cvar_allow_buy_no_start)
	|| g_infbombcounter >= get_pcvar_num(cvar_infbomblimit))) || (itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons)))
	{
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
		return;
	}
	
	// Check for hard coded items with special conditions
	if((itemid == EXTRA_ANTIDOTE && (g_endround || g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI || fnGetZombies() <= 1 || (get_pcvar_num(cvar_deathmatch) && !get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() == 1)))
	|| (itemid == EXTRA_INFBOMB && (g_endround || g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI))) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_CANTUSE")
		return;
	}

	if(itemid == EXTRA_ANTIDOTE && native_get_zombie_count() < get_pcvar_num(cvar_antidote_minzms)) {
		zp_colored_print(id, "^4[ZP]^1 %L", id, "ANTIDOTE_NOT_AVALIABLE1", get_pcvar_num(cvar_antidote_minzms))
		return;
	}
	
	if(itemid == EXTRA_NVISION && g_nvision[id] || itemid == EXTRA_MADNESS && g_nodamage[id]) {
		zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_HAVE_ITEM")
		return;
	}

	// Ignore item's cost?
	if(!ignorecost)
	{
		// Check that we have enough ammo packs
		if(g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, itemid)) {
			zp_colored_print(id, "^x04[ZP]^x01 %L", id, "NOT_ENOUGH_AMMO")
			return;
		}
		
		// Deduce item cost
		g_ammopacks[id] -= ArrayGetCell(g_extraitem_cost, itemid)
	}
	
	if(g_isbot[id]) 
		g_bot_extra_count[id]++
	
	// Check which kind of item we're buying
	switch (itemid)
	{
		case EXTRA_NVISION: // Night Vision
		{
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
			{
				if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				show_menu_extras(id)
				return;
			}
				
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost) {
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return
			}
			
			g_nvision[id] = true
			
			if(!g_isbot[id])
			{
				g_nvisionenabled[id] = true
				
				// Custom nvg?
				if(get_pcvar_num(cvar_customnvg))
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
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
			{
				if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				show_menu_extras(id)
				return;
			}
				
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost) {
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return
			}
			
			// Increase antidote purchase count for this round
			g_antidotecounter++
			
			humanme(id, 0, 0)
		}
		case EXTRA_MADNESS: // Zombie Madness
		{
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
			{
				if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				show_menu_extras(id)
				return;
			}
				
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost) {
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return
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
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
			{
				if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				show_menu_extras(id)
				return;
			}
				
			// Item selected forward
			ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
			// Item purchase blocked, restore buyer's ammo packs
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost) {
				g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				return
			}
			
			// Increase infection bomb purchase count for this round
			g_infbombcounter++
			
			// Already own one
			if(user_has_weapon(id, CSW_HEGRENADE))
			{
				// Increase BP ammo on it instead
				cs_set_user_bpammo(id, CSW_HEGRENADE, cs_get_user_bpammo(id, CSW_HEGRENADE) + 1)
				
				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()
				
				// Play clip purchase sound
				emit_sound(id, CHAN_ITEM, sound_buyammo, 1.0, ATTN_NORM, 0, PITCH_NORM)
				
				return; // stop here
			}
			
			// Give weapon to the player
			fm_give_item(id, "weapon_hegrenade")
			
			if(g_isbot[id] && user_has_weapon(id, CSW_HEGRENADE))	{
				engclient_cmd(id, "weapon_hegrenade");
				ExecuteHam(Ham_Weapon_PrimaryAttack, get_pdata_cbase(id, 373, 5));
			}
		}
		default:
		{
			if(itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1) // Weapons
			{
				// Item selected forward
				ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid);
				
				// Item purchase blocked, restore buyer's ammo packs
				if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
				{
					if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
					show_menu_extras(id)
					return;
				}
				
				// Item selected forward
				ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
				// Item purchase blocked, restore buyer's ammo packs
				if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost)
					g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
				
				// Get weapon's id and name
				static weaponid, wname[32]
				ArrayGetString(g_extraweapon_items, itemid - EXTRA_WEAPONS_STARTID, wname, charsmax(wname))
				weaponid = cs_weapon_name_to_id(wname)
				
				// If we are giving a primary/secondary weapon
				if(MAXBPAMMO[weaponid] > 2)
				{
					// Make user drop the previous one
					if((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM) drop_weapons(id, 1)
					else drop_weapons(id, 2)

					// Give full BP ammo for the new one
					ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
				}
				// If we are giving a grenade which the user already owns
				else if(user_has_weapon(id, weaponid))
				{
					// Increase BP ammo on it instead
					cs_set_user_bpammo(id, weaponid, cs_get_user_bpammo(id, weaponid) + 1)
					
					// Flash ammo in hud
					message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
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
				if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
				{
					if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
					show_menu_extras(id)
					return;
				}
				
				// Item selected forward
				ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid);
				
				// Item purchase blocked, restore buyer's ammo packs
				if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && !ignorecost)
					g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)				
			}
		}
	}
}

// Zombie Class Menu
public menu_zclass(id, menuid, item)
{
	// Menu was closed
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	// Retrieve zombie class id
	static buffer[2], dummy, classid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	classid = buffer[0]
	
	if(g_zombie[id] && g_zm_special[id] <= 0 && !g_choosed_zclass[id] && get_pcvar_num(cvar_chosse_instantanly)) 
	{
		// Class selected Pre forward
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid);
						
		// Not Show the Zombie Class
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
		{
			show_menu_zclass(id)
			menu_destroy(menuid)
			return PLUGIN_HANDLED;
		}
		
		g_zombieclassnext[id] = classid
		g_choosed_zclass[id] = true
		zombieme(id, 0, 0, 2, 0)
		
		static name[32]
		ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))
		
		// Show selected zombie class info and stats
		zp_colored_print(id, "^x04[ZP]^x01 %L^x01:^x04 %s", id, "ZOMBIE_SELECT", name)
		zp_colored_print(id, "^x04[ZP]^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
		id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))
		
		ExecuteForward(g_forwards[CLASS_CHOOSED_POST], g_fwDummyResult, id, classid);
	}
	else
	{
		// Class selected Pre forward
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid);
						
		// Not Show the Zombie Class
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
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
	if(item == MENU_EXIT)
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
	if(get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (gameid - MAX_GAME_MODES)))
	{
		// Only allow the game mode to proceed after some checks
		if(allowed_custom_game() && ArrayGetCell(g_gamemode_enable, (gameid - MAX_GAME_MODES)) > 0)
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
			if(userflags & (g_access_flag[ACCESS_MODE_INFECTION] | g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_NEMESIS] | g_access_flag[ACCESS_MAKE_NEMESIS]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_SURVIVOR] | g_access_flag[ACCESS_MAKE_SURVIVOR]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_SNIPER] | g_access_flag[ACCESS_MAKE_SNIPER]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_ASSASSIN] | g_access_flag[ACCESS_MAKE_ASSASSIN]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_BERSERKER] | g_access_flag[ACCESS_MAKE_BERSERKER]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_PREDATOR] | g_access_flag[ACCESS_MAKE_PREDATOR]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_WESKER] | g_access_flag[ACCESS_MAKE_WESKER]))
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
			if(userflags & (g_access_flag[ACCESS_MODE_BOMBARDIER] | g_access_flag[ACCESS_MAKE_BOMBARDIER]))
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
		case 10: // Spy command
		{
			if(userflags & (g_access_flag[ACCESS_MODE_SPY] | g_access_flag[ACCESS_MAKE_SPY]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_SPY
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 11: // Dragon command
		{
			if(userflags & (g_access_flag[ACCESS_MODE_DRAGON] | g_access_flag[ACCESS_MAKE_DRAGON]))
			{
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_MAKE_DRAGON
				show_menu_player_list(id)
			}
			else
			{
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
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
			if(userflags & g_access_flag[ACCESS_MODE_MULTI]) {
				if(allowed_multi()) command_multi(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")

			show_menu2_admin(id)
		}
		case 1: // Swarm Mode command
		{
			if(userflags & g_access_flag[ACCESS_MODE_SWARM]) {
				if(allowed_swarm()) command_swarm(id)
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			
			show_menu2_admin(id)
		}
		case 2: // Plague Mode command
		{
			if(g_zm_special_enable[NEMESIS] && g_hm_special_enable[SURVIVOR]) {
				if(userflags & g_access_flag[ACCESS_MODE_PLAGUE]) {
					if(allowed_plague()) command_plague(id)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			show_menu2_admin(id)
		}
		case 3: // Armageddon Mode command
		{
			if(g_zm_special_enable[NEMESIS] && g_hm_special_enable[SURVIVOR]) {
				if(userflags & g_access_flag[ACCESS_MODE_LNJ]) {
					if(allowed_lnj()) command_lnj(id)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}			
			show_menu2_admin(id)
		}
		case 9: show_menu3_admin(id) // Chose to return
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
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU]) show_menu_admin(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
		case 1: // Admin Menu Class
		{
			// Check if player has the required access
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU2]) show_menu2_admin(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
		case 2: // Admin Menu of Custom Game modes
		{
			// Check if player has the required access
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3]) show_menu_game_mode(id)
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
		}
		case 3: // Respawn Player
		{
			if(get_user_flags(id) & g_access_flag[ACCESS_RESPAWN_PLAYERS]) {
				// Show player list for admin to pick a target
				PL_ACTION = ACTION_RESPAWN_PLAYER
				show_menu_player_list(id);
			}
			else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS");
		}
		case 4: show_menu_make_special(id, 0)
		case 5: show_menu_make_special(id, 1)
	}
	return PLUGIN_HANDLED;
}

// Player List Menu
public menu_player_list(id, menuid, item)
{
	// Menu was closed
	if(item == MENU_EXIT)
	{
		menu_destroy(menuid)
		if(PL_ACTION != ACTION_RESPAWN_PLAYER) show_menu_admin(id)
		else show_menu3_admin(id)
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
	if(g_isconnected[playerid])
	{
		// Perform the right action if allowed
		switch (PL_ACTION)
		{
			case ACTION_ZOMBIEFY_HUMANIZE: // Zombiefy/Humanize command
			{
				if(g_zombie[playerid]) {
					if(userflags & g_access_flag[ACCESS_MAKE_HUMAN]) {
						if(allowed_human(playerid)) command_human(id, playerid)
						else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
				else {
					if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_INFECTION]) : (userflags & g_access_flag[ACCESS_MAKE_ZOMBIE]))
					{
						if(allowed_zombie(playerid)) command_zombie(id, playerid)
						else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
					}
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
				}
			}
			case ACTION_MAKE_NEMESIS: // Nemesis command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_NEMESIS]) : (userflags & g_access_flag[ACCESS_MAKE_NEMESIS])) {
					if(allowed_special(playerid, 1, NEMESIS)) command_nemesis(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SURVIVOR: // Survivor command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_SURVIVOR]) : (userflags & g_access_flag[ACCESS_MAKE_SURVIVOR])) {
					if(allowed_special(playerid, 0, SURVIVOR)) command_survivor(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SNIPER: // Sniper command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_SNIPER]) : (userflags & g_access_flag[ACCESS_MAKE_SNIPER])) {
					if(allowed_special(playerid, 0, SNIPER)) command_sniper(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_ASSASSIN: // Assassin command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_ASSASSIN]) : (userflags & g_access_flag[ACCESS_MAKE_ASSASSIN])) {
					if(allowed_special(playerid, 1, ASSASSIN)) command_assassin(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_PREDATOR: // Predator command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_PREDATOR]) : (userflags & g_access_flag[ACCESS_MAKE_PREDATOR])) {
					if(allowed_special(playerid, 1, PREDATOR)) command_predator(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_BERSERKER: // Berserker command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_BERSERKER]) : (userflags & g_access_flag[ACCESS_MAKE_BERSERKER])) {
					if(allowed_special(playerid, 0, BERSERKER)) command_berserker(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_WESKER: // Wesker command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_WESKER]) : (userflags & g_access_flag[ACCESS_MAKE_WESKER])) {
					if(allowed_special(playerid, 0, WESKER)) command_wesker(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			
			case ACTION_MAKE_BOMBARDIER: // Bombardier command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_BOMBARDIER]) : (userflags & g_access_flag[ACCESS_MAKE_BOMBARDIER])) {
					if(allowed_special(playerid, 1, BOMBARDIER)) command_bombardier(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			
			case ACTION_MAKE_SPY: // Spy command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_SPY]) : (userflags & g_access_flag[ACCESS_MAKE_SPY])) {
					if(allowed_special(playerid, 0, SPY)) command_spy(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}
			
			case ACTION_MAKE_DRAGON: // Dragon command
			{
				if(g_newround ? (userflags & g_access_flag[ACCESS_MODE_DRAGON]) : (userflags & g_access_flag[ACCESS_MAKE_DRAGON])) {
					if(allowed_special(playerid, 1, DRAGON)) command_dragon(id, playerid)
					else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT")
				}
				else zp_colored_print(id, "^x04[ZP]^x01 %L", id, "CMD_NOT_ACCESS")
			}

			case ACTION_RESPAWN_PLAYER: // Respawn command
			{
				if(userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS]) {
					if(allowed_respawn(playerid)) command_respawn(id, playerid)
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
	if(g_newround)
	{
		// Start Mode Infection
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_INFECTION], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Zombie
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_ZOMBIE], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be zombie
	if(!allowed_zombie(player))
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
	if(!cmd_access(id, g_access_flag[ACCESS_MAKE_HUMAN], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be human
	if(!allowed_human(player))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_human(id, player)
	
	return PLUGIN_HANDLED;
}

// z
// zp_survivor [target]
public cmd_survivor(id, level, cid)
{
	if(!g_hm_special_enable[SURVIVOR]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Survivor
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Survivor
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_SURVIVOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be survivor
	if(!allowed_special(player, 0, SURVIVOR))
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
	if(!g_zm_special_enable[NEMESIS]) 
		return PLUGIN_HANDLED;
	
	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Nemesis
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Nemesis
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_NEMESIS], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be nemesis
	if(!allowed_special(player, 1, NEMESIS)) {
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
	if(!cmd_access(id, g_access_flag[ACCESS_RESPAWN_PLAYERS], cid, 2))
		return PLUGIN_HANDLED;
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be respawned
	if(!allowed_respawn(player))
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
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_SWARM], cid, 2))
		return PLUGIN_HANDLED;
	
	// Swarm mode not allowed
	if(!allowed_swarm())
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
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_MULTI], cid, 2))
		return PLUGIN_HANDLED;
	
	// Multi infection mode not allowed
	if(!allowed_multi())
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
	if(!g_zm_special_enable[NEMESIS] || !g_hm_special_enable[SURVIVOR]) 
		return PLUGIN_HANDLED;

	// Check for access flag - Mode Plague
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_PLAGUE], cid, 2))
		return PLUGIN_HANDLED;
	
	// Plague mode not allowed
	if(!allowed_plague())
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
	if(!g_hm_special_enable[SNIPER]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Sniper
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_SNIPER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Sniper
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_SNIPER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be sniper
	if(!allowed_special(player, 0, SNIPER))
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
	if(!g_zm_special_enable[ASSASSIN]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_ASSASSIN], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_ASSASSIN], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be assassin
	if(!allowed_special(player, 1, ASSASSIN))
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
	if(!g_zm_special_enable[PREDATOR]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_PREDATOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_PREDATOR], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be predator
	if(!allowed_special(player, 1, PREDATOR))
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
	if(!g_zm_special_enable[BOMBARDIER]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_BOMBARDIER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_BOMBARDIER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be bombardier
	if(!allowed_special(player, 1, BOMBARDIER))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_bombardier(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_dragon [target]
public cmd_dragon(id, level, cid)
{
	if(!g_zm_special_enable[DRAGON]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_DRAGON], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Assassin
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_DRAGON], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be dragon
	if(!allowed_special(player, 1, DRAGON))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_dragon(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_berserker [target]
public cmd_berserker(id, level, cid)
{
	if(!g_hm_special_enable[BERSERKER]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Berserker
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_BERSERKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Berserker
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_BERSERKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be berserker
	if(!allowed_special(player, 0, BERSERKER))
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
	if(!g_hm_special_enable[WESKER]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Wesker
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_WESKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Wesker
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_WESKER], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be wesker
	if(!allowed_special(player, 0, WESKER))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_wesker(id, player)
	
	return PLUGIN_HANDLED;
}

// zp_spy [target]
public cmd_spy(id, level, cid)
{
	if(!g_hm_special_enable[SPY]) 
		return PLUGIN_HANDLED;
	
	// Check for access flag depending on the resulting action
	if(g_newround)
	{
		// Start Mode Spy
		if(!cmd_access(id, g_access_flag[ACCESS_MODE_SPY], cid, 2))
			return PLUGIN_HANDLED;
	}
	else
	{
		// Make Spy
		if(!cmd_access(id, g_access_flag[ACCESS_MAKE_SPY], cid, 2))
			return PLUGIN_HANDLED;
	}
	
	// Retrieve arguments
	static arg[32], player
	read_argv(1, arg, charsmax(arg))
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	// Invalid target
	if(!player) return PLUGIN_HANDLED;
	
	// Target not allowed to be spy
	if(!allowed_special(player, 0, SPY))
	{
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_spy(id, player)
	
	return PLUGIN_HANDLED;
}
// zp_lnj
public cmd_lnj(id, level, cid)
{
	if(!g_zm_special_enable[NEMESIS] || !g_hm_special_enable[SURVIVOR]) 
		return PLUGIN_HANDLED;

	// Check for access flag - Mode Apocalypse
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_LNJ], cid, 2))
		return PLUGIN_HANDLED;
	
	// Apocalypse mode not allowed
	if(!allowed_lnj())
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
	if(!g_isalive[msg_entity] || g_zombie[msg_entity] || g_hm_special[msg_entity] == BERSERKER)
		return;
	
	// Not an active weapon
	if(get_msg_arg_int(1) != 1)
		return;
		
	if(g_hm_special[msg_entity] >= MAX_SPECIALS_HUMANS) {
		if(ArrayGetCell(g_hm_special_uclip, g_hm_special[msg_entity]-MAX_SPECIALS_HUMANS) <= 1)
			return;
	}

	// Unlimited clip disabled for class
	if(g_hm_special[msg_entity] < MAX_SPECIALS_HUMANS) {
		if(get_pcvar_num(cvar_hm_infammo[g_hm_special[msg_entity]]) <= 1)
			return;
	}
	
	// Get weapon's id
	static weapon
	weapon = get_msg_arg_int(2)
	
	// Unlimited Clip Ammo for this weapon?
	if(MAXBPAMMO[weapon] > 2)
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
	if(!get_pcvar_num(cvar_removemoney))
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
	if(health < 256) return;
	
	// Check if we need to fix it
	if(health % 256 == 0)
		fm_set_user_health(msg_entity, pev(msg_entity, pev_health) + 1)
	
	// HUD can only show as much as 255 hp
	set_msg_arg_int(1, get_msg_argtype(1), 255)
}

// Fix Hud when armor is multiples of 999
public message_armor(msg_id, msg_dest, msg_entity)
{
	// Get player's health
	static armor
	armor = get_msg_arg_int(1)
	
	// Don't bother
	if(armor < 1000) 
		return;
	
	// HUD can only show as much as 999 armor
	set_msg_arg_int(1, get_msg_argtype(1), 999)
}

// Block flashlight battery messages if custom flashlight is enabled instead
public message_flashbat()
{
	if(g_cached_customflash)
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Flashbangs should only affect zombies
public message_screenfade(msg_id, msg_dest, msg_entity)
{
	if(get_msg_arg_int(4) != 255 || get_msg_arg_int(5) != 255 || get_msg_arg_int(6) != 255 || get_msg_arg_int(7) < 200)
		return PLUGIN_CONTINUE;
	
	// Nemesis/Assassin shouldn't be FBed
	if(g_zombie[msg_entity] && g_zm_special[msg_entity] <= 0)
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
public message_nvgtoggle() {
	return PLUGIN_HANDLED;
}

// Set correct model on player corpses
public message_clcorpse() {
	set_msg_arg_string(1, g_playermodel[get_msg_arg_int(12)])
}

// Prevent zombies from seeing any weapon pickup icon
public message_weappickup(msg_id, msg_dest, msg_entity)
{
	if(g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Prevent zombies from seeing any ammo pickup icon
public message_ammopickup(msg_id, msg_dest, msg_entity)
{
	if(g_zombie[msg_entity])
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Block hostage HUD display
public message_scenario()
{
	if(get_msg_args() > 1)
	{
		static sprite[8]
		get_msg_arg_string(2, sprite, charsmax(sprite))
		
		if(equal(sprite, "hostage"))
			return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block hostages from appearing on radar
public message_hostagepos() {
	return PLUGIN_HANDLED;
}

// Block some text messages
public message_textmsg()
{
	static textmsg[22]
	get_msg_arg_string(2, textmsg, charsmax(textmsg))
	
	// Game restarting, reset scores and call round end to balance the teams
	if(equal(textmsg, "#Game_will_restart_in"))
	{
		g_scorehumans = 0
		g_scorezombies = 0
		logevent_round_end()
	}
	// Block round end related messages
	else if(equal(textmsg, "#Hostages_Not_Rescued") || equal(textmsg, "#Round_Draw") || equal(textmsg, "#Terrorists_Win") || equal(textmsg, "#CTs_Win")) {
		return PLUGIN_HANDLED;
	}
	
	return PLUGIN_CONTINUE;
}

// Block CS round win audio messages, since we're playing our own instead
public message_sendaudio()
{
	static audio[17]
	get_msg_arg_string(2, audio, charsmax(audio))
	
	if(equal(audio[7], "terwin") || equal(audio[7], "ctwin") || equal(audio[7], "rounddraw"))
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}

// Send actual team scores (T = zombies // CT = humans)
public message_teamscore()
{
	static team[2]
	get_msg_arg_string(1, team, charsmax(team))
	
	switch (team[0]) {
		case 'C': set_msg_arg_int(2, get_msg_argtype(2), g_scorehumans) // CT
		case 'T': set_msg_arg_int(2, get_msg_argtype(2), g_scorezombies) // Terrorist
	}
}

// Team Switch (or player joining a team for first time)
public message_teaminfo(msg_id, msg_dest)
{
	// Only hook global messages
	if(msg_dest != MSG_ALL && msg_dest != MSG_BROADCAST) return;
	
	// Don't pick up our own TeamInfo messages for this player (bugfix)
	if(g_switchingteam) return;
	
	// Get player's id
	static id
	id = get_msg_arg_int(1)
	
	// Enable spectators' nightvision if not spawning right away
	set_task(0.2, "spec_nvision", id)
	
	// Round didn't start yet, nothing to worry about
	if(g_newround) return;
	
	// Get his new team
	static team[2]
	get_msg_arg_string(2, team, charsmax(team))
	
	// Perform some checks to see if they should join a different team instead
	switch (team[0])
	{
		case 'C': // CT
		{
			if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM && fnGetHumans()) // survivor, sniper and berserker alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
			else if(!fnGetZombies()) // no zombies alive --> switch to T and spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
		}
		case 'T': // Terrorist
		{
			if(g_currentmode >= MODE_SURVIVOR && g_currentmode <= MODE_SWARM && fnGetHumans()) // survivor/sniper/berserker alive or swarm round w\ humans --> spawn as zombie
			{
				g_respawn_as_zombie[id] = true;
			}
			else if(fnGetZombies()) // zombies alive --> switch to CT
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
	if(iPlayersnum < 1)
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
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SWARM) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_SWARM])) == get_pcvar_num(cvar_mod_enable[MODE_SWARM]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_SWARM]))
	|| mode == MODE_SET)
	{		
		// Swarm Mode
		g_currentmode = MODE_SWARM
		g_lastmode = MODE_SWARM
		
		// Prevent Infection
		g_allowinfection = false
		
		// Make sure there are alive players on both teams (BUGFIX)
		if(!fnGetAliveTs())
		{
			// Move random player to T team
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			fm_user_team_update(id)
		}
		else if(!fnGetAliveCTs())
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
			if(!g_isalive[id])
				continue;
			
			// Not a Terrorist
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_T)
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play swarm sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Swarm HUD notice
		set_hudmessage(20, 255, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SWARM")
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_SWARM])
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
	if(!g_zm_special_enable[NEMESIS] || !g_hm_special_enable[SURVIVOR]) {
		start_multi_mode(0, MODE_NONE)
		return;
	}
		
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64], iZombies, iMaxZombies
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PLAGUE) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_PLAGUE])) == get_pcvar_num(cvar_mod_enable[MODE_PLAGUE]) 
	&& floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) >= 1&& 
	iPlayersnum-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) >= 1 
	&& iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_PLAGUE])) || mode == MODE_SET)
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
			if(g_hm_special[id] == SURVIVOR)
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
			if(g_hm_special[id] == SURVIVOR || g_zm_special[id] == NEMESIS)
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
			if(++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Random chance
			if(random_num(0, 1))
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
			if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play plague sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Plague HUD notice
		set_hudmessage(0, 50, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_PLAGUE")
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE])
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
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_MULTI) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_MULTI])) == get_pcvar_num(cvar_mod_enable[MODE_MULTI]) && 
	floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_MULTI]))
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
			if(++id > g_maxplayers) id = 1
			
			// Dead or already a zombie
			if(!g_isalive[id] || g_zombie[id])
				continue;
			
			// Random chance
			if(random_num(0, 1))
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
			if(!g_isalive[id] || g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
		}
		
		// Play multi infection sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Multi Infection HUD notice
		set_hudmessage(200, 50, 0, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_MULTI")
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
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
	if(!g_zm_special_enable[NEMESIS] || !g_hm_special_enable[SURVIVOR]) {
		start_sniper_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static sound[64], iZombies, iMaxZombies
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_LNJ) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_LNJ])) == get_pcvar_num(cvar_mod_enable[MODE_LNJ]) &&
	iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_LNJ]) && floatround(iPlayersnum*get_pcvar_float(cvar_lnjratio), floatround_ceil) >= 1 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum)
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
			if(++id > g_maxplayers) id = 1
			
			// Dead or already a zombie or survivor
			if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Random chance
			if(random_num(0, 1))
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
			if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR)
				continue;
			
			// Turn into a Survivor
			humanme(id, SURVIVOR, 0)
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti)))
		}
		
		// Play armageddon sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Armageddon HUD notice
		set_hudmessage(181 , 62, 244, -1.0, 0.17, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_LNJ")
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_LNJ])
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
	if(!g_hm_special_enable[SNIPER]) {
		start_survivor_mode(0, MODE_NONE)
		return;
	}
	
	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SNIPER) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_SNIPER])) == get_pcvar_num(cvar_mod_enable[MODE_SNIPER]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_SNIPER]))
	|| mode == MODE_SET)
	{
		// Sniper Mode
		g_currentmode = MODE_SNIPER
		g_lastmode = MODE_SNIPER
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make sniper
		humanme(id, SNIPER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// Sniper or already a zombie
			if(g_hm_special[id] == SNIPER || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play sniper sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show Sniper HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SNIPER", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_SNIPER])
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
	if(!g_hm_special_enable[SURVIVOR]) {
		start_assassin_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SURVIVOR) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_SURVIVOR])) == get_pcvar_num(cvar_mod_enable[MODE_SURVIVOR]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_SURVIVOR]))
	|| mode == MODE_SET)
	{
		// Survivor Mode
		g_currentmode = MODE_SURVIVOR
		g_lastmode = MODE_SURVIVOR
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into a survivor
		humanme(id, SURVIVOR, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// Survivor or already a zombie
			if(g_hm_special[id] == SURVIVOR || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}
		
		// Play survivor sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Survivor HUD notice
		set_hudmessage(0, 10, 255, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SURVIVOR", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_SURVIVOR])
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
	if(!g_zm_special_enable[ASSASSIN]) {
		start_nemesis_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_ASSASSIN) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_ASSASSIN])) == get_pcvar_num(cvar_mod_enable[MODE_ASSASSIN]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_ASSASSIN]))
	|| mode == MODE_SET)
	{
		// Assassin Mode
		g_currentmode = MODE_ASSASSIN
		g_lastmode = MODE_ASSASSIN
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
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
			if(!g_isalive[id])
				continue;
			
			// First assassin
			if(g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			
			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[ASSASSIN]), get_pcvar_num(cvar_zm_green[ASSASSIN]), get_pcvar_num(cvar_zm_blue[ASSASSIN]), 255)

			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Assassin sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[ASSASSIN]), get_pcvar_num(cvar_zm_green[ASSASSIN]), get_pcvar_num(cvar_zm_blue[ASSASSIN]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_ASSASSIN", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_ASSASSIN])
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
	if(!g_zm_special_enable[NEMESIS]) {
		start_berserker_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_NEMESIS) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_NEMESIS])) == get_pcvar_num(cvar_mod_enable[MODE_NEMESIS]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_NEMESIS]))
	|| mode == MODE_SET)
	{
		// Nemesis Mode
		g_currentmode = MODE_NEMESIS
		g_lastmode = MODE_NEMESIS
			
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into nemesis
		zombieme(id, 0, NEMESIS, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// First nemesis
			if(g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[NEMESIS]), get_pcvar_num(cvar_zm_green[NEMESIS]), get_pcvar_num(cvar_zm_blue[NEMESIS]), 255)
		}
		
		// Play Nemesis sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Nemesis HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[NEMESIS]), get_pcvar_num(cvar_zm_green[NEMESIS]), get_pcvar_num(cvar_zm_blue[NEMESIS]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_NEMESIS", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_NEMESIS])
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
	if(!g_hm_special_enable[BERSERKER]) {
		start_predator_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_BERSERKER) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_BERSERKER])) == get_pcvar_num(cvar_mod_enable[MODE_BERSERKER]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_BERSERKER]))
	|| mode == MODE_SET)
	{
		// Berserker Mode
		g_currentmode = MODE_BERSERKER
		g_lastmode = MODE_BERSERKER
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make Berserker
		humanme(id, BERSERKER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// Berserker or already a zombie
			if(g_hm_special[id] == BERSERKER || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play berserker sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show berserker HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_BERSERKER", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_BERSERKER])
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
	if(!g_zm_special_enable[PREDATOR]) {
		start_wesker_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PREDATOR) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_PREDATOR])) == get_pcvar_num(cvar_mod_enable[MODE_PREDATOR]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_PREDATOR]))
	|| mode == MODE_SET)
	{
		// Predator Mode
		g_currentmode = MODE_PREDATOR
		g_lastmode = MODE_PREDATOR
		
		// Prevent Infection
		g_allowinfection = false
		
		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into predator
		zombieme(id, 0, PREDATOR, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// First predator
			if(g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			
			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[PREDATOR]), get_pcvar_num(cvar_zm_green[PREDATOR]), get_pcvar_num(cvar_zm_blue[PREDATOR]), 255)

			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Predator sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[PREDATOR]), get_pcvar_num(cvar_zm_green[PREDATOR]), get_pcvar_num(cvar_zm_blue[PREDATOR]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_PREDATOR", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_PREDATOR])
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
	if(!g_hm_special_enable[WESKER]) {
		start_bombardier_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_WESKER) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_WESKER])) == get_pcvar_num(cvar_mod_enable[MODE_WESKER]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_WESKER]))
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
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make Wesker
		humanme(id, WESKER, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// Wesker or already a zombie
			if(g_hm_special[id] == WESKER || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play wesker sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show wesker HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_WESKER", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_WESKER])
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
	if(!g_zm_special_enable[BOMBARDIER]) {
		start_spy_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_BOMBARDIER) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_BOMBARDIER])) == get_pcvar_num(cvar_mod_enable[MODE_BOMBARDIER]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_BOMBARDIER]))
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
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into bombardier
		zombieme(id, 0, BOMBARDIER, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// First bombardier
			if(g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[BOMBARDIER]), get_pcvar_num(cvar_zm_green[BOMBARDIER]), get_pcvar_num(cvar_zm_blue[BOMBARDIER]), 255)

			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Bombardier sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[BOMBARDIER]), get_pcvar_num(cvar_zm_green[BOMBARDIER]), get_pcvar_num(cvar_zm_blue[BOMBARDIER]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_BOMBARDIER", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_BOMBARDIER])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_BOMBARDIER, forward_id);
		
		// Stop here
		return;
	}
	// Give chance to other game modes
	start_spy_mode(0, MODE_NONE)
}

// Start spy mode
start_spy_mode(id, mode)
{
	if(!g_hm_special_enable[SPY]) {
		start_dragon_mode(0, MODE_NONE)
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SPY) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_SPY])) == get_pcvar_num(cvar_mod_enable[MODE_SPY]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_SPY]))
	|| mode == MODE_SET)
	{
		// spy Mode
		g_currentmode = MODE_SPY
		g_lastmode = MODE_SPY
		
		// Prevent Infection
		g_allowinfection = false
		g_modestarted = true
		g_newround = false

		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
		
		// Remember id for calling our forward later
		forward_id = id
		
		// Make spy
		humanme(id, SPY, 0)
		
		// Turn the remaining players into zombies
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// spy or already a zombie
			if(g_hm_special[id] == SPY || g_zombie[id])
				continue;
			
			// Turn into a zombie
			zombieme(id, 0, 0, 1, 0)
		}

		// Play spy sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show spy HUD notice
		set_hudmessage(0 , 250, 250, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SPY", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_SPY])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_SPY, forward_id);
		
		// Stop here
		return;
	}
	
	// Give chance to other game modes
	start_dragon_mode(0, MODE_NONE)
}


// Start dragon mode
start_dragon_mode(id, mode)
{
	if(!g_zm_special_enable[DRAGON]) {
		start_custom_mode()
		return;
	}

	// Get alive players count
	static iPlayersnum
	iPlayersnum = fnGetAlive()
	
	static forward_id, sound[64]
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_DRAGON) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_DRAGON])) == get_pcvar_num(cvar_mod_enable[MODE_DRAGON]) && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_DRAGON]))
	|| mode == MODE_SET)
	{
		// Berserker Mode
		g_currentmode = MODE_DRAGON
		g_lastmode = MODE_DRAGON
		
		// Prevent Infection
		g_allowinfection = false
		g_modestarted = true
		g_newround = false

		// Choose player randomly?
		if(mode == MODE_NONE)
			id = fnGetRandomAlive(random_num(1, iPlayersnum))
			
		// Remember id for calling our forward later
		forward_id = id
		
		// Turn player into dragon
		zombieme(id, 0, DRAGON, 0, 0)
		
		// Remaining players should be humans (CTs)
		for (id = 1; id <= g_maxplayers; id++)
		{
			// Not alive
			if(!g_isalive[id])
				continue;
			
			// First dragon
			if(g_zombie[id])
				continue;
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
			{
				// Change team
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}
			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[DRAGON]), get_pcvar_num(cvar_zm_green[DRAGON]), get_pcvar_num(cvar_zm_blue[DRAGON]), 255)

			
			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}
		
		// Play Dragon sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Assassin HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[DRAGON]), get_pcvar_num(cvar_zm_green[DRAGON]), get_pcvar_num(cvar_zm_blue[DRAGON]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_DRAGON", g_playername[forward_id])
		
		// Start ambience sounds
		if(g_ambience_sounds[AMBIENCE_SOUNDS_DRAGON])
		{
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		// Round start forward
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_DRAGON, forward_id);
		
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
		if((random_num(1, ArrayGetCell(g_gamemode_chance, (game - MAX_GAME_MODES))) == 1) && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != game) && (ArrayGetCell(g_gamemode_enable, (game - MAX_GAME_MODES)) > 0))
		{
			// Execute our round start pre forward
			// This is were the game mode will decide whether to run itself or block it self
			ExecuteForward(g_forwards[ROUND_START_PRE], g_fwDummyResult, game)
			
			// The game mode didnt accept some conditions
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED)
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
					update_team(id)
				}
				// Stop the loop and prevent other game modes from being given a chance [BUGFIX]
				break;
			}
		}
		// The game mode was not given a chance then continue the loop
		else continue;
	}
	
	// No game mode has started then start our good old infection mode [BUGFIX]
	if(!g_modestarted)
		start_infection_mode(0, MODE_NONE)
}

public update_team(id)
{
	if(!g_isalive[id])
		return
		
	if(!g_zombie[id])
	{
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
		{
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
	}
	else
	{
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) // need to change team?
		{
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			fm_user_team_update(id)
		}
	}
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
	if(mode == MODE_NONE)
		id = fnGetRandomAlive(random_num(1, iPlayersnum))
	
	// Turn player into the first zombie
	zombieme(id, 0, 0, 0, 0)
	
	// Remember id for calling our forward later
	forward_id = id
	
	// Remaining players should be humans (CTs)
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Not alive
		if(!g_isalive[id])
			continue;
		
		// First zombie
		if(g_zombie[id])
			continue;
		
		// Switch to CT
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
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
	if(g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION])
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
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetZombies() > g_lastplayerleaving)
		return;
	
	// Pre user infect forward
	ExecuteForward(g_forwards[INFECTED_PRE], g_fwDummyResult, id, infector, classid)
	
	// Remove aura (bugfix)
	remove_task(id+TASK_AURA)
	
	if(silentmode != 2) remove_task(id) // Nao buga a frozen
	
	// Show zombie class menu if they haven't chosen any (e.g. just connected)
	if(g_zombieclassnext[id] == ZCLASS_NONE && get_pcvar_num(cvar_zclasses) && classid <= 0
	|| !g_choosed_zclass[id] && get_pcvar_num(cvar_zclasses) && classid <= 0 && get_pcvar_num(cvar_chosse_instantanly))
		set_task(0.2, "show_menu_zclass", id)
	
	g_zombieclass[id] = g_zombieclassnext[id]

	if(g_zombieclass[id] == ZCLASS_NONE) 
		g_zombieclass[id] = 0
	
	// Way to go...
	g_zombie[id] = true
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	if(silentmode != 2) g_firstzombie[id] = false
	g_user_custom_speed[id] = false
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	// Reset burning duration counter (bugfix)
	g_burning_dur[id] = 0
	if(silentmode != 2 || classid > 0) native_set_user_frozen(id, 0)
	
	// Show deathmsg and reward infector?
	if(rewards && infector)
	{
		// Send death notice and fix the "dead" attrib on scoreboard
		SendDeathMsg(infector, id)
		FixDeadAttrib(id)
		
		// Reward frags, deaths, health, and ammo packs
		UpdateFrags(infector, id, get_pcvar_num(cvar_fragsinfect), 1, 1)
		g_ammopacks[infector] += get_pcvar_num(cvar_ammoinfect)
		fm_set_user_health(infector, pev(infector, pev_health) + get_pcvar_num(cvar_zm_basehp[0]))
	}
	
	// Cache speed, 	, and name for player's class
	g_spd[id] = float(ArrayGetCell(g_zclass_spd, g_zombieclass[id]))
	g_zombie_knockback[id] = Float:ArrayGetCell(g_zclass_kb, g_zombieclass[id])
	ArrayGetString(g_zclass_name, g_zombieclass[id], g_zombie_classname[id], charsmax(g_zombie_classname[]))
	
	// Set zombie attributes based on the mode
	static sound[64]
	if(!silentmode)
	{
		if(classid >= MAX_SPECIALS_ZOMBIES) 
		{
			g_zm_special[id] = classid
			
			new special_id = g_zm_special[id]-MAX_SPECIALS_ZOMBIES
			
			// Set Health [0 = auto]
			if(ArrayGetCell(g_zm_special_health, special_id) == 0)
			{
				if(ArrayGetCell(g_zm_special_health, special_id) == 0)
					fm_set_user_health(id, get_pcvar_num(cvar_zm_health[0]) * fnGetAlive())
				else
					fm_set_user_health(id, ArrayGetCell(g_zm_special_health, special_id) * fnGetAlive())
			}
			else
				fm_set_user_health(id, ArrayGetCell(g_zm_special_health, special_id))
			
			// Set gravity, unless frozen
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zm_special_gravity, special_id))
			
			g_spd[id] = float(ArrayGetCell(g_zm_special_speed, g_zm_special[id]-MAX_SPECIALS_ZOMBIES))
			g_custom_leap_cooldown[id] = Float:ArrayGetCell(g_zm_special_leap_c, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)
			g_zombie_knockback[id] = Float:ArrayGetCell(g_zm_special_knockback, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)
		}
		else if(classid > 0 && g_zm_special_enable[classid])
		{
			g_zm_special[id] = classid
			
			// Set health [0 = auto]
			if(get_pcvar_num(cvar_zm_health[classid]) == 0)
			{
				if(get_pcvar_num(cvar_zm_basehp[classid]) == 0)
					fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else
					fm_set_user_health(id, get_pcvar_num(cvar_zm_basehp[classid]) * fnGetAlive())
			}
			else
				fm_set_user_health(id, get_pcvar_num(cvar_zm_health[classid]))
				
			// Set gravity, unless frozen
			if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_zmgravity[classid]))
			
			if(classid == PREDATOR) { // Predator Powers
				g_zm_special[id] = PREDATOR
				set_task(1.0, "turn_invisible", id)
			}
			else if(classid == BOMBARDIER) { // Bombardier Powers
				give_hegrenade_bombardier(id+1213131)
				set_task(3.0, "give_hegrenade_bombardier", id+1213131, _, _, "b")
			}
			else if(classid == DRAGON){
				if(g_isbot[id]) set_task(random_float(5.0, 15.0), "use_cmd", id, _, _, "b") // Dragon Skills Bot Suport
				zp_colored_print(id, "^x04[ZP]^x01 %L", id, "DRAGON_INFO") // Dragon Info Msg
			}
		}
		else if((fnGetZombies() == 1) && g_zm_special[id] <= 0)
		{
			// First zombie
			g_firstzombie[id] = true
			
			// Set health and gravity, unless frozen
			fm_set_user_health(id, floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zm_health[0])))
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
		}
		else
		{
			// Infected by someone
			
			// Set health and gravity, unless frozen
			if(silentmode != 2) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id]))
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			
			// Infection sound
			ArrayGetString(zombie_infect, random_num(0, ArraySize(zombie_infect) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Show Infection HUD notice
			set_hudmessage(255, 0, 0, HUD_INFECT_X, HUD_INFECT_Y, 0, 0.0, 5.0, 1.0, 1.0, -1)
			
			if(infector) // infected by someone?
				ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT2", g_playername[id], g_playername[infector])
			else
				ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT", g_playername[id])
		}
	}
	else
	{
		// Silent mode, no HUD messages, no infection sounds
		
		// Set health and gravity, unless frozen
		if(silentmode != 2) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id])) // Dont change HP when choose other zclass instantanly
		if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
	}
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	
	// Switch to T
	if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
		fm_user_team_update(id)
	}
	
	reset_player_models(id) 
	if(!g_frozen[id]) reset_user_rendering(id)
	
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
	if(g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
		if(g_zm_special[id] > 0 && g_zm_special_enable[g_zm_special[id]] && get_pcvar_num(cvar_zm_aura[g_zm_special[id]]))
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
	}
	else {
		if(ArrayGetCell(g_zm_special_aurarad, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0)
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
	}
		
	// Give Zombies Night Vision?
	if(get_pcvar_num(cvar_nvggive))
	{
		g_nvision[id] = true
		
		if(!g_isbot[id]) {
			// Turn on Night Vision automatically?
			if(get_pcvar_num(cvar_nvggive) == 1) {
				g_nvisionenabled[id] = true
				
				// Custom nvg?
				if(get_pcvar_num(cvar_customnvg)) {
					remove_task(id+TASK_NVISION)
					set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
				}
				else set_user_gnvision(id, 1)
			}
			// Turn off nightvision when infected (bugfix)
			else if(g_nvisionenabled[id]) {
				if(get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
				else set_user_gnvision(id, 0)
				g_nvisionenabled[id] = false
			}
		}
		else cs_set_user_nvg(id, 1); // turn on NVG for bots
	}
	// Disable nightvision when infected (bugfix)
	else if(g_nvision[id]) {
		if(g_isbot[id]) cs_set_user_nvg(id, 0) // Turn off NVG for bots
		if(get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
		else if(g_nvisionenabled[id]) set_user_gnvision(id, 0)
		g_nvision[id] = false
		g_nvisionenabled[id] = false
	}
	
	// Set custom FOV?
	if(get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0) {
		message_begin(MSG_ONE, g_msgSetFOV, _, id)
		write_byte(get_pcvar_num(cvar_zombiefov)) // fov angle
		message_end()
	}
	
	// Call the bloody task
	if(g_zm_special[id] <= 0 && get_pcvar_num(cvar_zombiebleeding))
		set_task(0.7, "make_blood", id+TASK_BLOOD, _, _, "b")
	
	// Idle sounds task
	if(g_zm_special[id] <= 0)
		set_task(random_float(50.0, 70.0), "zombie_play_idle", id+TASK_BLOOD, _, _, "b")
	
	// Turn off zombie's flashlight
	turn_off_flashlight(id)
	
	// Post user infect forward
	ExecuteForward(g_forwards[INFECTED_POST], g_fwDummyResult, id, infector, classid)
	
	// Last Zombie Check
	fnCheckLastZombie()

	reset_player_models(id) 
	if(!g_frozen[id]) reset_user_rendering(id)
}


// Function Human Me (player id, turn into a survivor, silent mode)
humanme(id, classid, silentmode)
{
	// User humanize attempt forward
	ExecuteForward(g_forwards[HUMANIZE_ATTEMP], g_fwDummyResult, id, classid)
	
	// One or more plugins blocked the "humanization". Only allow this after making sure it's
	// not going to leave us with no humans. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first survivor e.g.
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetHumans() > g_lastplayerleaving)
		return;
	
	// Pre user humanize forward
	ExecuteForward(g_forwards[HUMANIZED_PRE], g_fwDummyResult, id, classid)
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	remove_task(id+TASK_NVISION)
	remove_task(id)
	
	// Reset some vars
	g_zombie[id] = false
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	g_firstzombie[id] = false
	g_canbuy[id] = true
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	g_user_custom_speed[id] = false
	g_choosed_zclass[id] = false
	
	// Remove survivor/sniper/berserker's aura (bugfix)
	remove_task(id+TASK_AURA)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)
	
	native_set_user_frozen(id, 0)
	
	// Reset burning duration counter (bugfix)
	g_burning_dur[id] = 0
	
	// Drop previous weapons
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip off from weapons
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")

	// Set human attributes based on the mode
	if(classid >= MAX_SPECIALS_HUMANS) 
	{
		g_hm_special[id] = classid
		
		new special_id = g_hm_special[id]-MAX_SPECIALS_HUMANS
		
		// Set Health [0 = auto]
		if(ArrayGetCell(g_hm_special_health, special_id) == 0)
		{
			if(ArrayGetCell(g_hm_special_health, special_id) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]) * fnGetAlive())
			else
				fm_set_user_health(id, ArrayGetCell(g_hm_special_health, special_id) * fnGetAlive())
		}
		else
			fm_set_user_health(id, ArrayGetCell(g_hm_special_health, special_id))
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_hm_special_gravity, special_id))
		
		g_spd[id] = float(ArrayGetCell(g_hm_special_speed, g_hm_special[id]-MAX_SPECIALS_HUMANS))
		g_custom_leap_cooldown[id] = Float:ArrayGetCell(g_hm_special_leap_c, g_hm_special[id]-MAX_SPECIALS_HUMANS)
		
		// Turn off his flashlight
		turn_off_flashlight(id)

		// Give the special a nice aura
		if(ArrayGetCell(g_hm_special_aurarad, special_id) > 0)
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Special Humans bots will also need nightvision to see in the dark
		if(g_isbot[id]) {
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else if(classid > 0 && g_hm_special_enable[classid]) {
		g_hm_special[id] = classid
			
		// Set Health [0 = auto]
		if(get_pcvar_num(cvar_hm_health[classid]) == 0)
		{
			if(get_pcvar_num(cvar_hm_basehp[classid]) == 0)
				fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]) * fnGetAlive())
			else
				fm_set_user_health(id, get_pcvar_num(cvar_hm_basehp[classid]) * fnGetAlive())
		}
		else
			fm_set_user_health(id, get_pcvar_num(cvar_hm_health[classid]))
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[classid]))
		
		// Turn off his flashlight
		turn_off_flashlight(id)
		
		// Give the goku a nice aura
		if(get_pcvar_num(cvar_hm_aura[classid]))
			set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b")
		
		// Special Humans bots will also need nightvision to see in the dark
		if(g_isbot[id]) {
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
		
		// Set human attributes based on the mode
		if(g_hm_special[id] == SURVIVOR) {
			static survweapon[32]
			get_pcvar_string(cvar_survweapon, survweapon, charsmax(survweapon))
			fm_give_item(id, survweapon)
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[cs_weapon_name_to_id(survweapon)], AMMOTYPE[cs_weapon_name_to_id(survweapon)], MAXBPAMMO[cs_weapon_name_to_id(survweapon)])
		}
		else if(g_hm_special[id] == SNIPER) {
			fm_give_item(id, "weapon_awp")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_AWP], AMMOTYPE[CSW_AWP], MAXBPAMMO[CSW_AWP])
		}
		else if(g_hm_special[id] == BERSERKER) {
			fm_give_item(id, "weapon_knife")
			g_currentweapon[id] = CSW_KNIFE
			replace_weapon_models(id, g_currentweapon[id])
		}
		else if(g_hm_special[id] == WESKER) {
			fm_give_item(id, "weapon_deagle")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_DEAGLE], AMMOTYPE[CSW_DEAGLE], MAXBPAMMO[CSW_DEAGLE])
		}
		else if(g_hm_special[id] == SPY)	{
			fm_give_item(id, "weapon_m3")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_M3], AMMOTYPE[CSW_M3], MAXBPAMMO[CSW_M3])
			set_task(1.0, "turn_invisible", id)
		}
	}
	else
	{
		// Human taking an antidote
		
		// Set health
		fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]))
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[0]))
		
		// Show custom buy menu?
		if(get_pcvar_num(cvar_buycustom))
			set_task(0.2, "show_menu_buy1", id+TASK_SPAWN)
		
		// Silent mode = no HUD messages, no antidote sound
		if(!silentmode)
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
	if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
	{
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}
	
	reset_player_models(id) 
	if(!g_frozen[id]) reset_user_rendering(id)
	
	// Restore FOV?
	if(get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0) {
		message_begin(MSG_ONE, g_msgSetFOV, _, id)
		write_byte(90) // angle
		message_end()
	}
	
	// Disable nightvision
	if(g_isbot[id]) cs_set_user_nvg(id, 0)
	else if(!get_pcvar_num(cvar_customnvg) && g_nvisionenabled[id]) set_user_gnvision(id, 0)
	
	// Post user humanize forward
	ExecuteForward(g_forwards[HUMANIZED_POST], g_fwDummyResult, id, classid)
	
	// Last Zombie Check
	fnCheckLastZombie()
	
	// Reset user Rendering
	reset_user_rendering(id)
}

/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/
public cache_cvars()
{
	g_cached_zombiesilent = get_pcvar_num(cvar_zombiesilent)
	g_cached_customflash = get_pcvar_num(cvar_customflash)
	
	new i
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++)  {
		g_hm_cached_spd[i] = get_pcvar_float(cvar_hm_spd[i])
		if(i > 0) {
			g_hm_cached_leap[i] = get_pcvar_num(cvar_leap_hm_allow[i])
			g_hm_cached_cooldown[i] = get_pcvar_float(cvar_leap_hm_cooldown[i])
		}
	}
	for(i = 0; i < MAX_SPECIALS_ZOMBIES; i++)  {
		g_zm_cached_leap[i] = get_pcvar_num(cvar_leap_zm_allow[i])
		g_zm_cached_cooldown[i] = get_pcvar_float(cvar_leap_zm_cooldown[i])
		if(i > 0) g_zm_cached_spd[i] = get_pcvar_float(cvar_zm_spd[i])
	}
}

load_customization_from_files()
{
	new path[64]; get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_CUSTOMIZATION_FILE)
	
	// File not present
	if(!file_exists(path))
	{
		new error[100]
		formatex(error, charsmax(error), "[ZP Special] Cannot load customization file %s!", path)
		set_fail_state(error)
		return;
	}

	new i
	new zombie_special_names[MAX_SPECIALS_ZOMBIES][] = { "ZOMBIE", "NEMESIS", "ASSASSIN", "PREDATOR", "BOMBARDIER", "DRAGON" }
	new human_special_names[MAX_SPECIALS_HUMANS][] = { "HUMAN", "SURVIVOR", "SNIPER", "BERSERKER", "WESKER", "SPY" }
	
	// Section Main Configs
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Main Configs", "GAME NAME", g_modname, charsmax(g_modname));
	amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Main Configs", "NADE EXPLOSION RADIUS", NADE_EXPLOSION_RADIUS);
	
	new szKey[150]
	
	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) {
		formatex(szKey, charsmax(szKey), "ENABLE %s", zombie_special_names[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Main Configs", szKey, g_zm_special_enable[i])
	}
	
	for(i = 1; i < MAX_SPECIALS_HUMANS; i++) {
		formatex(szKey, charsmax(szKey), "ENABLE %s", human_special_names[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Main Configs", szKey, g_hm_special_enable[i])
	}

	// Section Access Flags
	new user_access[40]
	new access_names[MAX_ACCESS_FLAGS][] = { "ADMIN MENU OF CLASSES", "ADMIN MENU OF MODES", "ADMIN MENU MAIN ACCESS", "ADMIN MODELS", "VIP MODELS", "RESPAWN PLAYERS",
	"START MODE LNJ", "START MODE INFECTION", "START MODE SWARM", "START MODE MULTI", "START MODE PLAGUE", "START MODE NEMESIS", "START MODE SURVIVOR", "START MODE SNIPER",
	"START MODE ASSASSIN", "START MODE BERSERKER", "START MODE PREDATOR", "START MODE WESKER", "START MODE BOMBARDIER", "START MODE SPY", "START MODE DRAGON", "MAKE ZOMBIE", 
	"MAKE HUMAN", "MAKE NEMESIS", "MAKE SURVIVOR", "MAKE SNIPER", "MAKE ASSASSIN","MAKE BERSERKER", "MAKE PREDATOR", "MAKE WESKER", "MAKE BOMBARDIER", "MAKE SPY", "MAKE DRAGON" }

	for(i = 0; i < MAX_ACCESS_FLAGS; i++) {
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", access_names[i], user_access, charsmax(user_access)); 
		g_access_flag[i] = read_flags(user_access);
	}	
	
	// Player Models
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", human_special_names[i], model_human[i])
	}

	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", zombie_special_names[i], model_zm_special[i])
	}
	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN ZOMBIE", model_admin_zombie)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN HUMAN", model_admin_human)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "VIP HUMAN", model_vip_human)
	
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "FORCE CONSISTENCY", g_force_consistency)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "SAME MODELS FOR ALL", g_same_models_for_all)

	if(g_same_models_for_all) 
	{
		new linedata[1024], key[40], tmodel_buffer[150]
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ZOMBIE", g_zclass_playermodel)
	
		for (i = 0; i < ArraySize(g_zclass_playermodel); i++)
		{
			ArrayGetString(g_zclass_playermodel, i, key, charsmax(key))
			
			// Precache model and retrieve its modelindex
			formatex(linedata, charsmax(linedata), "models/player/%s/%s.mdl", key, key)
			ArrayPushCell(g_zclass_modelindex, engfunc(EngFunc_PrecacheModel, linedata))
			formatex(tmodel_buffer, charsmax(tmodel_buffer), "models/player/%s/%sT.mdl", key, key)
			if(file_exists(tmodel_buffer)) engfunc(EngFunc_PrecacheModel, tmodel_buffer)
			if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, linedata)
			if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, linedata)
		}
		
	}
	
	
	// Weapon Models
	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) {
		formatex(szKey, charsmax(szKey), "V_KNIFE %s", zombie_special_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_vknife_zm_special[i], charsmax(model_vknife_zm_special[]))
	}

	new special_hm_wpn_names[MAX_SPECIALS_HUMANS][] = { "KNIFE HUMAN", "M249 SURVIVOR", "AWP SNIPER", "KNIFE BERSERKER", "DEAGLE WESKER", "M3 SPY" }
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++) {
		formatex(szKey, charsmax(szKey), "V_%s", special_hm_wpn_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_v_weapon_human[i], charsmax(model_v_weapon_human[]));
		formatex(szKey, charsmax(szKey), "P_%s", special_hm_wpn_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_p_weapon_human[i], charsmax(model_p_weapon_human[]));
	}
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
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE DIE", zombie_die)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE FALL", zombie_die)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MISS SLASH", zombie_miss_slash)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MISS WALL", zombie_miss_wall)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE HIT NORMAL", zombie_hit_normal)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE HIT STAB", zombie_hit_stab)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE IDLE", zombie_idle)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE IDLE LAST", zombie_idle_last)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", "ZOMBIE MADNESS", zombie_madness)
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
	
	for(i = 0; i < MAX_SPECIALS_ZOMBIES; i++) {
		formatex(szKey, charsmax(szKey), "%s PAIN", zombie_special_names[i])
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, zombie_pain[i])
	}
	
	new mode_name_str[MAX_GAME_MODES][] = { "NONE", "INFECTION", "NEMESIS", "ASSASSIN", "PREDATOR", "BOMBARDIER", "DRAGON",
	"SURVIVOR", "SNIPER", "BERSERKER", "WESKER", "SPY", "SWARM", "MULTI", "PLAGUE", "LNJ" }
	
	for(i = 2; i < MAX_GAME_MODES; i++) {
		formatex(szKey, charsmax(szKey), "ROUND %s", mode_name_str[i])
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, sound_mod[i])
	}

	// Ambience Sounds
	new ambience_snd_names[MAX_AMBIENCE_SOUNDS][] = { "INFECTION", "NEMESIS", "SURVIVOR", "SWARM", "LNJ", "PLAGUE", "SNIPER", "ASSASSIN",
	"BERSERKER", "PREDATOR", "WESKER", "SPY", "BOMBARDIER", "DRAGON" }

	for(i = 0; i < MAX_AMBIENCE_SOUNDS; i++) {
		formatex(szKey, charsmax(szKey), "%s ENABLE", ambience_snd_names[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", szKey, g_ambience_sounds[i])
		if(g_ambience_sounds[i]) {
			formatex(szKey, charsmax(szKey), "%s SOUNDS", ambience_snd_names[i])
			amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", szKey, sound_ambience[i])
			formatex(szKey, charsmax(szKey), "%s DURATIONS", ambience_snd_names[i])
			amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Ambience Sounds", szKey, sound_ambience_duration[i])
		}
	}
	
	// Buy Menu Weapons
	new wpn_ids[32]
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "PRIMARY", g_primary_items)
	for (i = 0; i < ArraySize(g_primary_items); i++) {
		ArrayGetString(g_primary_items, i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_primary_weaponids, cs_weapon_name_to_id(wpn_ids))
	}	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "SECONDARY", g_secondary_items)
	for (i = 0; i < ArraySize(g_secondary_items); i++) {
		ArrayGetString(g_secondary_items, i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_secondary_weaponids, cs_weapon_name_to_id(wpn_ids))
	}
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "ADDITIONAL ITEMS", g_additional_items)

	// Extra Items: Weapons and their costs
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "NAMES", g_extraweapon_names)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "ITEMS", g_extraweapon_items)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "COSTS", g_extraweapon_costs)	
	
	// Hard Coded Items Costs
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "NIGHT VISION", g_extra_costs2[EXTRA_NVISION])
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "ANTIDOTE", g_extra_costs2[EXTRA_ANTIDOTE])
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "ZOMBIE MADNESS", g_extra_costs2[EXTRA_MADNESS])
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Hard Coded Items Costs", "INFECTION BOMB", g_extra_costs2[EXTRA_INFBOMB])

	// Weather Effects
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "RAIN", g_ambience_rain)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "SNOW", g_ambience_snow)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG", g_ambience_fog)
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG DENSITY", g_fog_density, charsmax(g_fog_density))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weather Effects", "FOG COLOR", g_fog_color, charsmax(g_fog_color))
	
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Custom Skies", "ENABLE", g_sky_enable)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Custom Skies", "SKY NAMES", g_sky_names)
	
	if(g_sky_enable)
	{
		// Choose random sky and precache sky files
		new path[128], skyname[32]//, g_SkyArrayIndex
		//g_SkyArrayIndex = random_num(0, ArraySize(g_sky_names) - 1)
		for (i = 0; i < ArraySize(g_sky_names); i++) {
			ArrayGetString(g_sky_names, i, skyname, charsmax(skyname))
			formatex(path, charsmax(path), "gfx/env/%sbk.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
			formatex(path, charsmax(path), "gfx/env/%sdn.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
			formatex(path, charsmax(path), "gfx/env/%sft.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
			formatex(path, charsmax(path), "gfx/env/%slf.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
			formatex(path, charsmax(path), "gfx/env/%srt.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
			formatex(path, charsmax(path), "gfx/env/%sup.tga", skyname)
			engfunc(EngFunc_PrecacheGeneric, path)
		}
	}

	// Lightning Lights Cycle
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Lightning Lights Cycle", "LIGHTS", lights_thunder)
	
	// Zombie Decals
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Zombie Decals", "DECALS", zombie_decals)
	
	// Knockback Power for Weapons
	new wpn_key
	for(i = 1; i < sizeof WEAPONENTNAMES; i++)
	{
		if(!equal(WEAPONENTNAMES[i], "")) {	
			wpn_key = cs_weapon_name_to_id(WEAPONENTNAMES[i])
			new buffer[32]
			format(buffer, charsmax(buffer), "%s", WEAPONENTNAMES[i])
			replace_all(buffer, charsmax(buffer), "weapon_", "")
			strtoupper(buffer)
			amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Knockback Power for Weapons", buffer, kb_weapon_power[wpn_key])
		}
	}
					
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Objective Entities", "CLASSNAMES", g_objective_ents)
	
	amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "MODELCHANGE DELAY", g_modelchange_delay)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "HANDLE MODELS ON SEPARATE ENT", g_handle_models_on_separate_ent)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "SET MODELINDEX OFFSET", g_set_modelindex_offset)
	
	// Load Zombie Class Custonomization
	load_zclass_file()
}


// Save customization from files
save_customization()
{
	new i, buffer[512], section[512], Float:value_f, value, k, path[512]
	
	// Add any new zombie classes data at the end if needed
	for (i = 0; i < ArraySize(g_zclass_name); i++)
	{
		if(ArrayGetCell(g_zclass_new, i))
		{
			// Get real name
			ArrayGetString(g_zclass_real_name, i, section, charsmax(section))
			
			// Add name
			ArrayGetString(g_zclass_name, i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "NAME", buffer) // Add Name
			
			// Add info
			ArrayGetString(g_zclass_info, i, buffer, charsmax(buffer))
			
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "INFO", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "INFO", buffer) 
				
			for (k = ArrayGetCell(g_zclass_modelsstart, i); k < ArrayGetCell(g_zclass_modelsend, i); k++) {
				if(k == ArrayGetCell(g_zclass_modelsstart, i)) {
					ArrayGetString(g_zclass_playermodel, k, buffer, charsmax(buffer))
				}
				else {
					ArrayGetString(g_zclass_playermodel, k, path, charsmax(path))
					format(buffer, charsmax(buffer), "%s , %s", buffer, path)
				}
			}
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "MODELS", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "MODELS", buffer) // Add models
			
			// Add clawmodel
			ArrayGetString(g_zclass_clawmodel, i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "CLAWMODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "CLAWMODEL", buffer) 
			
			value = ArrayGetCell(g_zclass_hp, i)
			if(!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, section, "HEALTH", value))
				amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, section, "HEALTH", value) // Add health

			value = ArrayGetCell(g_zclass_spd, i)
			if(!amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, section, "SPEED", value))
				amx_save_setting_int(ZP_ZOMBIECLASSES_FILE, section, "SPEED", value) // Add speed

			value_f = Float:ArrayGetCell(g_zclass_grav, i)
			if(!amx_load_setting_float(ZP_ZOMBIECLASSES_FILE, section, "GRAVITY", value_f))
				amx_save_setting_float(ZP_ZOMBIECLASSES_FILE, section, "GRAVITY", value_f) // Add gravity

			value_f = Float:ArrayGetCell(g_zclass_kb, i)
			if(!amx_load_setting_float(ZP_ZOMBIECLASSES_FILE, section, "KNOCKBACK", value_f))
				amx_save_setting_float(ZP_ZOMBIECLASSES_FILE, section, "KNOCKBACK", value_f) // Add knockback
		}
	}
	
	// Add any new extra items data at the end if needed
	for (i = EXTRAS_CUSTOM_STARTID; i < ArraySize(g_extraitem_realname); i++)
	{
		if(ArrayGetCell(g_extraitem_new, i))
		{
			// Add real name
			ArrayGetString(g_extraitem_realname, i, section, charsmax(section))
			
			ArrayGetString(g_extraitem_name, i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", buffer) // Add Name

			value = ArrayGetCell(g_extraitem_cost, i)
			if(!amx_load_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", value))
				amx_save_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", value) // Add Cost
				
			new data[1501], len; len = 0; data[0] = '^0';
			new team; team = ArrayGetCell(g_extraitem_team, i)

			new team_count
			team_count = 0
			for(new t = 0; t < MAX_CLASSES; t++) {
				if(team & (1<<t)) {
					if(!team_count) {
						len += formatex(data[len], charsmax(data)-len, "%s", ZP_TEAM_NAMES[t])
						team_count++
					}
					else {
						len += formatex(data[len], charsmax(data)-len, ", %s", ZP_TEAM_NAMES[t])
						team_count++
					}
				}
			}
			if(!amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "TEAMS", data, charsmax(data)))
				amx_save_setting_string(ZP_EXTRAITEMS_FILE, section, "TEAMS", data) // Add Team
		}
	}
	
	// Add any new gamemodes data at the end if needed
	new gameid
	for (i = MAX_GAME_MODES; i < g_gamemodes_i; i++)
	{
		gameid = i-MAX_GAME_MODES

		if(ArrayGetCell(g_gamemodes_new, gameid))
		{
			// Add real name
			ArrayGetString(g_gamemode_realname, gameid, section, charsmax(section))
			
			ArrayGetString(g_gamemode_name, gameid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", buffer) // Add Name

			value = ArrayGetCell(g_gamemode_enable, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value) // Add Value

			value = ArrayGetCell(g_gamemode_chance, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value) // Add Chance
				
			value = ArrayGetCell(g_gamemode_dm, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value) // Add Chance

		}
	}
	
	// Add any new special classes data at the end if needed
	new specialid
	for (i = MAX_SPECIALS_HUMANS; i < g_hm_specials_i; i++)
	{
		specialid = i-MAX_SPECIALS_HUMANS

		if(ArrayGetCell(g_hm_specials, specialid))
		{
			// Add real name
			ArrayGetString(g_hm_special_realname, specialid, section, charsmax(section))
			
			ArrayGetString(g_hm_special_name, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer)
			
			ArrayGetString(g_hm_special_model, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", buffer)

			value = ArrayGetCell(g_hm_special_health, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_speed, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value) // Add Value
				
			value_f = Float:ArrayGetCell(g_hm_special_gravity, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f) // Add Value
				
			value = ArrayGetCell(g_hm_special_aurarad, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_glow, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_r, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_g, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_b, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_leap, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_leap_f, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value) // Add Value
				
			value_f = Float:ArrayGetCell(g_hm_special_leap_h, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f) // Add Value
				
			value_f = Float:ArrayGetCell(g_hm_special_leap_c, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f) // Add Value
				
			value = ArrayGetCell(g_hm_special_uclip, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "CLIP TYPE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "CLIP TYPE", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_ignorefrag, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_ignoreammo, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_respawn, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value) // Add Value
				
			value = ArrayGetCell(g_hm_special_painfree, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value) // Add Value
		}
	}
	
	for (i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++)	{
		specialid = i-MAX_SPECIALS_ZOMBIES

		if(ArrayGetCell(g_zm_specials, specialid))
		{
			// Add real name
			ArrayGetString(g_zm_special_realname, specialid, section, charsmax(section))
			
			ArrayGetString(g_zm_special_name, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer)
			
			ArrayGetString(g_zm_special_model, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", buffer)

			ArrayGetString(g_zm_special_knifemodel, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", buffer)
				
			ArrayGetString(g_zm_special_painsound, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", buffer)
				
			value = ArrayGetCell(g_zm_special_health, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_speed, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value) // Add Value
				
			value_f = Float:ArrayGetCell(g_zm_special_gravity, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f) // Add Value
				
			value = ArrayGetCell(g_zm_special_aurarad, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_glow, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_r, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_g, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_b, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_leap, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_leap_f, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value) // Add Value
				
			value_f = Float:ArrayGetCell(g_zm_special_leap_h, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f) // Add Value
				
			value_f = Float:ArrayGetCell(g_zm_special_leap_c, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f) // Add Value
				
			value_f = ArrayGetCell(g_zm_special_knockback, specialid)
			if(!amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "KNOCKBACK", value_f))
				amx_save_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "KNOCKBACK", value_f) // Add Value
				
			value = ArrayGetCell(g_zm_special_ignorefrag, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_ignoreammo, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_respawn, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_painfree, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value) // Add Value
		}
	}

	// Free arrays containing class/item overrides
	ArrayDestroy(g_zclass2_realname)
	ArrayDestroy(g_zclass2_name)
	ArrayDestroy(g_zclass2_info)
	ArrayDestroy(g_zclass2_modelsstart)
	ArrayDestroy(g_zclass2_modelsend)
	ArrayDestroy(g_zclass2_playermodel)
	ArrayDestroy(g_zclass2_clawmodel)
	ArrayDestroy(g_zclass2_hp)
	ArrayDestroy(g_zclass2_spd)
	ArrayDestroy(g_zclass2_grav)
	ArrayDestroy(g_zclass2_kb)
	ArrayDestroy(g_zclass_new)
}

load_zclass_file()
{	
	// Build zombie classes file path
	new path[64]
	get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_ZOMBIECLASSES_FILE)
	
	new linedata[1024], key[64], value[960]
	
	// Parse if present
	if(file_exists(path))
	{
		// Open zombie classes file for reading
		new file = fopen(path, "rt")
		
		while (file && !feof(file))
		{
			// Read one line at a time
			fgets(file, linedata, charsmax(linedata))
			
			// Replace newlines with a null character to prevent headaches
			replace(linedata, charsmax(linedata), "^n", "")
			
			// Blank line or comment
			if(!linedata[0] || linedata[0] == ';') continue;
			
			// New class starting
			if(linedata[0] == '[')
			{
				// Remove first and last characters (braces)
				linedata[strlen(linedata) - 1] = 0
				copy(linedata, charsmax(linedata), linedata[1])
				
				// Store its real name for future reference
				ArrayPushString(g_zclass2_realname, linedata)
				continue;
			}
			
			// Get key and value(s)
			strtok(linedata, key, charsmax(key), value, charsmax(value), '=')
			
			// Trim spaces
			trim(key)
			trim(value)
			
			if(equal(key, "NAME"))
				ArrayPushString(g_zclass2_name, value)
			else if(equal(key, "INFO"))
				ArrayPushString(g_zclass2_info, value)
			else if(equal(key, "MODELS"))
			{
				// Set models start index
				ArrayPushCell(g_zclass2_modelsstart, ArraySize(g_zclass2_playermodel))
				
				// Parse class models
				while (value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ','))
				{
					// Trim spaces
					trim(key)
					trim(value)
					
					// Add to class models array
					ArrayPushString(g_zclass2_playermodel, key)
				}
				
				// Set models end index
				ArrayPushCell(g_zclass2_modelsend, ArraySize(g_zclass2_playermodel))
			}
			else if(equal(key, "CLAWMODEL"))
				ArrayPushString(g_zclass2_clawmodel, value)
			else if(equal(key, "HEALTH"))
				ArrayPushCell(g_zclass2_hp, str_to_num(value))
			else if(equal(key, "SPEED"))
				ArrayPushCell(g_zclass2_spd, str_to_num(value))
			else if(equal(key, "GRAVITY"))
				ArrayPushCell(g_zclass2_grav, str_to_float(value))
			else if(equal(key, "KNOCKBACK"))
				ArrayPushCell(g_zclass2_kb, str_to_float(value))
		}
		if(file) fclose(file)
	}
}

// Register Ham Forwards for CZ bots
public register_ham_czbots(id)
{
	// Make sure it's a CZ bot and it's still connected
	if(g_hamczbots || !g_isconnected[id] || !get_pcvar_num(cvar_botquota))
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
	if(is_user_alive(id)) fw_PlayerSpawn_Post(id)
}

// Disable minmodels task
public disable_minmodels(id)
{
	if(!g_isconnected[id]) return;
	client_cmd(id, "cl_minmodels 0")
	client_cmd(id, "gl_fog 1")
}

// Bots automatically buy extra items
public bot_buy_extras(taskid)
{
	// Nemesis, Survivor, Sniper and Berserker bots have nothing to buy by default
	if(!g_isalive[ID_SPAWN] || g_hm_special[ID_SPAWN] > 0 || g_zm_special[ID_SPAWN] > 0 || g_bot_extra_count[ID_SPAWN] >= get_pcvar_num(cvar_bot_maxitem))
		return;
	
	if(!g_zombie[ID_SPAWN]) {
		// Attempt to buy Night Vision
		buy_extra_item(ID_SPAWN, EXTRA_NVISION, 1)
	}
	
	// Attempt to buy a item
	buy_extra_item(ID_SPAWN, random_num(0, g_extraitem_i-1), 1)

	set_task(get_pcvar_float(cvar_bot_buyitem_interval), "bot_buy_extras", ID_SPAWN+TASK_SPAWN)
}

// Refill BP Ammo Task
public refill_bpammo(const args[], id)
{
	// Player died or turned into a zombie
	if(!g_isalive[id] || g_zombie[id])
		return;
	
	set_msg_block(g_msgAmmoPickup, BLOCK_ONCE)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[REFILL_WEAPONID], AMMOTYPE[REFILL_WEAPONID], MAXBPAMMO[REFILL_WEAPONID])
}

// Balance Teams Task
balance_teams()
{
	// Get amount of users playing
	static iPlayersnum
	iPlayersnum = fnGetPlaying()
	
	// No players, don't bother
	if(iPlayersnum < 1) return;
	
	// Split players evenly
	static iTerrors, iMaxTerrors, id, team[33]
	iMaxTerrors = iPlayersnum/2
	iTerrors = 0
	
	// First, set everyone to CT
	for (id = 1; id <= g_maxplayers; id++)
	{
		// Skip if not connected
		if(!g_isconnected[id])
			continue;
		
		team[id] = fm_cs_get_user_team(id)
		
		// Skip if not playing
		if(team[id] == FM_CS_TEAM_SPECTATOR || team[id] == FM_CS_TEAM_UNASSIGNED)
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
		if(++id > g_maxplayers) id = 1
		
		// Skip if not connected
		if(!g_isconnected[id])
			continue;
		
		// Skip if not playing or already a Terrorist
		if(team[id] != FM_CS_TEAM_CT)
			continue;
		
		// Random chance
		if(random_num(0, 1))
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
	if(!get_pcvar_num(cvar_hm_infammo[0])) zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "NOTICE_INFO2")

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
	if((!g_endround && team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED && !g_isalive[ID_SPAWN]) && (!(g_currentmode > MODE_LNJ) || (g_deathmatchmode > 0)))
	{
		// Infection rounds = none of the above
		if(!get_pcvar_num(cvar_mod_allow_respawn[MODE_INFECTION]) && (g_currentmode == MODE_INFECTION || g_currentmode == MODE_MULTI))
			return;
			
		if(g_currentmode < MAX_GAME_MODES && g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI) {
			if(!get_pcvar_num(cvar_mod_allow_respawn[g_currentmode])) 
				return;
		}
		 
		// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
		if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[ID_SPAWN] = true
		else if(g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR) g_respawn_as_zombie[ID_SPAWN] = false
		
		respawn_player_manually(ID_SPAWN)
	}
}

// Respawn Player Manually (called after respawn checks are done)
respawn_player_manually(id)
{
	// Set proper team before respawning, so that the TeamInfo message that's sent doesn't confuse PODBots
	if(g_respawn_as_zombie[id]) fm_cs_set_user_team(id, FM_CS_TEAM_T)
	else fm_cs_set_user_team(id, FM_CS_TEAM_CT)
	
	// Respawning a player has never been so easy
	ExecuteHamB(Ham_CS_RoundRespawn, id)
}

// Check Round Task -check that we still have both zombies and humans on a round-
check_round(leaving_player)
{
	// Round ended or make_a_zombie task still active
	if(g_endround || task_exists(TASK_MAKEZOMBIE))
		return;
	
	// Get alive players count
	static iPlayersnum, id
	iPlayersnum = fnGetAlive()
	
	// Last alive player, don't bother
	if(iPlayersnum < 2)
		return;
	
	// Last zombie disconnecting
	if(g_zombie[leaving_player] && fnGetZombies() == 1)
	{
		// Only one CT left, don't bother
		if(fnGetHumans() == 1 && fnGetCTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player) { /* keep looping */ }
		
		// Show last zombie left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_ZOMBIE_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Nemesis, Assassin or just a zombie?
		zombieme(id, 0, g_zm_special[leaving_player], 0, 0)
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		// If Specials, set chosen player's health to that of the one who's leaving
		if(get_pcvar_num(cvar_keephealthondisconnect) && g_zm_special[leaving_player] > 0 && g_zm_special[leaving_player] < MAX_SPECIALS_ZOMBIES)
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
	
	// Last human disconnecting
	else if(!g_zombie[leaving_player] && fnGetHumans() == 1)
	{
		// Only one T left, don't bother
		if(fnGetZombies() == 1 && fnGetTs() == 1)
			return;
		
		// Pick a random one to take his place
		while ((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player) { /* keep looping */ }
		
		// Show last human left notice
		zp_colored_print(0, "^x04[ZP]^x01 %L", LANG_PLAYER, "LAST_HUMAN_LEFT", g_playername[id])
		
		// Set player leaving flag
		g_lastplayerleaving = true
		
		// Turn into a Survivor, Sniper, berserker or just a human?
		humanme(id, g_hm_special[leaving_player], 0)
		
		// Remove player leaving flag
		g_lastplayerleaving = false
		
		if(get_pcvar_num(cvar_keephealthondisconnect) && (g_hm_special[leaving_player] > 0))
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
	if(lighting[0] == '0')
		return;
	
	// Darkest light settings?
	if(lighting[0] >= 'a' && lighting[0] <= 'd')
	{
		static thunderclap_in_progress, Float:thunder
		thunderclap_in_progress = task_exists(TASK_THUNDER)
		thunder = get_pcvar_float(cvar_thunder)
		
		// Set thunderclap tasks if not existant
		if(thunder > 0.0 && !task_exists(TASK_THUNDER_PRE) && !thunderclap_in_progress)
		{
			g_lights_i = 0
			ArrayGetString(lights_thunder, random_num(0, ArraySize(lights_thunder) - 1), g_lights_cycle, charsmax(g_lights_cycle))
			g_lights_cycle_len = strlen(g_lights_cycle)
			set_task(thunder, "thunderclap", TASK_THUNDER_PRE)
		}
		
		// Set lighting only when no thunderclaps are going on
		if(!thunderclap_in_progress) engfunc(EngFunc_LightStyle, 0, (g_currentmode == MODE_ASSASSIN) ? "a" : lighting) // no lighting in assassin round
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
	if(g_lights_i == 0)
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
	if(g_lights_i >= g_lights_cycle_len)
	{
		remove_task(TASK_THUNDER)
		lighting_effects()
	}
	// Lighting cycle start?
	else if(!task_exists(TASK_THUNDER))
		set_task(0.1, "thunderclap", TASK_THUNDER, _, _, "b")
}

// Ambience Sound Effects Task
public ambience_sound_effects(taskid)
{
	// Play a random sound depending on the round
	static sound[64], iRand, duration, str_dur[32], ambience_id
	
	// Check for current game mode
	switch (g_currentmode) {
		case MODE_INFECTION: ambience_id = AMBIENCE_SOUNDS_INFECTION
		case MODE_NEMESIS: ambience_id = AMBIENCE_SOUNDS_NEMESIS
		case MODE_ASSASSIN: ambience_id = AMBIENCE_SOUNDS_ASSASSIN
		case MODE_PREDATOR: ambience_id = AMBIENCE_SOUNDS_PREDATOR
		case MODE_BOMBARDIER: ambience_id = AMBIENCE_SOUNDS_BOMBARDIER
		case MODE_SURVIVOR: ambience_id = AMBIENCE_SOUNDS_SURVIVOR
		case MODE_SNIPER: ambience_id = AMBIENCE_SOUNDS_SNIPER
		case MODE_BERSERKER: ambience_id = AMBIENCE_SOUNDS_BERSERKER
		case MODE_WESKER: ambience_id = AMBIENCE_SOUNDS_WESKER
		case MODE_SPY: ambience_id = AMBIENCE_SOUNDS_SPY
		case MODE_DRAGON: ambience_id = AMBIENCE_SOUNDS_DRAGON
		case MODE_SWARM: ambience_id = AMBIENCE_SOUNDS_SWARM
		case MODE_MULTI: ambience_id = AMBIENCE_SOUNDS_INFECTION
		case MODE_PLAGUE: ambience_id = AMBIENCE_SOUNDS_PLAGUE
		case MODE_LNJ: ambience_id = AMBIENCE_SOUNDS_LNJ
	}

	iRand = random_num(0, ArraySize(sound_ambience[ambience_id]) - 1)
	ArrayGetString(sound_ambience[ambience_id], iRand, sound, charsmax(sound))
	ArrayGetString(sound_ambience_duration[ambience_id], iRand, str_dur, charsmax(str_dur))
	duration = str_to_num(str_dur)
	
	// Play it on clients
	PlaySound(sound)
	
	// Set the task for when the sound is done playing
	set_task(float(duration), "ambience_sound_effects", TASK_AMBIENCESOUNDS)
}

// Ambience Sounds Stop Task
ambience_sound_stop() client_cmd(0, "mp3 stop; stopsound")

// Flashlight Charge Task
public flashlight_charge(taskid)
{
	// Drain or charge?
	if(g_flashlight[ID_CHARGE])
		g_flashbattery[ID_CHARGE] -= get_pcvar_num(cvar_flashdrain)
	else
		g_flashbattery[ID_CHARGE] += get_pcvar_num(cvar_flashcharge)
	
	// Battery fully charged
	if(g_flashbattery[ID_CHARGE] >= 100)
	{
		// Don't exceed 100%
		g_flashbattery[ID_CHARGE] = 100
		
		// Update flashlight battery on HUD
		message_begin(MSG_ONE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(100) // battery
		message_end()
		
		// Task not needed anymore
		remove_task(taskid);
		return;
	}
	
	// Battery depleted
	if(g_flashbattery[ID_CHARGE] <= 0)
	{
		// Turn it off
		g_flashlight[ID_CHARGE] = false
		g_flashbattery[ID_CHARGE] = 0
		
		// Play flashlight toggle sound
		emit_sound(ID_CHARGE, CHAN_ITEM, sound_flashlight, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Update flashlight status on HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, ID_CHARGE)
		write_byte(0) // toggle
		write_byte(0) // battery
		message_end()
		
		// Remove flashlight task for this player
		remove_task(ID_CHARGE+TASK_FLASH)
	}
	else
	{
		// Update flashlight battery on HUD
		message_begin(MSG_ONE_UNRELIABLE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(g_flashbattery[ID_CHARGE]) // battery
		message_end()
	}
}

// Remove Spawn Protection Task
public remove_spawn_protection(taskid)
{
	// Not alive
	if(!g_isalive[ID_SPAWN])
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
	if(!g_isalive[ID_SPAWN])
		return;
	
	// Hide money
	message_begin(MSG_ONE, g_msgHideWeapon, _, ID_SPAWN)
	write_byte(HIDE_MONEY) // what to hide bitsum
	message_end()
	
	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgCrosshair, _, ID_SPAWN)
	write_byte(0) // toggle
	message_end()
}

// Turn Off Flashlight and Restore Batteries
turn_off_flashlight(id)
{
	// Restore batteries for the next use
	fm_cs_set_user_batteries(id, 100)
	
	// Check if flashlight is on
	if(pev(id, pev_effects) & EF_DIMLIGHT)
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
	if(g_cached_customflash)
	{
		// Turn it off
		g_flashlight[id] = false
		g_flashbattery[id] = 100
		
		// Update flashlight HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, id)
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
	if(!g_isbot[id] && g_isconnected[id] && get_pcvar_num(cvar_aiminfo)) 
	{
		// Retrieve the aimed player's id
		static aimid
		aimid = read_data(2)
		
		// Only show friends status ?
		if(g_zombie[id] == g_zombie[aimid])
		{
			static class[32], spid[32]
			
			if(g_zombie[aimid] && g_zm_special[aimid] >= MAX_SPECIALS_ZOMBIES) {
				ArrayGetString(g_zm_special_name, g_zm_special[aimid]-MAX_SPECIALS_ZOMBIES, spid, charsmax(spid))
				formatex(class, charsmax(class), "%L %s", id, "CLASS_CLASS", spid)
			}
			else if(!g_zombie[aimid] && g_hm_special[aimid] >= MAX_SPECIALS_HUMANS) {
				ArrayGetString(g_hm_special_name, g_hm_special[aimid]-MAX_SPECIALS_HUMANS, spid, charsmax(spid))
				formatex(class, charsmax(class), "%L %s", id, "CLASS_CLASS", spid)
			}
			else
				formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", id, g_zombie[id] ? zm_special_class_langs[g_zm_special[aimid]] : hm_special_class_langs[g_hm_special[aimid]])
			
			// Show the notice
			set_hudmessage(g_zombie[id] ? 255 : 0, 50, g_zombie[id] ? 0 : 255, -1.0, 0.60, 1, 0.01, 3.0, 0.01, 0.01, -1)
			ShowSyncHudMsg(id, g_MsgSync[2],"%L", id, "AIM_INFO", g_playername[aimid], class, pev(aimid, pev_health), pev(aimid, pev_armorvalue), g_ammopacks[aimid])
		}
	}
}

// Remove the aim-info message
public event_hide_status(id) ClearSyncHud(id, g_MsgSync[2])

// Infection Bomb Explosion
infection_explode(ent)
{
	// Round ended (bugfix)
	if(g_endround) return;
	
	// Get origin
	static Float:originF[3]
	pev(ent, pev_origin, originF)
	
	// Make the explosion
	create_blast(originF, 0, 250, 0)
	
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
		if(!is_user_valid_alive(victim) || g_zombie[victim] || g_nodamage[victim])
			continue;
		
		// Last human is killed
		if(fnGetHumans() == 1 || g_zm_special[attacker] == BOMBARDIER || !g_allowinfection)
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
	create_blast(originF, 200, 100, 0)
	
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
		if(!is_user_valid_alive(victim) || !g_zombie[victim] || g_nodamage[victim])
			continue;
			
		ExecuteForward(g_forwards[BURN_PRE], g_fwDummyResult, victim);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) continue;
		
		// Heat icon?
		if(get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, victim)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_BURN) // damage type
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		if(g_zm_special[victim] > 0 || g_hm_special[victim] > 0) // fire duration (nemesis/assassin is fire resistant)
			g_burning_dur[victim] += get_pcvar_num(cvar_fireduration)
		else
			g_burning_dur[victim] += get_pcvar_num(cvar_fireduration) * 5
		
		if(g_burning_dur[victim] > 0) ExecuteForward(g_forwards[BURN_POST], g_fwDummyResult, victim);
		
		// Set burning task on victim if not present
		if(!task_exists(victim+TASK_BURN))
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
	create_blast(originF, 0, 100, 200)
	
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
		if(!is_user_valid_alive(victim) || g_nodamage[victim] || !g_zombie[victim] || g_frozen[victim]) continue;
			
		ExecuteForward(g_forwards[FROZEN_PRE], g_fwDummyResult, victim);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) continue;

		// Nemesis and Assassin shouldn't be frozen
		if(g_zm_special[victim] > 0 || g_hm_special[victim] > 0)
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
		if(get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, victim)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_DROWN) // damage type - DMG_FREEZE
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		// Light blue glow while frozen
		if(g_handle_models_on_separate_ent)
			fm_set_rendering(g_ent_playermodel[victim], kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		else
			fm_set_rendering(victim, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		
		// Freeze sound
		ArrayGetString(grenade_frost_player, random_num(0, ArraySize(grenade_frost_player) - 1), sound, charsmax(sound))
		emit_sound(victim, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgScreenFade, _, victim)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Prevent from jumping
		if(pev(victim, pev_flags) & FL_ONGROUND)
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
	if(!g_isalive[id] || !g_frozen[id])
		return;
	
	// Unfreeze
	g_frozen[id] = false;
	
	// Restore gravity
	if(g_zombie[id] && g_zm_special[id] < MAX_SPECIALS_ZOMBIES)
		set_pev(id, pev_gravity, g_zm_special[id] <= 0 ? (Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])) : get_pcvar_float(cvar_zmgravity[g_zm_special[id]]))
	else if(g_zombie[id] && g_zm_special[id] >= MAX_SPECIALS_ZOMBIES)
		set_pev(id, pev_gravity, Float:ArrayGetCell(g_zm_special_gravity, g_zm_special[id]-MAX_SPECIALS_ZOMBIES))
	else if(!g_zombie[id] && g_hm_special[id] >= MAX_SPECIALS_HUMANS)
		set_pev(id, pev_gravity, Float:ArrayGetCell(g_hm_special_gravity, g_hm_special[id]-MAX_SPECIALS_HUMANS))
	else
		set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[g_hm_special[id]]))
	
	// Nemesis, Assassin, Survivor, Sniper and Berserker glow / remove glow on player model entity
	reset_user_rendering(id)
	
	// Gradually remove screen's blue tint
	message_begin(MSG_ONE, g_msgScreenFade, _, id)
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
	if(get_pcvar_num(cvar_removedoors) > 0)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door_rotating")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Remove all doors
	if(get_pcvar_num(cvar_removedoors) > 1)
	{
		ent = -1;
		while ((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	
	// Triggered lights
	if(!get_pcvar_num(cvar_triggered))
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
			if(g_zombie[id]) // Zombies
			{
				new szKnifeModel[64]
				if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
					ArrayGetString(g_zm_special_knifemodel, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, szKnifeModel, charsmax(szKnifeModel))
					set_pev(id, pev_viewmodel2, szKnifeModel)
				}
				else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
					if(g_zm_special_enable[g_zm_special[id]])
						set_pev(id, pev_viewmodel2, model_vknife_zm_special[g_zm_special[id]])
				}
				else
				{
					// Admin knife models?
					if(get_pcvar_num(cvar_adminknifemodelszombie) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])
						set_pev(id, pev_viewmodel2, model_vknife_admin_zombie)
					else {
						static clawmodel[100]
						ArrayGetString(g_zclass_clawmodel, g_zombieclass[id], clawmodel, charsmax(clawmodel))
						format(clawmodel, charsmax(clawmodel), "models/zombie_plague/%s", clawmodel)
						set_pev(id, pev_viewmodel2, clawmodel)
					}
				}
				set_pev(id, pev_weaponmodel2, "")
			}
			else
			{
				if(g_hm_special[id] == BERSERKER && g_hm_special_enable[BERSERKER]) {
					set_pev(id, pev_viewmodel2, model_v_weapon_human[BERSERKER])
					set_pev(id, pev_weaponmodel2, model_p_weapon_human[BERSERKER])
				}
				else if(get_pcvar_num(cvar_adminknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]) {
					set_pev(id, pev_viewmodel2, model_vknife_admin_human)
					set_pev(id, pev_weaponmodel2, model_pknife_admin_human)
				}
				else if(get_pcvar_num(cvar_vipknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]) {
					set_pev(id, pev_viewmodel2, model_vknife_vip_human)
					set_pev(id, pev_weaponmodel2, model_pknife_vip_human)
				}
				else {
					set_pev(id, pev_viewmodel2, model_v_weapon_human[0])
					set_pev(id, pev_weaponmodel2, model_p_weapon_human[0])
				}
			}
		}
		case CSW_M249: // Survivor's M249
		{
			if(g_hm_special[id] == SURVIVOR && g_hm_special_enable[SURVIVOR]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[SURVIVOR])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[SURVIVOR])
			}
		}
		case CSW_AWP: // Sniper's AWP
		{
			if(g_hm_special[id] == SNIPER && g_hm_special_enable[SNIPER]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[SNIPER])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[SNIPER])
			}
		}
		case CSW_DEAGLE: // Wesker's Deagle
		{
			if(g_hm_special[id] == WESKER && g_hm_special_enable[WESKER]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[WESKER])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[WESKER])
			}
				
		}
		case CSW_M3: // Spy's M3
		{
			if(g_hm_special[id] == SPY && g_hm_special_enable[SPY]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[SPY])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[SPY])
			}
				
		}
		case CSW_HEGRENADE: // Infection bomb or fire grenade
		{
			if(g_zombie[id]) set_pev(id, pev_viewmodel2, model_grenade_infect)
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
	if(g_handle_models_on_separate_ent) fm_set_weaponmodel_ent(id)
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
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	g_respawn_as_zombie[id] = false
	g_nvision[id] = false
	g_nvisionenabled[id] = false
	g_flashlight[id] = false
	g_flashbattery[id] = 100
	g_canbuy[id] = true
	g_burning_dur[id] = 0
	g_user_custom_speed[id] = false
	
	if(resetall)
	{
		g_ammopacks[id] = get_pcvar_num(cvar_startammopacks)
		g_zombieclass[id] = ZCLASS_NONE
		g_zombieclassnext[id] = ZCLASS_NONE
		g_choosed_zclass[id] = false
		g_damagedealt[id] = 0
		WPN_AUTO_ON = 0
	}
}

// Set spectators nightvision
public spec_nvision(id)
{
	// Not connected, alive, or bot
	if(!g_isconnected[id] || g_isalive[id] || g_isbot[id])
		return;
	
	// Give Night Vision?
	if(get_pcvar_num(cvar_nvggive))
	{
		g_nvision[id] = true
		
		// Turn on Night Vision automatically?
		if(get_pcvar_num(cvar_nvggive) == 1)
		{
			g_nvisionenabled[id] = true
			
			// Custom nvg?
			if(get_pcvar_num(cvar_customnvg))
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
	if(!get_pcvar_num(cvar_huddisplay))
		return;
	
	static id
	id = ID_SHOWHUD;
	
	// Player died?
	if(!g_isalive[id])
	{
		// Get spectating target
		id = pev(id, PEV_SPEC_TARGET)
		
		// Target not alive
		if(!g_isalive[id]) return;
	}
	
	// Format classname
	static class[32], rgb[3]
	
	switch(g_hud_color[g_zombie[id] ? 1 : 0][id])
	{
		case 0: rgb = { 255, 255, 255 }
		case 1: rgb = { 255, 0, 0 }
		case 2: rgb = { 0, 255, 0 }
		case 3: rgb = { 0, 0, 255 }
		case 4: rgb = { 0, 255, 255 }
		case 5: rgb = { 255, 0, 255 }
		case 6: rgb = { 255, 255, 0 }
	}

	
	if(g_zombie[id]) // zombies
	{	
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) 
			ArrayGetString(g_zm_special_name, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, class, charsmax(class))
		else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) 
			formatex(class, charsmax(class), "%L", ID_SHOWHUD, zm_special_class_langs[g_zm_special[id]])
		else 
			copy(class, charsmax(class), g_zombie_classname[id])
	}
	else {
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) 
			ArrayGetString(g_hm_special_name, g_hm_special[id]-MAX_SPECIALS_HUMANS, class, charsmax(class))
		else 
			formatex(class, charsmax(class), "%L", ID_SHOWHUD, hm_special_class_langs[g_hm_special[id]])
	}
	
	// Spectating someone else?
	if(id != ID_SHOWHUD)
	{
		// Show name, health, class, and ammo packs and armor
		set_hudmessage(rgb[0], rgb[1], rgb[2], HUD_SPECT_X, HUD_SPECT_Y, 1, 6.0, 1.1, 0.0, 0.0, -1)
		ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "%L %s^nHP: %s - %L %s - %L %s - %L %s", ID_SHOWHUD, "SPECTATING", g_playername[id],
		add_point(pev(id, pev_health)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[id]), ID_SHOWHUD, "ARMOR", add_point(pev(id, pev_armorvalue)))
	}
	else
	{		
		static g_ModeName[64]
		if(g_currentmode >= MAX_GAME_MODES)
			ArrayGetString(g_gamemode_name, (g_currentmode - MAX_GAME_MODES), g_ModeName, charsmax(g_ModeName))
		else
			formatex(g_ModeName, charsmax(g_ModeName), "%L", ID_SHOWHUD, g_endround ? "ROUND_ENDED" : mode_langs[g_currentmode])
	
		if(g_hud_type[ID_SHOWHUD] == 0)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.78, 0.18, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %s]^n[%L %s]^n[%L %s]^n[%L: %s]^n[%L: %d]^n[%L: %i]^n[%L: %d]^n[%L: %s]", id, "ZOMBIE_ATTRIB1", add_point(pev(ID_SHOWHUD, pev_health)), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(id)), id, "ZOMBIE_ATTRIB8", get_user_deaths(id), id, "ZOMBIE_ATTRIB7", get_user_frags(id), id, "ZOMBIE_ATTRIB2", fm_get_speed(id), id, "ZOMBIE_ATTRIB6", g_ModeName);
		}
		else if(g_hud_type[ID_SHOWHUD] == 1)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.02, 0.9, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "HP: %s - %L %s - %L %s", add_point(get_user_health(ID_SHOWHUD)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]))
		}
		else if(g_hud_type[ID_SHOWHUD] == 2)
		{
			set_hudmessage(rgb[0], rgb[1], rgb[2], -1.0, 0.60, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %s]^n[%L %s]^n[%L %s]^n[%L: %s]^n[%L: %d]^n[%L: %i]^n[%L: %d]^n[%L: %s]", id, "ZOMBIE_ATTRIB1", add_point(pev(ID_SHOWHUD, pev_health)), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(id)), id, "ZOMBIE_ATTRIB8", get_user_deaths(id), id, "ZOMBIE_ATTRIB7", get_user_frags(id), id, "ZOMBIE_ATTRIB2", fm_get_speed(id), id, "ZOMBIE_ATTRIB6", g_ModeName);
		}
		else if(g_hud_type[ID_SHOWHUD] == 3)
		{
			new player_name[32]; get_user_name(ID_SHOWHUD, player_name, 31)
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.57, 0.75, 1, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s]",player_name, id, "ZOMBIE_ATTRIB1", add_point(get_user_health(ID_SHOWHUD)), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(ID_SHOWHUD)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", 
			add_point(g_ammopacks[ID_SHOWHUD]), id, "CURRENT_MODE", g_ModeName)
		}
	}
}

// Play idle zombie sounds
public zombie_play_idle(taskid)
{
	// Round ended/new one starting
	if(g_endround || g_newround)
		return;
	
	static sound[64]
	
	// Last zombie?
	if(g_lastzombie[ID_BLOOD]) {
		ArrayGetString(zombie_idle_last, random_num(0, ArraySize(zombie_idle_last) - 1), sound, charsmax(sound))
		emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else {
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
	if(!regularspawns)
	{
		// No spawns?
		if(!g_spawnCount)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if(i >= g_spawnCount) i = 0
			
			// Free spawn space?
			if(is_hull_vacant(g_spawns[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns[i])
				break;
			}
			
			// Loop completed, no free space found
			if(i == sp_index) break;
		}
	}
	else
	{
		// No spawns?
		if(!g_spawnCount2)
			return;
		
		// Choose random spawn to start looping at
		sp_index = random_num(0, g_spawnCount2 - 1)
		
		// Try to find a clear spawn
		for (i = sp_index + 1; /*no condition*/; i++)
		{
			// Start over when we reach the end
			if(i >= g_spawnCount2) i = 0
			
			// Free spawn space?
			if(is_hull_vacant(g_spawns2[i], hull))
			{
				// Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				engfunc(EngFunc_SetOrigin, id, g_spawns2[i])
				break;
			}
			
			// Loop completed, no free space found
			if(i == sp_index) break;
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
		if(g_isalive[id] && g_zombie[id])
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
		if(g_isalive[id] && !g_zombie[id])
			iHumans++
	}
	
	return iHumans;
}

// Get Specials -returns alive Specials number-
fnGetSpecials(zombie, specialid)
{
	static count, id
	count = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if(zombie) {
			if(g_isalive[id] && g_zm_special[id] == specialid)
				count++
		}
		else {
			if(g_isalive[id] && g_hm_special[id] == specialid)
				count++
		}
	}
	
	return count;
}

// Get Alive -returns alive players number-
fnGetAlive()
{
	static iAlive, id
	iAlive = 0
	
	for (id = 1; id <= g_maxplayers; id++)
	{
		if(g_isalive[id])
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
		if(g_isalive[id])
			iAlive++
		
		if(iAlive == n)
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
		if(g_isconnected[id])
		{
			team = fm_cs_get_user_team(id)
			
			if(team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED)
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
		if(g_isconnected[id])
		{			
			if(fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
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
		if(g_isconnected[id])
		{			
			if(fm_cs_get_user_team(id) == FM_CS_TEAM_T)
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
		if(g_isalive[id])
		{			
			if(fm_cs_get_user_team(id) == FM_CS_TEAM_CT)
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
		if(g_isalive[id])
		{			
			if(fm_cs_get_user_team(id) == FM_CS_TEAM_T)
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
		if(g_isalive[id] && g_zombie[id] && g_zm_special[id] <= 0 && fnGetZombies() == 1)
		{
			if(!g_lastzombie[id])
			{
				// Last zombie forward
				ExecuteForward(g_forwards[USER_LAST_ZOMBIE], g_fwDummyResult, id);
			}
			g_lastzombie[id] = true
		}
		else
			g_lastzombie[id] = false
		
		// Last human
		if(g_isalive[id] && !g_zombie[id] && g_hm_special[id] <= 0 && fnGetHumans() == 1)
		{
			if(!g_lasthuman[id])
			{
				// Last human forward
				ExecuteForward(g_forwards[USER_LAST_HUMAN], g_fwDummyResult, id);
				
				// Reward extra hp
				fm_set_user_health(id, pev(id, pev_health) + get_pcvar_num(cvar_hm_basehp[0]))
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
	if(db_name[id][0] && !equal(g_playername[id], db_name[id]))
	{
		// If DB size is exceeded, write over old records
		if(db_slot_i >= sizeof db_name)
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
		if(equal(g_playername[id], db_name[i]))
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
	if((g_zombie[id] && g_zm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be human
allowed_human(id)
{
	if((!g_zombie[id] && g_hm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}

// Checks if a player is allowed to be a special class
allowed_special(id, zombie, specialid)
{
	if(zombie)
	{
		if(specialid < MAX_SPECIALS_ZOMBIES) {
			if(!g_zm_special_enable[specialid])
				return false;
		}
		if(g_endround || g_zm_special[id] == specialid || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
			return false;
	}
	else {
		if(specialid < MAX_SPECIALS_HUMANS) {
			if(!g_hm_special_enable[specialid])
				return false;
		}	
		
		if(g_endround || g_hm_special[id] == specialid || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
			return false;
	}
	
	return true;
}

// Checks if a player is allowed to respawn
allowed_respawn(id)
{
	static team
	team = fm_cs_get_user_team(id)
	
	if(g_endround || team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED || g_isalive[id])
		return false;
	
	return true;
}

// Checks if swarm mode is allowed
allowed_swarm()
{
	if(g_endround || !g_newround || task_exists(TASK_WELCOMEMSG))
		return false;
	
	return true;
}

// Checks if multi infection mode is allowed
allowed_multi()
{
	if(g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) < 2 || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) >= fnGetAlive())
		return false;
	
	return true;
}

// Checks if plague mode is allowed
allowed_plague()
{
	if(!g_hm_special_enable[SURVIVOR] || !g_zm_special_enable[NEMESIS] || g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) < 1
	|| fnGetAlive()-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) < 1)
		return false;
	
	return true;
}

// Checks if armageddon mode is allowed
allowed_lnj()
{
	if(!g_hm_special_enable[SURVIVOR] || !g_zm_special_enable[NEMESIS] || g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2)
		return false;
	
	return true;
}

// Checks if a custom game mode is allowed
allowed_custom_game()
{
	if(g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2)
		return false;
	
	return true;
}

// Admin Command. zp_zombie
command_zombie(id, player)
{
	// Log and Print Message
	zp_log_message(id, player, "CMD_INFECT")

	// New round?
	if(g_newround)
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
	// Log and Print Message
	zp_log_message(id, player, "CMD_DISINFECT")
	
	// Turn to human
	humanme(player, 0, 0)
}

// Admin Command. zp_survivor
command_survivor(id, player)
{
	if(!g_hm_special_enable[SURVIVOR])
		return
	
	// Log and Print Message
	zp_log_message(id, player, "CMD_SURVIVAL")

	// New round?
	if(g_newround)
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

command_custom_special(id, player, spid, zombie)
{
	new special_name[32]
	if(zombie) ArrayGetString(g_zm_special_name, spid-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else ArrayGetString(g_hm_special_name, spid-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
	
	switch (get_pcvar_num(cvar_showactivity))
	{
		case 1: zp_colored_print(0, "!g*ADMIN*!y %s !t- %L", g_playername[player], LANG_PLAYER, "CMD_CUSTOM_SP", special_name)
		case 2: zp_colored_print(0, "!g*ADMIN*!y %s !t-!y %s!t %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_CUSTOM_SP", special_name)
	}
	
	// Log to Zombie Plague log file?
	if(get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_CUSTOM_SP", special_name, fnGetPlaying(), g_maxplayers)
		log_to_file("zombie_plague_special.log", logdata)
	}


	if(zombie) zombieme(player, 0, spid, 0, 0)
	else humanme(player, spid, 0)
}

// Admin Command. zp_nemesis
command_nemesis(id, player)
{
	if(!g_zm_special_enable[NEMESIS])
		return

	// Log and Print Message
	zp_log_message(id, player, "CMD_NEMESIS")

	// New round?
	if(g_newround)
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
	// Log and Print Message
	zp_log_message(id, player, "CMD_RESPAWN")

	// Respawn as zombie?
	if(g_currentmode > MODE_LNJ) // Custom round ?
	{
		if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	else // Normal round
	{
		if(get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	
	// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
	if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[player] = true
	else if(g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR) g_respawn_as_zombie[player] = false
	
	respawn_player_manually(player);
}

// Admin Command. zp_swarm
command_swarm(id)
{
	// Log and Print Message
	zp_log_message(id, 0, "CMD_SWARM")
	
	// Call Swarm Mode
	remove_task(TASK_MAKEZOMBIE)
	start_swarm_mode(0, MODE_SET)
}

// Admin Command. zp_multi
command_multi(id)
{
	// Log and Print Message
	zp_log_message(id, 0, "CMD_MULTI")
	
	// Call Multi Infection
	remove_task(TASK_MAKEZOMBIE)
	start_multi_mode(0, MODE_SET)
}

// Admin Command. zp_plague
command_plague(id)
{
	if(!g_hm_special_enable[SURVIVOR] || !g_zm_special_enable[NEMESIS])
		return
		
	// Log and Print Message
	zp_log_message(id, 0, "CMD_PLAGUE")

	// Call Plague Mode
	remove_task(TASK_MAKEZOMBIE)
	start_plague_mode(0, MODE_SET)
}

// Admin Command. zp_sniper
command_sniper(id, player)
{
	if(!g_hm_special_enable[SNIPER])
		return

	// Log and Print Message
	zp_log_message(id, player, "CMD_SNIPER")

	// New round?
	if(g_newround)
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
	if(!g_zm_special_enable[ASSASSIN])
		return
		
	// Log and Print Message
	zp_log_message(id, player, "CMD_ASSASSIN")

	// New round?
	if(g_newround)
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
	if(!g_zm_special_enable[PREDATOR])
		return
		
	// Log and Print Message
	zp_log_message(id, player, "CMD_PREDATOR")

	// New round?
	if(g_newround)
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
	if(!g_zm_special_enable[BOMBARDIER])
		return
	
	// Log and Print Message
	zp_log_message(id, player, "CMD_BOMBARDIER")

	// New round?
	if(g_newround)
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

// Admin command: dragon
command_dragon(id, player)
{
	if(!g_zm_special_enable[DRAGON])
		return

	// Log and Print Message
	zp_log_message(id, player, "CMD_DRAGON")

	// New round?
	if(g_newround)
	{
		// Set as first dragon
		remove_task(TASK_MAKEZOMBIE)
		start_dragon_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a dragon
		zombieme(player, 0, DRAGON, 0, 0)
	}
}

// Admin Command. zp_berserker
command_berserker(id, player)
{
	if(!g_hm_special_enable[BERSERKER])
		return

	// Log and Print Message
	zp_log_message(id, player, "CMD_BERSERKER")
	
	// New round?
	if(g_newround)
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
	if(!g_hm_special_enable[WESKER])
		return
		
	// Log and Print Message
	zp_log_message(id, player, "CMD_WESKER")

	// New round?
	if(g_newround)
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

// Admin Command. zp_spy
command_spy(id, player)
{
	if(!g_hm_special_enable[SPY])
		return

	// Log and Print Message
	zp_log_message(id, player, "CMD_SPY")
	
	// New round?
	if(g_newround)
	{
		// Set as first spy
		remove_task(TASK_MAKEZOMBIE)
		start_spy_mode(player, MODE_SET)
	}
	else
	{
		// Turn player into a Spy
		humanme(player, SPY, 0)
	}
}

// Admin Command. zp_lnj
command_lnj(id)
{
	if(!g_hm_special_enable[SURVIVOR] || !g_zm_special_enable[NEMESIS])
		return

	// Log and Print Message
	zp_log_message(id, 0, "CMD_LNJ")
	
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
	
	if(id != 0) {
		// Show activity?
		switch (get_pcvar_num(cvar_showactivity)) {
			case 1: zp_colored_print(0, "!t*ADMIN*!t - %L %s", LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
			case 2: zp_colored_print(0, "!g*ADMIN*!y %s !t- %L %s", g_playername[id], LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
		}
		// Log to Zombie Plague Advance log file?
		if(get_pcvar_num(cvar_logcommands))
		{
			static logdata[100], authid[32], ip[16] 
			get_user_authid(id, authid, charsmax(authid))
			get_user_ip(id, ip, charsmax(ip), 1)
			formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %L %s (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "MENU_ADMIN2_CUSTOM", buffer, fnGetPlaying(), g_maxplayers)
			log_to_file("zombie_plague_special.log", logdata)
		}
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
	
	static i
	for (i = 1; i <= g_maxplayers; i++)
		update_team(i)			// Fix Team Change

	// Execute our round start forward with the game mode id [BUGFIX]
	ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, gameid, 0)
	
	// Execute our game mode selected forward
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, gameid, id)
}

stock zp_log_message(id, player, const lang[])
{
	// Show activity?
	if(player > 0) {
		switch (get_pcvar_num(cvar_showactivity))
		{
			case 1: zp_colored_print(0, "!g*ADMIN*!y %s !t- %L", g_playername[player], LANG_PLAYER, lang)
			case 2: zp_colored_print(0, "!g*ADMIN*!y %s !t-!y %s!t %L", g_playername[id], g_playername[player], LANG_PLAYER, lang)
		}
	}
	else {
		// Show activity?
		switch (get_pcvar_num(cvar_showactivity))
		{
			case 1: zp_colored_print(0, "!g*ADMIN*!t - %L", LANG_PLAYER, lang)
			case 2: zp_colored_print(0, "!g*ADMIN*!y %s !t- %L", g_playername[id], LANG_PLAYER, lang)
		}
	}
	
	// Log to Zombie Plague log file?
	if(get_pcvar_num(cvar_logcommands))
	{
		static logdata[100], authid[32], ip[16]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)

		if(player > 0) 
			formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, lang, fnGetPlaying(), g_maxplayers)
		else
			formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, lang, fnGetPlaying(), g_maxplayers)

		log_to_file("zombie_plague_special.log", logdata)
	}
	
}

/*================================================================================
 [Custom Natives]
=================================================================================*/

// Native: zp_get_user_zombie
public native_get_user_zombie(id) {
	return g_zombie[id];
}

// Native: zp_get_user_nemesis
public native_get_user_nemesis(id) {
	return g_zm_special[id] == NEMESIS;
}

// Native: zp_get_user_survivor
public native_get_user_survivor(id) {
	return g_hm_special[id] == SURVIVOR;
}

public native_get_user_first_zombie(id) {
	return g_firstzombie[id];
}

public native_get_human_special_class(id) {
	return g_zombie[id] ? 0 : g_hm_special[id];
}

public native_get_zombie_special_class(id) {
	return g_zombie[id] ? g_zm_special[id] : 0
}

// Native: zp_get_user_last_zombie
public native_get_user_last_zombie(id) {
	return g_lastzombie[id];
}

// Native: zp_get_user_last_human
public native_get_user_last_human(id) {
	return g_lasthuman[id];
}

public native_get_user_madness(id) {
	return g_nodamage[id];
}

// Native: zp_get_user_zombie_class
public native_get_user_zombie_class(id) {
	if(g_zm_special[id] > 0) // Fix Bug of Special Classes using Zombie Classes's Skills
		return -1
	
	return g_zombieclass[id];
}

// Native: zp_get_user_next_class
public native_get_user_next_class(id) {
	if(g_zm_special[id] > 0) // Fix Bug of Special Classes using Zombie Classes's Skills
		return -1
	
	return g_zombieclassnext[id];
}

// Native: zp_set_user_zombie_class
public native_set_user_zombie_class(id, classid) {
	if(classid < 0 || classid >= g_zclass_i)
		return 0;
	
	g_zombieclassnext[id] = classid
	return 1;
}

// Native: zp_get_user_ammo_packs
public native_get_user_ammo_packs(id) {
	return g_ammopacks[id];
}

// Native: zp_set_user_ammo_packs
public native_set_user_ammo_packs(id, amount) {
	g_ammopacks[id] = amount;
}

public native_get_user_frozen(id) {
	return g_frozen[id];
}

public native_get_user_burn(id) {
	return g_burning_dur[id] > 0
}

public native_get_user_infectnade(id) {
	return (g_zombie[id] && g_zm_special[id] <= 0 && user_has_weapon(id, CSW_HEGRENADE));
}

// Native: zp_get_zombie_maxhealth
public native_get_zombie_maxhealth(id)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	if(g_zombie[id] && g_zm_special[id] <= 0)
	{
		if(g_firstzombie[id])
			return floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zm_health[0]))
		else
			return ArrayGetCell(g_zclass_hp, g_zombieclass[id])
	}
	return -1;
}

// Native: zp_get_user_batteries
public native_get_user_batteries(id) {
	return g_flashbattery[id];
}

// Native: zp_set_user_batteries
public native_set_user_batteries(id, value)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return;
	
	g_flashbattery[id] = clamp(value, 0, 100);
	
	if(g_cached_customflash)
	{
		// Set the flashlight charge task to update battery status
		remove_task(id+TASK_CHARGE)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	}
}

// Native: zp_get_user_nightvision
public native_get_user_nightvision(id) {
	return g_nvision[id];
}

// Native: zp_set_user_rendering
public native_set_rendering(id, fx, r, g, b, render, amount)
{
	if(!g_isconnected[id] || !g_isalive[id])
		return	
		
	fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, fx, r, g, b, render, amount)
}

// Native: zp_reset_user_rendering
public native_reset_user_rendering(id) { 
	reset_user_rendering(id)
}

// Native: zp_get_extra_item_cost
public native_get_extra_item_cost(itemid) {
	return ArrayGetCell(g_extraitem_cost, itemid)
}

// Native: zp_get_extra_item_name
public native_get_extra_item_name(plugin_id, param_nums)
{
	if(param_nums != 3)
		return -1;
	
	static itemid, buffer[50]
	itemid = get_param(1)
	ArrayGetString(g_extraitem_name, itemid, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	
	return 1;
}

public native_special_class_name(plugin_id, param_nums) {
	
	if (param_nums != 3)
		return -1;
		
	// ZP Special disabled
	if(!g_pluginenabled)
		return -1;
	
	static id; id = get_param(1)
	
	if(!g_isconnected[id])
		return 0;
	
	new zm_specials_names[][] = { "Zombie", "Nemesis", "Assassin", "Predator", "Bombardier", "Dragon" }
	new hm_specials_names[][] = { "Human", "Survivor", "Sniper", "Berserker", "Wesker", "Spy" }
	
	static sp_name[64]
	
	if(g_zombie[id]) {
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES)
			ArrayGetString(g_zm_special_realname, (g_zm_special[id] - MAX_SPECIALS_ZOMBIES), sp_name, charsmax(sp_name))
		else
			formatex(sp_name, charsmax(sp_name), "%s", zm_specials_names[g_zm_special[id]])
	}
	else {
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS)
			ArrayGetString(g_hm_special_realname, (g_hm_special[id] - MAX_SPECIALS_HUMANS), sp_name, charsmax(sp_name))
		else
			formatex(sp_name, charsmax(sp_name), "%s", hm_specials_names[g_hm_special[id]])
	}

	set_string(2, sp_name, get_param(3))
	
	return 1;
}

// Native: zp_get_current_mode_name
public native_get_current_mode_name(plugin_id, param_nums)
{
	if(param_nums != 2)
		return -1;
		
	new const mode_name[][] = { "None", "Infection", "Nemesis", "Assassin", "Predator", "Bombardier", "Dragon",
	"Survivor", "Sniper", "Berserker", "Wesker", "Spy", "Swarm", "Multi-Infection", "Plague", "Armageddon", "Undefined" }
	
	static g_ModeName[64]
	if(g_currentmode >= MAX_GAME_MODES)
		ArrayGetString(g_gamemode_name, (g_currentmode - MAX_GAME_MODES), g_ModeName, charsmax(g_ModeName))
	else
		formatex(g_ModeName, charsmax(g_ModeName), "%s", mode_name[g_currentmode])

	set_string(1, g_ModeName, get_param(2))
	
	return 1;
}

// Native: zp_get_extra_item_realname
public native_get_extra_item_realname(plugin_id, param_nums)
{
	if(param_nums != 3)
		return -1;
	
	static itemid, buffer[50]
	itemid = get_param(1)
	ArrayGetString(g_extraitem_realname, itemid, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	
	return 1;
}

// Native: zp_get_zombie_class_name
public native_get_zombie_class_name(plugin_id, param_nums)
{
	if(param_nums != 3)
		return -1;
	
	static class, buffer[50]
	class = get_param(1)
	ArrayGetString(g_zclass_name, class, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	
	return 1;
}

// Native: zp_get_zombie_class_info
public native_get_zombie_class_info(plugin_id, param_nums)
{
	if(param_nums != 3)
		return -1;
	
	static class, buffer[50]
	class = get_param(1)
	ArrayGetString(g_zclass_info, class, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	
	return 1;
}

// Native: zp_set_zombie_class_info
public native_set_zombie_class_info(class, const newinfo[]) {
	param_convert(2)
	ArraySetString(g_zclass_info, class, newinfo)
}

// Native: zp_set_zombie_class_name
public native_set_zombie_class_name(class, const newname[]) {
	param_convert(2)
	ArraySetString(g_zclass_name, class, newname)
}

// Native: zp_set_extra_item_team
public native_set_extra_item_team(itemid, team) {
	ArraySetCell(g_extraitem_team, itemid, team)
}

// Native: zp_set_extra_item_cost
public native_set_extra_item_cost(itemid, cost) {
	ArraySetCell(g_extraitem_cost, itemid, cost)
}

// Native: zp_set_extra_item_name
public native_set_extra_item_name(itemid, const newname[]) {
	param_convert(2)
	ArraySetString(g_extraitem_name, itemid, newname)
}

// Native: zp_set_extra_damage
public native_set_extra_damage(victim, attacker, damage, const weaponDescription[])
{
	param_convert(4)
		
	if(pev(victim, pev_takedamage) == DAMAGE_NO || damage <= 0 || g_nodamage[victim]) 
		return;

	if(get_user_health(victim) - damage <= 0 ) 
	{
		set_msg_block(get_user_msgid("DeathMsg"), BLOCK_SET);
		ExecuteHamB(Ham_Killed, victim, attacker, 2);
		set_msg_block(get_user_msgid("DeathMsg"), BLOCK_NOT);

		message_begin(MSG_BROADCAST, get_user_msgid("DeathMsg"));
		write_byte(attacker);
		write_byte(victim);
		write_byte(0);
		write_string(weaponDescription);
		message_end();
		
		set_pev(attacker, pev_frags, float(get_user_frags(attacker) + 1));
		
		new kname[32], vname[32], kauthid[32], vauthid[32], kteam[10], vteam[10];
		get_user_name(attacker, kname, 31); get_user_team(attacker, kteam, 9); get_user_authid(attacker, kauthid, 31);
		get_user_name(victim, vname, 31); get_user_team(victim, vteam, 9); get_user_authid(victim, vauthid, 31);
		
		log_message("^"%s<%d><%s><%s>^" killed ^"%s<%d><%s><%s>^" with ^"%s^"", kname, get_user_userid(attacker), kauthid, kteam, 
		vname, get_user_userid(victim), vauthid, vteam, weaponDescription);
	}
	else  {
		ExecuteHam(Ham_TakeDamage, victim, 0, attacker, float(damage), DMG_BLAST)
	}
}

// Native: zp_set_user_maxspeed
public native_set_user_maxspeed(id, Float:Speed)
{
	if(!g_isalive[id])
		return
	
	g_user_custom_speed[id] = true
	g_current_maxspeed[id] = Speed
}

// Native: zp_get_user_maxspeed
public Float:native_get_user_maxspeed(id)
{
	if(g_user_custom_speed[id]) 
		return g_current_maxspeed[id]
	else if(g_zombie[id])
		return (g_zm_special[id] > 0 ? g_zm_cached_spd[g_zm_special[id]] : g_spd[id])
	else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS)
		return g_spd[id]

	return g_hm_cached_spd[g_hm_special[id]]
}

// Native: zp_reset_user_maxspeed
public native_reset_user_maxspeed(id)
{
	if(g_user_custom_speed[id]) {
		g_user_custom_speed[id] = false
		g_current_maxspeed[id] = 0.0
	}
}

// Native: zp_set_user_nightvision
public native_set_user_nightvision(id, set)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return;
	
	if(set)
	{
		g_nvision[id] = true
		
		if(!g_isbot[id])
		{
			g_nvisionenabled[id] = true
			
			// Custom nvg?
			if(get_pcvar_num(cvar_customnvg))
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
		if(g_isbot[id]) cs_set_user_nvg(id, 0);
		if(get_pcvar_num(cvar_customnvg)) remove_task(id+TASK_NVISION)
		else if(g_nvisionenabled[id]) set_user_gnvision(id, 0)
		g_nvision[id] = false
		g_nvisionenabled[id] = false
	}
}

public native_set_user_madness(id, set)
{
	if(!g_pluginenabled)
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
	}
}


public native_set_user_frozen(id, set)
{
	if(!g_pluginenabled)
		return;
	
	static sound[64]
	if(set)
	{
		// Only effect alive unfrozen zombies
		if(!is_user_valid_alive(id) || g_nodamage[id] || g_frozen[id]) return;
			
		ExecuteForward(g_forwards[FROZEN_PRE], g_fwDummyResult, id);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return;

		// Specials Zombies shouldn't be frozen
		if(set < 2) {
			if(g_zm_special[id] > 0 || g_hm_special[id] > 0)
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
		}
		
		// Freeze icon?
		if(get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_DROWN) // damage type - DMG_FREEZE
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		// Light blue glow while frozen
		fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25)
		
		// Freeze sound
		ArrayGetString(grenade_frost_player, random_num(0, ArraySize(grenade_frost_player) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
		
		// Add a blue tint to their screen
		message_begin(MSG_ONE, g_msgScreenFade, _, id)
		write_short(0) // duration
		write_short(0) // hold time
		write_short(FFADE_STAYOUT) // fade type
		write_byte(0) // red
		write_byte(50) // green
		write_byte(200) // blue
		write_byte(100) // alpha
		message_end()
		
		// Prevent from jumping
		if(pev(id, pev_flags) & FL_ONGROUND)
			set_pev(id, pev_gravity, 999999.9) // set really high
		else
			set_pev(id, pev_gravity, 0.000001) // no gravity
		
		// Set a task to remove the freeze
		g_frozen[id] = true;
		ExecuteForward(g_forwards[FROZEN_POST], g_fwDummyResult, id);
		set_task(get_pcvar_float(cvar_freezeduration), "remove_freeze", id)
	}
	else {
		remove_freeze(id)
	}
}

public native_set_user_burn(id, set)
{
	if(!g_pluginenabled)
		return;
	
	if(set)
	{
		// Only effect alive zombies
		if(!is_user_valid_alive(id) || g_nodamage[id])
			return;
			
		ExecuteForward(g_forwards[BURN_PRE], g_fwDummyResult, id);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return;
		
		// Heat icon?
		if(get_pcvar_num(cvar_hudicons))
		{
			message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_BURN) // damage type
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}
		
		if(g_zm_special[id] > 0 && set > 2|| g_hm_special[id] > 0 && set > 2)
			g_burning_dur[id] += get_pcvar_num(cvar_fireduration)
		else
			g_burning_dur[id] += get_pcvar_num(cvar_fireduration) * 5
		
		if(g_burning_dur[id] > 0) ExecuteForward(g_forwards[BURN_POST], g_fwDummyResult, id);
		
		// Set burning task on id if not present
		if(!task_exists(id+TASK_BURN))
			set_task(0.2, "burning_flame", id+TASK_BURN, _, _, "b")
	}
	else
	{
		g_burning_dur[id] = 0
	}
}

public native_set_user_infectnade(id, set)
{
	if(!g_pluginenabled || !g_zombie[id]) 
		return
	
	if(set) fm_give_item(id, "weapon_hegrenade");
	else cs_set_user_bpammo(id, CSW_HEGRENADE, 0), engclient_cmd(id, "weapon_knife")
	
}

// Native: zp_infect_user
public native_infect_user(id, infector, silent, rewards)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Not allowed to be zombie
	if(!allowed_zombie(id))
		return 0;
	
	// New round?
	if(g_newround)
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
	if(!g_pluginenabled)
		return -1;
	
	// Not allowed to be human
	if(!allowed_human(id))
		return 0;
	
	// Turn to human
	humanme(id, 0, (silent == 1) ? 1 : 0)
	return 1;
}

// Native: zp_make_user_nemesis
public native_make_user_nemesis(id) {
	return native_make_user_special(id, NEMESIS, 1)
}

// Native: zp_make_user_survivor
public native_make_user_survivor(id) {
	return native_make_user_special(id, SURVIVOR, 0)
}

// Native: zp_make_user_survivor
public native_make_user_special(id, spid, zombie)
{
	// ZP Special disabled
	if(!g_pluginenabled)
		return -1;
	
	// Not allowed to be survivor
	if(!allowed_special(id, 0, spid))
		return 0;
	
	// New round?
	if(g_newround && spid < MAX_SPECIALS_HUMANS && !zombie || g_newround && spid < MAX_SPECIALS_ZOMBIES && zombie) {

		remove_task(TASK_MAKEZOMBIE)
		
		if(zombie) {
			switch(spid) {
				case NEMESIS: start_nemesis_mode(id, MODE_SET)
				case ASSASSIN: start_assassin_mode(id, MODE_SET)
				case PREDATOR: start_predator_mode(id, MODE_SET)
				case BOMBARDIER: start_bombardier_mode(id, MODE_SET)
				case DRAGON: start_dragon_mode(id, MODE_SET)
			}
		}
		else {
			switch(spid) {
				case SURVIVOR: start_survivor_mode(id, MODE_SET)
				case SNIPER: start_sniper_mode(id, MODE_SET)
				case BERSERKER: start_berserker_mode(id, MODE_SET)
				case WESKER: start_wesker_mode(id, MODE_SET)
				case SPY: start_spy_mode(id, MODE_SET)
			}
		}
	}
	else
	{
		// Turn player into a Survivor
		if(zombie)  zombieme(id, 0, spid, 0, 0)
		else humanme(id, spid, 0)
	}
	
	return 1;
}


// Native: zp_respawn_user
public native_respawn_user(id, team)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Invalid player
	if(!is_user_valid_connected(id))
		return 0;
	
	// Respawn not allowed
	if(!allowed_respawn(id))
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
	if(!g_pluginenabled)
		return -1;
	
	if(itemid < 0 || itemid >= g_extraitem_i)
		return 0;
	
	buy_extra_item(id, itemid, ignorecost)
	return 1;
}

// Native: zp_get_user_sniper
public native_get_user_sniper(id) {
	return g_hm_special[id] == SNIPER;
}

// Native: zp_make_user_sniper
public native_make_user_sniper(id) {
	return native_make_user_special(id, SNIPER, 0);
}

// Native: zp_get_user_assassin
public native_get_user_assassin(id) {
	return g_zm_special[id] == ASSASSIN;
}

 // Native: zp_make_user_assassin
public native_make_user_assassin(id) {
	return native_make_user_special(id, ASSASSIN, 1)
}

// Native: zp_get_user_predator
public native_get_user_predator(id) {
	return g_zm_special[id] == PREDATOR;
}

 // Native: zp_make_user_predator
public native_make_user_predator(id) {
	return native_make_user_special(id, PREDATOR, 1)
}

// Native: zp_get_user_bombardier
public native_get_user_bombardier(id) {
	return g_zm_special[id] == BOMBARDIER;
}

 // Native: zp_make_user_bombardier
public native_make_user_bombardier(id) {
	return native_make_user_special(id, BOMBARDIER, 1)
}

// Native: zp_get_user_dragon
public native_get_user_dragon(id) {
	return g_zm_special[id] == DRAGON;
}

 // Native: zp_make_user_dragon
public native_make_user_dragon(id) {
	return native_make_user_special(id, DRAGON, 1)
}

// Native: zp_get_user_berserker
public native_get_user_berserker(id) {
	return g_hm_special[id] == BERSERKER;
}

// Native: zp_get_user_wesker
public native_get_user_wesker(id) {
	return g_hm_special[id] == WESKER;
}

// Native: zp_get_user_spy
public native_get_user_spy(id) {
	return g_hm_special[id] == SPY;
}

// Native: zp_make_user_berserker
public native_make_user_berserker(id) {
	return native_make_user_special(id, BERSERKER, 0)
}

// Native: zp_make_user_wesker
public native_make_user_wesker(id) {
	return native_make_user_special(id, WESKER, 0)
}

// Native: zp_make_user_spy
public native_make_user_spy(id) {
	return native_make_user_special(id, SPY, 0)
}

// Native: zp_get_user_model
public native_get_user_model(plugin_id, param_nums)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Insufficient number of arguments
	if(param_nums != 3)
		return -1;
	
	// Retrieve the player's index
	static id; id = get_param(1)
	
	// Not an alive player or invalid player
	if(!is_user_valid_alive(id))
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
	if(!g_pluginenabled)
		return false;
	
	if(!is_user_valid_connected(id))
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
	
	if(g_handle_models_on_separate_ent)
	{
		// Set the right model
		copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
		if(g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
		
		// Set model on player model entity
		fm_set_playermodel_ent(id)
	}
	else
	{
		// Get current model for comparing it with the current one
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
		
		// Set the right model, after checking that we don't already have it
		if(!equal(currentmodel, newmodel))
		{
			copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
			if(g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
			
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if(g_newround)
				set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else
				fm_user_model_update(id+TASK_MODEL)
		}
	}
	return true;
}

// Native: zp_get_current_mode
public native_get_current_mode() {
	return g_currentmode
}

// Native: zp_get_last_mode
public native_get_last_mode() {
	return g_lastmode
}

// Native: zp_has_round_started
public native_has_round_started()
{
	if(g_newround) return 0; // not started
	if(g_modestarted) return 1; // started
	return 2; // starting
}

public native_has_round_ended() {
	return g_endround;
}

// Native: zp_is_nemesis_round
public native_is_nemesis_round() {
	return (g_currentmode == MODE_NEMESIS);
}

// Native: zp_is_survivor_round
public native_is_survivor_round() {
	return (g_currentmode == MODE_SURVIVOR);
}

// Native: zp_is_swarm_round
public native_is_swarm_round() {
	return (g_currentmode == MODE_SWARM);
}

// Native: zp_is_plague_round
public native_is_plague_round() {
	return (g_currentmode == MODE_PLAGUE);
}

// Native: zp_get_zombie_count
public native_get_zombie_count() {
	return fnGetZombies();
}

// Native: zp_get_human_count
public native_get_human_count() {
	return fnGetHumans();
}

// Native: zp_get_nemesis_count
public native_get_nemesis_count() {
	return fnGetSpecials(1, NEMESIS);
}

// Native: zp_get_survivor_count
public native_get_survivor_count() {
	return fnGetSpecials(0, SURVIVOR);
}

// Native: zp_is_sniper_round
public native_is_sniper_round() {
	return (g_currentmode == MODE_SNIPER);
}

// Native: zp_get_sniper_count
public native_get_sniper_count() {
	return fnGetSpecials(0, SNIPER);
}

// Native: zp_is_assassin_round
public native_is_assassin_round() {
	return (g_currentmode == MODE_ASSASSIN);
}

// Native: zp_get_assassin_count
public native_get_assassin_count() {
	return fnGetSpecials(1, ASSASSIN);
}

// Native: zp_is_predator_round
public native_is_predator_round() {
	return (g_currentmode == MODE_PREDATOR);
}

// Native: zp_get_predator_count
public native_get_predator_count() {
	return fnGetSpecials(1, PREDATOR);
}

// Native: zp_is_bombardier_round
public native_is_bombardier_round() {
	return (g_currentmode == MODE_BOMBARDIER);
}

// Native: zp_get_bombardier_count
public native_get_bombardier_count() {
	return fnGetSpecials(1, BOMBARDIER);
}

// Native: zp_is_dragon_round
public native_is_dragon_round() {
	return (g_currentmode == MODE_DRAGON);
}

// Native: zp_get_dragon_count
public native_get_dragon_count() {
	return fnGetSpecials(1, DRAGON);
}

// Native: zp_is_berserker_round
public native_is_berserker_round() {
	return (g_currentmode == MODE_BERSERKER);
}

// Native: zp_is_wesker_round
public native_is_wesker_round() {
	return (g_currentmode == MODE_WESKER);
}

// Native: zp_is_spy_round
public native_is_spy_round() {
	return (g_currentmode == MODE_SPY);
}

// Native: zp_get_berserker_count
public native_get_berserker_count() {
	return fnGetSpecials(0, BERSERKER);
}

// Native: zp_get_wesker_count
public native_get_wesker_count() {
	return fnGetSpecials(0, WESKER);
}

// Native: zp_get_spy_count
public native_get_spy_count() {
	return fnGetSpecials(0, SPY);
}

// Native: zp_is_lnj_round
public native_is_lnj_round() {
	return (g_currentmode == MODE_LNJ);
}

public native_get_special_count(is_zombie, specialid) {
	return fnGetSpecials(is_zombie, specialid);
}

// Native: zp_register_human_special
public native_register_human_special(const name[], const model[], hp, speed, Float:gravity, flags, clip_type, aura_radius, glow, r, g, b)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if(!g_arrays_created)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2) 
		
	new szRealname[32]
	formatex(szRealname, charsmax(szRealname), "%s", name)
	replace_all(szRealname, charsmax(szRealname), "[", "(")
	replace_all(szRealname, charsmax(szRealname), "]", ")")
	replace_all(szRealname, charsmax(szRealname), "\r", "")
	replace_all(szRealname, charsmax(szRealname), "\y", "") // Replace for Prevent bug on Save
	replace_all(szRealname, charsmax(szRealname), "\w", "")
	replace_all(szRealname, charsmax(szRealname), "\d", "")
	
	ArrayPushString(g_hm_special_realname, szRealname)
	ArrayPushString(g_hm_special_name, name)
	ArrayPushString(g_hm_special_model, model)
	ArrayPushCell(g_hm_special_health, hp)
	ArrayPushCell(g_hm_special_speed, speed)
	ArrayPushCell(g_hm_special_gravity, gravity)
	ArrayPushCell(g_hm_special_flags, flags)
	ArrayPushCell(g_hm_special_aurarad, aura_radius)
	ArrayPushCell(g_hm_special_glow, glow)
	ArrayPushCell(g_hm_special_r, r)
	ArrayPushCell(g_hm_special_g, g)
	ArrayPushCell(g_hm_special_b, b)
	ArrayPushCell(g_hm_special_leap, 1)
	ArrayPushCell(g_hm_special_leap_f, 500)
	ArrayPushCell(g_hm_special_leap_h, 300.0)
	ArrayPushCell(g_hm_special_leap_c, 5.0)
	ArrayPushCell(g_hm_special_uclip, clip_type)
	ArrayPushCell(g_hm_special_ignorefrag, 0)
	ArrayPushCell(g_hm_special_ignoreammo, 0)
	ArrayPushCell(g_hm_special_respawn, 1)
	ArrayPushCell(g_hm_special_painfree, 0)
	
	ArrayPushCell(g_hm_specials, 1)
	
	new section[64]
	new specialid = g_hm_specials_i-MAX_SPECIALS_HUMANS
	ArrayGetString(g_hm_special_realname, specialid, section, charsmax(section))
	
	// Load Custom Special Classes
	new szName[32], szModel[64]
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", szName, charsmax(szName)))
		ArraySetString(g_hm_special_name, specialid, szName)
		
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", szModel, charsmax(szModel)))
		ArraySetString(g_hm_special_model, specialid, szModel)
	
	new value, Float:value_f
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value))
		ArraySetCell(g_hm_special_health, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value))
		ArraySetCell(g_hm_special_speed, specialid, value)
		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f))
		ArraySetCell(g_hm_special_gravity, specialid, value_f)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value))
		ArraySetCell(g_hm_special_aurarad, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value))
		ArraySetCell(g_hm_special_glow, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value))
		ArraySetCell(g_hm_special_r, specialid, value)
	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value))
		ArraySetCell(g_hm_special_g, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value))
		ArraySetCell(g_hm_special_b, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value))
		ArraySetCell(g_hm_special_leap, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value))
		ArraySetCell(g_hm_special_leap_f, specialid, value)
	
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f))
		ArraySetCell(g_hm_special_leap_h, specialid, value_f)
		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f))
		ArraySetCell(g_hm_special_leap_c, specialid, value_f)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "CLIP TYPE", value))
		ArraySetCell(g_hm_special_uclip, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value))
		ArraySetCell(g_hm_special_ignorefrag, specialid, value)
	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value))
		ArraySetCell(g_hm_special_ignoreammo, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value))
		ArraySetCell(g_hm_special_respawn, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value))
		ArraySetCell(g_hm_special_painfree, specialid, value)

	// Precache player model
	new prec_mdl[64]
	ArrayGetString(g_hm_special_model, specialid, szModel, charsmax(szModel))
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", szModel, szModel)
	ArrayPushCell(g_hm_special_modelindex, engfunc(EngFunc_PrecacheModel, prec_mdl))
	if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
	if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%sT.mdl", szModel, szModel)
	if(file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)
	
	// Increase registered special humans counter
	g_hm_specials_i++
	
	// Return id under which we registered the human special 
	return (g_hm_specials_i-1);
}

// Native: zp_register_zombie_special
public native_register_zombie_special(const name[], const model[], const knifemodel[], const pain_sound[], hp, speed, Float:gravity, flags, Float:knockback, aura_radius, glow, r, g, b)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if(!g_arrays_created)
		return -1;
		
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	param_convert(4)
		
	new szRealname[32]
	formatex(szRealname, charsmax(szRealname), "%s", name)
	replace_all(szRealname, charsmax(szRealname), "[", "(")
	replace_all(szRealname, charsmax(szRealname), "]", ")")
	replace_all(szRealname, charsmax(szRealname), "\r", "")
	replace_all(szRealname, charsmax(szRealname), "\y", "") // Replace for Prevent bug on Save
	replace_all(szRealname, charsmax(szRealname), "\w", "")
	replace_all(szRealname, charsmax(szRealname), "\d", "")
		
	if(g_zm_specials_i > MAX_SPECIALS_ZOMBIES) {
		new szRealname2[32], alterady_exists
		alterady_exists = false
		for (new i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++)
		{
			if(ArrayGetCell(g_zm_specials, i-MAX_SPECIALS_ZOMBIES))
			{
				// Add real name
				ArrayGetString(g_zm_special_realname, i-MAX_SPECIALS_ZOMBIES, szRealname2, charsmax(szRealname2))
				if(equal(szRealname, szRealname2)) alterady_exists = true
			}
		}
		if(alterady_exists) {
			log_error(AMX_ERR_PARAMS, "Custom Zombie Special Class Alterady Exists")
			return -1;
		}
	}
		
	ArrayPushString(g_zm_special_realname, szRealname)
	ArrayPushString(g_zm_special_name, name)
	ArrayPushString(g_zm_special_model, model)
	ArrayPushString(g_zm_special_knifemodel, knifemodel)
	ArrayPushString(g_zm_special_painsound, pain_sound)
	ArrayPushCell(g_zm_special_health, hp)
	ArrayPushCell(g_zm_special_speed, speed)
	ArrayPushCell(g_zm_special_gravity, gravity)
	ArrayPushCell(g_zm_special_flags, flags)
	ArrayPushCell(g_zm_special_aurarad, aura_radius)
	ArrayPushCell(g_zm_special_glow, glow)
	ArrayPushCell(g_zm_special_r, r)
	ArrayPushCell(g_zm_special_g, g)
	ArrayPushCell(g_zm_special_b, b)
	ArrayPushCell(g_zm_special_leap, 1)
	ArrayPushCell(g_zm_special_leap_f, 500)
	ArrayPushCell(g_zm_special_leap_h, 300.0)
	ArrayPushCell(g_zm_special_leap_c, 5.0)
	ArrayPushCell(g_zm_special_knockback, knockback)
	ArrayPushCell(g_zm_special_ignorefrag, 0)
	ArrayPushCell(g_zm_special_ignoreammo, 0)
	ArrayPushCell(g_zm_special_respawn, 1)
	ArrayPushCell(g_zm_special_painfree, 0)
	
	ArrayPushCell(g_zm_specials, 1)
	
	new section[64]
	new specialid = g_zm_specials_i-MAX_SPECIALS_ZOMBIES
	ArrayGetString(g_zm_special_realname, specialid, section, charsmax(section))
	
	// Load Custom Special Classes
	new szName[32], szModel[64], szKnifeModel[64], szPainSnd[64], value, Float:value_f
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", szName, charsmax(szName)))
		ArraySetString(g_zm_special_name, specialid, szName)
		
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", szModel, charsmax(szModel)))
		ArraySetString(g_zm_special_model, specialid, szModel)
		
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", szKnifeModel, charsmax(szKnifeModel)))
		ArraySetString(g_zm_special_knifemodel, specialid, szKnifeModel)
		
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", szPainSnd, charsmax(szPainSnd)))
		ArraySetString(g_zm_special_painsound, specialid, szPainSnd)

	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value))
		ArraySetCell(g_zm_special_health, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value))
		ArraySetCell(g_zm_special_speed, specialid, value)
		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f))
		ArraySetCell(g_zm_special_gravity, specialid, value_f)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value))
		ArraySetCell(g_zm_special_aurarad, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value))
		ArraySetCell(g_zm_special_glow, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value))
		ArraySetCell(g_zm_special_r, specialid, value)
	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value))
		ArraySetCell(g_zm_special_g, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value))
		ArraySetCell(g_zm_special_b, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value))
		ArraySetCell(g_zm_special_leap, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value))
		ArraySetCell(g_zm_special_leap_f, specialid, value)
	
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f))
		ArraySetCell(g_zm_special_leap_h, specialid, value_f)
		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f))
		ArraySetCell(g_zm_special_leap_c, specialid, value_f)
		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "KNOCKBACK", value_f))
		ArraySetCell(g_zm_special_knockback, specialid, value_f)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value))
		ArraySetCell(g_zm_special_ignorefrag, specialid, value)
	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value))
		ArraySetCell(g_zm_special_ignoreammo, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value))
		ArraySetCell(g_zm_special_respawn, specialid, value)
		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value))
		ArraySetCell(g_zm_special_painfree, specialid, value)
		
	// Precache Knife Model
	ArrayGetString(g_zm_special_knifemodel, specialid, szKnifeModel, charsmax(szKnifeModel))
	engfunc(EngFunc_PrecacheModel, szKnifeModel) 
	
	// Precache Pain Sound
	ArrayGetString(g_zm_special_painsound, specialid, szPainSnd, charsmax(szPainSnd))
	engfunc(EngFunc_PrecacheSound, szPainSnd) 

	// Precache player model
	new prec_mdl[128]
	ArrayGetString(g_zm_special_model, specialid, szModel, charsmax(szModel))
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", szModel, szModel)
	ArrayPushCell(g_zm_special_modelindex, engfunc(EngFunc_PrecacheModel, prec_mdl))
	if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
	if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
	formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%sT.mdl", szModel, szModel)
	if(file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)

		
	// Increase registered special humans counter
	g_zm_specials_i++
	
	// Return id under which we registered the human special 
	return (g_zm_specials_i-1);
}

// Native: zp_register_game_mode
public native_register_game_mode(const name[], flags, chance, allow, dm_mode)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if(!g_arrays_created)
		return -1;
		
	// Strings passed byref
	param_convert(1)
	
	new szRealname[32]
	formatex(szRealname, charsmax(szRealname), "%s", name)
	replace_all(szRealname, charsmax(szRealname), "[", "(")
	replace_all(szRealname, charsmax(szRealname), "]", ")")
	replace_all(szRealname, charsmax(szRealname), "\r", "")
	replace_all(szRealname, charsmax(szRealname), "\y", "") // Replace for Prevent bug on Save
	replace_all(szRealname, charsmax(szRealname), "\w", "")
	replace_all(szRealname, charsmax(szRealname), "\d", "")
	
	if(g_gamemodes_i > MAX_GAME_MODES) {
		new szRealname2[32], alterady_exists
		alterady_exists = false
		for (new i = MAX_GAME_MODES; i < g_gamemodes_i; i++)
		{
			if(ArrayGetCell(g_gamemodes_new, i-MAX_GAME_MODES))
			{
				// Add real name
				ArrayGetString(g_gamemode_realname, i-MAX_GAME_MODES, szRealname2, charsmax(szRealname2))
				if(equal(szRealname, szRealname2)) alterady_exists = true
			}
		}
		if(alterady_exists) {
			log_error(AMX_ERR_PARAMS, "Custom Game Mode Alterady Exists")
			return -1;
		}
	}
	
	// Add the game mode
	ArrayPushString(g_gamemode_realname, szRealname)
	ArrayPushString(g_gamemode_name, name)
	ArrayPushCell(g_gamemode_flag, flags)
	ArrayPushCell(g_gamemode_chance, chance)
	ArrayPushCell(g_gamemode_allow, allow)
	ArrayPushCell(g_gamemode_dm, dm_mode)
	ArrayPushCell(g_gamemode_enable, 1)

	ArrayPushCell(g_gamemodes_new, 1)
	
	new section[64]
	new gameid = g_gamemodes_i-MAX_GAME_MODES
	ArrayGetString(g_gamemode_realname, gameid, section, charsmax(section))
	
	// Load Custom Game Modes	
	new szName[32]
	if(amx_load_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", szName, charsmax(szName)))
		ArraySetString(g_gamemode_name, gameid, szName)
	
	new value
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value))
		ArraySetCell(g_gamemode_enable, gameid, value)
	
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value))
		ArraySetCell(g_gamemode_chance, gameid, value)
		
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value))
		ArraySetCell(g_gamemode_dm, gameid, value)
	
	// Increase registered game modes counter
	g_gamemodes_i++
	
	// Return id under which we registered the game mode
	return (g_gamemodes_i-1);
}

// Native: zp_extra_item_textadd
public native_extra_item_textadd(const text[]) {
	param_convert(1)	
	format(g_AdditionalMenuText, charsmax(g_AdditionalMenuText), "%s%s", g_AdditionalMenuText, text)
}

// Native: zp_zombie_class_textadd
public native_zombie_class_textadd(const text[]) {
	param_convert(1)	
	format(g_AdditionalMenuText2, charsmax(g_AdditionalMenuText2), "%s%s", g_AdditionalMenuText2, text)
}

// Native: zp_register_extra_item
public native_register_extra_item(const name[], cost, team)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if(!g_arrays_created)
		return -1;
	
	// For backwards compatibility
	if(team == ZP_TEAM_ANY)
		team = ZP_TEAM_ZOMBIE|ZP_TEAM_HUMAN
	
	// Strings passed byref
	param_convert(1)
	
	// Add the item
	
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	new szRealname[32]
	formatex(szRealname, charsmax(szRealname), "%s", name)
	replace_all(szRealname, charsmax(szRealname), "[", "(")
	replace_all(szRealname, charsmax(szRealname), "]", ")")
	replace_all(szRealname, charsmax(szRealname), "\r", "")
	replace_all(szRealname, charsmax(szRealname), "\y", "") // Replace for Prevent bug on Save
	replace_all(szRealname, charsmax(szRealname), "\w", "")
	replace_all(szRealname, charsmax(szRealname), "\d", "")
	ArrayPushString(g_extraitem_realname, szRealname)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	new section[64]
	ArrayGetString(g_extraitem_realname, g_extraitem_i, section, charsmax(section))
		
	new sz_custom_name[32]
	if(amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", sz_custom_name, charsmax(sz_custom_name)))
		ArraySetString(g_extraitem_name, g_extraitem_i, sz_custom_name)
	
	new cost2
	if(amx_load_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", cost2))
		ArraySetCell(g_extraitem_cost, g_extraitem_i, cost2)
	
	new team2, szTeam[32], Array:team_array = ArrayCreate(32, 1)
	team2 = 0
	if(amx_load_setting_string_arr(ZP_EXTRAITEMS_FILE, section, "TEAMS", team_array))
	{
		for(new t = 0; t < MAX_CLASSES; t++) 
		{
			for (new team_name = 0; team_name < ArraySize(team_array); team_name++)
			{
				ArrayGetString(team_array, team_name, szTeam, charsmax(szTeam))
	
				if(equal(szTeam, ZP_TEAM_NAMES[t]))
					team2 |= (1<<t)
			}
		}
		ArraySetCell(g_extraitem_team, g_extraitem_i, team2)
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
	ArrayPushString(g_extraitem_realname, name)
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	
	// Set temporary new item flag
	ArrayPushCell(g_extraitem_new, 1)
	
	// Increase registered items counter
	g_extraitem_i++
}
public native_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback)
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Arrays not yet initialized
	if(!g_arrays_created)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	param_convert(2)
	param_convert(3)
	param_convert(4)
	
	new szRealname[32]
	formatex(szRealname, charsmax(szRealname), "%s", name)
	replace_all(szRealname, charsmax(szRealname), "[", "(")
	replace_all(szRealname, charsmax(szRealname), "]", ")")
	replace_all(szRealname, charsmax(szRealname), "\r", "")
	replace_all(szRealname, charsmax(szRealname), "\y", "") // Replace for Prevent bug on Save
	replace_all(szRealname, charsmax(szRealname), "\w", "")
	replace_all(szRealname, charsmax(szRealname), "\d", "")
	
	if(g_zclass_i > 0) {
		new szRealname2[32], alterady_exists
		alterady_exists = false
		for (new i = 0; i < g_zclass_i; i++)
		{
			if(ArrayGetCell(g_zclass_new, i))
			{
				// Add real name
				ArrayGetString(g_zclass_real_name, i, szRealname2, charsmax(szRealname2))
				if(equal(szRealname, szRealname2)) alterady_exists = true
			}
		}
		if(alterady_exists) {
			log_error(AMX_ERR_PARAMS, "Zombie Class Alterady Exists")
			return -1;
		}
	}
	
	// Add the class
	ArrayPushString(g_zclass_real_name, szRealname)
	ArrayPushString(g_zclass_name, name)
	ArrayPushString(g_zclass_info, info)
	
	// Using same zombie models for all classes?
	if(g_same_models_for_all)
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
		if(!equal(name, buffer))
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
		if(!g_same_models_for_all)
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
				if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
				if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
				formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%sT.mdl", buffer, buffer)
				if(file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)
			}
			
			// We have more custom models than what we can accommodate,
			// Let's make some space...
			if(nummodels_custom > nummodels_default)
			{
				for (k = nummodels_default; k < nummodels_custom; k++)
				{
					ArrayGetString(g_zclass2_playermodel, ArrayGetCell(g_zclass2_modelsstart, i) + k, buffer, charsmax(buffer))
					ArrayInsertStringAfter(g_zclass_playermodel, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k - 1, buffer)
					
					// Precache player model and retrieve its modelindex
					formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", buffer, buffer)
					ArrayInsertCellAfter(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i) + k - 1, engfunc(EngFunc_PrecacheModel, prec_mdl))
					if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
					if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
					formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%sT.mdl", buffer, buffer)
					if(file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)
				}
				
				// Fix models end index for this class
				ArraySetCell(g_zclass_modelsend, g_zclass_i, ArrayGetCell(g_zclass_modelsend, g_zclass_i) + (nummodels_custom - nummodels_default))
			}
			
			/* --- Not needed since classes can't have more than 1 default model for now ---
			// We have less custom models than what this class has by default,
			// Get rid of those extra entries...
			if(nummodels_custom < nummodels_default)
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
	if(ArrayGetCell(g_zclass_new, g_zclass_i))
	{
		// If not using same models for all classes
		if(!g_same_models_for_all)
		{
			// Precache default class model and replace modelindex with the real one
			formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%s.mdl", model, model)
			ArraySetCell(g_zclass_modelindex, ArrayGetCell(g_zclass_modelsstart, g_zclass_i), engfunc(EngFunc_PrecacheModel, prec_mdl))
			formatex(prec_mdl, charsmax(prec_mdl), "models/player/%s/%sT.mdl", buffer, buffer)
			if(file_exists(prec_mdl)) engfunc(EngFunc_PrecacheModel, prec_mdl)
			if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, prec_mdl)
			if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, prec_mdl)
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
	if(!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every item
	static i, item_name[32]
	for (i = 0; i < g_extraitem_i; i++)
	{
		ArrayGetString(g_extraitem_name, i, item_name, charsmax(item_name))
		
		// Check if this is the item to retrieve
		if(equali(name, item_name))
			return i;
	}
	
	return -1;
}

// Native: zp_get_zombie_class_id
public native_get_zombie_class_id(const name[])
{
	// ZPA disabled
	if(!g_pluginenabled)
		return -1;
	
	// Strings passed byref
	param_convert(1)
	
	// Loop through every class
	static i, class_name[32]
	for (i = 0; i < g_zclass_i; i++)
	{
		ArrayGetString(g_zclass_name, i, class_name, charsmax(class_name))
		
		// Check if this is the class to retrieve
		if(equali(name, class_name))
			return i;
	}
	
	return -1;
}

// Native: zp_set_custom_game_mod
public native_set_custom_game_mod(gameid) {
	
	if(allowed_custom_game() && ArrayGetCell(g_gamemode_enable, (gameid - MAX_GAME_MODES)) > 0) {
		command_custom_game(gameid, 0)
		return 1;
	}
	
	return 0		
}

// Native: zp_reset_player_model
public native_reset_player_model(id) {
	reset_player_models(id)
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
	if(g_zm_special[ID_NVISION] >= MAX_SPECIALS_ZOMBIES) {
		write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // r
		write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // g
		write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // b
	}
	else if(g_zm_special[ID_NVISION] > 0 && g_zm_special[ID_NVISION] < MAX_SPECIALS_ZOMBIES)
	{
		write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[ID_NVISION]])) // r
		write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[ID_NVISION]])) // g
		write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[ID_NVISION]])) // b
	}

	// Human / Spectator in normal round
	else if(!g_zombie[ID_NVISION] || !g_isalive[ID_NVISION])
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
	message_begin(MSG_ONE, g_msgNVGToggle, _, id)
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
	if(get_distance_f(originF, destoriginF) > get_pcvar_float(cvar_flashdist))
		return;
	
	// Send to all players?
	if(get_pcvar_num(cvar_flashshowall))
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
	write_byte(get_pcvar_num(g_currentmode == MODE_ASSASSIN ? cvar_flashsize[1] : cvar_flashsize[0])) // radius
	write_byte(g_lant_rgb[0]) // r
	write_byte(g_lant_rgb[1]) // g
	write_byte(g_lant_rgb[2]) // b
	write_byte(3) // life
	write_byte(0) // decay rate
	message_end()
}

// Infection special effects
infection_effects(id)
{
	// Screen fade? (unless frozen)
	if(!g_frozen[id] && get_pcvar_num(cvar_infectionscreenfade))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
		write_short(UNIT_SECOND) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // r
			write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // g
			write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // b
		}
		else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES)
		{
			write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[id]])) // r
			write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[id]])) // g
			write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[id]])) // b
		}
		else
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

		write_byte (255) // alpha
		message_end()
	}
	
	// Screen shake?
	if(get_pcvar_num(cvar_infectionscreenshake))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
		write_short(UNIT_SECOND*75) // amplitude
		write_short(UNIT_SECOND*5) // duration
		write_short(UNIT_SECOND*75) // frequency
		message_end()
	}
	
	// Infection icon?
	if(get_pcvar_num(cvar_hudicons))
	{
		message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
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
	if(get_pcvar_num(cvar_infectiontracers))
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
	if(get_pcvar_num(cvar_infectionparticles))
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
	if(get_pcvar_num(cvar_infectionsparkle))
	{
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_DLIGHT) // TE id
		write_coord(origin[0]) // x
		write_coord(origin[1]) // y
		write_coord(origin[2]) // z
		write_byte(20) // radius
		write_byte(255) // r
		write_byte(0) // g
		write_byte(0) // b
		write_byte(2) // life
		write_byte(0) // decay rate
		message_end()
	}
}

// Nemesis/madness aura task
public zombie_aura(taskid)
{
	// Not nemesis, not in zombie madness
	if(g_zm_special[ID_AURA] <= 0 && !g_nodamage[ID_AURA] || g_zm_special[ID_AURA] >= MAX_SPECIALS_ZOMBIES && ArrayGetCell(g_zm_special_aurarad, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES) <= 0)
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
	
	if(g_zm_special[ID_AURA] >= MAX_SPECIALS_ZOMBIES) {
		write_byte(ArrayGetCell(g_zm_special_aurarad, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES)) // radius
		write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES)) // r
		write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES)) // g
		write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES)) // b
	}
	else {
		write_byte(get_pcvar_num(cvar_zm_auraradius)) // radius
		write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[ID_AURA]])) // r
		write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[ID_AURA]])) // g
		write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[ID_AURA]])) // b
	}
	
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Survivor/Sniper/Berserker aura task
public human_aura(taskid)
{
	// Not survivor or sniper
	if(g_hm_special[ID_AURA] <= 0 || g_hm_special[ID_AURA] >= MAX_SPECIALS_HUMANS && ArrayGetCell(g_hm_special_aurarad, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS) <= 0)
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
	
	if(g_hm_special[ID_AURA] >= MAX_SPECIALS_HUMANS) {
		write_byte(ArrayGetCell(g_hm_special_aurarad, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS)) // radius
		write_byte(ArrayGetCell(g_hm_special_r, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS)) // r
		write_byte(ArrayGetCell(g_hm_special_g, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS)) // g
		write_byte(ArrayGetCell(g_hm_special_b, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS)) // b
	}
	else {
		write_byte(get_pcvar_num(cvar_hm_auraradius[g_hm_special[ID_AURA]])) // radius
		write_byte(get_pcvar_num(cvar_hm_red[g_hm_special[ID_AURA]])) // r
		write_byte(get_pcvar_num(cvar_hm_green[g_hm_special[ID_AURA]])) // g
		write_byte(get_pcvar_num(cvar_hm_blue[g_hm_special[ID_AURA]])) // b
	}
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}

// Make zombies leave footsteps and bloodstains on the floor
public make_blood(taskid)
{
	// Only bleed when moving on ground
	if(!(pev(ID_BLOOD, pev_flags) & FL_ONGROUND) || fm_get_speed(ID_BLOOD) < 80)
		return;
	
	// Get user origin
	static Float:originF[3]
	pev(ID_BLOOD, pev_origin, originF)
	
	// If ducking set a little lower
	if(pev(ID_BLOOD, pev_bInDuck))
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
	
	// Lighting in assassin round is different
	engfunc(EngFunc_MessageBegin, MSG_PAS, SVC_TEMPENTITY, originF, 0)
	write_byte(TE_DLIGHT) // TE id
	engfunc(EngFunc_WriteCoord, originF[0]) // x
	engfunc(EngFunc_WriteCoord, originF[1]) // y
	engfunc(EngFunc_WriteCoord, originF[2]) // z
	write_byte(get_pcvar_num(cvar_flaresize[g_currentmode == MODE_ASSASSIN ? 1 : 0])) // radius
	write_byte(color[0]) // r
	write_byte(color[1]) // g
	write_byte(color[2]) // b
	write_byte(51) //life
	write_byte((duration < 2) ? 3 : 0) //decay rate
	message_end()
	
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
	if(!g_isalive[ID_BURN] || g_nodamage[ID_BURN] || (flags & FL_INWATER) || g_burning_dur[ID_BURN] < 1)
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
	if(g_zombie[ID_BURN] && g_zm_special[ID_BURN] <= 0 && !random_num(0, 20))
	{
		static sound[64]
		ArrayGetString(grenade_fire_player, random_num(0, ArraySize(grenade_fire_player) - 1), sound, charsmax(sound))
		emit_sound(ID_BURN, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	
	// Fire slow down, unless nemesis
	if(g_zm_special[ID_BURN] <= 0 && (flags & FL_ONGROUND) && get_pcvar_float(cvar_fireslowdown) > 0.0)
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
	if(health - floatround(get_pcvar_float(cvar_firedamage), floatround_ceil) > 0)
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
	g_burning_dur[ID_BURN]--
}

// Grenade Blast
create_blast(const Float:originF[3], r, g, b)
{
	new radius_shockwave, size
	radius_shockwave = floatround(NADE_EXPLOSION_RADIUS)
	while(radius_shockwave >= 60) {
		radius_shockwave -= 60
		size++
	}
	
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
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(r) // red
	write_byte(g) // green
	write_byte(b) // blue
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
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(r) // red
	write_byte(g) // green
	write_byte(b) // blue
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
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(r) // red
	write_byte(g) // green
	write_byte(b) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()
}

// Fix Dead Attrib on scoreboard
FixDeadAttrib(id)
{
	message_begin(MSG_BROADCAST, g_msgScoreAttrib)
	write_byte(id) // id
	write_byte(0) // attrib
	message_end()
}

// Send Death Message for infections
SendDeathMsg(attacker, victim)
{
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
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
	if(scoreboard)
	{
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
		write_byte(attacker) // id
		write_short(pev(attacker, pev_frags)) // frags
		write_short(cs_get_user_deaths(attacker)) // deaths
		write_short(0) // class?
		write_short(fm_cs_get_user_team(attacker)) // team
		message_end()
		
		message_begin(MSG_BROADCAST, g_msgScoreInfo)
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

precache_ambience(sound[])
{
	new buffer[150]
	if(equal(sound[strlen(sound)-4], ".mp3")) {
		format(buffer, charsmax(buffer), "sound/%s", sound)
		engfunc(EngFunc_PrecacheGeneric, buffer)
	}
	else  {
		format(buffer, charsmax(buffer), "%s", sound)
		engfunc(EngFunc_PrecacheSound, buffer)
	}
}

// Plays a sound on clients
stock PlaySound(const sound[])
{
	if(equal(sound[strlen(sound)-4], ".mp3"))
		client_cmd(0, "mp3 play ^"sound/%s^"", sound)
	else
		client_cmd(0, "spk ^"%s^"", sound)
}

// Prints a colored message to target (use 0 for everyone), supports ML formatting.
new g_msgsaytext
stock zp_colored_print(const id,const input[], any:...)
{
	if(!g_msgsaytext) {
		g_msgsaytext = get_user_msgid("SayText")
	}

	new msg[191], players[32], count = 1; vformat(msg,190,input,3);
	replace_all(msg,190,"!g","^4");    // green
	replace_all(msg,190,"!y","^1");    // normal
	replace_all(msg,190,"!t","^3");    // team
	
	if(id) players[0] = id; else get_players(players,count,"ch");
	
	for (new i=0;i<count;i++) {
		message_begin(MSG_ONE_UNRELIABLE,g_msgsaytext,_,players[i]);
		write_byte(players[i]);
		write_string(msg);
		message_end();
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
	if(!pev_valid(ent)) return;
	
	static Float:originF[3]
	pev(id, pev_origin, originF)
	set_pev(ent, pev_origin, originF)
	set_pev(ent, pev_spawnflags, pev(ent, pev_spawnflags) | SF_NORESPAWN)
	dllfunc(DLLFunc_Spawn, ent)
	
	static save
	save = pev(ent, pev_solid)
	dllfunc(DLLFunc_Touch, ent, id)
	if(pev(ent, pev_solid) != save)
		return;
	
	engfunc(EngFunc_RemoveEntity, ent)
}

// Strip user weapons (from fakemeta_util)
stock fm_strip_user_weapons(id)
{
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "player_weaponstrip"))
	if(!pev_valid(ent)) return;
	
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
	if(file_exists(filepath))
	{
		new csdmdata[10][6], file = fopen(filepath,"rt")
		
		while (file && !feof(file))
		{
			fgets(file, linedata, charsmax(linedata))
			
			// invalid spawn
			if(!linedata[0] || str_count(linedata,' ') < 2) continue;
			
			// get spawn point data
			parse(linedata,csdmdata[0],5,csdmdata[1],5,csdmdata[2],5,csdmdata[3],5,csdmdata[4],5,csdmdata[5],5,csdmdata[6],5,csdmdata[7],5,csdmdata[8],5,csdmdata[9],5)
			
			// origin
			g_spawns[g_spawnCount][0] = floatstr(csdmdata[0])
			g_spawns[g_spawnCount][1] = floatstr(csdmdata[1])
			g_spawns[g_spawnCount][2] = floatstr(csdmdata[2])
			
			// increase spawn count
			g_spawnCount++
			if(g_spawnCount >= sizeof g_spawns) break;
		}
		if(file) fclose(file)
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
		if(g_spawnCount >= sizeof g_spawns) break;
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
		if(g_spawnCount2 >= sizeof g_spawns2) break;
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
		
		if((dropwhat == 1 && ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)) || (dropwhat == 2 && ((1<<weaponid) & SECONDARY_WEAPONS_BIT_SUM)))
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
		if(str[i] == searchchar)
			count++
	}
	
	return count;
}

// Checks if a space is vacant (credits to VEN)
stock is_hull_vacant(Float:origin[3], hull)
{
	engfunc(EngFunc_TraceHull, origin, origin, 0, hull, 0, 0)
	
	if(!get_tr2(0, TR_StartSolid) && !get_tr2(0, TR_AllSolid) && get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Check if a player is stuck (credits to VEN)
stock is_player_stuck(id)
{
	static Float:originF[3]
	pev(id, pev_origin, originF)
	
	engfunc(EngFunc_TraceHull, originF, originF, 0, (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN, id, 0)
	
	if(get_tr2(0, TR_StartSolid) || get_tr2(0, TR_AllSolid) || !get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}

// Simplified get_weaponid (CS only)
stock cs_weapon_name_to_id(const weapon[])
{
	static i
	for (i = 0; i < sizeof WEAPONENTNAMES; i++)
	{
		if(equal(weapon, WEAPONENTNAMES[i]))
			return i;
	}
	
	return 0;
}

// Get User Current Weapon Entity
stock fm_cs_get_current_weapon_ent(id) {
	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}

// Get Weapon Entity's Owner
stock fm_cs_get_weapon_ent_owner(ent) {
	if(!pev_valid(ent))
		return -1
	
	return get_pdata_cbase(ent, OFFSET_WEAPONOWNER, OFFSET_LINUX_WEAPONS);
}

// Set User Deaths
stock fm_cs_set_user_deaths(id, value) {
	set_pdata_int(id, OFFSET_CSDEATHS, value, OFFSET_LINUX)
}

// Get User Team
stock fm_cs_get_user_team(id) {
	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}

// Set a Player's Team
stock fm_cs_set_user_team(id, team) {
	set_pdata_int(id, OFFSET_CSTEAMS, team, OFFSET_LINUX)
}

// Set User Money
stock fm_cs_set_user_money(id, value) {
	set_pdata_int(id, OFFSET_CSMONEY, value, OFFSET_LINUX)
}

// Set User Flashlight Batteries
stock fm_cs_set_user_batteries(id, value) {
	set_pdata_int(id, OFFSET_FLASHLIGHT_BATTERY, value, OFFSET_LINUX)
}

// Update Player's Team on all clients (adding needed delays)
stock fm_user_team_update(id)
{
	static Float:current_time
	current_time = get_gametime()
	
	if(current_time - g_teams_targettime >= 0.1)
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
	emessage_begin(MSG_ALL, g_msgTeamInfo)
	ewrite_byte(ID_TEAM) // player
	ewrite_string(CS_TEAM_NAMES[fm_cs_get_user_team(ID_TEAM)]) // team
	emessage_end()
	
	// Done switching team
	g_switchingteam = false
}

// Set the precached model index (updates hitboxes server side)
stock fm_cs_set_user_model_index(id, value) {
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
	if(!pev_valid(g_ent_playermodel[id]))
	{
		g_ent_playermodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if(!pev_valid(g_ent_playermodel[id])) return;
		
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
	if(!pev_valid(g_ent_weaponmodel[id]))
	{
		g_ent_weaponmodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if(!pev_valid(g_ent_weaponmodel[id])) return;
		
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
	if(pev_valid(g_ent_playermodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_playermodel[id])
		g_ent_playermodel[id] = 0
	}
	// Remove "weaponmodel" ent if present
	if(pev_valid(g_ent_weaponmodel[id]))
	{
		engfunc(EngFunc_RemoveEntity, g_ent_weaponmodel[id])
		g_ent_weaponmodel[id] = 0
	}
}

// Set User Model
public fm_cs_set_user_model(taskid) {
	set_user_info(ID_MODEL, "model", g_playermodel[ID_MODEL])
}

// Get User Model -model passed byref-
stock fm_cs_get_user_model(player, model[], len) {
	get_user_info(player, "model", model, len)
}

// Update Player's Model on all clients (adding needed delays)
public fm_user_model_update(taskid)
{
	static Float:current_time
	current_time = get_gametime()
	
	if(current_time - g_models_targettime >= g_modelchange_delay) {
		fm_cs_set_user_model(taskid)
		g_models_targettime = current_time
	}
	else {
		set_task((g_models_targettime + g_modelchange_delay) - current_time, "fm_cs_set_user_model", taskid)
		g_models_targettime = g_models_targettime + g_modelchange_delay
	}
}

// Predator/Spy Invisible Powers
public turn_invisible(id) 
{
	if(g_zm_special[id] == PREDATOR) {
		if(get_pcvar_num(cvar_zm_glow[PREDATOR])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, get_pcvar_num(cvar_zm_red[PREDATOR]), get_pcvar_num(cvar_zm_green[PREDATOR]), get_pcvar_num(cvar_zm_blue[PREDATOR]), kRenderTransAdd, 5)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAdd, 5)
	}
	
	if(g_hm_special[id] == SPY) {
		if(get_pcvar_num(cvar_hm_glow[SPY])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[SPY]), get_pcvar_num(cvar_hm_green[SPY]), get_pcvar_num(cvar_hm_blue[SPY]), kRenderTransAdd, 5)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAdd, 5)
	}
}

// Meun bkplayer
public show_menu_personal(id)
{
	new szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_TITLE")
	new menu = menu_create(szText, "show_menu_personal_handler")
	
	if(get_pcvar_num(cvar_huddisplay)) {
		formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM1")
		menu_additem(menu, szText, "1", 0)
	}
	if(get_pcvar_num(cvar_customnvg)) {
		formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM2")
		menu_additem(menu, szText, "2", 0)
	}
	formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM3")
	menu_additem(menu, szText, "3", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public show_menu_personal_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key) {
		case 1: menu_hud_config(id)
		case 2: menu_nightvision(id)
		case 3: menu_flashlight_color(id)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public menu_hud_config(id)
{
	if(!get_pcvar_num(cvar_huddisplay))
		return
	
	new szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TITLE")
	new menu = menu_create(szText, "menu_hud_config_handler")
	
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM1")
	menu_additem(menu, szText, "1", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM2")
	menu_additem(menu, szText, "2", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM3")
	menu_additem(menu, szText, "3", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	menu_display(id, menu, 0)
}
public menu_hud_config_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key) {
		case 1: menu_hud_config_type(id);
		case 2: menu_hud_color(id, 0)
		case 3: menu_hud_color(id, 1)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}

new const personal_color_langs[][] = { "MENU_PERSONAL_COLOR1", "MENU_PERSONAL_COLOR2", "MENU_PERSONAL_COLOR3", "MENU_PERSONAL_COLOR4", 
"MENU_PERSONAL_COLOR5", "MENU_PERSONAL_COLOR6", "MENU_PERSONAL_COLOR7" }

public menu_hud_color(id, zm)
{
	if(!get_pcvar_num(cvar_huddisplay))
		return
	
	new szText[555], szItem[10]
	formatex(szText, charsmax(szText), "%L", id, zm ? "MENU_CHOOSE_HUD_COLOR_TITLE1" : "MENU_CHOOSE_HUD_COLOR_TITLE2")
	new menu = menu_create(szText, zm ? "menu_hud_zm_color_handler" : "menu_hud_hm_color_handler")
	
	for(new i = 0; i < 7; i++) {
		formatex(szText, charsmax(szText), "%L", id, personal_color_langs[i])
		num_to_str(i+1, szItem, charsmax(szItem))
		menu_additem(menu, szText, szItem, 0)
	}
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_hud_zm_color_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
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

public menu_hud_hm_color_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
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
	if(!get_pcvar_num(cvar_huddisplay))
		return
	
	new szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_TITLE")
	new menu = menu_create(szText, "menu_hud_config_type_handler")
	
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_ITEM1")
	menu_additem(menu, szText, "1", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_ITEM2")
	menu_additem(menu, szText, "2", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_ITEM3")
	menu_additem(menu, szText, "3", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_ITEM4")
	menu_additem(menu, szText, "4", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_hud_config_type_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
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
	new szText[555], szItem[10]
	formatex(szText, charsmax(szText), "%L", id, "MENU_CHOOSE_FLASH_COLOR_TITLE")
	new menu = menu_create(szText, "menu_flashlight_color_handler")
	
	for(new i = 0; i < 7; i++) {
		formatex(szText, charsmax(szText), "%L", id, personal_color_langs[i])
		num_to_str(i+1, szItem, charsmax(szItem))
		menu_additem(menu, szText, szItem, 0)
	}
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_flashlight_color_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	g_lantern_color[id] = key-1
	
	menu_destroy(menu)
	show_menu_personal(id)
	return PLUGIN_HANDLED
	
}

public menu_nightvision(id)
{
	if(!get_pcvar_num(cvar_customnvg))
		return
	
	new szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_CONFIG_TITLE")
	new menu = menu_create(szText, "menu_nightvision_handler")
	
	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_ITEM1")
	menu_additem(menu, szText, "1", 0)
	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_ITEM2")
	menu_additem(menu, szText, "2", 0)
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_nightvision_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}
	
	new data[6], iName[64]
	new access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key)
	{
		case 1: menu_night_color(id, 1);
		case 2: menu_night_color(id, 0)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}

public menu_night_color(id, zm)
{
	if(!get_pcvar_num(cvar_customnvg))
		return

	new szText[555], szItem[10]
	formatex(szText, charsmax(szText), "%L", id, zm ? "MENU_NVISION_COLOR_TITLE2" : "MENU_NVISION_COLOR_TITLE1")
	new menu = menu_create(szText, zm ? "menu_night_zm_color_handler" : "menu_night_hm_color_handler")
	
	for(new i = 0; i < 7; i++) {
		formatex(szText, charsmax(szText), "%L", id, personal_color_langs[i])
		num_to_str(i+1, szItem, charsmax(szItem))
		menu_additem(menu, szText, szItem, 0)
	}
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	menu_display(id, menu, 0)
}

public menu_night_hm_color_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
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

public menu_night_zm_color_handler(id, menu, item)
{
	if(item == MENU_EXIT) {
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

public give_hegrenade_bombardier(id) {
	id -= 1213131
	if(g_isalive[id] && g_zombie[id] && g_zm_special[id] == BOMBARDIER && !user_has_weapon(id, CSW_HEGRENADE))
		fm_give_item(id, "weapon_hegrenade")
	else if(!g_zombie[id] || g_zm_special[id] != BOMBARDIER)
		remove_task(id+1213131)
		
	if(g_isbot[id] && user_has_weapon(id, CSW_HEGRENADE))	{
		engclient_cmd(id, "weapon_hegrenade");
		ExecuteHam(Ham_Weapon_PrimaryAttack, get_pdata_cbase(id, 373, 5));
	}
}

// Dragon Habilities
public use_cmd(player)
{
	if(g_zm_special[player] != DRAGON || !g_isalive[player])
		return PLUGIN_HANDLED
	
	if(get_gametime() - gLastUseCmd[player] < get_pcvar_float(cvar_dragon_power_cooldown))
		return PLUGIN_HANDLED
	
	gLastUseCmd[player] = get_gametime()
	
	new target, body
	get_user_aiming(player, target, body, get_pcvar_num(cvar_dragon_power_distance))
	
	if(is_user_valid_alive(target) && !g_zombie[target]) {
		switch(random_num(0,1)) {
			case 0: native_set_user_frozen(target, 1), sprite_control(player, 0)
			case 1: native_set_user_burn(target, 1), sprite_control(player, 1)
		}
	}
	else {
		switch(random_num(0,1)) {
			case 0: sprite_control(player, 0)
			case 1: sprite_control(player, 1)
		}
	}
	return PLUGIN_HANDLED
}

public te_spray(args[])
{
	message_begin(MSG_BROADCAST,SVC_TEMPENTITY)
	write_byte(120) // Throws a shower of sprites or models
	write_coord(args[0]) // start pos
	write_coord(args[1])
	write_coord(args[2])
	write_coord(args[3]) // velocity
	write_coord(args[4])
	write_coord(args[5])
	write_short(args[6] ? g_flameSpr : frostsprite) // spr
	write_byte(8) // count
	write_byte(70) // speed
	write_byte(100) //(noise)
	write_byte(5) // (rendermode)
	message_end()
	
	return PLUGIN_CONTINUE
}

public sprite_control(player, fire)
{
	new vec[3], aimvec[3], velocityvec[3], length, speed = 10
	
	get_user_origin(player, vec)
	get_user_origin(player, aimvec, 2)
	
	velocityvec[0] = aimvec[0] - vec[0]
	velocityvec[1] = aimvec[1] - vec[1]
	velocityvec[2] = aimvec[2] - vec[2]
	length = sqrt(velocityvec[0] * velocityvec[0] + velocityvec[1] * velocityvec[1] + velocityvec[2] * velocityvec[2])
	velocityvec[0] = velocityvec[0] * speed / length
	velocityvec[1] = velocityvec[1] * speed / length
	velocityvec[2] = velocityvec[2] * speed / length
	
	new args[8]
	args[0] = vec[0]; args[1] = vec[1]; args[2] = vec[2]
	args[3] = velocityvec[0]; args[4] = velocityvec[1]; args[5] = velocityvec[2]
	args[6] = fire
	
	set_task(0.1, "te_spray", 0, args, 8, "a", 2)
	
}

public client_PreThink(id) 
{
	if(g_zm_special[id] != DRAGON || !g_isalive[id]) return PLUGIN_CONTINUE
	
	new Float:fAim[3] , Float:fVelocity[3];
	VelocityByAim(id , get_pcvar_num(cvar_dragon_flyspped) , fAim);
	
	if(get_user_button(id) & IN_JUMP) {
		fVelocity[0] = fAim[0]; fVelocity[1] = fAim[1]; fVelocity[2] = fAim[2];
		set_user_velocity(id , fVelocity);
	}
	return PLUGIN_CONTINUE;
}

public sqrt(num)
{
	new div = num
	new result = 1
	while(div > result) {
		div = (div + result) / 2
		result = num / div
	}
	return div
}

public reset_user_rendering(id)
{
	new ent_id
	ent_id = g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id
	
	if(g_frozen[id]) {
		fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25) // Light blue glow while frozen
	}	
	else if(g_zombie[id])
	{
		if(g_zm_special[id] <= 0)
			fm_set_rendering(ent_id)
			
		else if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_glow, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0)
				fm_set_rendering(ent_id, kRenderFxGlowShell, ArrayGetCell(g_zm_special_r, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_g, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_b, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), kRenderNormal, 20)
			else
				fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0,  kRenderNormal, 20)
		}
	
		else if(g_zm_special[id] > 0) {
			if(get_pcvar_num(cvar_zm_glow[g_zm_special[id]]))
				fm_set_rendering(ent_id, kRenderFxGlowShell, get_pcvar_num(cvar_zm_red[g_zm_special[id]]), get_pcvar_num(cvar_zm_green[g_zm_special[id]]), get_pcvar_num(cvar_zm_blue[g_zm_special[id]]), g_zm_special[id] == PREDATOR ? kRenderTransAdd : kRenderNormal, g_zm_special[id] == PREDATOR ?  5 : 20)
			else
				fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0, g_zm_special[id] == PREDATOR ? kRenderTransAdd : kRenderNormal, g_zm_special[id] == PREDATOR ?  5 : 20)
		}
	}
	else
	{
		if(g_hm_special[id] <= 0)
			fm_set_rendering(ent_id)
			
		else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_glow, g_hm_special[id]-MAX_SPECIALS_HUMANS) > 0)
				fm_set_rendering(ent_id, kRenderFxGlowShell, ArrayGetCell(g_hm_special_r, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_g, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_b, g_hm_special[id]-MAX_SPECIALS_HUMANS), kRenderNormal, 20)
			else
				fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0,  kRenderNormal, 20)
		}

		else if(g_hm_special[id] > 0) {
			if(get_pcvar_num(cvar_hm_glow[g_hm_special[id]]))
				fm_set_rendering(ent_id, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[g_hm_special[id]]), get_pcvar_num(cvar_hm_green[g_hm_special[id]]), get_pcvar_num(cvar_hm_blue[g_hm_special[id]]), g_hm_special[id] == SPY ? kRenderTransAdd : kRenderNormal, g_hm_special[id] == SPY ? 5 : 20)
			else
				fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0, g_hm_special[id] == SPY ? kRenderTransAdd : kRenderNormal, g_hm_special[id] == SPY ? 5 : 20)
		}
	}
}



public reset_player_models(id) 
{
	static currentmodel[32], tempmodel[32], already_has_model, i, iRand, size
	already_has_model = false
	
	if(g_handle_models_on_separate_ent)
	{
		if(g_zombie[id]) {
			// Set the right model
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				ArrayGetString(g_zm_special_model, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, g_playermodel[id], charsmax(g_playermodel[]))
				if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zm_special_modelindex, g_zm_special[id]-MAX_SPECIALS_ZOMBIES))
			}
			else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(g_zm_special[id] > 0 && g_zm_special_enable[g_zm_special[id]]) {
					iRand = random_num(0, ArraySize(model_zm_special[g_zm_special[id]]) - 1)
					ArrayGetString(model_zm_special[g_zm_special[id]], iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_zm_sp[g_zm_special[id]], iRand))
				}
			}
			else
			{
				if(get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					iRand = random_num(0, ArraySize(model_admin_zombie) - 1)
					ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
				}
				else {
					iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
					ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
				}
			}
		}
		else {
			// Set the right model
			if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
				ArrayGetString(g_hm_special_model, g_hm_special[id]-MAX_SPECIALS_HUMANS, g_playermodel[id], charsmax(g_playermodel[]))
				if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hm_special_modelindex, g_hm_special[id]-MAX_SPECIALS_HUMANS))
			}
			else if(g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS) {	
				if(g_hm_special[id] > 0 && g_hm_special_enable[g_hm_special[id]]) {
					iRand = random_num(0, ArraySize(model_human[g_hm_special[id]]) - 1)
					ArrayGetString(model_human[g_hm_special[id]], iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human[g_hm_special[id]], iRand))
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					iRand = random_num(0, ArraySize(model_admin_human) - 1)
					ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
				}
				else if(get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					iRand = random_num(0, ArraySize(model_vip_human) - 1)
					ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
				}
				else {
					iRand = random_num(0, ArraySize(model_human[0]) - 1)
					ArrayGetString(model_human[0], iRand, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human[0], iRand))
				}
			}
		}
		// Set model on player model entity
		fm_set_playermodel_ent(id)

	}
	else
	{
		if(g_zombie[id]) {
			// Get current model for comparing it with the current one
			fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
			
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				ArrayGetString(g_zm_special_model, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, tempmodel, charsmax(tempmodel))
				
				if(equal(currentmodel, tempmodel)) already_has_model = true
		
				if(!already_has_model) {
					ArrayGetString(g_zm_special_model, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zm_special_modelindex, g_zm_special[id]-MAX_SPECIALS_ZOMBIES))
				}
			}
			else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(g_zm_special[id] > 0 && g_zm_special_enable[g_zm_special[id]]) {
					// Set the right model, after checking that we don't already have it
					size = ArraySize(model_zm_special[g_zm_special[id]])
					for (i = 0; i < size; i++) {
						ArrayGetString(model_zm_special[g_zm_special[id]], i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_zm_special[g_zm_special[id]], iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_zm_sp[g_zm_special[id]], iRand))
					}
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					size = ArraySize(model_admin_zombie)
					for (i = 0; i < size; i++) {
						ArrayGetString(model_admin_zombie, i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_admin_zombie, iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_zombie, iRand))
					}
				}
				else {
					for (i = ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]); i < ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]); i++) {
						ArrayGetString(g_zclass_playermodel, i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
						ArrayGetString(g_zclass_playermodel, iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_zclass_modelindex, iRand))
					}
				}
			}
		}
		else {
			// Get current model for comparing it with the current one
			fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))
			
			// Set the right model, after checking that we don't already have it
			if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
				ArrayGetString(g_hm_special_model, g_hm_special[id]-MAX_SPECIALS_HUMANS, tempmodel, charsmax(tempmodel))
				
				if(equal(currentmodel, tempmodel)) already_has_model = true
		
				if(!already_has_model) {
					ArrayGetString(g_hm_special_model, g_hm_special[id]-MAX_SPECIALS_HUMANS, g_playermodel[id], charsmax(g_playermodel[]))
					if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_hm_special_modelindex, g_hm_special[id]-MAX_SPECIALS_HUMANS))
				}
			}			
			else if(g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS) {
				if(g_hm_special[id] > 0 && g_hm_special_enable[g_hm_special[id]]) {
					size = ArraySize(model_human[g_hm_special[id]])
					for (i = 0; i < size; i++) {
						ArrayGetString(model_human[g_hm_special[id]], i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_human[g_hm_special[id]], iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human[g_hm_special[id]], iRand))
					}
				}
			}
			else
			{
				if(get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					size = ArraySize(model_admin_human)
					for (i = 0; i < size; i++) {
						ArrayGetString(model_admin_human, i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_admin_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_admin_human, iRand))
					}
				}
				else if(get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					size = ArraySize(model_vip_human)
					for (i = 0; i < size; i++) {
						ArrayGetString(model_vip_human, i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_vip_human, iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_vip_human, iRand))
					}
				}
				else {
					size = ArraySize(model_human[0])
					for (i = 0; i < size; i++) {
						ArrayGetString(model_human[0], i, tempmodel, charsmax(tempmodel))
						if(equal(currentmodel, tempmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_human[0], iRand, g_playermodel[id], charsmax(g_playermodel[]))
						if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, ArrayGetCell(g_modelindex_human[0], iRand))
					}
				}
			}
		}

		// Need to change the model?
		if(!already_has_model) {
			if(g_newround) set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else fm_user_model_update(id+TASK_MODEL)
		}
	}
}

stock add_point(number)
{ 
	new count, i, str[29], str2[35], len
	num_to_str(number, str, charsmax(str))
	len = strlen(str)

	for (i = 0; i < len; i++) {
		if(i != 0 && ((len - i) %3 == 0)) {
			add(str2, charsmax(str2), ".", 1)
			count++
			add(str2[i+count], 1, str[i], 1)
		}
		else add(str2[i+count], 1, str[i], 1)
	}
	return str2;
}

stock set_screenfadein(id, fadetime, r, g, b, alpha)
{
	new players[32], count = 1
	if(id) players[0] = id; else get_players(players,count,"ch");
    
	for (new i=0;i<count;i++) {
		if(is_user_connected(players[i])) {
			message_begin(MSG_ONE, g_msgScreenFade, _, players[i])
			write_short(UNIT_SECOND*fadetime) // duration
			write_short(0) // hold time
			write_short(FFADE_IN) // fade type
			write_byte(r) // red
			write_byte(g) // green
			write_byte(b) // blue
			write_byte(alpha) // alpha
			message_end()
		}
	}
}
