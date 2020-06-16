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
		- Custom Modes (If Enable): Assassin Vs Sniper, Nightmare, Remix
		- More Custom Modes (If you want): https://github.com/PerfectScrash/ZP-Special-Mods

	If you Want to see more ZPSp Gameplay Additions Click Here: https://github.com/PerfectScrash/ZP-Special-Additions
	
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
			- Added Some Natives (zp_get_special_class_id/zp_get_zombie_class_realname)
			- Fixed custom special class's rounds
		* 3.3:
			- Added 4.3 fix 5a's all contains and fixes
			
		* 3.4:
			- Fixed cvar "zp_surv_damage_multi"
			- Added New Natives
			- Added Cvars for turn on/off frozing Nemesis/Assassin/Predator/Bombardier/Dragon
			- Added Configuration for turn on/off frozing Custom Special Zombies
			- Removed cvar "zp_random_weapons" because are changed for "zp_random_primary" and "zp_random_secondary" (Like ZP 5.0)
		* 3.5:
			- Added Zombie Escape Map Suport
			- Fix Bug on Custom Special Classes Game modes not start when have one people on server
			- Added Natives: (zp_is_escape_map | zp_do_random_spawn)
			- Added More New Cvars
			- Fixed Small Bug on precache ambience sounds
			- Fixed Bombardier Grenade when infection bomb is disable
			- Added p_ & w_ model for Grenades
		* 3.5 Fix:
			- Removed Block use button before round begins (Reason: Some maps have button for open door on start)
			- Fixed Native zp_get_user_next_class
		* 4.0:
			- Fixed T Model Precache
			- Added Configuration for enable/disable Special Classes (Custom and Normal)
			- Fixed native ze_is_escape_map
			- Fixed Log Error when player die before round begins
			- Readed cvar for change nvsion color 
			- Added cvar for disable/enable for peoples change nvision color in personal menu
			- Fixed cvar for change flashlight color 
			- Added cvar for disable/enable for peoples change flashlight color in personal menu
			- Added one Hud Style: Under Radar
			- Added cvar zp_zombie_escape_fail for zombies scoring when time up and humans not escaped in escape maps
			- Added configuration: "VIP ZOMBIE" for change vip zombie model
			- Added configuration: "ENABLE END ROUND SOUNDS" for enable/disable end round sounds
			- Added More Forwards for you custonomize more easily
			- Updated zombie_plague_special.ini and .cfg (Need Change when you update 3.5 to 4.0 for prevent bugs)
			- Lang Updated (Need Change when you update 3.5 to 4.0 for prevent bugs)
			
		* 4.1:
			- Fixed Start Modes Menu
			- Fixed Forwards
			- Added Multimodels Suport in .ini files
			- ZP main menu title can change now from lang [Lang Updated (Need Change when you update 4.0 or bellow to 4.1 for prevent bugs)]
			- Added Escape Support for Cvar "zp_human_armor_protect"
			- Fixed a Small Bug with choose class instantanly when dead
			- Added Block Trigger Hurt Kill Damage before Round Starts and when round end (Essentials for Zombie Escape Maps)
			- Fixed MP3 Precache

		* 4.2:
			- Added Native: zp_reload_csdm_respawn()
			- Added Native: zp_set_lighting(const light[])
			- Added Native: zp_reset_lighting()
			- Added Native: zp_get_random_player(const team = 0)
			- Added Native: zp_is_user_stuck(id)
			- Added Forward: zp_infected_by_bomb_pre(victim, attacker)
			- Added Forward: zp_infected_by_bomb_post(victim, attacker)
			- Added Forward: zp_user_unstuck_pre(id)
			- Added Forward: zp_user_unstuck_post(id)
			- Added Native: zp_register_weapon(const name[], wpn_type)
			- Added Native: zp_weapon_menu_textadd(const text[])
			- Added Native: zp_get_weapon_realname(wpn_type, weaponid, name[], len)
			- Added Native: zp_get_weapon_name(wpn_type, weaponid, name[], len)
			- Added Native: zp_set_weapon_name(wpn_type, weaponid, name[])
			- Added Native: zp_weapon_is_custom(wpn_type, weaponid)
			- Added Native: zp_weapon_count(wpn_type, skip_def_custom)
			- Added Native: zp_set_model_param(const string[])
			- Added Forward: zp_weapon_selected_pre(id, wpn_type, weaponid)
			- Added Forward: zp_weapon_selected_post(id, wpn_type, weaponid)
			- Added Free Nightvision for Human Special Class (Disable with cvar)
			- Removed "zp_nvg_give" cvar for add cvar for each class
			- Trigger hurt kill before round starts now teleport player to spawn
			- Fixed Log Files
			- Fixed small bug in forward zp_user_model_change_pre/zp_user_model_change_post (In override native)
			- Log files are created now with date on name (Example: zombie_plague_special_21-06-2018.txt)
			- Fixed Admin Menu Small Bugs
			- Fixed Dragon Frost Skill Bug
			- Added Start Special Class modes itens (Nemesis/Assassin/Survivor/etc) in Start modes menu
			- Improved Code
			- .cfg update [Need Change for prevent possible bugs]
			- Lang updated (For menu itens) [Need Change for prevent possible bugs]

		* 4.3
			- Fixed Native: zp_get_special_class_id
			- Fixed Native: zp_get_zombie_class_realname
			- Fixed Native: zp_get_extra_item_realname
			- Fixed Native: zp_make_user_special
			- Fixed Native: zp_get_gamemode_id
			- Fixed Native: zp_get_extra_item_realname
			- Fixed Native: zp_get_random_player
			- Fixed Zombie armor damage.
			- Removed Replace Chars when you register some item/class/gamemode/special class/weapon with [ or ] chars (Update your amx_settings for prevent bugs)
			- Added Native: zp_start_game_mod(gameid)
			- Added Native: zp_set_next_game_mode(gameid)
			- Added Native: zp_is_special_class_enable(is_zm, classid)
			- Added Native: zp_is_gamemode_enable(modeid)
			- Added Cvar: zp_zombie_idle_sound
			- Added Separate Grenade Configuration
			- Fixed Escape support for external gamemodes when enable gamemode only in escape map
			- Changed Swarm chossing player system to same system of multi infection (Before are chossing by Team now its randomly)
			- Added Cvar: zp_swarm_ratio
			- Added Escape support for enable/disable internal gamemodes in a certain modes
			- Optmized Code
		
		* 4.3 [Fix]:
			- Fixed small bug with extra item grenades (Like antidote bomb, jump bomb, etc)
		
		* 4.4 Beta:
			- Fixed Plague Mod
			- Added ZP_CHAT_TAG in lang (You can change chat tag now) [Lang updated: update lang for prevent bugs]
			- Fixed Server Crash when "zp_human_damage_reward"/"zp_zombie_damage_reward" are disable
			- Now Ammo Pack by Damage dealth are now works like in zp 5.0
			- Added Cvar "zp_ammopack_damage"
			- Changed Native "zp_set_extra_damage"
			- Fixed Native in include: "zp_get_special_class_name"
			- Fixed Trigger Hurt kill
			
		--- Beta Update 1/3/20
			- Fixed painfree/knockback
			- Added Support to change roundtime in zombie_plague_special.ini

		--- Beta Update 25/3/20
			- Added Respawn limit cvars by gamemode (Same with custom gamemodes but you can change only in zpsp_gamemodes.ini)
			- Added Native: zpsp_register_gamemode(const name[], flags, chance, allow, dm_mode, resp_limit=0, enable_in_ze=0)
			- Added Custom Death sound for Normal/Special Zombie Classes (Now you can change in .ini files for any class)
			- Added Pain Sounds for specific zombie class (You can change in zpsp_zombieclasses.ini)
			- Added Native: zp_get_custom_extra_start()

		--- Beta Update 15/06/20
			- Fixed Not Precached Sound '0'
			- Added Fade Nightvision Mode (Can change by cvar "zp_nvg_custom")
			- Added Cvar: "zp_nvg_fade_alpha"
			- Added Madness delay (After Use)
			- Added Cvar: "zp_extra_madness_use_delay"


============================================================================================================================*/
/*================================================================================
 [Plugin Info]
=================================================================================*/
#define PLUGIN "\r[Z]\wombie \r[P]\wlague \r[S]\wpecial"
#define VERSION "4.4"
#define AUTHOR "MeRcyLeZZ | @bdul! | [P]erfect [S]crash"

/*================================================================================
 [Plugin Customization]
=================================================================================*/
new const ZP_CUSTOMIZATION_FILE[] = "zombie_plague_special.ini"
new const ZP_ZOMBIECLASSES_FILE[] = "zpsp_zombieclasses.ini"
new const ZP_EXTRAITEMS_FILE[] = "zpsp_extraitems.ini"
new const ZP_CUSTOM_GM_FILE[] = "zpsp_gamemodes.ini"
new const ZP_SPECIAL_CLASSES_FILE[] = "zpsp_special_classes.ini"
new const ZP_WEAPONS_FILE[] = "zpsp_custom_weapons.ini"

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
#include <amx_settings_api>

/*================================================================================
 [Constants, Offsets, Macros]
=================================================================================*/
new const mode_langs[][] = {
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

enum { // Access flags
	ACCESS_ADMIN_MENU = 0,
	ACCESS_MODE_INFECTION,
	ACCESS_MODE_NEMESIS,
	ACCESS_MODE_ASSASSIN,
	ACCESS_MODE_PREDATOR,
	ACCESS_MODE_BOMBARDIER,
	ACCESS_MODE_DRAGON,
	ACCESS_MODE_SURVIVOR,
	ACCESS_MODE_SNIPER,
	ACCESS_MODE_BERSERKER,
	ACCESS_MODE_WESKER,
	ACCESS_MODE_SPY,
	ACCESS_MODE_SWARM,
	ACCESS_MODE_MULTI,
	ACCESS_MODE_PLAGUE,
	ACCESS_MODE_LNJ,
	ACCESS_ADMIN_MENU2,
	ACCESS_ADMIN_MENU3,
	ACCESS_ADMIN_MODELS,
	ACCESS_VIP_MODELS,
	ACCESS_RESPAWN_PLAYERS,
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
enum (+= 100) { // Task offsets
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
	TASK_AMBIENCESOUNDS,
	TASK_MADNESS
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

#define REFILL_WEAPONID args[0] // BP Ammo Refill task

// For weapon buy menu handlers
#define WPN_STARTID g_menu_data[id][1]
#define WPN_SELECTION (g_menu_data[id][1]+key)
#define WPN_AUTO_ON g_menu_data[id][2]
#define WPN_AUTO_PRI g_menu_data[id][3]
#define WPN_AUTO_SEC g_menu_data[id][4]
#define WPN_TYPE g_menu_data[id][12]

// For remembering menu pages
#define MENU_PAGE_ZCLASS g_menu_data[id][5]
#define MENU_PAGE_EXTRAS g_menu_data[id][6]
#define MENU_PAGE_PLAYERS g_menu_data[id][7]
#define MENU_PAGE_GAMEMODES g_menu_data[id][8]
#define MENU_PAGE_SPECIAL_CLASS g_menu_data[id][9]
#define MENU_PAGE_CUSTOM_SP_Z g_menu_data[id][10]
#define MENU_PAGE_CUSTOM_SP_H g_menu_data[id][11]
#define MENU_PAGE_START_MODES g_menu_data[id][13]

#define PL_ACTION g_menu_data[id][0] // For player list menu handlers

#define EXTRAS_CUSTOM_STARTID (EXTRA_WEAPONS_STARTID + ArraySize(g_extraweapon_names)) // For extra items menu handlers

// Menu selections
const MENU_KEY_AUTOSELECT = 7
const MENU_KEY_BACK = 7
const MENU_KEY_NEXT = 8
const MENU_KEY_EXIT = 9

enum { EXTRA_NVISION = 0, EXTRA_ANTIDOTE, EXTRA_MADNESS, EXTRA_INFBOMB, EXTRA_WEAPONS_STARTID } // Hard coded extra items
new const MODE_SET = 1 // Game mode settings

enum { // Game modes
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
const ZP_TEAM_ZOMBIE_SPECIAL = -1
const ZP_TEAM_HUMAN_SPECIAL = -2
const ZP_TEAM_ANY_SPECIAL = -3
const ZP_TEAM_ALL = -4
enum {
	TEAM_ZOMBIE = 0,
	TEAM_HUMAN,
	TEAM_NEMESIS,
	TEAM_SURVIVOR,
	TEAM_SNIPER,
	TEAM_ASSASSIN,
	TEAM_PREDATOR,
	TEAM_BERSERKER,
	TEAM_WESKER,
	TEAM_BOMBARDIER,
	TEAM_SPY,
	TEAM_DRAGON,
	MAX_TEAMS
}
#define GetTeamIndex(%1) (1<<ArrayGetCell(ZP_TEAM_INDEX, %1))
#define IsTeam(%1) (team & (1<<ArrayGetCell(ZP_TEAM_INDEX, %1)))
new Array:ZP_TEAM_NAMES, Array:ZP_TEAM_INDEX, Array:itens_teams_index_human, Array:itens_teams_index_zombie

new Array:temp_array[3] // Create an temporary Array

const ZCLASS_NONE = -1 // Zombie classes

// HUD messages
const Float:HUD_EVENT_X = -1.0
const Float:HUD_EVENT_Y = 0.17
const Float:HUD_INFECT_X = 0.05
const Float:HUD_INFECT_Y = 0.45
const Float:HUD_SPECT_X = -1.0
const Float:HUD_SPECT_Y = 0.8
const Float:HUD_STATS_X = 0.78
const Float:HUD_STATS_Y = 0.18

new Ham:Ham_Player_ResetMaxSpeed = Ham_Item_PreFrame // Hack to be able to use Ham_Player_ResetMaxSpeed (by joaquimandrade)

// CS Player PData Offsets (win32)
const PDATA_SAFE = 2
const OFFSET_PAINSHOCK = 108 // ConnorMcLeod
const OFFSET_CSTEAMS = 114
const OFFSET_CSMONEY = 115
const OFFSET_CSMENUCODE = 205
const OFFSET_FLASHLIGHT_BATTERY = 244
const OFFSET_CSDEATHS = 444
const OFFSET_MODELINDEX = 491 // Orangutanz

const OFFSET_ACTIVE_ITEM = 373 // CS Player CBase Offsets (win32)

const OFFSET_WEAPONOWNER = 41 // CS Weapon CBase Offsets (win32)

// Linux diff's
const OFFSET_LINUX = 5 // offsets 5 higher in Linux builds
const OFFSET_LINUX_WEAPONS = 4 // weapon offsets are only 4 steps higher on Linux

enum { // CS Teams
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

new const cs_sounds[][] = { "items/flashlight1.wav", "items/9mmclip1.wav", "player/bhit_helmet-1.wav" } // CS sounds
new Float:NADE_EXPLOSION_RADIUS // Explosion radius for custom grenades
const PEV_ADDITIONAL_AMMO = pev_iuser1 // HACK: pev_ field used to store additional ammo on weapons

// HACK: pev_ field used to store custom nade types and their values
const PEV_NADE_TYPE = pev_flTimeStepSound
const NADE_TYPE_INFECTION = 1111
const NADE_TYPE_NAPALM = 2222
const NADE_TYPE_FROST = 3333
const NADE_TYPE_FLARE = 4444
const PEV_FLARE_COLOR = pev_punchangle
const PEV_FLARE_DURATION = pev_flSwimTime

enum { FIRE = 0, FROST, FLARE, INFECTION_BOMB, MAX_GRENADES } // Grenade Index

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

enum { // Ambience Sounds
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
enum { // Admin menu actions
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
enum { NEMESIS = 1, ASSASSIN, PREDATOR, BOMBARDIER, DRAGON, MAX_SPECIALS_ZOMBIES }	// Special Class Index
enum { SURVIVOR = 1, SNIPER, BERSERKER, WESKER, SPY, MAX_SPECIALS_HUMANS }

// Special Class Vars
new Array:g_hm_special_realname, Array:g_hm_special_name, Array:g_hm_special_model, Array:g_hm_special_modelindex, Array:g_hm_special_health, Array:g_hm_special_speed, Array:g_hm_special_uclip,
Array:g_hm_special_gravity, Array:g_hm_special_leap, Array:g_hm_special_leap_f, Array:g_hm_special_ignorefrag, Array:g_hm_special_ignoreammo, Array:g_hm_special_flags,
Array:g_hm_special_leap_h, Array:g_hm_special_leap_c, Array:g_hm_specials, Array:g_hm_special_respawn, Array:g_hm_special_painfree, Array:g_hm_special_modelstart, Array:g_hm_special_modelsend,
Array:g_hm_special_aurarad, Array:g_hm_special_glow, Array:g_hm_special_r, Array:g_hm_special_g, Array:g_hm_special_b, Array:g_hm_special_enable, Array:g_hm_special_nvision
new g_hm_specials_i = MAX_SPECIALS_HUMANS, g_hm_special[33]

new Array:g_zm_special_realname, Array:g_zm_special_name, Array:g_zm_special_model, Array:g_zm_special_painsound, Array:g_zm_special_knifemodel, Array:g_zm_special_modelindex, Array:g_zm_special_health, Array:g_zm_special_speed, Array:g_zm_special_knockback,
Array:g_zm_special_gravity, Array:g_zm_special_leap, Array:g_zm_special_leap_f, Array:g_zm_special_ignorefrag, Array:g_zm_special_ignoreammo, Array:g_zm_special_flags, Array:g_zm_special_painsndstart, Array:g_zm_special_painsndsend,
Array:g_zm_special_leap_h, Array:g_zm_special_leap_c, Array:g_zm_specials, Array:g_zm_special_respawn, Array:g_zm_special_painfree, Array:g_zm_special_modelstart, Array:g_zm_special_modelsend,
Array:g_zm_special_aurarad, Array:g_zm_special_glow, Array:g_zm_special_r, Array:g_zm_special_g, Array:g_zm_special_b, Array:g_zm_special_allow_burn, Array:g_zm_special_allow_frost, Array:g_zm_special_enable, Array:g_zm_special_nvision
new g_zm_specials_i = MAX_SPECIALS_ZOMBIES, g_zm_special[33], Array:g_zm_sp_deathsnd, Array:g_zm_sp_deathsnd_start, Array:g_zm_sp_deathsnd_end

// Player vars
new g_hud_type[33], g_hud_color[2][33], g_flashlight_color[33], g_flashlight_rgb[3], g_nv_color[2][33], g_nvrgb[3], g_respawn_count[33]
new g_zombie[33], g_firstzombie[33], g_lastzombie[33], g_lasthuman[33], g_frozen[33], g_nodamage[33], g_respawn_as_zombie[33], Float:g_frozen_gravity[33], Float:g_buytime[33]
new g_nvision[33], g_nvisionenabled[33], g_nvg_enabled_mode[33], g_zombieclass[33], g_zombieclassnext[33], g_flashlight[33], g_flashbattery[33] = { 100, ... }
new g_canbuy[33], g_ammopacks[33], g_damagedealt[33], how_many_rewards, Float:g_lastleaptime[33], Float:g_lastflashtime[33], g_playermodel[33][32], g_bot_extra_count[33]
new g_menu_data[33][14], g_ent_playermodel[33], g_ent_weaponmodel[33], g_burning_dur[33], Float:g_current_maxspeed[33], g_user_custom_speed[33]

// Game vars
new g_pluginenabled, g_newround, g_endround, g_modestarted, g_allowinfection, g_deathmatchmode, g_currentmode, g_lastmode, g_nextmode 
new g_scorezombies, g_scorehumans, g_gamecommencing, g_spawnCount, g_spawnCount2, Float:g_spawns[MAX_CSDM_SPAWNS][3], Float:g_spawns2[MAX_CSDM_SPAWNS][3] 
new g_lights_i, g_lights_cycle[32], g_lights_cycle_len, Float:g_models_targettime, Float:g_teams_targettime, g_MsgSync[3]
new g_trailSpr[MAX_GRENADES], g_ExplodeSpr[MAX_GRENADES], g_GibSpr[MAX_GRENADES], g_RingSpr, g_flameSpr, g_smokeSpr, g_glassSpr, g_modname[32], g_freezetime, g_maxplayers, g_czero
new g_hamczbots, g_fwSpawn, g_fwPrecacheSound, g_infbombcounter, g_antidotecounter, g_madnesscounter, g_arrays_created, g_escape_map
new g_lastplayerleaving, g_switchingteam, g_buyzone_ent, zm_special_enable[MAX_SPECIALS_ZOMBIES], hm_special_enable[MAX_SPECIALS_HUMANS]
new custom_lighting[2], g_custom_light, g_ForwardParameter[64]

// Message IDs vars
new g_msgScoreInfo, g_msgNVGToggle, g_msgScoreAttrib, g_msgAmmoPickup, g_msgScreenFade, g_msgDeathMsg, g_msgSetFOV, g_msgFlashlight, g_msgFlashBat, 
g_msgTeamInfo, g_msgDamage, g_msgHideWeapon, g_msgCrosshair, g_msgScreenShake, g_msgCurWeapon

enum { // Forward Enum
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
	RESET_RENDERING_PRE,
	RESET_RENDERING_POST,
	MODEL_CHANGE_PRE,
	MODEL_CHANGE_POST,
	HM_SP_CHOSSED_PRE,
	ZM_SP_CHOSSED_PRE,
	HM_SP_CHOSSED_POST,
	ZM_SP_CHOSSED_POST,
	GM_SELECTED_PRE,
	INFECTED_BY_BOMB_PRE,
	INFECTED_BY_BOMB_POST,
	UNSTUCK_PRE,
	UNSTUCK_POST,
	WEAPON_SELECTED_PRE,
	WEAPON_SELECTED_POST,
	MAX_FORWARDS_NUM
};
new g_forwards[MAX_FORWARDS_NUM], g_fwDummyResult

enum { VIEW_MODEL = 0, PLAYER_MODEL, WORLD_MODEL, MAX_WPN_MDL } // Weapon Model

#define entity_set_model(%1,%2) engfunc(EngFunc_SetModel, %1, %2)

// Temporary Database vars (used to restore players stats in case they get disconnected)
new db_name[MAX_STATS_SAVED][32], db_ammopacks[MAX_STATS_SAVED], db_zombieclass[MAX_STATS_SAVED], db_slot_i

// Custom Game Modes vars
new Array:g_gamemode_realname, Array:g_gamemode_name, Array:g_gamemode_enable, Array:g_gamemode_enable_on_ze_map, Array:g_gamemode_flag, Array:g_gamemode_chance, 
Array:g_gamemode_allow, Array:g_gamemode_dm, Array:g_gamemodes_new, Array:g_gamemode_respawn_limit, g_gamemodes_i = MAX_GAME_MODES

// Extra Items vars
new Array:g_extraitem_realname, Array:g_extraitem_name, Array:g_extraitem_cost, Array:g_extraitem_team, g_extraitem_i, g_AdditionalMenuText[32], Array:g_extraitem_new

// Zombie Classes vars
new Array:g_zclass_real_name, Array:g_zclass_name, Array:g_zclass_info, Array:g_zclass_modelsstart, Array:g_zclass_modelsend, Array:g_zclass_playermodel
new Array:g_zclass_modelindex, Array:g_zclass_clawmodel, Array:g_zclass_hp, Array:g_zclass_spd, Array:g_zclass_grav, Array:g_zclass_kb, g_zclass_i, Array:g_zclass_new
new Array:g_zclass_deathsnd, Array:g_zclass_deathsnd_start, Array:g_zclass_deathsnd_end, Array:g_zclass_painsnd, Array:g_zclass_painsnd_start, Array:g_zclass_painsnd_end

#define MAX_ARRAY_SOUNDS 20 // Max Array Sounds

// Customization vars
new g_access_flag[MAX_ACCESS_FLAGS], Array:model_zm_special[MAX_SPECIALS_ZOMBIES], Array:model_human[MAX_SPECIALS_HUMANS], Array:g_modelindex_human[MAX_SPECIALS_HUMANS], Array:model_admin_zombie,  Array:model_vip_zombie, Array:model_admin_human, Array:model_vip_human,
Array:g_modelindex_zm_sp[MAX_SPECIALS_ZOMBIES], g_same_models_for_all, Array:g_modelindex_admin_zombie, Array:g_modelindex_vip_zombie, Array:g_modelindex_admin_human, Array:g_modelindex_vip_human,
model_vknife_zm_special[MAX_SPECIALS_ZOMBIES][64], model_v_weapon_human[MAX_SPECIALS_HUMANS][64], model_p_weapon_human[MAX_SPECIALS_HUMANS][64], model_grenade_infect[MAX_WPN_MDL][64], model_grenade_bombardier[MAX_WPN_MDL][64], model_grenade_fire[MAX_WPN_MDL][64], model_grenade_frost[MAX_WPN_MDL][64], model_grenade_flare[MAX_WPN_MDL][64],
model_knife_admin_human[MAX_WPN_MDL][64], model_knife_vip_human[MAX_WPN_MDL][64], model_vknife_admin_zombie[64], model_vknife_vip_zombie[64], 
Array:sound_win_zombies, Array:sound_win_humans, Array:sound_win_no_one, Array:ar_sound[MAX_ARRAY_SOUNDS],  Array:zombie_pain[MAX_SPECIALS_ZOMBIES], g_ambience_rain,
Array:g_additional_items, Array:g_weapon_is_custom[2], Array:g_weapon_realname[2], Array:g_weapon_name[2], g_weapon_i[2], Array:g_weapon_ids[2],
Array:g_extraweapon_names, Array:g_extraweapon_items, Array:g_extraweapon_costs, g_extra_costs2[EXTRA_WEAPONS_STARTID], g_ambience_snow, g_ambience_fog, g_fog_density[10], g_fog_color[12], g_sky_enable,
Array:g_sky_names, Array:lights_thunder, Array:zombie_decals, Array:g_objective_ents, Array:g_escape_maps, Float:g_modelchange_delay, g_set_modelindex_offset, g_handle_models_on_separate_ent, 
Float:kb_weapon_power[31] = { -1.0, ... }, g_force_consistency, g_choosed_zclass[33], g_enable_end_round_sounds,
g_ambience_sounds[MAX_AMBIENCE_SOUNDS], Array:sound_mod[MAX_GAME_MODES], Array:sound_ambience[MAX_AMBIENCE_SOUNDS], Array:sound_ambience_duration[MAX_AMBIENCE_SOUNDS],
enable_trail[MAX_GRENADES], enable_explode[MAX_GRENADES], enable_gib[MAX_GRENADES], sprite_grenade_trail[MAX_GRENADES][64], sprite_grenade_explode[MAX_GRENADES][64], sprite_grenade_gib[MAX_GRENADES][64], 
sprite_grenade_ring[64], sprite_grenade_fire[64], sprite_grenade_smoke[64], sprite_grenade_glass[64], grenade_rgb[MAX_GRENADES][3]

// CVAR pointers
new cvar_lighting, cvar_zombiefov, cvar_removemoney, cvar_thunder, cvar_deathmatch, cvar_customnvg, cvar_nvg_alpha, cvar_hitzones, cvar_flashsize[2], cvar_ammodamage, cvar_ammodamage_quantity, cvar_zombiearmor, cvar_chosse_instantanly,
cvar_flashdrain, cvar_zombiebleeding, cvar_removedoors, cvar_customflash, cvar_randspawn, cvar_ammoinfect, cvar_toggle, cvar_knockbackpower, cvar_freezeduration, cvar_triggered, cvar_flashcharge,
cvar_firegrenades, cvar_frostgrenades, cvar_logcommands, cvar_spawnprotection, cvar_nvgsize, cvar_flareduration, cvar_zclasses, cvar_extraitems, cvar_showactivity, cvar_warmup, cvar_flashdist, cvar_flarecolor, cvar_fireduration, cvar_firedamage,
cvar_flaregrenades, cvar_knockbackducking, cvar_knockbackdamage, cvar_knockbackzvel, cvar_multiratio, cvar_swarmratio, cvar_flaresize[2], cvar_spawndelay, cvar_extraantidote, cvar_extramadness, cvar_extraantidote_ze, cvar_extramadness_ze,
cvar_extraweapons, cvar_extranvision, cvar_zm_nvggive[MAX_SPECIALS_ZOMBIES], cvar_hm_nvggive[MAX_SPECIALS_HUMANS], cvar_spec_nvggive, cvar_preventconsecutive, cvar_botquota, cvar_buycustom, cvar_fireslowdown, cvar_sniperfraggore, cvar_nemfraggore, cvar_humansurvive, cvar_antidote_minzms,
cvar_extrainfbomb, cvar_extrainfbomb_ze, cvar_knockback, cvar_fragsinfect, cvar_ammodamage_zombie, cvar_fragskill, cvar_humanarmor, cvar_zombiesilent, cvar_removedropped, cvar_huddisplay, cvar_allow_buy_no_start,
cvar_plagueratio, cvar_blocksuicide, cvar_knockbackdist,  cvar_respawnonsuicide, cvar_respawnafterlast, cvar_statssave, cvar_adminmodelshuman, cvar_vipmodelshuman,
cvar_adminmodelszombie, cvar_vipmodelszombie, cvar_blockpushables, cvar_respawnworldspawnkill, cvar_madnessduration, cvar_plaguenemnum, cvar_plaguenemhpmulti, cvar_plaguesurvhpmulti,
cvar_survweapon, cvar_plaguesurvnum, cvar_infectionscreenfade, cvar_infectionscreenshake, cvar_infectionsparkle, cvar_infectiontracers, cvar_infectionparticles, cvar_infbomblimit,
cvar_flashshowall, cvar_hudicons, cvar_startammopacks, cvar_random_weapon[2], cvar_buyzonetime, cvar_antidotelimit, cvar_madnesslimit, cvar_madness_use_countdown, g_madness_used[33], 
cvar_adminknifemodelshuman, cvar_vipknifemodelshuman, cvar_adminknifemodelszombie, cvar_vipknifemodelszombie, cvar_keephealthondisconnect, 
cvar_lnjnemhpmulti, cvar_lnjsurvhpmulti,  cvar_lnjratio, cvar_lnjrespsurv, cvar_lnjrespnem , cvar_frozenhit, cvar_aiminfo, cvar_human_unstuck, cvar_bot_buyitem_interval, cvar_bot_maxitem,
cvar_mod_chance[MAX_GAME_MODES], cvar_mod_minplayers[MAX_GAME_MODES], cvar_mod_enable[MAX_GAME_MODES], cvar_mod_allow_respawn[MAX_GAME_MODES], cvar_respawn_limit[MAX_GAME_MODES],
cvar_leap_hm_allow[MAX_SPECIALS_HUMANS], cvar_leap_hm_cooldown[MAX_SPECIALS_HUMANS], cvar_leap_hm_force[MAX_SPECIALS_HUMANS], cvar_leap_hm_height[MAX_SPECIALS_HUMANS],
cvar_hm_basehp[MAX_SPECIALS_HUMANS], cvar_hm_spd[MAX_SPECIALS_HUMANS], cvar_hm_glow[MAX_SPECIALS_HUMANS], cvar_hm_auraradius[MAX_SPECIALS_HUMANS], cvar_hm_aura[MAX_SPECIALS_HUMANS], cvar_hm_painfree[MAX_SPECIALS_HUMANS],
cvar_hm_respawn[MAX_SPECIALS_HUMANS], cvar_hm_health[MAX_SPECIALS_HUMANS], cvar_hm_ignore_frags[MAX_SPECIALS_HUMANS], cvar_hmgravity[MAX_SPECIALS_HUMANS], cvar_hm_ignore_ammo[MAX_SPECIALS_HUMANS], cvar_hm_damage[MAX_SPECIALS_HUMANS], cvar_hm_infammo[MAX_SPECIALS_HUMANS],
cvar_leap_zm_allow[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_cooldown[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_force[MAX_SPECIALS_ZOMBIES], cvar_leap_zm_height[MAX_SPECIALS_ZOMBIES], cvar_zm_ignore_ammo[MAX_SPECIALS_ZOMBIES],
cvar_zm_spd[MAX_SPECIALS_ZOMBIES], cvar_zm_glow[MAX_SPECIALS_ZOMBIES], cvar_zm_aura[MAX_SPECIALS_ZOMBIES], cvar_zm_auraradius, cvar_zm_painfree[MAX_SPECIALS_ZOMBIES], cvar_zm_damage[MAX_SPECIALS_ZOMBIES],
cvar_zm_respawn[MAX_SPECIALS_ZOMBIES],cvar_zm_basehp[MAX_SPECIALS_ZOMBIES], cvar_zm_health[MAX_SPECIALS_ZOMBIES], cvar_zmgravity[MAX_SPECIALS_ZOMBIES], cvar_zmsp_knockback[MAX_SPECIALS_ZOMBIES], cvar_zm_ignore_frags[MAX_SPECIALS_ZOMBIES],
cvar_zm_allow_frost[MAX_SPECIALS_ZOMBIES], cvar_zm_allow_burn[MAX_SPECIALS_ZOMBIES], cvar_block_zm_use_button, cvar_zombieescapefail, cvar_zm_idle_sound
new frostsprite, cvar_dragon_power_distance, cvar_dragon_power_cooldown, cvar_dragon_flyspped,  Float:gLastUseCmd[33]

// CVARS with arrays
new cvar_flashcolor[3], cvar_flashcolor2[3], cvar_hm_red[MAX_SPECIALS_HUMANS], cvar_hm_green[MAX_SPECIALS_HUMANS], cvar_hm_blue[MAX_SPECIALS_HUMANS],
cvar_zm_red[MAX_SPECIALS_ZOMBIES], cvar_zm_green[MAX_SPECIALS_ZOMBIES], cvar_zm_blue[MAX_SPECIALS_ZOMBIES], cvar_flashlight_menu, cvar_nvision_menu[2], cvar_zombie_nvsion_rgb[3]

// Cached stuff for players
new g_isconnected[33], g_isalive[33], g_isbot[33], g_currentweapon[33], g_playername[33][32], Float:g_spd[33], Float:g_custom_leap_cooldown[33], Float:g_zombie_knockback[33], g_zombie_classname[33][32]
#define is_user_valid_connected(%1) (1 <= %1 <= g_maxplayers && g_isconnected[%1])
#define is_user_valid_alive(%1) (1 <= %1 <= g_maxplayers && g_isalive[%1])
#define is_user_valid(%1) (1 <= %1 <= g_maxplayers)

// Cached CVARs
new g_cached_customflash, g_cached_zombiesilent, Float:g_cached_buytime, g_hm_cached_leap[MAX_SPECIALS_HUMANS], Float:g_hm_cached_cooldown[MAX_SPECIALS_HUMANS],
g_zm_cached_leap[MAX_SPECIALS_ZOMBIES], Float:g_zm_cached_cooldown[MAX_SPECIALS_ZOMBIES]

/*================================================================================
 [Natives, Precache and Init]
=================================================================================*/
public plugin_natives() {
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
	register_native("zp_extra_item_textadd", "native_menu_textadd", 1)
	register_native("zp_zombie_class_textadd", "native_menu_textadd", 1)
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
	
	// New Natives (3.2 or High Available)
	register_native("zp_get_special_class_id", "native_get_special_class_id", 1)
	register_native("zp_get_zombie_class_realname", "native_get_zclass_realname")
	
	// New Natives (3.4 or High Available)
	register_native("zp_get_extra_item_count", "native_get_extra_item_count", 1)
	register_native("zp_get_zclass_count", "native_get_zclass_count", 1)
	register_native("zp_get_gamemodes_count", "native_get_gamemodes_count", 1)
	register_native("zp_get_custom_special_count", "native_get_custom_special_count", 1)
	register_native("zp_get_gamemode_id", "native_get_gamemode_id", 1)
	
	// New Natives (3.5 or High Available)
	register_native("zp_is_escape_map", "native_is_escape_map", 1)
	register_native("zp_do_random_spawn", "native_do_random_spawn", 1)

	// New Natives (4.2 or High Available)
	register_native("zp_reload_csdm_respawn", "native_reload_csdm_respawn", 1)
	register_native("zp_set_lighting", "native_set_lighting", 1)
	register_native("zp_reset_lighting", "native_reset_lighting", 1)
	register_native("zp_is_user_stuck", "native_is_user_stuck", 1)
	register_native("zp_register_weapon", "native_register_weapon", 1)
	register_native("zp_weapon_menu_textadd", "native_menu_textadd", 1)
	register_native("zp_get_weapon_realname", "native_get_weapon_realname")
	register_native("zp_get_weapon_name", "native_get_weapon_name")
	register_native("zp_set_weapon_name", "native_set_weapon_name", 1)
	register_native("zp_weapon_is_custom", "native_weapon_is_custom", 1)
	register_native("zp_weapon_count", "native_weapon_count", 1)
	register_native("zp_get_random_player", "native_get_random_player", 1)
	register_native("zp_set_model_param", "native_set_fw_param_string", 1)

	// New Natives (4.3 or High Available)
	register_native("zp_start_game_mode", "native_start_game_mode", 1)
	register_native("zp_set_next_game_mode", "native_set_next_game_mode", 1)
	register_native("zpsp_register_extra_item", "native_register_extra_item3", 1)
	register_native("zp_is_special_class_enable", "native_is_special_class_enable", 1)
	register_native("zp_is_gamemode_enable", "native_is_gamemode_enable", 1)

	// New Natives (4.4 or High Available)
	register_native("zp_set_user_extra_damage", "native_set_user_extra_damage", 1)
	register_native("zpsp_register_gamemode", "native_register_gamemode", 1)
	register_native("zp_get_custom_extra_start", "native_get_custom_extra_start", 1)

}
public plugin_precache() {
	register_plugin(PLUGIN, VERSION, AUTHOR) // Register earlier to show up in plugins list properly after plugin disable/error at loading

	cvar_toggle = register_cvar("zp_on", "1") // To switch plugin on/off
	if(!get_pcvar_num(cvar_toggle)) return; // Plugin disabled?
	g_pluginenabled = true
	
	new i, x, buffer[150]

	// Initialize a few dynamically sized arrays (alright, maybe more than just a few...)
	ZP_TEAM_NAMES = ArrayCreate(32, 1)
	ZP_TEAM_INDEX = ArrayCreate(1, 1)

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
	for(i = 2; i < MAX_GAME_MODES; i++) sound_mod[i] = ArrayCreate(64, 1);
	for(i = 0; i < MAX_ARRAY_SOUNDS; i++) ar_sound[i] = ArrayCreate(64, 1);

	itens_teams_index_human = ArrayCreate(1, 1)
	itens_teams_index_zombie = ArrayCreate(1, 1)
	model_admin_human = ArrayCreate(32, 1)
	model_vip_human = ArrayCreate(32, 1)
	model_admin_zombie = ArrayCreate(32, 1)
	model_vip_zombie = ArrayCreate(32, 1)
	g_modelindex_admin_human = ArrayCreate(1, 1)
	g_modelindex_vip_human = ArrayCreate(1, 1)
	g_modelindex_admin_zombie = ArrayCreate(1, 1)
	g_modelindex_vip_zombie = ArrayCreate(1, 1)
	sound_win_zombies = ArrayCreate(64, 1)
	sound_win_humans = ArrayCreate(64, 1)
	sound_win_no_one = ArrayCreate(64, 1)
	g_additional_items = ArrayCreate(32, 1)
	g_extraweapon_names = ArrayCreate(32, 1)
	g_extraweapon_items = ArrayCreate(32, 1)
	g_extraweapon_costs = ArrayCreate(1, 1)
	g_sky_names = ArrayCreate(32, 1)
	lights_thunder = ArrayCreate(32, 1)
	zombie_decals = ArrayCreate(32, 1)
	g_objective_ents = ArrayCreate(32, 1)
	g_escape_maps = ArrayCreate(32, 1)
	g_gamemode_realname = ArrayCreate(32, 1)
	g_gamemode_name = ArrayCreate(32, 1)
	g_gamemode_flag = ArrayCreate(1, 1)
	g_gamemode_chance = ArrayCreate(1, 1)
	g_gamemode_allow = ArrayCreate(1, 1)
	g_gamemode_dm = ArrayCreate(1, 1)
	g_gamemode_enable = ArrayCreate(1, 1)
	g_gamemode_enable_on_ze_map = ArrayCreate(1, 1)
	g_gamemode_respawn_limit = ArrayCreate(1, 1)
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
	g_zclass_new = ArrayCreate(1, 1)
	g_zclass_deathsnd = ArrayCreate(64, 1)
	g_zclass_deathsnd_start = ArrayCreate(1, 1)
	g_zclass_deathsnd_end = ArrayCreate(1, 1)
	g_zclass_painsnd_end = ArrayCreate(1, 1)
	g_zclass_painsnd_start = ArrayCreate(1, 1)
	g_zclass_painsnd = ArrayCreate(64, 1)
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
	g_hm_special_enable = ArrayCreate(1, 1)
	g_hm_special_modelstart = ArrayCreate(1, 1)
	g_hm_special_modelsend = ArrayCreate(1, 1)
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
	g_zm_special_allow_burn = ArrayCreate(1, 1)
	g_zm_special_allow_frost = ArrayCreate(1, 1)
	g_zm_special_enable = ArrayCreate(1, 1)
	g_zm_special_modelstart = ArrayCreate(1, 1)
	g_zm_special_modelsend = ArrayCreate(1, 1)
	g_zm_special_painsndstart = ArrayCreate(1, 1)
	g_zm_special_painsndsend = ArrayCreate(1, 1)
	g_zm_sp_deathsnd = ArrayCreate(64, 1)
	g_zm_sp_deathsnd_start = ArrayCreate(1, 1)
	g_zm_sp_deathsnd_end = ArrayCreate(1, 1)
	g_zm_specials = ArrayCreate(1, 1)
	g_hm_special_nvision = ArrayCreate(1, 1)
	g_zm_special_nvision = ArrayCreate(1, 1)

	for(i = 0; i < 2; i++) {
		g_weapon_is_custom[i] = ArrayCreate(1, 1)
		g_weapon_realname[i] = ArrayCreate(32, 1)
		g_weapon_name[i] = ArrayCreate(32, 1)
		g_weapon_ids[i] = ArrayCreate(1, 1)
	}

	g_arrays_created = true // Allow registering stuff now
	load_customization_from_files() // Load customization data

	new const team_names[][] = { "ZOMBIE", "HUMAN", "NEMESIS", "SURVIVOR", "SNIPER", "ASSASSIN", "BERSERKER", "PREDATOR", "WESKER",
	"BOMBARDIER", "SPY", "DRAGON" }

	for(i = 0; i < sizeof team_names; i++) {
		ArrayPushString(ZP_TEAM_NAMES, team_names[i])
		ArrayPushCell(ZP_TEAM_INDEX, i)
	}
	ArrayPushCell(itens_teams_index_human, TEAM_HUMAN)
	ArrayPushCell(itens_teams_index_human, TEAM_SURVIVOR)
	ArrayPushCell(itens_teams_index_human, TEAM_SNIPER)
	ArrayPushCell(itens_teams_index_human, TEAM_BERSERKER)
	ArrayPushCell(itens_teams_index_human, TEAM_WESKER)
	ArrayPushCell(itens_teams_index_human, TEAM_SPY)
	ArrayPushCell(itens_teams_index_zombie, TEAM_ZOMBIE)
	ArrayPushCell(itens_teams_index_zombie, TEAM_NEMESIS)
	ArrayPushCell(itens_teams_index_zombie, TEAM_ASSASSIN)
	ArrayPushCell(itens_teams_index_zombie, TEAM_PREDATOR)
	ArrayPushCell(itens_teams_index_zombie, TEAM_BOMBARDIER)
	ArrayPushCell(itens_teams_index_zombie, TEAM_DRAGON)
	
	// Load up the hard coded extra items
	native_register_extra_item2("NightVision", g_extra_costs2[EXTRA_NVISION], GetTeamIndex(TEAM_HUMAN)|GetTeamIndex(TEAM_ZOMBIE))
	native_register_extra_item2("T-Virus Antidote", g_extra_costs2[EXTRA_ANTIDOTE], GetTeamIndex(TEAM_ZOMBIE))
	native_register_extra_item2("Zombie Madness", g_extra_costs2[EXTRA_MADNESS], GetTeamIndex(TEAM_ZOMBIE))
	native_register_extra_item2("Infection Bomb", g_extra_costs2[EXTRA_INFBOMB], GetTeamIndex(TEAM_ZOMBIE))
	
	// Extra weapons
	for(i = 0; i < ArraySize(g_extraweapon_names); i++) {
		ArrayGetString(g_extraweapon_names, i, buffer, charsmax(buffer))
		native_register_extra_item2(buffer, ArrayGetCell(g_extraweapon_costs, i), GetTeamIndex(TEAM_HUMAN))
	}

	// Custom player models
	for(i = 0; i < ArraySize(model_admin_zombie); i++) {
		ArrayGetString(model_admin_zombie, i, buffer, charsmax(buffer))
		ArrayPushCell(g_modelindex_admin_zombie, precache_player_model(buffer))
	}
	for(i = 0; i < ArraySize(model_vip_zombie); i++) {
		ArrayGetString(model_vip_zombie, i, buffer, charsmax(buffer))
		ArrayPushCell(g_modelindex_vip_zombie, precache_player_model(buffer))
	}
	for(i = 0; i < ArraySize(model_admin_human); i++) {
		ArrayGetString(model_admin_human, i, buffer, charsmax(buffer))
		ArrayPushCell(g_modelindex_admin_human, precache_player_model(buffer))
	}
	for(i = 0; i < ArraySize(model_vip_human); i++)	{
		ArrayGetString(model_vip_human, i, buffer, charsmax(buffer))
		ArrayPushCell(g_modelindex_vip_human, precache_player_model(buffer))
	}
	for(x = 1; x < MAX_SPECIALS_ZOMBIES; x++) {
		if(zm_special_enable[x]) {
			for(i = 0; i < ArraySize(model_zm_special[x]); i++) {
				ArrayGetString(model_zm_special[x], i, buffer, charsmax(buffer))
				ArrayPushCell(g_modelindex_zm_sp[x], precache_player_model(buffer))
			}
			engfunc(EngFunc_PrecacheModel, model_vknife_zm_special[x])
			if(x == DRAGON) frostsprite = engfunc(EngFunc_PrecacheModel, "sprites/frost_explode.spr")
		}
	}
	for(x = 0; x < MAX_SPECIALS_HUMANS; x++) {
		if(hm_special_enable[x] || x == 0) {
			for(i = 0; i < ArraySize(model_human[x]); i++) {
				ArrayGetString(model_human[x], i, buffer, charsmax(buffer))
				ArrayPushCell(g_modelindex_human[x], precache_player_model(buffer))
			}
			engfunc(EngFunc_PrecacheModel, model_v_weapon_human[x])
			engfunc(EngFunc_PrecacheModel, model_p_weapon_human[x])
		}
	}
	// Custom weapon models
	for(i = 0; i < MAX_WPN_MDL; i++) {
		engfunc(EngFunc_PrecacheModel, model_grenade_infect[i])
		engfunc(EngFunc_PrecacheModel, model_grenade_bombardier[i])
		engfunc(EngFunc_PrecacheModel, model_grenade_fire[i])
		engfunc(EngFunc_PrecacheModel, model_grenade_frost[i])
		engfunc(EngFunc_PrecacheModel, model_grenade_flare[i])

		if(i < WORLD_MODEL) {
			engfunc(EngFunc_PrecacheModel, model_knife_admin_human[i])
			engfunc(EngFunc_PrecacheModel, model_knife_vip_human[i])
		}
	}
	engfunc(EngFunc_PrecacheModel, model_vknife_admin_zombie)
	engfunc(EngFunc_PrecacheModel, model_vknife_vip_zombie)

	for(i = 0; i < MAX_GRENADES; i++) { // Custom sprites for grenades
		if(enable_trail[i]) g_trailSpr[i] = engfunc(EngFunc_PrecacheModel, sprite_grenade_trail[i]);
		if(i != FLARE && enable_explode[i]) g_ExplodeSpr[i] = engfunc(EngFunc_PrecacheModel, sprite_grenade_explode[i]);
		if(i != FLARE && enable_gib[i]) g_GibSpr[i] = engfunc(EngFunc_PrecacheModel, sprite_grenade_gib[i]);
	}

	g_RingSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_ring)
	g_flameSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_fire)
	g_smokeSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_smoke)
	g_glassSpr = engfunc(EngFunc_PrecacheModel, sprite_grenade_glass)

	if(g_enable_end_round_sounds) { // Custom sounds
		for(i = 0; i < ArraySize(sound_win_zombies); i++) {
			ArrayGetString(sound_win_zombies, i, buffer, charsmax(buffer))
			precache_ambience(buffer)
		}
		for(i = 0; i < ArraySize(sound_win_humans); i++) {
			ArrayGetString(sound_win_humans, i, buffer, charsmax(buffer))
			precache_ambience(buffer)
		}
		for(i = 0; i < ArraySize(sound_win_no_one); i++) {
			ArrayGetString(sound_win_no_one, i, buffer, charsmax(buffer))
			precache_ambience(buffer)
		}
	}
	for(x = 1; x < MAX_SPECIALS_ZOMBIES; x++) {
		if(zm_special_enable[x]) {
			for(i = 0; i < ArraySize(zombie_pain[x]); i++) {
				ArrayGetString(zombie_pain[x], i, buffer, charsmax(buffer))
				engfunc(EngFunc_PrecacheSound, buffer)
			}
		}
	}
	for(x = 2; x < MAX_GAME_MODES; x++) {
		for(i = 0; i < ArraySize(sound_mod[x]); i++) {
			ArrayGetString(sound_mod[x], i, buffer, charsmax(buffer))
			precache_ambience(buffer)
		}
	}
	for(x = 0; x < MAX_ARRAY_SOUNDS; x++) {
		for(i = 0; i < ArraySize(ar_sound[x]); i++) {
			ArrayGetString(ar_sound[x], i, buffer, charsmax(buffer))
			engfunc(EngFunc_PrecacheSound, buffer)
		}
	}
	for(x = 0; x < MAX_AMBIENCE_SOUNDS; x++) {
		if(g_ambience_sounds[x]) {
			for(i = 0; i < ArraySize(sound_ambience[x]); i++) {
				ArrayGetString(sound_ambience[x], i, buffer, charsmax(buffer))
				precache_ambience(buffer)
			}
		}
	}
	for(i = 0; i < sizeof cs_sounds; i++) engfunc(EngFunc_PrecacheSound, cs_sounds[i]) // CS sounds (just in case)

	new ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "hostage_entity"))
	if(pev_valid(ent)) { // Fake Hostage (to force round ending)
		engfunc(EngFunc_SetOrigin, ent, Float:{8192.0,8192.0,8192.0})
		dllfunc(DLLFunc_Spawn, ent)
	}
	
	if(g_ambience_fog) { // Weather/ambience effects
		ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_fog"))
		if(pev_valid(ent)) {
			fm_set_kvd(ent, "density", g_fog_density, "env_fog")
			fm_set_kvd(ent, "rendercolor", g_fog_color, "env_fog")
		}
	}
	if(g_ambience_rain) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_rain"))
	if(g_ambience_snow) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "env_snow"))
	
	// Custom buyzone for all players
	g_buyzone_ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "func_buyzone"))
	if(pev_valid(g_buyzone_ent)) {
		dllfunc(DLLFunc_Spawn, g_buyzone_ent)
		set_pev(g_buyzone_ent, pev_solid, SOLID_NOT)
	}

	g_fwSpawn = register_forward(FM_Spawn, "fw_Spawn") // Prevent some entities from spawning
	g_fwPrecacheSound = register_forward(FM_PrecacheSound, "fw_PrecacheSound") // Prevent hostage sounds from being precached
}
public plugin_init() {
	
	if(!g_pluginenabled) return; // Plugin disabled?	
	if(!g_zclass_i) set_fail_state("No zombie classes loaded!") // No zombie classes?
	
	// Print the number of registered Game Modes (if any)
	if(g_gamemodes_i > MAX_GAME_MODES) server_print("[ZP] Total Registered Custom Game Modes: %d", g_gamemodes_i - MAX_GAME_MODES)
	if(g_hm_specials_i > MAX_SPECIALS_HUMANS) server_print("[ZP] Total Registered Custom Special Humans: %d", g_hm_specials_i - MAX_SPECIALS_HUMANS)
	if(g_zm_specials_i > MAX_SPECIALS_ZOMBIES) server_print("[ZP] Total Registered Custom Special Zombies: %d", g_zm_specials_i - MAX_SPECIALS_ZOMBIES)
	
	server_print("[ZP] Total Registered Zombie Classes: %d", g_zclass_i) // Print the number of registered Zombie Classes
	server_print("[ZP] Total Registered Extra Items: %d", g_extraitem_i) // Print the number of registered Extra Items

	new Float:game_roundtime
	if(g_escape_map) {
		game_roundtime = 15.0
		if(!amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Main Configs", "ZOMBIE ESCAPE ROUNDTIME", game_roundtime))
			amx_save_setting_float(ZP_ZOMBIECLASSES_FILE, "Main Configs", "ZOMBIE ESCAPE ROUNDTIME", game_roundtime) // Backwards compatibility		
	}
	else {
		game_roundtime = 5.0
		if(!amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Main Configs", "ZOMBIE PLAGUE ROUNDTIME", game_roundtime))
			amx_save_setting_float(ZP_ZOMBIECLASSES_FILE, "Main Configs", "ZOMBIE PLAGUE ROUNDTIME", game_roundtime) // Backwards compatibility		
	}
	set_cvar_float("mp_roundtime", game_roundtime) // Change Roundtime
	server_print("[ZP] Game Roundtime: %0.2f", game_roundtime)

	register_dictionary("zombie_plague_special.txt") // Language files
	
	// Events
	register_event("HLTV", "event_round_start", "a", "1=0", "2=0")
	register_event("StatusValue", "event_show_status", "be", "1=2", "2!0")
	register_event("StatusValue", "event_hide_status", "be", "1=1", "2=0")
	register_logevent("logevent_round_start",2, "1=Round_Start")
	register_logevent("logevent_round_end", 2, "1=Round_End")
	register_event("AmmoX", "event_ammo_x", "be")

	for(new i = 0; i < MAX_AMBIENCE_SOUNDS; i++) if(g_ambience_sounds[i]) register_event("30", "event_intermission", "a")
	
	// HAM Forwards
	RegisterHam(Ham_Spawn, "player", "fw_PlayerSpawn_Post", 1)
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled")
	RegisterHam(Ham_Killed, "player", "fw_PlayerKilled_Post", 1)
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage")
	RegisterHam(Ham_TakeDamage, "player", "fw_TakeDamage_Post", 1)
	RegisterHam(Ham_TraceAttack, "player", "fw_TraceAttack")
	RegisterHam(Ham_Player_ResetMaxSpeed, "player", "fw_ResetMaxSpeed_Post", 1)
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary")
	RegisterHam(Ham_Use, "func_tank", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankmortar", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tankrocket", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_tanklaser", "fw_UseStationary_Post", 1)
	RegisterHam(Ham_Use, "func_pushable", "fw_UsePushable")
	RegisterHam(Ham_Use, "func_button", "fw_UseButton")
	RegisterHam(Ham_Touch, "weaponbox", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "armoury_entity", "fw_TouchWeapon")
	RegisterHam(Ham_Touch, "weapon_shield", "fw_TouchWeapon")
	RegisterHam(Ham_AddPlayerItem, "player", "fw_AddPlayerItem")
	for(new i = 1; i < sizeof WEAPONENTNAMES; i++)
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
	register_menu("Buy Menu", KEYSMENU, "menu_buy")
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
	cvar_buyzonetime = register_cvar("zp_buyzone_time", "0.0")
	cvar_random_weapon[0] = register_cvar("zp_random_primary", "0")
	cvar_random_weapon[1] = register_cvar("zp_random_secondary", "0")
	cvar_adminmodelshuman = register_cvar("zp_admin_models_human", "1")
	cvar_adminknifemodelshuman = register_cvar("zp_admin_knife_models_human", "0")
	cvar_vipmodelshuman = register_cvar("zp_vip_models_human", "1")
	cvar_vipknifemodelshuman = register_cvar("zp_vip_knife_models_human", "1")
	cvar_adminmodelszombie = register_cvar("zp_admin_models_zombie", "1")
	cvar_vipmodelszombie = register_cvar("zp_vip_models_zombie", "1")
	cvar_adminknifemodelszombie = register_cvar("zp_admin_knife_models_zombie", "0")
	cvar_vipknifemodelszombie = register_cvar("zp_vip_knife_models_zombie", "0")
	cvar_zclasses = register_cvar("zp_zombie_classes", "1")
	cvar_statssave = register_cvar("zp_stats_save", "1")
	cvar_startammopacks = register_cvar("zp_starting_ammo_packs", "5")
	cvar_preventconsecutive = register_cvar("zp_prevent_consecutive_modes", "1")
	cvar_keephealthondisconnect = register_cvar("zp_keep_health_on_disconnect", "1")
	cvar_humansurvive = register_cvar("zp_human_survive", "1")
	cvar_zombieescapefail = register_cvar("zp_zombie_escape_fail", "1")
	cvar_aiminfo = register_cvar("zp_aim_info", "1")
	cvar_human_unstuck = register_cvar("zp_allow_human_unstuck", "1")
	cvar_bot_maxitem = register_cvar("zp_bot_max_extra_for_round", "5")
	cvar_bot_buyitem_interval = register_cvar("zp_bot_buy_extra_interval", "20.0")
	cvar_huddisplay = register_cvar("zp_hud_display", "1")
	cvar_allow_buy_no_start = register_cvar("zp_allow_buy_extra_before_start", "1")
	cvar_chosse_instantanly = register_cvar("zp_choose_zclass_instantanly", "1")
	cvar_ammodamage_quantity = register_cvar("zp_ammopack_damage", "1")
	
	// CVARS - Deathmatch
	cvar_deathmatch = register_cvar("zp_deathmatch", "0")
	cvar_spawndelay = register_cvar("zp_spawn_delay", "5")
	cvar_spawnprotection = register_cvar("zp_spawn_protection", "5")
	cvar_respawnonsuicide = register_cvar("zp_respawn_on_suicide", "0")
	cvar_respawnafterlast = register_cvar("zp_respawn_after_last_human", "1")
	cvar_zm_respawn[0] = register_cvar("zp_respawn_zombies", "1")
	cvar_hm_respawn[0] = register_cvar("zp_respawn_humans", "1")
	cvar_zm_respawn[NEMESIS] = register_cvar("zp_respawn_nemesis", "1")
	cvar_hm_respawn[SURVIVOR] = register_cvar("zp_respawn_survivors", "1")
	cvar_hm_respawn[SNIPER] = register_cvar("zp_respawn_snipers", "1")
	cvar_zm_respawn[ASSASSIN] = register_cvar("zp_respawn_assassins", "1")
	cvar_zm_respawn[PREDATOR] = register_cvar("zp_respawn_predators", "1")
	cvar_zm_respawn[BOMBARDIER] = register_cvar("zp_respawn_bombardiers", "1")
	cvar_zm_respawn[DRAGON] = register_cvar("zp_respawn_dragons", "1")
	cvar_hm_respawn[BERSERKER] = register_cvar("zp_respawn_berserkers", "1")
	cvar_hm_respawn[WESKER] = register_cvar("zp_respawn_weskers", "1")
	cvar_hm_respawn[SPY] = register_cvar("zp_respawn_spys", "1")
	cvar_lnjrespsurv = register_cvar("zp_lnj_respawn_surv", "0")
	cvar_lnjrespnem = register_cvar("zp_lnj_respawn_nem", "0")

	// Game mode enable Respawns
	cvar_mod_allow_respawn[MODE_INFECTION] = register_cvar("zp_infection_allow_respawn", "1")
	cvar_mod_allow_respawn[MODE_NEMESIS] = register_cvar("zp_nem_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SURVIVOR] = register_cvar("zp_surv_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SWARM] = register_cvar("zp_swarm_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_PLAGUE] = register_cvar("zp_plague_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SNIPER] = register_cvar("zp_sniper_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_ASSASSIN] = register_cvar("zp_assassin_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_PREDATOR] = register_cvar("zp_predator_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_BOMBARDIER] = register_cvar("zp_bombardier_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_DRAGON] = register_cvar("zp_dragon_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_BERSERKER] = register_cvar("zp_berserker_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_WESKER] = register_cvar("zp_wesker_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_SPY] = register_cvar("zp_spy_allow_respawn", "0")
	cvar_mod_allow_respawn[MODE_LNJ] = register_cvar("zp_lnj_allow_respawn", "0")

	// Game mode respawn limit (0 - Unlimited)
	cvar_respawn_limit[MODE_INFECTION] = register_cvar("zp_infection_respawn_limit", "0")
	cvar_respawn_limit[MODE_NEMESIS] = register_cvar("zp_nem_respawn_limit", "0")
	cvar_respawn_limit[MODE_SURVIVOR] = register_cvar("zp_surv_respawn_limit", "0")
	cvar_respawn_limit[MODE_SWARM] = register_cvar("zp_swarm_respawn_limit", "0")
	cvar_respawn_limit[MODE_PLAGUE] = register_cvar("zp_plague_respawn_limit", "0")
	cvar_respawn_limit[MODE_SNIPER] = register_cvar("zp_sniper_respawn_limit", "0")
	cvar_respawn_limit[MODE_ASSASSIN] = register_cvar("zp_assassin_respawn_limit", "0")
	cvar_respawn_limit[MODE_PREDATOR] = register_cvar("zp_predator_respawn_limit", "0")
	cvar_respawn_limit[MODE_BOMBARDIER] = register_cvar("zp_bombardier_respawn_limit", "0")
	cvar_respawn_limit[MODE_DRAGON] = register_cvar("zp_dragon_respawn_limit", "0")
	cvar_respawn_limit[MODE_BERSERKER] = register_cvar("zp_berserker_respawn_limit", "0")
	cvar_respawn_limit[MODE_WESKER] = register_cvar("zp_wesker_respawn_limit", "0")
	cvar_respawn_limit[MODE_SPY] = register_cvar("zp_spy_respawn_limit", "0")
	cvar_respawn_limit[MODE_LNJ] = register_cvar("zp_lnj_respawn_limit", "0")
	
	// CVARS - Extra Items
	cvar_extraitems = register_cvar("zp_extra_items", "1")
	cvar_extraweapons = register_cvar("zp_extra_weapons", "1")
	cvar_extranvision = register_cvar("zp_extra_nvision", "1")
	cvar_extraantidote = register_cvar("zp_extra_antidote", "1")
	cvar_extraantidote_ze = register_cvar("zp_extra_antidote_allow_escape", "0")
	cvar_antidotelimit = register_cvar("zp_extra_antidote_limit", "999")
	cvar_extramadness = register_cvar("zp_extra_madness", "1")
	cvar_extramadness_ze = register_cvar("zp_extra_madness_allow_escape", "0")
	cvar_madnesslimit = register_cvar("zp_extra_madness_limit", "999")
	cvar_madnessduration = register_cvar("zp_extra_madness_dur", "5.0")
	cvar_extrainfbomb = register_cvar("zp_extra_infbomb", "1")
	cvar_extrainfbomb_ze = register_cvar("zp_extra_infbomb_allow_escape", "0")
	cvar_infbomblimit = register_cvar("zp_extra_infbomb_limit", "999")
	cvar_antidote_minzms = register_cvar("zp_extra_antidote_min_zms", "5")
	cvar_madness_use_countdown = register_cvar("zp_extra_madness_use_delay", "5.0")

	// CVARS - Flashlight and Nightvision
	cvar_zm_nvggive[0] = register_cvar("zp_nvg_give_zombies", "1")
	cvar_zm_nvggive[NEMESIS] = register_cvar("zp_nvg_give_nemesis", "1")
	cvar_zm_nvggive[ASSASSIN] = register_cvar("zp_nvg_give_assassin", "1")
	cvar_zm_nvggive[PREDATOR] = register_cvar("zp_nvg_give_predator", "1")
	cvar_zm_nvggive[BOMBARDIER] = register_cvar("zp_nvg_give_bombardier", "1")
	cvar_zm_nvggive[DRAGON] = register_cvar("zp_nvg_give_dragon", "1")
	cvar_hm_nvggive[0] = register_cvar("zp_nvg_give_humans", "0")
	cvar_hm_nvggive[SURVIVOR] = register_cvar("zp_nvg_give_survivor", "1")
	cvar_hm_nvggive[SNIPER] = register_cvar("zp_nvg_give_sniper", "1")
	cvar_hm_nvggive[BERSERKER] = register_cvar("zp_nvg_give_berserker", "1")
	cvar_hm_nvggive[WESKER] = register_cvar("zp_nvg_give_wesker", "1")
	cvar_hm_nvggive[SPY] = register_cvar("zp_nvg_give_spy", "1")
	cvar_spec_nvggive = register_cvar("zp_nvg_spectator", "1")
	cvar_customnvg = register_cvar("zp_nvg_custom", "1")
	cvar_nvg_alpha = register_cvar("zp_nvg_fade_alpha", "70")
	cvar_nvgsize = register_cvar("zp_nvg_size", "80")
	cvar_zm_red[0] = register_cvar("zp_zombie_madness_color_R", "255")
	cvar_zm_green[0] = register_cvar("zp_zombie_madness_color_G", "0")
	cvar_zm_blue[0] = register_cvar("zp_zombie_madness_color_B", "0")
	cvar_zombie_nvsion_rgb[0] = register_cvar("zp_nvg_color_R", "255")
	cvar_zombie_nvsion_rgb[1] = register_cvar("zp_nvg_color_G", "255")
	cvar_zombie_nvsion_rgb[2] = register_cvar("zp_nvg_color_B", "0")
	cvar_nvision_menu[0] = register_cvar("zp_nvg_hm_personal_menu", "1")
	cvar_nvision_menu[1] = register_cvar("zp_nvg_zm_personal_menu", "1")
	cvar_flashlight_menu = register_cvar("zp_flashlight_personal_menu", "1")
	cvar_hm_red[0] = register_cvar("zp_nvg_hum_color_R", "100")
	cvar_hm_green[0] = register_cvar("zp_nvg_hum_color_G", "100")
	cvar_hm_blue[0] = register_cvar("zp_nvg_hum_color_B", "100")
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
	cvar_ammodamage_zombie = register_cvar("zp_zombie_damage_reward", "0")
	cvar_fragsinfect = register_cvar("zp_zombie_frags_for_infect", "1")
	cvar_block_zm_use_button = register_cvar("zp_zombie_blockuse_button", "1")
	cvar_zm_idle_sound = register_cvar("zp_zombie_idle_sound", "1")
	
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
	cvar_mod_minplayers[MODE_NEMESIS] = register_cvar("zp_nem_min_players", "2")
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
	cvar_zm_allow_frost[NEMESIS] = register_cvar("zp_nem_allow_frost", "0")
	cvar_zm_allow_burn[NEMESIS] = register_cvar("zp_nem_allow_burn", "0")
	
	// CVARS - Survivor
	cvar_mod_enable[MODE_SURVIVOR] = register_cvar("zp_surv_enabled", "1")
	cvar_mod_chance[MODE_SURVIVOR] = register_cvar("zp_surv_chance", "20")
	cvar_mod_minplayers[MODE_SURVIVOR] = register_cvar("zp_surv_min_players", "2")
	cvar_hm_health[SURVIVOR] = register_cvar("zp_surv_health", "0")
	cvar_hm_basehp[SURVIVOR] = register_cvar("zp_surv_base_health", "0")
	cvar_hm_spd[SURVIVOR] = register_cvar("zp_surv_speed", "230")
	cvar_hmgravity[SURVIVOR] = register_cvar("zp_surv_gravity", "1.25")
	cvar_hm_glow[SURVIVOR] = register_cvar("zp_surv_glow", "1")
	cvar_hm_aura[SURVIVOR] = register_cvar("zp_surv_aura", "1")
	cvar_hm_damage[SURVIVOR] = register_cvar("zp_surv_damage_multi", "3.0")
	cvar_hm_red[SURVIVOR] = register_cvar("zp_surv_color_R", "0")
	cvar_hm_green[SURVIVOR] = register_cvar("zp_surv_color_G", "250")
	cvar_hm_blue[SURVIVOR] = register_cvar("zp_surv_color_B", "250")
	cvar_hm_painfree[SURVIVOR] = register_cvar("zp_surv_painfree", "1")
	cvar_hm_ignore_frags[SURVIVOR] = register_cvar("zp_surv_ignore_frags", "1")
	cvar_hm_ignore_ammo[SURVIVOR] = register_cvar("zp_surv_ignore_rewards", "1")
	cvar_survweapon = register_cvar("zp_surv_weapon", "weapon_m249")
	cvar_hm_infammo[SURVIVOR] = register_cvar("zp_surv_unlimited_ammo", "2")
	cvar_hm_auraradius[SURVIVOR] =  register_cvar("zp_surv_aura_size", "35")

	// CVARS - Swarm Mode
	cvar_mod_enable[MODE_SWARM] = register_cvar("zp_swarm_enabled", "1")
	cvar_mod_chance[MODE_SWARM] = register_cvar("zp_swarm_chance", "20")
	cvar_mod_minplayers[MODE_SWARM] = register_cvar("zp_swarm_min_players", "2")
	cvar_swarmratio = register_cvar("zp_swarm_ratio", "0.15")
	
	// CVARS - Multi Infection
	cvar_mod_enable[MODE_MULTI] = register_cvar("zp_multi_enabled", "1")
	cvar_mod_chance[MODE_MULTI] = register_cvar("zp_multi_chance", "20")
	cvar_mod_minplayers[MODE_MULTI] = register_cvar("zp_multi_min_players", "2")
	cvar_multiratio = register_cvar("zp_multi_ratio", "0.15")
	
	// CVARS - Plague Mode
	cvar_mod_enable[MODE_PLAGUE] = register_cvar("zp_plague_enabled", "1")
	cvar_mod_chance[MODE_PLAGUE] = register_cvar("zp_plague_chance", "30")
	cvar_mod_minplayers[MODE_PLAGUE] = register_cvar("zp_plague_min_players", "2")
	cvar_plagueratio = register_cvar("zp_plague_ratio", "0.5")
	cvar_plaguenemnum = register_cvar("zp_plague_nem_number", "1")
	cvar_plaguenemhpmulti = register_cvar("zp_plague_nem_hp_multi", "0.5")
	cvar_plaguesurvnum = register_cvar("zp_plague_surv_number", "1")
	cvar_plaguesurvhpmulti = register_cvar("zp_plague_surv_hp_multi", "0.5")
	
	// CVARS - Sniper
	cvar_mod_enable[MODE_SNIPER] = register_cvar("zp_sniper_enabled", "1")
	cvar_mod_chance[MODE_SNIPER] = register_cvar("zp_sniper_chance", "20")
	cvar_mod_minplayers[MODE_SNIPER] = register_cvar("zp_sniper_min_players", "2")
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
	cvar_hm_red[SNIPER] = register_cvar("zp_sniper_color_R", "200")
	cvar_hm_green[SNIPER] = register_cvar("zp_sniper_color_G", "200")
	cvar_hm_blue[SNIPER] = register_cvar("zp_sniper_color_B", "0")
	
	// CVARS - Assassin
	cvar_mod_enable[MODE_ASSASSIN] = register_cvar("zp_assassin_enabled", "1")
	cvar_mod_chance[MODE_ASSASSIN] = register_cvar("zp_assassin_chance", "20")
	cvar_mod_minplayers[MODE_ASSASSIN] = register_cvar("zp_assassin_min_players", "2")
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
	cvar_zm_allow_frost[ASSASSIN] = register_cvar("zp_assassin_allow_frost", "0")
	cvar_zm_allow_burn[ASSASSIN] = register_cvar("zp_assassin_allow_burn", "0")
	
	// CVARS - Predator
	cvar_mod_enable[MODE_PREDATOR] = register_cvar("zp_predator_enabled", "1")
	cvar_mod_chance[MODE_PREDATOR] = register_cvar("zp_predator_chance", "20")
	cvar_mod_minplayers[MODE_PREDATOR] = register_cvar("zp_predator_min_players", "2")
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
	cvar_zm_allow_frost[PREDATOR] = register_cvar("zp_predator_allow_frost", "0")
	cvar_zm_allow_burn[PREDATOR] = register_cvar("zp_predator_allow_burn", "0")
	
	// CVARS - Bombardier
	cvar_mod_enable[MODE_BOMBARDIER] = register_cvar("zp_bombardier_enabled", "1")
	cvar_mod_chance[MODE_BOMBARDIER] = register_cvar("zp_bombardier_chance", "20")
	cvar_mod_minplayers[MODE_BOMBARDIER] = register_cvar("zp_bombardier_min_players", "2")
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
	cvar_zm_allow_frost[BOMBARDIER] = register_cvar("zp_bombardier_allow_frost", "0")
	cvar_zm_allow_burn[BOMBARDIER] = register_cvar("zp_bombardier_allow_burn", "0")
	
	// CVARS - Dragon
	cvar_mod_enable[MODE_DRAGON] = register_cvar("zp_dragon_enabled", "1")
	cvar_mod_chance[MODE_DRAGON] = register_cvar("zp_dragon_chance", "20")
	cvar_mod_minplayers[MODE_DRAGON] = register_cvar("zp_dragon_min_players", "2")
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
	cvar_zm_allow_frost[DRAGON] = register_cvar("zp_dragon_allow_frost", "0")
	cvar_zm_allow_burn[DRAGON] = register_cvar("zp_dragon_allow_burn", "0")

	// CVARS - Berserker
	cvar_mod_enable[MODE_BERSERKER] = register_cvar("zp_berserker_enabled", "1")
	cvar_mod_chance[MODE_BERSERKER] = register_cvar("zp_berserker_chance", "20")
	cvar_mod_minplayers[MODE_BERSERKER] = register_cvar("zp_berserker_min_players", "2")
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
	cvar_hm_red[BERSERKER] = register_cvar("zp_berserker_color_R", "200")
	cvar_hm_green[BERSERKER] = register_cvar("zp_berserker_color_G", "200")
	cvar_hm_blue[BERSERKER] = register_cvar("zp_berserker_color_B", "0")	
	
	// CVARS - Wesker
	cvar_mod_enable[MODE_WESKER] = register_cvar("zp_wesker_enabled", "1")
	cvar_mod_chance[MODE_WESKER] = register_cvar("zp_wesker_chance", "20")
	cvar_mod_minplayers[MODE_WESKER] = register_cvar("zp_wesker_min_players", "2")
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
	cvar_hm_red[WESKER] = register_cvar("zp_wesker_color_R", "200")
	cvar_hm_green[WESKER] = register_cvar("zp_wesker_color_G", "200")
	cvar_hm_blue[WESKER] = register_cvar("zp_wesker_color_B", "0")	
	
	// CVARS - Spy
	cvar_mod_enable[MODE_SPY] = register_cvar("zp_spy_enabled", "1")
	cvar_mod_chance[MODE_SPY] = register_cvar("zp_spy_chance", "20")
	cvar_mod_minplayers[MODE_SPY] = register_cvar("zp_spy_min_players", "2")
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
	cvar_hm_red[SPY] = register_cvar("zp_spy_color_R", "0")
	cvar_hm_green[SPY] = register_cvar("zp_spy_color_G", "0")
	cvar_hm_blue[SPY] = register_cvar("zp_spy_color_B", "250")

	// CVARS - LNJ Mode
	cvar_mod_enable[MODE_LNJ] = register_cvar("zp_lnj_enabled", "1")
	cvar_mod_chance[MODE_LNJ] = register_cvar("zp_lnj_chance", "30")
	cvar_mod_minplayers[MODE_LNJ] = register_cvar("zp_lnj_min_players", "2")
	cvar_lnjnemhpmulti = register_cvar("zp_lnj_nem_hp_multi", "2.0")
	cvar_lnjsurvhpmulti = register_cvar("zp_lnj_surv_hp_multi", "4.0")
	cvar_lnjratio = register_cvar("zp_lnj_ratio", "0.5")
	
	// CVARS - Others
	cvar_logcommands = register_cvar("zp_logcommands", "1")
	cvar_showactivity = get_cvar_pointer("amx_show_activity")
	cvar_botquota = get_cvar_pointer("bot_quota")
	register_cvar("zombie_plague_special", VERSION, FCVAR_SERVER|FCVAR_SPONLY)
	set_cvar_string("zombie_plague_special", VERSION)
	
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
	
	// New Forwards (4.0 or Higher)
	g_forwards[RESET_RENDERING_PRE] = CreateMultiForward("zp_user_rendering_reset_pre", ET_CONTINUE, FP_CELL)
	g_forwards[RESET_RENDERING_POST] = CreateMultiForward("zp_user_rendering_reset_post", ET_IGNORE, FP_CELL)
	g_forwards[MODEL_CHANGE_PRE] = CreateMultiForward("zp_user_model_change_pre", ET_CONTINUE, FP_CELL, FP_STRING)
	g_forwards[MODEL_CHANGE_POST] = CreateMultiForward("zp_user_model_change_post", ET_IGNORE, FP_CELL, FP_STRING)
	g_forwards[HM_SP_CHOSSED_PRE] = CreateMultiForward("zp_human_special_choosed_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[HM_SP_CHOSSED_POST] = CreateMultiForward("zp_human_special_choosed_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[ZM_SP_CHOSSED_PRE] = CreateMultiForward("zp_zombie_special_choosed_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[ZM_SP_CHOSSED_POST] = CreateMultiForward("zp_zombie_special_choosed_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[GM_SELECTED_PRE] = CreateMultiForward("zp_game_mode_selected_pre", ET_CONTINUE, FP_CELL, FP_CELL)

	// New Forwards (4.2 or Higher)
	g_forwards[INFECTED_BY_BOMB_PRE] = CreateMultiForward("zp_infected_by_bomb_pre", ET_CONTINUE, FP_CELL, FP_CELL)
	g_forwards[INFECTED_BY_BOMB_POST] = CreateMultiForward("zp_infected_by_bomb_post", ET_IGNORE, FP_CELL, FP_CELL)
	g_forwards[UNSTUCK_PRE] = CreateMultiForward("zp_user_unstuck_pre", ET_CONTINUE, FP_CELL)
	g_forwards[UNSTUCK_POST] = CreateMultiForward("zp_user_unstuck_post", ET_IGNORE, FP_CELL)
	g_forwards[WEAPON_SELECTED_PRE] = CreateMultiForward("zp_weapon_selected_pre", ET_CONTINUE, FP_CELL, FP_CELL, FP_CELL)
	g_forwards[WEAPON_SELECTED_POST] = CreateMultiForward("zp_weapon_selected_post", ET_IGNORE, FP_CELL, FP_CELL, FP_CELL)

	load_spawns() // Collect random spawn points
	
	if(g_sky_enable) { // Set a random skybox?
		static sky[32]; ArrayGetString(g_sky_names, random_num(0, ArraySize(g_sky_names) - 1), sky, charsmax(sky))
		set_cvar_string("sv_skyname", sky)
	}
	
	// Disable sky lighting so it doesn't mess with our custom lighting
	set_cvar_num("sv_skycolor_r", 0)
	set_cvar_num("sv_skycolor_g", 0)
	set_cvar_num("sv_skycolor_b", 0)
	
	// Create the HUD Sync Objects
	for(new i = 0; i <= 2; i++) g_MsgSync[i] = CreateHudSyncObj()

	g_maxplayers = get_maxplayers() // Get Max Players

	db_slot_i = g_maxplayers+1 // Reserved saving slots starts on maxplayers+1
	
	// Check if it's a CZ server
	static mymod[6]; get_modname(mymod, charsmax(mymod))
	if(equal(mymod, "czero")) g_czero = 1
}
public plugin_cfg() {
	if(!g_pluginenabled) return; // Plugin disabled?
	
	static cfgdir[32]; get_configsdir(cfgdir, charsmax(cfgdir)) // Get configs dir
	server_cmd("exec %s/zombie_plague_special.cfg", cfgdir) // Execute config file (zombie_plague_special.cfg)

	g_arrays_created = false // Prevent any more stuff from registering
	save_customization() // Save customization data

	set_task(5.0, "lighting_effects", _, _, _, "b") // Lighting task
	set_task(0.5, "cache_cvars")
	set_task(0.5, "event_round_start") // Cache CVARs after configs are loaded / call roundstart manually
	set_task(0.5, "logevent_round_start")
}

/*================================================================================
 [Main Events]
=================================================================================*/
public event_round_start() { // Event Round Start
	set_task(0.1, "remove_stuff") // Remove doors/lights?
	
	// New round starting
	g_newround = true
	g_endround = false
	g_modestarted = false
	g_allowinfection = false
	g_currentmode = MODE_NONE // No present mode in progress ?

	g_infbombcounter = 0
	g_antidotecounter = 0 // Reset bought infection bombs counter
	g_madnesscounter = 0
	
	g_freezetime = true // Freezetime begins
	custom_lighting[0] = 0
	g_custom_light = false
	lighting_effects()

	// Reset Respawn Limit
	for(new i = 1; i <= g_maxplayers; i++)
		g_respawn_count[i] = 0

	remove_task(TASK_WELCOMEMSG)
	set_task(2.0, "welcome_msg", TASK_WELCOMEMSG) // Show welcome message and T-Virus notice

	remove_task(TASK_MAKEZOMBIE) // Set a new "Make Zombie Task"
	set_task(2.0 + get_pcvar_float(cvar_warmup), "make_zombie_task", TASK_MAKEZOMBIE)
}
public logevent_round_start() g_freezetime = false // Freezetime ends

public logevent_round_end() { // Log Event Round End
	// Prevent this from getting called twice when restarting (bugfix)
	static Float:lastendtime, Float:current_time
	current_time = get_gametime()
	if(current_time - lastendtime < 0.5) return;
	lastendtime = current_time
	
	if(get_pcvar_num(cvar_chosse_instantanly)) {
		for(new i = 1; i <= g_maxplayers; i++) 
			g_choosed_zclass[i] = false
	}
	if(get_pcvar_num(cvar_statssave)) { // Temporarily save player stats?
		static id, team
		for(id = 1; id <= g_maxplayers; id++) {
			if(!g_isconnected[id]) continue;

			team = fm_cs_get_user_team(id)

			if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED) continue; // Not playing

			save_stats(id)
		}
	}

	g_endround = true // Round ended
	g_allowinfection = false // No infection allowed
	g_currentmode = MODE_NONE // No current mode is bieng played
	
	remove_task(TASK_WELCOMEMSG)
	remove_task(TASK_MAKEZOMBIE) // Stop old tasks (if any)
	remove_task(TASK_AMBIENCESOUNDS)
	ambience_sound_stop()
	
	// Show HUD notice, play win sound, update team scores...
	static sound[64]
	if(!fnGetZombies()) { // Human team wins
		set_hudmessage(0, 0, 200, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_HUMAN")

		if(g_enable_end_round_sounds) { // Play win sound and increase score
			ArrayGetString(sound_win_humans, random_num(0, ArraySize(sound_win_humans) - 1), sound, charsmax(sound))
			PlaySound(sound)
		}
		if(!g_gamecommencing) g_scorehumans++

		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, GetTeamIndex(TEAM_HUMAN)); // Round end forward
	}
	else if(!fnGetHumans()) { // Zombie team wins
		set_hudmessage(200, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_ZOMBIE")

		if(g_enable_end_round_sounds) { // Play win sound and increase score
			ArrayGetString(sound_win_zombies, random_num(0, ArraySize(sound_win_zombies) - 1), sound, charsmax(sound))
			PlaySound(sound)
		}
		if(!g_gamecommencing) g_scorezombies++

		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, GetTeamIndex(TEAM_ZOMBIE)); // Round end forward
	}
	else if(get_pcvar_num(cvar_humansurvive) && !g_escape_map) { // Humans survived the plague
		set_hudmessage(0, 200, 100, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_HUMAN_SURVIVE")

		if(g_enable_end_round_sounds) { // Play win sound and increase score
			ArrayGetString(sound_win_humans, random_num(0, ArraySize(sound_win_humans) - 1), sound, charsmax(sound))
			PlaySound(sound)
		}
		if(!g_gamecommencing) g_scorehumans++

		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, GetTeamIndex(TEAM_HUMAN)); // Round end forward (will remain same)
	}
	else if(get_pcvar_num(cvar_zombieescapefail) && g_escape_map) { // Zombie team wins if human not escape before time ends
		set_hudmessage(200, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_ZOMBIE_ESCAPE_FAIL")

		if(g_enable_end_round_sounds) { // Play win sound and increase score
			ArrayGetString(sound_win_zombies, random_num(0, ArraySize(sound_win_zombies) - 1), sound, charsmax(sound))
			PlaySound(sound)
		}
		if(!g_gamecommencing) g_scorezombies++

		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, GetTeamIndex(TEAM_ZOMBIE)); // Round end forward
	}
	else { // No one wins
		set_hudmessage(0, 200, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 3.0, 2.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "WIN_NO_ONE")

		if(g_enable_end_round_sounds) { // Play win sound and increase human score
			ArrayGetString(sound_win_no_one, random_num(0, ArraySize(sound_win_no_one) - 1), sound, charsmax(sound))
			PlaySound(sound)
		}
		ExecuteForward(g_forwards[ROUND_END], g_fwDummyResult, ZP_TEAM_NO_ONE); // Round end forward
	}
	g_gamecommencing = false // Game commencing triggers round end
	balance_teams() // Balance the teams
}
// Event Map Ended
public event_intermission() remove_task(TASK_AMBIENCESOUNDS) // Remove ambience sounds task

public event_ammo_x(id) { // BP Ammo update
	if(g_zombie[id] || g_hm_special[id] == BERSERKER) return; // Humans only

	static type; type = read_data(1) // Get ammo type
	if(type >= sizeof AMMOWEAPON) return; // Unknown ammo type

	static weapon; weapon = AMMOWEAPON[type] // Get weapon's id
	if(MAXBPAMMO[weapon] <= 2) return; // Primary and secondary only

	static amount; amount = read_data(2) // Get ammo amount
	
	static update; update = false
	if(g_hm_special[id] < MAX_SPECIALS_HUMANS) update =  get_pcvar_num(cvar_hm_infammo[g_hm_special[id]]) ? true : false
	else update = (ArrayGetCell(g_hm_special_uclip, g_hm_special[id]-MAX_SPECIALS_HUMANS) > 0) ? true : false

	if(update) { // Unlimited BP Ammo?
		if(amount < MAXBPAMMO[weapon]) {
			// The BP Ammo refill code causes the engine to send a message, but we
			// can't have that in this forward or we risk getting some recursion bugs.
			// For more info see: https://bugs.alliedmods.net/show_bug.cgi?id=3664
			static args[1]; args[0] = weapon
			set_task(0.1, "refill_bpammo", id, args, sizeof args)
		}
	}
	if(g_isbot[id] && amount <= BUYAMMO[weapon]) set_task(0.1, "clcmd_buyammo", id) // Bots automatically buy ammo when needed
}

/*================================================================================
 [Main Forwards]
=================================================================================*/
public fw_Spawn(entity) { // Entity Spawn Forward
	if(!pev_valid(entity)) return FMRES_IGNORED;

	new classname[32], objective[32], size = ArraySize(g_objective_ents)
	pev(entity, pev_classname, classname, charsmax(classname))

	for(new i = 0; i < size; i++) { // Check whether it needs to be removed
		ArrayGetString(g_objective_ents, i, objective, charsmax(objective))
		if(equal(classname, objective)) {
			engfunc(EngFunc_RemoveEntity, entity)
			return FMRES_SUPERCEDE;
		}
	}
	return FMRES_IGNORED;
}

public fw_PrecacheSound(const sound[]) { // Sound Precache Forward
	if(equal(sound, "hostage", 7)) return FMRES_SUPERCEDE; // Block all those unneeeded hostage sounds

	return FMRES_IGNORED;
}

public fw_PlayerSpawn_Post(id) { // Ham Player Spawn Post Forward
	if(!is_user_alive(id) || !fm_cs_get_user_team(id)) return;

	g_isalive[id] = true // Player spawned

	remove_task(id+TASK_SPAWN)
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_BURN)		// Remove previous tasks
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_CHARGE)
	remove_task(id+TASK_FLASH)
	remove_task(id+TASK_NVISION)

	if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id); // Spawn at a random location?
	if(get_pcvar_num(cvar_removemoney)) set_task(0.4, "task_hide_money", id+TASK_SPAWN); // Hide money?
	
	// Respawn player if he dies because of a worldspawn kill?
	if(get_pcvar_num(cvar_respawnworldspawnkill)) set_task(2.0, "respawn_player_check_task", id+TASK_SPAWN)

	if(!g_newround) { // Check whether to transform the player before spawning
		if(g_respawn_as_zombie[id]) { // Respawn as a zombie ?
			reset_vars(id, 0) // Reset player vars
			if(g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespnem)) { // Respawn as a nemesis on LNJ round ?
				zombieme(id, 0, NEMESIS, 0, 0) // Make him nemesis right away
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjnemhpmulti))) // Apply the nemesis health multiplier
			}
			else zombieme(id, 0, 0, 0, 0) // Make him zombie right away
		}
		else {
			reset_vars(id, 0) // Reset player vars
			if(g_currentmode == MODE_LNJ && get_pcvar_num(cvar_lnjrespsurv)) { // Respawn as a survivor on LNJ round ?
				humanme(id, SURVIVOR, 0) // Make him survivor right away			
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti))) // Apply the survivor health multiplier
			}
		}
		if(g_zombie[id]) { // Execute our player spawn post forward
			ExecuteForward(g_forwards[PLAYER_SPAWN_POST], g_fwDummyResult, id);
			return;
		}
	}

	reset_vars(id, 0) // Reset player vars
	g_buytime[id] = get_gametime()
	
	if(get_pcvar_num(cvar_buycustom)) set_task(0.2, "menu_buy_show", id+TASK_SPAWN) // Show custom buy menu?
	
	// Set health and gravity
	fm_set_user_health(id, get_pcvar_num(cvar_hm_health[g_hm_special[id]]))
	set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[g_hm_special[id]]))

	
	if(!g_zombie[id]) { // Give nvision for humans ?
		static enable; enable = 0
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) enable = ArrayGetCell(g_hm_special_nvision, g_hm_special[id])
		else enable = get_pcvar_num(cvar_hm_nvggive[g_hm_special[id]])

		if(enable) {
			g_nvision[id] = true
			if(!g_isbot[id]) {
				if(enable == 1) { // Turn on Night Vision automatically?
					g_nvisionenabled[id] = true
					user_nightvision(id, 1)
				}
				else nvision_toggle_off(id)
			}
			else cs_set_user_nvg(id, 1); // turn on NVG for bots
		}
		else if(g_nvision[id]) { // Disable nightvision when turning into human/survivor (bugfix)
			nvision_toggle_off(id)
			g_nvision[id] = false
		}
	}
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set human maxspeed
	
	// Switch to CT if spawning mid-round
	if(!g_newround && fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT)
		fm_user_team_update(id)
	}

	reset_player_models(id)
	reset_user_rendering(id)

	if(g_isbot[id]) { // Bots stuff
		cs_set_user_nvg(id, 0) // Turn off NVG for bots

		if(get_pcvar_num(cvar_extraitems) && get_pcvar_num(cvar_bot_maxitem) > 0) { // Automatically buy extra items/weapons after first zombie is chosen
			g_bot_extra_count[id] = 0
			set_task(get_pcvar_float(cvar_bot_buyitem_interval) + g_newround ? get_pcvar_float(cvar_warmup) : 0.0, "bot_buy_extras", id+TASK_SPAWN)
		}
	}

	if(!g_newround && get_pcvar_float(cvar_spawnprotection) > 0.0) { // Enable spawn protection for humans spawning mid-round
		g_nodamage[id] = true // Do not take damage
		set_pev(id, pev_takedamage, DAMAGE_NO)
		set_pev(id, pev_effects, pev(id, pev_effects) | EF_NODRAW) // Make temporarily invisible
		set_task(get_pcvar_float(cvar_spawnprotection), "remove_spawn_protection", id+TASK_SPAWN) // Set task to remove it
	}

	turn_off_flashlight(id) // Turn off his flashlight (prevents double flashlight bug/exploit)
	if(g_cached_customflash) set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b") // Set the flashlight charge task to update battery status
	
	// Replace weapon models (bugfix)
	static weapon_ent; weapon_ent = fm_cs_get_current_weapon_ent(id)
	if(pev_valid(weapon_ent)) replace_weapon_models(id, cs_get_weapon_id(weapon_ent))

	fnCheckLastZombie() // Last Zombie Check
	ExecuteForward(g_forwards[PLAYER_SPAWN_POST], g_fwDummyResult, id); // Execute our player spawn post forward
}
public fw_PlayerKilled(victim, attacker, shouldgib) { // Ham Player Killed Forward
	g_isalive[victim] = false // Player killed
	g_nodamage[victim] = false // Disable nodamage mode after we die to prevent spectator nightvision using zombie madness colors bug
	
	set_task(0.1, "spec_nvision", victim) // Enable dead players nightvision

	if(g_zombie[victim] && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES || !g_zombie[victim] && g_hm_special[victim] < MAX_SPECIALS_HUMANS) {
		
		// Disable nightvision when killed (bugfix)
		if(get_pcvar_num(g_zombie[victim] ? cvar_zm_nvggive[g_zm_special[victim]] : cvar_hm_nvggive[g_hm_special[victim]]) == 0 && g_nvision[victim]) {
			nvision_toggle_off(victim)
			g_nvision[victim] = false
		}
		
		// Turn off nightvision when killed (bugfix)
		if(get_pcvar_num(g_zombie[victim] ? cvar_zm_nvggive[g_zm_special[victim]] : cvar_hm_nvggive[g_hm_special[victim]]) == 2 && g_nvision[victim] && g_nvisionenabled[victim])
			nvision_toggle_off(victim)
	}
	else {
		if(g_nvision[victim] && (g_zombie[victim] && ArrayGetCell(g_zm_special_nvision, g_zm_special[victim]-MAX_SPECIALS_ZOMBIES) == 0
		|| !g_zombie[victim] && ArrayGetCell(g_hm_special_nvision, g_hm_special[victim]-MAX_SPECIALS_HUMANS) == 0)) {
			nvision_toggle_off(victim)
			g_nvision[victim] = false
		}
		if(g_nvision[victim] && g_nvisionenabled[victim] && (g_zombie[victim] && ArrayGetCell(g_zm_special_nvision, g_zm_special[victim]-MAX_SPECIALS_ZOMBIES) == 2
		|| !g_zombie[victim] && ArrayGetCell(g_hm_special_nvision, g_hm_special[victim]-MAX_SPECIALS_HUMANS) == 2))
			nvision_toggle_off(victim)
	}
	if(g_cached_customflash) { // Turn off custom flashlight when killed
		g_flashlight[victim] = false	// Turn it off
		g_flashbattery[victim] = 100
		remove_task(victim+TASK_CHARGE) // Remove previous tasks
		remove_task(victim+TASK_FLASH)
	}
	if(g_zombie[victim] || g_hm_special[victim] > 0) { // Stop bleeding/burning/aura when killed
		remove_task(victim+TASK_BLOOD)
		remove_task(victim+TASK_AURA)
		remove_task(victim+TASK_BURN)
	}
	if(is_user_valid_connected(attacker)) { // Nemesis and Assassin explode! or when killed by a Assassin victim is cut in pieces
		if(g_zm_special[victim] > 0 || g_zm_special[attacker] == ASSASSIN && get_pcvar_num(cvar_nemfraggore)) {
			SetHamParamInteger(3, 2)
			if(g_zm_special[victim] > 0) {
				static iRand, sound[128]
				iRand = random_num(ArrayGetCell(g_zm_sp_deathsnd_start, g_zm_special[victim]-1), ArrayGetCell(g_zm_sp_deathsnd_end, g_zm_special[victim]-1) -1)
				ArrayGetString(g_zm_sp_deathsnd, iRand, sound, charsmax(sound))
				emit_sound(victim, CHAN_STATIC, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
		}
	}
	static selfkill // Get deathmatch mode status and whether the player killed himself
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false
	
	if(selfkill) return; // Make sure that the player was not killed by a non-player entity or through self killing

	// Ignore Nemesis/Survivor/Sniper/Berserker Frags?
	if(g_zombie[attacker] && g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES) {
		if(get_pcvar_num(cvar_zm_ignore_frags[g_zm_special[attacker]])) RemoveFrags(attacker, victim);
	}
	else if(g_zombie[attacker] && g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES) 
		if(ArrayGetCell(g_zm_special_ignorefrag, g_zm_special[attacker]-MAX_SPECIALS_ZOMBIES) > 0) RemoveFrags(attacker, victim);
	
	if(!g_zombie[attacker] && g_hm_special[attacker] > 0 && g_hm_special[attacker] < MAX_SPECIALS_HUMANS) {
		if(get_pcvar_num(cvar_hm_ignore_frags[g_hm_special[attacker]])) RemoveFrags(attacker, victim);
	}
	else if(!g_zombie[attacker] && g_hm_special[attacker] >= MAX_SPECIALS_HUMANS)
		if(ArrayGetCell(g_hm_special_ignorefrag, g_hm_special[attacker]-MAX_SPECIALS_HUMANS)) RemoveFrags(attacker, victim);

	// Zombie/nemesis/assassin killed human, reward ammo packs
	if(g_zombie[attacker] && g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES) {
		if(!get_pcvar_num(cvar_zm_ignore_ammo[g_zm_special[attacker]])) g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
	}
	else if(g_zombie[attacker] && g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES)
		if(ArrayGetCell(g_zm_special_ignoreammo, g_zm_special[attacker]-MAX_SPECIALS_ZOMBIES) <= 0) g_ammopacks[attacker] += get_pcvar_num(cvar_ammoinfect)
	
	// Human killed zombie, add up the extra frags for kill
	if(!g_zombie[attacker] && get_pcvar_num(cvar_fragskill) > 1) UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragskill) - 1, 0, 0)
	
	// Zombie killed human, add up the extra frags for kill
	if(g_zombie[attacker] && get_pcvar_num(cvar_fragsinfect) > 1) UpdateFrags(attacker, victim, get_pcvar_num(cvar_fragsinfect) - 1, 0, 0)
	
	// When killed by a Sniper victim explodes
	if(g_hm_special[attacker] == SNIPER && (g_currentweapon[attacker] == CSW_AWP) && get_pcvar_num(cvar_sniperfraggore) && g_zombie[victim]) {	

		SetHamParamInteger(3, 2) // Cut him into pieces
		static origin[3]; get_user_origin(victim, origin)
		
		// Make some blood in the air
		message_begin(MSG_PVS, SVC_TEMPENTITY, origin)
		write_byte(TE_LAVASPLASH) // TE id
		write_coord(origin[0]) // origin x
		write_coord(origin[1]) // origin y
		write_coord(origin[2] - 26) // origin z
		message_end()
	}	
}
public fw_PlayerKilled_Post(victim, attacker, shouldgib) { // Ham Player Killed Post Forward
	fnCheckLastZombie() // Last Zombie Check

	static selfkill; // Determine whether the player killed himself
	selfkill = (victim == attacker || !is_user_valid_connected(attacker)) ? true : false

	if((g_newround || g_currentmode == MODE_NONE) && !g_endround) {
		respawn_player_task(victim+TASK_SPAWN) // Instant respawn before round begins
	}
	else if(get_pcvar_num(cvar_deathmatch) || ((g_currentmode > MODE_LNJ) && (g_deathmatchmode > 0))) { // Respawn if deathmatch is enabled
		if(selfkill && !get_pcvar_num(cvar_respawnonsuicide)) 
			return; // Respawn on suicide?

		// Respawn Limit
		static limit_resp
		limit_resp = 0

		if(g_currentmode >= MAX_GAME_MODES)
			limit_resp = ArrayGetCell(g_gamemode_respawn_limit, (g_currentmode - MAX_GAME_MODES))

		else if(g_currentmode == MODE_INFECTION || g_currentmode == MODE_MULTI)
			limit_resp = get_pcvar_num(cvar_respawn_limit[MODE_INFECTION])

		else if(g_currentmode != MODE_NONE && g_currentmode < MAX_GAME_MODES)
			limit_resp = get_pcvar_num(cvar_respawn_limit[g_currentmode])

		if(g_respawn_count[victim] >= limit_resp && limit_resp > 0)	
			return;
		
		// Respawn if only the last human is left?
		if(!get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() <= 1 && (g_currentmode == MODE_INFECTION || g_currentmode == MODE_MULTI))
			return;
		
		// Respawn if are Special Class
		if(!g_zombie[victim] && g_hm_special[victim] < MAX_SPECIALS_HUMANS) if(!get_pcvar_num(cvar_hm_respawn[g_hm_special[victim]])) return;
		else if(!g_zombie[victim] && g_hm_special[victim] >= MAX_SPECIALS_HUMANS) if(ArrayGetCell(g_hm_special_respawn, g_hm_special[victim]-MAX_SPECIALS_HUMANS) <= 0) return;
		else if(g_zombie[victim] && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) if(!get_pcvar_num(cvar_zm_respawn[g_zm_special[victim]])) return;
		else if(!g_zombie[victim] && g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES) if(ArrayGetCell(g_zm_special_respawn, g_zm_special[victim]-MAX_SPECIALS_ZOMBIES) <= 0) return;
		
		// Respawn as zombie?
		if((g_currentmode >= MAX_GAME_MODES) && (g_deathmatchmode > 0)) { // Custom round ?
			if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
				g_respawn_as_zombie[victim] = true
		}
		else if(get_pcvar_num(cvar_deathmatch) > 0) { // Normal round
			if(get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
				g_respawn_as_zombie[victim] = true
		}
		set_task(get_pcvar_float(cvar_spawndelay), "respawn_player_task", victim+TASK_SPAWN) // Set the respawn task
	}
}

public fw_TakeDamage(victim, inflictor, attacker, Float:damage, damage_type) { // Ham Take Damage Forward
	if(!is_user_valid_alive(victim))
		return HAM_IGNORED;
	
	if(!is_user_valid_connected(attacker) && pev_valid(attacker)) {
		static classname[32]; 
		pev(attacker, pev_classname, classname, charsmax(classname));
		if(damage >= get_user_health(victim) && equal(classname, "trigger_hurt")) {
			if(g_endround)
				return HAM_SUPERCEDE;

			// Block Entity Kill Damage before Round Starts and when round end (Essentials for Escape Maps)
			if((g_newround || g_currentmode == MODE_NONE) && !g_endround) { // Move to an initial spawn
				if(get_pcvar_num(cvar_randspawn)) do_random_spawn(victim) // random spawn (including CSDM)
				else do_random_spawn(victim, 1) // regular spawn
			}
			
			// Fix entity kill bug
			else user_kill(victim);
			
			return HAM_SUPERCEDE;
		}
		return HAM_IGNORED;
	}	

	if(victim == attacker || !is_user_valid_connected(attacker)) return HAM_IGNORED; // Non-player damage or self damage
	
	// New round starting or round ended  / Victim shouldn't take damage or victim is frozen
	if(g_newround || g_endround || g_currentmode == MODE_NONE || g_nodamage[victim] || (g_frozen[victim] && !(get_pcvar_num(cvar_frozenhit))))
		return HAM_SUPERCEDE;
	
	// Prevent friendly fire
	if(is_user_valid_alive(attacker) && fm_cs_get_user_team(attacker) == fm_cs_get_user_team(victim)) 
		return HAM_SUPERCEDE;
	
	if(!g_zombie[attacker]) { // Attacker is human...
		if(g_zm_special[victim] > 0 && g_hm_special[attacker] != SNIPER) { // Armor multiplier for the final damage on normal zombies
			damage *= get_pcvar_float(cvar_zombiearmor)
			SetHamParamFloat(4, damage)
		}
		switch(g_hm_special[attacker]) {
			case SURVIVOR: {
				static survweaponname[32]; get_pcvar_string(cvar_survweapon, survweaponname, charsmax(survweaponname))
				if(g_currentweapon[attacker] == cs_weapon_name_to_id(survweaponname)) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[SURVIVOR]))
			}
			case SNIPER: if(g_currentweapon[attacker] == CSW_AWP) SetHamParamFloat(4, get_pcvar_float(cvar_hm_damage[SNIPER]))
			case BERSERKER: if(g_currentweapon[attacker] == CSW_KNIFE) SetHamParamFloat(4, get_pcvar_float(cvar_hm_damage[BERSERKER]))
			case WESKER: if(g_currentweapon[attacker] == CSW_DEAGLE) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[WESKER]))
			case SPY: if(g_currentweapon[attacker] == CSW_M3) SetHamParamFloat(4, damage * get_pcvar_float(cvar_hm_damage[SPY]))
		}

		if(g_zm_special[victim] == PREDATOR) {
			if(get_pcvar_num(cvar_zm_glow[PREDATOR])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 250, 250, 250, kRenderNormal, 15)
			else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 15)
			set_task(1.0, "turn_invisible", victim)
		}

		return HAM_IGNORED;
	}
	
	// Attacker is zombie...
	
	// Prevent infection/damage by HE grenade (bugfix)
	if(damage_type & DMG_HEGRENADE) return HAM_SUPERCEDE;
		
	if(g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES) { // Nemesis/Assassin?
		
		// Ignore nemesis/assassin damage override if damage comes from a 3rd party entity
		// (to prevent this from affecting a sub-plugin's rockets e.g.)
		if(inflictor == attacker) 
			SetHamParamFloat(4, get_pcvar_float(cvar_zm_damage[g_zm_special[attacker]]))

		return HAM_IGNORED;
	}

	if(g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES) return HAM_IGNORED;

	if(g_hm_special[victim] == SPY) {
		if(get_pcvar_num(cvar_hm_glow[SPY])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[SPY]), get_pcvar_num(cvar_hm_green[SPY]), get_pcvar_num(cvar_hm_blue[SPY]), kRenderNormal, 15)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[victim] : victim, kRenderFxGlowShell, 0, 0, 0, kRenderNormal, 15)
		set_task(1.0, "turn_invisible", victim)
	}

	if(!g_allowinfection || fnGetHumans() == 1) return HAM_IGNORED; // Last human or infection not allowed
	
	// Does human armor need to be reduced before infecting?
	if(get_pcvar_num(cvar_humanarmor) == 1 || get_pcvar_num(cvar_humanarmor) == 2 && !g_escape_map || get_pcvar_num(cvar_humanarmor) >= 3 && g_escape_map) {
		
		static Float:armor; pev(victim, pev_armorvalue, armor) // Get victim armor
		if(armor > 0.0) { // If he has some, block the infection and reduce armor instead
			emit_sound(victim, CHAN_BODY, cs_sounds[2], 1.0, ATTN_NORM, 0, PITCH_NORM)
			if(armor - damage > 0.0) set_pev(victim, pev_armorvalue, armor - damage)
			else cs_set_user_armor(victim, 0, CS_ARMOR_NONE)

			return HAM_SUPERCEDE;
		}
	}
	// Infection allowed
	zombieme(victim, attacker, 0, 0, 1) // turn into zombie
	return HAM_SUPERCEDE;
}
public fw_TakeDamage_Post(victim, inflictor, attacker, Float:damage, damage_type) { // Ham Take Damage Post Forward
	if(!is_user_valid_alive(victim))
		return;

	// Damage Dealt (Now works like in zp 5.0)
	if(damage_type & DMG_BULLET)
		damage_dealth(attacker, victim, floatround(damage));

	// --- Check if victim should be Pain Shock Free ---
	// Check if proper CVARs are enabled
	if(g_zombie[victim]) {
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
				case 3: if(!g_firstzombie[victim]) return;
			}
		}
	}
	else {
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
	//if(pev_valid(victim) != PDATA_SAFE) 
		//return; // Prevent server crash if entity's private data not initalized

	set_pdata_float(victim, OFFSET_PAINSHOCK, 1.0, OFFSET_LINUX) // Set pain shock free offset
}

public fw_TraceAttack(victim, attacker, Float:damage, Float:direction[3], tracehandle, damage_type) { // Ham Trace Attack Forward
	if(victim == attacker || !is_user_valid_connected(attacker)) return HAM_IGNORED; // Non-player damage or self damage
	
	// New round starting or round ended / Victim shouldn't take damage or victim is frozen
	if(g_newround || g_endround || g_currentmode == MODE_NONE || g_nodamage[victim] || (g_frozen[victim] && !get_pcvar_num(cvar_frozenhit)))
		return HAM_SUPERCEDE;

	if(g_zombie[attacker] == g_zombie[victim]) 
		return HAM_SUPERCEDE; // Prevent friendly fire
	
	// Victim isn't a zombie or not bullet damage, nothing else to do here
	if(!g_zombie[victim] || !(damage_type & DMG_BULLET)) 
		return HAM_IGNORED;
	
	// If zombie hitzones are enabled, check whether we hit an allowed one
	if(get_pcvar_num(cvar_hitzones) && g_zm_special[victim] <= 0 && !(get_pcvar_num(cvar_hitzones) & (1<<get_tr2(tracehandle, TR_iHitgroup))))
		return HAM_SUPERCEDE;
	
	if(!get_pcvar_num(cvar_knockback)) 
		return HAM_IGNORED; // Knockback disabled, nothing else to do here

	// Specials knockback disabled, nothing else to do here	
	if(g_zm_special[victim] > 0 && g_zm_special[victim] < MAX_SPECIALS_ZOMBIES) {
		if(get_pcvar_float(cvar_zmsp_knockback[g_zm_special[victim]]) == 0.0) 
			return HAM_IGNORED;
	}
	else if(g_zombie_knockback[victim] == 0.0 && g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES) 
		return HAM_IGNORED;

	// Get whether the victim is in a crouch state
	static ducking; ducking = pev(victim, pev_flags) & (FL_DUCKING | FL_ONGROUND) == (FL_DUCKING | FL_ONGROUND)
	
	if(ducking && get_pcvar_float(cvar_knockbackducking) == 0.0) 
		return HAM_IGNORED; // Zombie knockback when ducking disabled
	
	// Get distance between players
	static origin1[3], origin2[3]
	get_user_origin(victim, origin1)
	get_user_origin(attacker, origin2)

	if(get_distance(origin1, origin2) > get_pcvar_num(cvar_knockbackdist)) 
		return HAM_IGNORED; // Max distance exceeded

	static Float:velocity[3]; pev(victim, pev_velocity, velocity) // Get victim's velocity

	if(get_pcvar_num(cvar_knockbackdamage)) 
		xs_vec_mul_scalar(direction, damage, direction) // Use damage on knockback calculation
	
	// Use weapon power on knockback calculation
	if(get_pcvar_num(cvar_knockbackpower) && kb_weapon_power[g_currentweapon[attacker]] > 0.0) 
		xs_vec_mul_scalar(direction, kb_weapon_power[g_currentweapon[attacker]], direction)

	if(ducking) 
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_knockbackducking), direction) // Apply ducking knockback multiplier
	
	// Apply zombie class/nemesis knockback multiplier
	if(g_zm_special[victim] >= MAX_SPECIALS_ZOMBIES || g_zm_special[victim] <= 0) 
		xs_vec_mul_scalar(direction, g_zombie_knockback[victim], direction) 
	else 
		xs_vec_mul_scalar(direction, get_pcvar_float(cvar_zmsp_knockback[g_zm_special[victim]]), direction)

	xs_vec_add(velocity, direction, direction) // Add up the new vector

	if(!get_pcvar_num(cvar_knockbackzvel)) 
		direction[2] = velocity[2] // Should knockback also affect vertical velocity?

	set_pev(victim, pev_velocity, direction) // Set the knockback'd victim's velocity
	return HAM_IGNORED;
}

public fw_ResetMaxSpeed_Post(id) { // Ham Reset MaxSpeed Post Forward
	if(g_freezetime || !g_isalive[id]) 
		return; // Freezetime active or player not alive

	set_player_maxspeed(id)
}
public fw_UseStationary(entity, caller, activator, use_type) { // Ham Use Stationary Gun Forward
	if(use_type == USE_USING && is_user_valid_connected(caller) && g_zombie[caller]) 
		return HAM_SUPERCEDE; // Prevent zombies from using stationary guns
	
	return HAM_IGNORED;
}
public fw_UseStationary_Post(entity, caller, activator, use_type) { // Ham Use Stationary Gun Post Forward
	if(use_type == USE_STOPPED && is_user_valid_connected(caller)) // Someone stopped using a stationary gun
		replace_weapon_models(caller, g_currentweapon[caller]) // replace weapon models (bugfix)
}
public fw_UsePushable() { // Ham Use Pushable Forward
	if(get_pcvar_num(cvar_blockpushables)) 
		return HAM_SUPERCEDE; // Prevent speed bug with pushables?
	
	return HAM_IGNORED;
}
public fw_UseButton(entity, caller, activator, use_type) {
	if(g_escape_map && g_endround) 
		return HAM_SUPERCEDE // Prevent bug on escape button
	
	if(!get_pcvar_num(cvar_block_zm_use_button) || get_pcvar_num(cvar_block_zm_use_button) < 2 && !g_escape_map) 
		return HAM_IGNORED;

	if(use_type == USE_USING && is_user_valid_connected(caller)) {
		if(g_zombie[caller]) return HAM_SUPERCEDE;
	}
	
	return HAM_IGNORED;
}
public fw_TouchWeapon(weapon, id) { // Ham Weapon Touch Forward
	if(!is_user_valid_connected(id)) 
		return HAM_IGNORED;
	
	if(g_zombie[id] || (g_hm_special[id] > 0)) 
		return HAM_SUPERCEDE; // Dont pickup weapons if zombie, special class
	
	return HAM_IGNORED;
}
public fw_AddPlayerItem(id, weapon_ent) { // Ham Weapon Pickup Forward
	static extra_ammo; extra_ammo = pev(weapon_ent, PEV_ADDITIONAL_AMMO) // HACK: Retrieve our custom extra ammo from the weapon
	
	if(extra_ammo) {
		static weaponid; weaponid = cs_get_weapon_id(weapon_ent)
		ExecuteHamB(Ham_GiveAmmo, id, extra_ammo, AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
		set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, 0)
	}
}
public fw_Item_Deploy_Post(weapon_ent) { // Ham Weapon Deploy Forward
	if(!pev_valid(weapon_ent)) return

	static owner; owner = fm_cs_get_weapon_ent_owner(weapon_ent) // Get weapon's owner
		
	if(!(1 <= owner <= g_maxplayers)) return; // Invalid player id? (bugfix)

	static weaponid; weaponid = cs_get_weapon_id(weapon_ent) // Get weapon's id
	
	g_currentweapon[owner] = weaponid // Store current weapon's id for reference
	replace_weapon_models(owner, weaponid) // Replace weapon models with custom ones

	// Zombie not holding an allowed weapon for some reason
	if(g_zombie[owner] && !((1<<weaponid) & ZOMBIE_ALLOWED_WEAPONS_BITSUM)) {
		g_currentweapon[owner] = CSW_KNIFE		// Switch to knife
		engclient_cmd(owner, "weapon_knife")
	}
}
// WeaponMod bugfix
// forward wpn_gi_reset_weapon(id);
public wpn_gi_reset_weapon(id) replace_weapon_models(id, CSW_KNIFE) // Replace knife model


public client_putinserver(id) { // Client joins the game
	if(!g_pluginenabled) return; // Plugin disabled?

	g_isconnected[id] = true
	g_zombieclassnext[id] = ZCLASS_NONE

	get_user_name(id, g_playername[id], charsmax(g_playername[])) // Cache player's name

	reset_vars(id, 1)
	g_hud_color[0][id] = 4
	g_hud_color[1][id] = 6

	if(get_pcvar_num(cvar_statssave)) load_stats(id) // Load player stats?
	
	if(!is_user_bot(id)) { // Set some tasks for humans only
		set_task(1.0, "ShowHUD", id+TASK_SHOWHUD, _, _, "b") // Set the custom HUD display task
		set_task(5.0, "disable_minmodels", id) // Disable minmodels for clients to see zombies properly
	}
	else {
		g_isbot[id] = true // Set bot flag

		// CZ bots seem to use a different "classtype" for player entities
		// (or something like that) which needs to be hooked separately
		if(!g_hamczbots && cvar_botquota) set_task(0.1, "register_ham_czbots", id) // Set a task to let the private data initialize
	}
}

public fw_ClientDisconnect(id) { // Client leaving
	if(g_isalive[id]) check_round(id) // Check that we still have both humans and zombies to keep the round going

	if(get_pcvar_num(cvar_statssave)) save_stats(id) // Temporarily save player stats?
	
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
	
	if(g_handle_models_on_separate_ent) fm_remove_model_ents(id) // Remove custom model entities
	
	// Player left, clear cached flags
	g_isconnected[id] = false
	g_isbot[id] = false
	g_isalive[id] = false
}
public fw_ClientDisconnect_Post() fnCheckLastZombie() // Last Zombie Check


public fw_ClientKill() { // Client Kill Forward
	if(get_pcvar_num(cvar_blocksuicide)) return FMRES_SUPERCEDE; // Prevent players from killing themselves?

	return FMRES_IGNORED;
}
public fw_EmitSound(id, channel, const sample[], Float:volume, Float:attn, flags, pitch) { // Emit Sound Forward
	// Block all those unneeeded hostage sounds
	if(sample[0] == 'h' && sample[1] == 'o' && sample[2] == 's' && sample[3] == 't' && sample[4] == 'a' && sample[5] == 'g' && sample[6] == 'e')
		return FMRES_SUPERCEDE;
	
	if(!is_user_valid_connected(id) || !g_zombie[id]) return FMRES_IGNORED; // Replace these next sounds for zombies only

	static sound[64], iRand

	// Dragon Skill
	if(equal(sample, "common/wpn_denyselect.wav") && (pev(id, pev_button) & IN_USE) && g_zm_special[id] == DRAGON) use_cmd(id)

	if(sample[7] == 'b' && sample[8] == 'h' && sample[9] == 'i' && sample[10] == 't') { // Zombie being hit
		if(g_zm_special[id] <= 0) {
			iRand = random_num(ArrayGetCell(g_zclass_painsnd_start, g_zombieclass[id]), ArrayGetCell(g_zclass_painsnd_end, g_zombieclass[id])-1)
			ArrayGetString(g_zclass_painsnd, iRand, sound, charsmax(sound))
		}
		else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
			iRand = random_num(0, ArraySize(zombie_pain[g_zm_special[id]]) - 1)
			ArrayGetString(zombie_pain[g_zm_special[id]], iRand, sound, charsmax(sound))
		}
		else {
			iRand = random_num(ArrayGetCell(g_zm_special_painsndstart, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_painsndsend, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)-1)
			ArrayGetString(g_zm_special_painsound, iRand, sound, charsmax(sound))
		}		
			
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}

	if(sample[8] == 'k' && sample[9] == 'n' && sample[10] == 'i' && sample[14] != 'd') { // Zombie attacks with knife
		if(sample[14] == 's' && sample[15] == 'l' && sample[16] == 'a') // slash
			ArrayGetString(ar_sound[3], random_num(0, ArraySize(ar_sound[3]) - 1), sound, charsmax(sound))

		if(sample[14] == 'h' && sample[15] == 'i' && sample[16] == 't') { // hit
			if(sample[17] == 'w') ArrayGetString(ar_sound[4], random_num(0, ArraySize(ar_sound[4]) - 1), sound, charsmax(sound)) // wall
			else ArrayGetString(ar_sound[5], random_num(0, ArraySize(ar_sound[5]) - 1), sound, charsmax(sound))
		}
		if(sample[14] == 's' && sample[15] == 't' && sample[16] == 'a') // stab
			ArrayGetString(ar_sound[6], random_num(0, ArraySize(ar_sound[6]) - 1), sound, charsmax(sound))

		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie dies
	if(sample[7] == 'd' && ((sample[8] == 'i' && sample[9] == 'e') || (sample[8] == 'e' && sample[9] == 'a')) && g_zm_special[id] <= 0) {
		/*if(g_zm_special[id] > 0) {
			//ArrayGetString(ar_sound[1], random_num(0, ArraySize(ar_sound[1]) - 1), sound, charsmax(sound))
			iRand = random_num(ArrayGetCell(g_zm_sp_deathsnd_start, g_zm_special[id]-1), ArrayGetCell(g_zm_sp_deathsnd_end, g_zm_special[id]-1) -1)
			ArrayGetString(g_zm_sp_deathsnd, iRand, sound, charsmax(sound))
		}*/
		
		iRand = random_num(ArrayGetCell(g_zclass_deathsnd_start, g_zombieclass[id]), ArrayGetCell(g_zclass_deathsnd_end, g_zombieclass[id])-1)
		ArrayGetString(g_zclass_deathsnd, iRand, sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	
	// Zombie falls off
	if(sample[10] == 'f' && sample[11] == 'a' && sample[12] == 'l' && sample[13] == 'l') {
		ArrayGetString(ar_sound[2], random_num(0, ArraySize(ar_sound[2]) - 1), sound, charsmax(sound))
		emit_sound(id, channel, sound, volume, attn, flags, pitch)
		return FMRES_SUPERCEDE;
	}
	return FMRES_IGNORED;
}
public fw_SetClientKeyValue(id, const infobuffer[], const key[]) { // Forward Set ClientKey Value -prevent CS from changing player models-
	if(key[0] == 'm' && key[1] == 'o' && key[2] == 'd' && key[3] == 'e' && key[4] == 'l') return FMRES_SUPERCEDE; // Block CS model changes

	return FMRES_IGNORED;
}
public fw_ClientUserInfoChanged(id) { // Forward Client User Info Changed -prevent players from changing models-
	get_user_name(id, g_playername[id], charsmax(g_playername[])) // Cache player's name
	
	if(!g_handle_models_on_separate_ent) {
		static currentmodel[32]; fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel)) // Get current model
		if(!equal(currentmodel, g_playermodel[id]) && !task_exists(id+TASK_MODEL)) fm_cs_set_user_model(id+TASK_MODEL) // If they're different, set model again
	}
}
public fw_GetGameDescription() { // Forward Get Game Description
	forward_return(FMV_STRING, g_modname) // Return the mod name so it can be easily identified
	return FMRES_SUPERCEDE;
}

public fw_SetModel(entity, const model[]) { // Forward Set Model
	if(strlen(model) < 8) return FMRES_IGNORED; // We don't care

	if(get_pcvar_float(cvar_removedropped) > 0.0) { // Remove weapons?
		static classname[10] // Get entity's classname
		pev(entity, pev_classname, classname, charsmax(classname))

		if(equal(classname, "weaponbox")) { // Check if it's a weapon box
			// They get automatically removed when thinking
			set_pev(entity, pev_nextthink, get_gametime() + get_pcvar_float(cvar_removedropped))
			return FMRES_IGNORED;
		}
	}
	if(model[7] != 'w' || model[8] != '_') return FMRES_IGNORED; // Narrow down our matches a bit
	
	static Float:dmgtime; pev(entity, pev_dmgtime, dmgtime) // Get damage time of grenade

	if(dmgtime == 0.0) return FMRES_IGNORED; // Grenade not yet thrown
	
	if(g_zombie[pev(entity, pev_owner)]) { // Get whether grenade's owner is a zombie
		if(model[9] == 'h' && model[10] == 'e' && ((get_pcvar_num(cvar_extrainfbomb) && !g_escape_map) || (get_pcvar_num(cvar_extrainfbomb_ze) && g_escape_map) || g_zm_special[pev(entity, pev_owner)] == BOMBARDIER)) { // Infection Bomb 
			// Give it a glow
			fm_set_rendering(entity, kRenderFxGlowShell, grenade_rgb[INFECTION_BOMB][0], grenade_rgb[INFECTION_BOMB][1], grenade_rgb[INFECTION_BOMB][2], kRenderNormal, 16);
			entity_set_model(entity, g_zm_special[pev(entity, pev_owner)] == BOMBARDIER ? model_grenade_bombardier[WORLD_MODEL] : model_grenade_infect[WORLD_MODEL])
			
			set_trail(entity, grenade_rgb[INFECTION_BOMB][0], grenade_rgb[INFECTION_BOMB][1], grenade_rgb[INFECTION_BOMB][2], INFECTION_BOMB)

			set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_INFECTION) // Set grenade type on the thrown grenade entity
			
			return FMRES_SUPERCEDE;
		}
	}
	else if(model[9] == 'h' && model[10] == 'e' && get_pcvar_num(cvar_firegrenades)) { // Napalm Grenade
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, grenade_rgb[FIRE][0], grenade_rgb[FIRE][1], grenade_rgb[FIRE][2], kRenderNormal, 16);
		entity_set_model(entity, model_grenade_fire[WORLD_MODEL])
		
		set_trail(entity, grenade_rgb[FIRE][0], grenade_rgb[FIRE][1], grenade_rgb[FIRE][2], FIRE)

		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_NAPALM) // Set grenade type on the thrown grenade entity
		
		return FMRES_SUPERCEDE;
	}
	else if(model[9] == 'f' && model[10] == 'l' && get_pcvar_num(cvar_frostgrenades)) { // Frost Grenade
		// Give it a glow
		fm_set_rendering(entity, kRenderFxGlowShell, grenade_rgb[FROST][0], grenade_rgb[FROST][1], grenade_rgb[FROST][2], kRenderNormal, 16);
		entity_set_model(entity, model_grenade_frost[WORLD_MODEL])
		
		set_trail(entity, grenade_rgb[FROST][0], grenade_rgb[FROST][1], grenade_rgb[FROST][2], FROST)

		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FROST) // Set grenade type on the thrown grenade entity
		
		return FMRES_SUPERCEDE;
	}
	else if(model[9] == 's' && model[10] == 'm' && get_pcvar_num(cvar_flaregrenades)) { // Flare
		static rgb[3] // Build flare's color
		switch (get_pcvar_num(cvar_flarecolor)) {
			case 0: rgb = { 250, 250, 250 } // white
			case 1: rgb = { 250, 0, 0 } // red
			case 2: rgb = { 0, 250, 0 } // green
			case 3: rgb = { 0, 0, 250 } // blue
			case 4: { // random (all colors)
				rgb[0] = random_num(50,200) // r
				rgb[1] = random_num(50,200) // g
				rgb[2] = random_num(50,200) // b
			}
			case 5: { // random (r,g,b)
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
		entity_set_model(entity, model_grenade_flare[WORLD_MODEL])
		
		set_trail(entity, rgb[0], rgb[1], rgb[2], FLARE)
		
		set_pev(entity, PEV_NADE_TYPE, NADE_TYPE_FLARE) // Set grenade type on the thrown grenade entity
		//set_pev(entity, pev_effects, EF_LIGHT);

		set_pev(entity, PEV_FLARE_COLOR, rgb) // Set flare color on the thrown grenade entity
		
		return FMRES_SUPERCEDE;
	}
	return FMRES_IGNORED;
}
set_trail(entity, r, g, b, grenade_type) {
	if(!pev_valid(entity) || !enable_trail[grenade_type]) return;

	// And a colored trail
	message_begin(MSG_BROADCAST, SVC_TEMPENTITY)
	write_byte(TE_BEAMFOLLOW) // TE id
	write_short(entity) // entity
	write_short(g_trailSpr[grenade_type]) // sprite
	write_byte(10) // life
	write_byte(10) // width
	write_byte(r) // r
	write_byte(g) // g
	write_byte(b) // b
	write_byte(200) // brightness
	message_end()
}
// Ham Grenade Think Forward
public fw_ThinkGrenade(entity) {
	if(!pev_valid(entity)) return HAM_IGNORED;

	// Get damage time of grenade
	static Float:dmgtime, Float:current_time, nade_type
	pev(entity, pev_dmgtime, dmgtime)
	current_time = get_gametime()

	if(dmgtime > current_time) return HAM_IGNORED; // Check if it's time to go off

	nade_type = pev(entity, PEV_NADE_TYPE)

	// Fixing small bug with extra item grenades (Like antidote bomb, jump bomb, etc) [4.3 Fix]
	if(nade_type != NADE_TYPE_FLARE && nade_type != NADE_TYPE_INFECTION && nade_type != NADE_TYPE_FROST && nade_type != NADE_TYPE_NAPALM)
		return HAM_IGNORED;

	// Infection/Frost/Fire Grenade
	if(nade_type != NADE_TYPE_FLARE) {
		grenade_explode(entity, nade_type)
		return HAM_SUPERCEDE;
	}
	else { // Flare Grenade
		static duration; duration = pev(entity, PEV_FLARE_DURATION) // Get its duration

		if(duration > 0) { // Already went off, do lighting loop for the duration of PEV_FLARE_DURATION
			if(duration == 1) { // Check whether this is the last loop
				engfunc(EngFunc_RemoveEntity, entity) // Get rid of the flare entity
				return HAM_SUPERCEDE;
			}
			flare_lighting(entity, duration) // Light it up!
			
			// Set time for next loop
			set_pev(entity, PEV_FLARE_DURATION, --duration)
			set_pev(entity, pev_dmgtime, current_time + 2.0)
		}
		else if((pev(entity, pev_flags) & FL_ONGROUND) && fm_get_speed(entity) < 10) { // Light up when it's stopped on ground
			static sound[64] // Flare sound
			ArrayGetString(ar_sound[17], random_num(0, ArraySize(ar_sound[17]) - 1), sound, charsmax(sound))
			emit_sound(entity, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Set duration and start lightning loop on next think
			set_pev(entity, PEV_FLARE_DURATION, 1 + get_pcvar_num(cvar_flareduration)/2)
			set_pev(entity, pev_dmgtime, current_time + 0.1)
		}
		else set_pev(entity, pev_dmgtime, current_time + 0.5) // Delay explosion until we hit ground
	}
	return HAM_IGNORED;
}

public fw_CmdStart(id, handle) { // Forward CmdStart
	if(!g_isalive[id]) return;
	
	// This logic looks kinda weird, but it should work in theory...
	// p = g_zombie[id], q = g_hm_special[id] == SURVIVOR, r = g_cached_customflash
	// ¬(p v q v (¬p ^ r)) <==> ¬p ^ ¬q ^ (p v ¬r)
	if(!g_zombie[id] && g_hm_special[id] <= 0 && (g_zombie[id] || !g_cached_customflash)) return;

	if(get_uc(handle, UC_Impulse) != IMPULSE_FLASHLIGHT) return; // Check if it's a flashlight impulse

	set_uc(handle, UC_Impulse, 0) // Block it I say!
	
	// Should human's custom flashlight be turned on?
	if(!g_zombie[id] && g_hm_special[id] <= 0 && g_flashbattery[id] > 2 && get_gametime() - g_lastflashtime[id] > 1.2) {
		g_lastflashtime[id] = get_gametime() // Prevent calling flashlight too quickly (bugfix)
		g_flashlight[id] = !(g_flashlight[id]) // Toggle custom flashlight
		
		emit_sound(id, CHAN_ITEM, cs_sounds[0], 1.0, ATTN_NORM, 0, PITCH_NORM) // Play flashlight toggle sound
		
		// Update flashlight status on the HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, id)
		write_byte(g_flashlight[id]) // toggle
		write_byte(g_flashbattery[id]) // battery
		message_end()
		
		remove_task(id+TASK_CHARGE) // Remove previous tasks
		remove_task(id+TASK_FLASH)
		
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b") // Set the flashlight charge task
		if(g_flashlight[id]) set_task(0.1, "set_user_flashlight", id+TASK_FLASH, _, _, "b") // Call our custom flashlight task if enabled
	}
}
set_player_maxspeed(id) { // Set proper maxspeed for player
	// If frozen, prevent from moving
	if(g_frozen[id]) set_pev(id, pev_maxspeed, 1.0) // prevent from moving
	else { // Otherwise, set maxspeed directly
		if(g_user_custom_speed[id]) set_pev(id, pev_maxspeed, g_current_maxspeed[id])
		else if(g_zombie[id] && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) set_pev(id, pev_maxspeed, g_zm_special[id] > 0 ? get_pcvar_float(cvar_zm_spd[g_zm_special[id]]) : g_spd[id])
		else if(!g_zombie[id] && g_hm_special[id] >= MAX_SPECIALS_HUMANS || g_zombie[id] && g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) set_pev(id, pev_maxspeed, g_spd[id])
		else if(get_pcvar_float(cvar_hm_spd[g_hm_special[id]]) > 0.0) set_pev(id, pev_maxspeed, get_pcvar_float(cvar_hm_spd[g_hm_special[id]]))
	}
}

public fw_PlayerPreThink(id) { // Forward Player PreThink
	if(!g_isalive[id]) return;

	if(g_zombie[id] && g_zm_special[id] == DRAGON) PreThinkDragon(id) // Dragon Skill

	// Enable custom buyzone for player during buytime, unless zombie or survivor or time expired
	if(g_cached_buytime > 0.0 && !g_zombie[id] && !g_hm_special[id] && (get_gametime() < g_buytime[id] + g_cached_buytime))
		if(pev_valid(g_buyzone_ent)) dllfunc(DLLFunc_Touch, g_buyzone_ent, id)
	
	// Silent footsteps for zombies/assassins ?
	if((g_cached_zombiesilent && g_zombie[id] && g_zm_special[id] <= 0)) set_pev(id, pev_flTimeStepSound, STEPTIME_SILENT)
	
	if(g_frozen[id]) { // Set Player MaxSpeed
		set_pev(id, pev_velocity, Float:{0.0,0.0,0.0}) // stop motion
		return; // shouldn't leap while frozen
	}
	
	// --- Check if player should leap ---
	if(g_freezetime) return; // shouldn't leap while in freezetime
	
	// Check if proper CVARs are enabled and retrieve leap settings
	static Float:cooldown, Float:current_time
	if(g_zombie[id]) {
		if(g_zm_special[id] <= 0) {
			switch (g_zm_cached_leap[0]) {
				case 0: return;
				case 2: if(!g_firstzombie[id]) return;
				case 3: if(!g_lastzombie[id]) return;
			}
			cooldown = g_zm_cached_cooldown[0]
		}
		else {
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				if(ArrayGetCell(g_zm_special_leap, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) <= 0) return;
				cooldown = g_custom_leap_cooldown[id]
			}		
			else if(g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(!g_zm_cached_leap[g_zm_special[id]]) return;
				cooldown = g_zm_cached_cooldown[g_zm_special[id]]
			}
		}
	}
	else
	{
		if(g_hm_special[id] <= 0) return;
		else if(g_hm_special[id] < MAX_SPECIALS_HUMANS) {
			if(!g_hm_cached_leap[g_hm_special[id]] && g_hm_special[id] > 0) return;
			cooldown = g_hm_cached_cooldown[g_hm_special[id]]
			
		}
		else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_leap, g_hm_special[id]-MAX_SPECIALS_HUMANS) <= 0) return;
			cooldown = g_custom_leap_cooldown[id]
		}			
	}
	
	current_time = get_gametime()
	if(current_time - g_lastleaptime[id] < cooldown) return; // Cooldown not over yet
	
	// Not doing a longjump (don't perform check for bots, they leap automatically)
	if(!g_isbot[id] && !(pev(id, pev_button) & (IN_JUMP | IN_DUCK) == (IN_JUMP | IN_DUCK))) return;
	
	if(!(pev(id, pev_flags) & FL_ONGROUND) || fm_get_speed(id) < 80) return; // Not on ground or not enough speed
	
	static Float:velocity[3]
	if(g_zombie[id]) {
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			velocity_by_aim(id, ArrayGetCell(g_zm_special_leap_f, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), velocity)
			velocity[2] = Float:ArrayGetCell(g_zm_special_leap_h, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)
		}
		else {
			velocity_by_aim(id, get_pcvar_num(cvar_leap_zm_force[g_zm_special[id]]), velocity)
			velocity[2] = get_pcvar_float(cvar_leap_zm_height[g_zm_special[id]])
		}
	}
	else {
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			velocity_by_aim(id, ArrayGetCell(g_hm_special_leap_f, g_hm_special[id]-MAX_SPECIALS_HUMANS), velocity)
			velocity[2] = Float:ArrayGetCell(g_hm_special_leap_h, g_hm_special[id]-MAX_SPECIALS_HUMANS)
		}
		else {
			velocity_by_aim(id, get_pcvar_num(cvar_leap_hm_force[g_hm_special[id]]), velocity)
			velocity[2] = get_pcvar_float(cvar_leap_hm_height[g_hm_special[id]])
		}
	}
	set_pev(id, pev_velocity, velocity) // Apply the new velocity
	g_lastleaptime[id] = current_time // Update last leap time
}

/*================================================================================
 [Client Commands]
=================================================================================*/
public clcmd_nightvision(id) { // Nightvision toggle
	if(g_nvision[id]) {
		g_nvisionenabled[id] = !(g_nvisionenabled[id]) 
		user_nightvision(id, g_nvisionenabled[id])
	}
	return PLUGIN_HANDLED;
}

public clcmd_drop(id) { // Survivor/Sniper/Berserker/Wesker/Spy should stick with its weapon
	if(g_hm_special[id] > 0) return PLUGIN_HANDLED

	return PLUGIN_CONTINUE;
}
public clcmd_buyammo(id) { 	// Buy BP Ammo or infinite ammo setting enabled
	if(!g_isalive[id] || get_pcvar_num(cvar_hm_infammo[0])) return PLUGIN_HANDLED;
	
	if(g_zombie[id]) { // Not human
		zp_colored_print(id, 1, "%L", id, "CMD_HUMAN_ONLY")
		return PLUGIN_HANDLED;
	}

	// Custom buytime enabled and human player standing in buyzone, allow buying weapon's ammo normally instead
	if(g_cached_buytime > 0.0 && !g_hm_special[id] && (get_gametime() < g_buytime[id] + g_cached_buytime) && cs_get_user_buyzone(id))
		return PLUGIN_CONTINUE;
	
	if(g_ammopacks[id] < 1) { // Not enough ammo packs
		zp_colored_print(id, 1, "%L", id, "NOT_ENOUGH_AMMO")
		return PLUGIN_HANDLED;
	}
	
	// Get user weapons
	static weapons[32], num, i, currentammo, weaponid, refilled
	num = 0 // reset passed weapons count (bugfix)
	refilled = false
	get_user_weapons(id, weapons, num)

	for(i = 0; i < num; i++) { // Loop through them and give the right ammo type
		weaponid = weapons[i] // Prevents re-indexing the array
		if(MAXBPAMMO[weaponid] > 2) { // Primary and secondary only
			currentammo = cs_get_user_bpammo(id, weaponid) // Get current ammo of the weapon
			ExecuteHamB(Ham_GiveAmmo, id, BUYAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid]) // Give additional ammo
			if(cs_get_user_bpammo(id, weaponid) - currentammo > 0) refilled = true // Check whether we actually refilled the weapon's ammo
		}
	}
	
	if(!refilled) return PLUGIN_HANDLED; // Weapons already have full ammo
	
	// Deduce ammo packs, play clip purchase sound, and notify player
	g_ammopacks[id]--
	emit_sound(id, CHAN_ITEM, cs_sounds[1], 1.0, ATTN_NORM, 0, PITCH_NORM)
	zp_colored_print(id, 1, "%L", id, "AMMO_BOUGHT")
	return PLUGIN_HANDLED;
}
public clcmd_changeteam(id) { // Block Team Change
	static team; team = fm_cs_get_user_team(id)
	if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED) return PLUGIN_CONTINUE; // Unless it's a spectator joining the game
	show_menu_game(id) // Pressing 'M' (chooseteam) ingame should show the main menu instead
	return PLUGIN_HANDLED;
}
/*================================================================================
 [Menus]
=================================================================================*/
show_menu_game(id) { // Game Menu
	static menu[250], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	len += formatex(menu[len], charsmax(menu) - len, "\d%L^n^n", id, "ZP_MAIN_MENU_TITLE") /* Title */ 
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", get_pcvar_num(cvar_buycustom) ? "\r1.\w" : "\d1.", id, "MENU_BUY") /* 1. Buy weapons */ 
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (get_pcvar_num(cvar_extraitems) && g_isalive[id]) ? "\r2.\w" : "\d2.", id, "MENU_EXTRABUY") /* 2. Extra items */ 
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", get_pcvar_num(cvar_zclasses) ? "\r3.\w" : "\d3.", id, "MENU_ZCLASS") /* 3. Zombie class */ 
	/* 4. Unstuck */
	ExecuteForward(g_forwards[UNSTUCK_PRE], g_fwDummyResult, id);
	if(g_zombie[id] || !g_zombie[id] && get_pcvar_num(cvar_human_unstuck) || g_fwDummyResult < ZP_PLUGIN_HANDLED) len += formatex(menu[len], charsmax(menu) - len, "\r4.\w %L^n", id,"MENU_UNSTUCK")
	else len += formatex(menu[len], charsmax(menu) - len, "\d4. %L^n", id,"MENU_UNSTUCK")
	
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w %L^n^n", id,"MENU_PERSONAL_OPTIONS") /* 5. Personal Options*/ 
	
	/* 7. Join spec */
	if(!g_isalive[id] || !get_pcvar_num(cvar_blocksuicide) || (userflags & g_access_flag[ACCESS_ADMIN_MENU])) len += formatex(menu[len], charsmax(menu) - len, "\r7.\w %L^n^n", id, "MENU_SPECTATOR")
	else len += formatex(menu[len], charsmax(menu) - len, "\d7. %L^n^n", id, "MENU_SPECTATOR")

	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (userflags & g_access_flag[ACCESS_ADMIN_MENU3]) ? "\r9.\w" : "\d9.", id, "MENU3_ADMIN") /* 9. Admin menu */ 
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r0.\w %L", id, "MENU_EXIT") /* 0. Exit */ 
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	show_menu(id, KEYSMENU, menu, -1, "Game Menu")
}
public menu_buy_show(taskid) {	
	static id // Get player's id
	(taskid > g_maxplayers) ? (id = ID_SPAWN) : (id = taskid);

	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0) return; // Zombies, specials get no guns

	// Automatic selection enabled for player and menu called on spawn event
	if(WPN_AUTO_ON)	{
		buy_weapon(id, WPN_AUTO_PRI, 0)
		buy_weapon(id, WPN_AUTO_SEC, 1)
	}
	else show_menu_buy(id, 0)
}
public show_menu_buy(id, wpn_type) { // Buy Menu
	// Zombies, Specials get no guns
	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0) return;
	
	// Bots pick their weapons randomly / Random weapons setting enabled
	if(get_pcvar_num(cvar_random_weapon[wpn_type]) || g_isbot[id])
	{
		buy_weapon(id, random_num(0, ArraySize(g_weapon_realname[wpn_type]) - 1), wpn_type)
		if(wpn_type == 0) show_menu_buy(id, 1)
		return;
	}
	
	WPN_TYPE = wpn_type

	static menu[300], len, weap, maxloops, weapon_maxids
	len = 0
	weapon_maxids = ArraySize(g_weapon_realname[wpn_type])
	maxloops = min(WPN_STARTID+7, weapon_maxids)

	// Title
	len += formatex(menu[len], charsmax(menu) - len, "\y%L \r[%d-%d]^n^n", id, (wpn_type == 0) ? "MENU_BUY1_TITLE" : "MENU_BUY2_TITLE", WPN_STARTID+1, min(WPN_STARTID+7, weapon_maxids))
	
	// 1-7. Weapon List
	for(weap = WPN_STARTID; weap < maxloops; weap++) {
		g_AdditionalMenuText[0] = 0
		ExecuteForward(g_forwards[WEAPON_SELECTED_PRE], g_fwDummyResult, id, wpn_type, weap);

		static szWeaponName[32]; ArrayGetString(g_weapon_name[wpn_type], weap, szWeaponName, charsmax(szWeaponName))
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) len += formatex(menu[len], charsmax(menu) - len, "\d%d. %s %s^n", weap-WPN_STARTID+1, szWeaponName, g_AdditionalMenuText)
		else len += formatex(menu[len], charsmax(menu) - len, "\r%d.\w %s %s^n", weap-WPN_STARTID+1, szWeaponName, g_AdditionalMenuText)
	}
	len += formatex(menu[len], charsmax(menu) - len, "^n\r8.\w %L \y[%L]", id, "MENU_AUTOSELECT", id, (WPN_AUTO_ON) ? "MOTD_ENABLED" : "MOTD_DISABLED") /* 8. Auto Select */ 
	len += formatex(menu[len], charsmax(menu) - len, "^n^n\r9.\w %L/%L^n^n\r0.\w %L", id, "MENU_NEXT", id, "MENU_BACK", id, "MENU_EXIT") /* 9. Next/Back - 0. Exit */ 
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	show_menu(id, KEYSMENU, menu, -1, "Buy Menu")
}
show_menu_extras(id) { // Extra Items Menu
	static menuid, menu[128], item, team, buffer[32], special_name[128]
	if(g_zombie[id] && g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) ArrayGetString(g_zm_special_name, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) ArrayGetString(g_hm_special_name, g_hm_special[id]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
	else formatex(special_name, charsmax(special_name), "%L", id, g_zombie[id] ? zm_special_class_langs[g_zm_special[id]] : hm_special_class_langs[g_hm_special[id]])
	
	// Title
	formatex(menu, charsmax(menu), "%L [%s]\r", id, "MENU_EXTRA_TITLE", special_name)
	menuid = menu_create(menu, "menu_extras")
	
	// Item List
	for(item = 0; item < g_extraitem_i; item++) {
		g_AdditionalMenuText[0] = 0
		team = ArrayGetCell(g_extraitem_team, item) // Retrieve item's team
		
		// Item not available to player's team/class
		if(g_zombie[id] && !IsTeam(ArrayGetCell(itens_teams_index_zombie, g_zm_special[id]))
		|| !g_zombie[id] && !IsTeam(ArrayGetCell(itens_teams_index_human, g_hm_special[id]))) 
			continue;

		switch (item) { // Check if it's one of the hardcoded items, check availability, set translated caption
			case EXTRA_NVISION: {
				if(!get_pcvar_num(cvar_extranvision) || !g_zombie[id] && get_pcvar_num(cvar_hm_nvggive[0]) || g_zombie[id] && get_pcvar_num(cvar_zm_nvggive[0])) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "NightVision")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA1")
			}
			case EXTRA_ANTIDOTE: {
				if((!get_pcvar_num(cvar_extraantidote) && !g_escape_map) || (!get_pcvar_num(cvar_extraantidote_ze) && g_escape_map) || g_antidotecounter >= get_pcvar_num(cvar_antidotelimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "T-Virus Antidote")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA2")
			}
			case EXTRA_MADNESS: {
				if((!get_pcvar_num(cvar_extramadness) && !g_escape_map) || (!get_pcvar_num(cvar_extramadness_ze) && g_escape_map) || g_madnesscounter >= get_pcvar_num(cvar_madnesslimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "Zombie Madness")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA3")
			}
			case EXTRA_INFBOMB: {
				if((!get_pcvar_num(cvar_extrainfbomb) && !g_escape_map) || (!get_pcvar_num(cvar_extrainfbomb_ze) && g_escape_map) || g_infbombcounter >= get_pcvar_num(cvar_infbomblimit)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
				if(equal(buffer, "Infection Bomb")) formatex(buffer, charsmax(buffer), "%L", id, "MENU_EXTRA4")
			}
			default: {				
				if(item >= EXTRA_WEAPONS_STARTID && item <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons)) continue;
				ArrayGetString(g_extraitem_name, item, buffer, charsmax(buffer))
			}
		}

		ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, item); // Item selected Pre forward
		if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue; // Not Show the Item Extra
			
		// Add Item Name and Cost
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED || g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, item)) {
			formatex(menu, charsmax(menu), "\d%s \d[%d] \d%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)
			buffer[0] = item
			buffer[1] = 0
			menu_additem(menuid, menu, buffer, 0, menu_makecallback("CallbackMenu"));
		}			
		else {
			formatex(menu, charsmax(menu), "%s \r[%d] \w%s", buffer, ArrayGetCell(g_extraitem_cost, item), g_AdditionalMenuText)
			buffer[0] = item
			buffer[1] = 0
			menu_additem(menuid, menu, buffer)
		}
	}
	if(menu_items(menuid) <= 0) { // No items to display?
		zp_colored_print(id, 1, "%L", id ,"CMD_NOT_EXTRAS")
		menu_destroy(menuid)
		return;
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)
	
	MENU_PAGE_EXTRAS = min(MENU_PAGE_EXTRAS, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menuid, MENU_PAGE_EXTRAS)
}

public show_menu_zclass(id) { // Zombie Class Menu
	if(!g_isconnected[id]) return;

	if(g_isbot[id]) { // Bots pick their zombie class randomly
		g_zombieclassnext[id] = random_num(0, g_zclass_i - 1)
		g_choosed_zclass[id] = true
		zombieme(id, 0, 0, 2, 0)
		return;
	}
	
	static menuid, menu[128], class, buffer[32], buffer2[32]
	
	// Title
	formatex(menu, charsmax(menu), "%L\r", id, "MENU_ZCLASS_TITLE")
	menuid = menu_create(menu, "menu_zclass")
	
	for(class = 0; class < g_zclass_i; class++) { // Class List
		g_AdditionalMenuText[0] = 0

		// Retrieve name and info
		ArrayGetString(g_zclass_name, class, buffer, charsmax(buffer))
		ArrayGetString(g_zclass_info, class, buffer2, charsmax(buffer2))

		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, class); // Item selected Pre forward
		if(g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { // Not Show the Zombie Class
			formatex(menu, charsmax(menu), "%s%s \r[\d%s\r] \r%s %s", g_fwDummyResult >= ZP_PLUGIN_HANDLED ? "\d" : "\w", buffer, buffer2, (class == g_zombieclassnext[id]) ? "[\dX\r]" : "[]", g_AdditionalMenuText)
			buffer[0] = class; buffer[1] = 0
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menuid, menu, buffer, 0, menu_makecallback("CallbackMenu"));
			else menu_additem(menuid, menu, buffer)
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)

	MENU_PAGE_ZCLASS = min(MENU_PAGE_ZCLASS, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menuid, MENU_PAGE_ZCLASS)
}

public show_menu_game_mode(id) { // Custom game mode menu
	if(!g_isconnected[id]) return;

	if(g_gamemodes_i == MAX_GAME_MODES) { // No custom game modes registered ?
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_GAME_MODES") // Print a message
		show_menu3_admin(id) // Show the main admin menu and stop
		return;
	}

	static menuid, menu[128], game,  buffer[32] // Create vars necessary for displaying the game modes menu
	
	// Title
	formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_TITLE")
	menuid = menu_create(menu, "menu_mode")

	for(game = MAX_GAME_MODES; game < g_gamemodes_i; game++) { // Game mode List
		ExecuteForward(g_forwards[GM_SELECTED_PRE], g_fwDummyResult, id, game);
		
		if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue;
		
		ArrayGetString(g_gamemode_name, (game - MAX_GAME_MODES), buffer, charsmax(buffer)) // Retrieve the game mode's name
		
		// Check for access flags and other conditions
		if((get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (game - MAX_GAME_MODES))) && allowed_custom_game() && is_gamemode_enable(game) && g_fwDummyResult < ZP_PLUGIN_HANDLED) {	
			formatex(menu, charsmax(menu), "%L %s ", id, "MENU_ADMIN1_CUSTOM", buffer)
			buffer[0] = game
			buffer[1] = 0
			menu_additem(menuid, menu, buffer)
		}
		else {
			formatex(menu, charsmax(menu), "\d%L %s", id, "MENU_ADMIN1_CUSTOM", buffer)
			buffer[0] = game
			buffer[1] = 0
			menu_additem(menuid, menu, buffer, 0, menu_makecallback("CallbackMenu"))
		}
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)
			
	MENU_PAGE_GAMEMODES = min(MENU_PAGE_GAMEMODES, menu_pages(menuid)-1)
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menuid, MENU_PAGE_GAMEMODES)
}

public show_menu_admin(id) { // Admin Menu
	static szText[999], userflags; userflags = get_user_flags(id)
	formatex(szText, charsmax(szText), "\y%L\r", id, "MENU_ADMIN_TITLE")
	
	new menu = menu_create(szText, "menu_admin")
	
	if(g_newround && userflags & (g_access_flag[ACCESS_MODE_INFECTION]) || !g_newround && userflags & (g_access_flag[ACCESS_MAKE_ZOMBIE | ACCESS_MAKE_HUMAN]))
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN1");
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN1");
	menu_additem(menu, szText, "1")
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, NEMESIS);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_NEMESIS : ACCESS_MAKE_NEMESIS]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN2")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN2");

	if(zm_special_enable[NEMESIS] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "2", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "2")
	}
	
	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, SURVIVOR);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SURVIVOR : ACCESS_MAKE_SURVIVOR]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN3")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN3")

	if(hm_special_enable[SURVIVOR] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "3", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "3")
	}

	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, SNIPER);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SNIPER : ACCESS_MAKE_SNIPER]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN8")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN8")

	if(hm_special_enable[SNIPER] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "4", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "4")
	}
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, ASSASSIN);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_ASSASSIN : ACCESS_MAKE_ASSASSIN]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN9")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN9")

	if(zm_special_enable[ASSASSIN] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "5", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "5")
	}
	
	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, BERSERKER);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_BERSERKER : ACCESS_MAKE_BERSERKER]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN13")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN13")

	if(hm_special_enable[BERSERKER] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "6", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "6")
	}
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, PREDATOR);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_PREDATOR : ACCESS_MAKE_PREDATOR]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN11")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN11")

	if(zm_special_enable[PREDATOR] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "7", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "7")
	}
	
	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, WESKER);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_WESKER : ACCESS_MAKE_WESKER]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN14")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN14")

	if(hm_special_enable[WESKER] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "8", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "8")
	}
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, BOMBARDIER);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_BOMBARDIER : ACCESS_MAKE_BOMBARDIER]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN12")
	else formatex(szText, charsmax(szText), "\d%L", id, "MENU_ADMIN12")

	if(zm_special_enable[BOMBARDIER] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "9", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "9")
	}
	
	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, SPY);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SPY : ACCESS_MAKE_SPY]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN15")
	else formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN15")

	if(hm_special_enable[SPY] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "10", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "10")
	}
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, DRAGON);
	if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_DRAGON : ACCESS_MAKE_DRAGON]) && g_fwDummyResult < ZP_PLUGIN_HANDLED)
		formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN16")
	else formatex(szText, charsmax(szText), "\w%L", id, "MENU_ADMIN16")

	if(zm_special_enable[DRAGON] && g_fwDummyResult < ZP_PLUGIN_SUPERCEDE) { 
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) menu_additem(menu, szText, "11", 0, menu_makecallback("CallbackMenu"))
		else menu_additem(menu, szText, "11")
	}
	
	// Back - Next - Exit
	formatex(szText, charsmax(szText), "%L", id, "MENU_BACK"); menu_setprop(menu, MPROP_BACKNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_NEXT"); menu_setprop(menu, MPROP_NEXTNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_EXIT"); menu_setprop(menu, MPROP_EXITNAME, szText)
	
	MENU_PAGE_SPECIAL_CLASS = min(MENU_PAGE_SPECIAL_CLASS, menu_pages(menu)-1)
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menu, MENU_PAGE_SPECIAL_CLASS)
}
// Admin Menu 2
new const menu2_adm_langs[][] = { "MENU_ADMIN17", "MENU_ADMIN18", "MENU_ADMIN19", "MENU_ADMIN20", "MENU_ADMIN21",  "MENU_ADMIN22", "MENU_ADMIN23", 
"MENU_ADMIN24", "MENU_ADMIN25", "MENU_ADMIN26", "MENU_ADMIN27", "MENU_ADMIN5", "MENU_ADMIN6", "MENU_ADMIN7", "MENU_ADMIN10" }
show_menu2_admin(id) {
	static szText[500], szKey[10], userflags, i
	userflags = get_user_flags(id)

	formatex(szText, charsmax(szText), "\y%L\r", id, "MENU2_ADMIN_TITLE")
	new menu = menu_create(szText, "menu2_admin")

	for(i = MODE_INFECTION; i < MAX_GAME_MODES; i++) {
		g_AdditionalMenuText[0] = 0 
		ExecuteForward(g_forwards[GM_SELECTED_PRE], g_fwDummyResult, id, i);

		if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE || allowed_game_mode(i) == -1)
			continue;

		if(i > MODE_INFECTION && i < MAX_GAME_MODES) if(!is_gamemode_enable(i)) continue;

		num_to_str(i, szKey, charsmax(szKey))
		if(userflags & (g_access_flag[i]) && allowed_game_mode(i) && g_fwDummyResult < ZP_PLUGIN_HANDLED) {
			formatex(szText, charsmax(szText), "\w%L %s", id, menu2_adm_langs[i-MODE_INFECTION], g_AdditionalMenuText)
			menu_additem(menu, szText, szKey)
		}
		else {
			formatex(szText, charsmax(szText), "\d%L %s", id, menu2_adm_langs[i-MODE_INFECTION], g_AdditionalMenuText)
			menu_additem(menu, szText, szKey, 0, menu_makecallback("CallbackMenu"))			
		}
	}

	MENU_PAGE_START_MODES = min(MENU_PAGE_START_MODES, menu_pages(menu)-1) // If remembered page is greater than number of pages, clamp down the value

	// Back - Next - Exit
	formatex(szText, charsmax(szText), "%L", id, "MENU_BACK"); menu_setprop(menu, MPROP_BACKNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_NEXT"); menu_setprop(menu, MPROP_NEXTNAME, szText)
	formatex(szText, charsmax(szText), "%L", id, "MENU_EXIT"); menu_setprop(menu, MPROP_EXITNAME, szText)
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menu, MENU_PAGE_START_MODES)
}
// Admin Menu 3
show_menu3_admin(id) {
	static menu[999], len, userflags
	len = 0
	userflags = get_user_flags(id)
	
	len += formatex(menu[len], charsmax(menu) - len, "\y%L^n^n", id, "MENU3_ADMIN_TITLE") // Title
	
	// 1. Admin menu of classes
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (userflags & g_access_flag[ACCESS_ADMIN_MENU]) ? "\r1.\w" : "\d1.", id, "MENU_ADMIN")
		
	// 2. Main Modes admin menu
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (userflags & g_access_flag[ACCESS_ADMIN_MENU2]) ? "\r2.\w" : "\d2.", id, "MENU2_ADMIN")
	
	// 3. Custom modes admin menu
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (userflags & g_access_flag[ACCESS_ADMIN_MENU3]) ? "\r3.\w" : "\d3.", id, "MENU_ADMIN_CUSTOM")
		
	// 4. Respawn Player
	len += formatex(menu[len], charsmax(menu) - len, "%s %L^n", (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS]) ? "\r4.\w" : "\d4.", id, "MENU_ADMIN4")

	// 5 and 6. Make Custom Special Class (Human/Zombie)
	len += formatex(menu[len], charsmax(menu) - len, "\r5.\w %L^n", id, "MENU_ADMIN_CUSTOM_SP_H")
	len += formatex(menu[len], charsmax(menu) - len, "\r6.\w %L^n^n", id, "MENU_ADMIN_CUSTOM_SP_Z")

	// 0. Exit
	len += formatex(menu[len], charsmax(menu) - len, "^n\r0.\w %L", id, "MENU_EXIT")
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	show_menu(id, KEYSMENU, menu, -1, "Menu3 Admin")
}
public show_menu_make_special(id, zombie) {
	if(!g_isconnected[id]) return; // Player disconnected
	
	// No custom game modes registered ?
	if(g_hm_specials_i == MAX_SPECIALS_HUMANS && !zombie || g_zm_specials_i == MAX_SPECIALS_ZOMBIES && zombie) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_CUSTOM_SP") // Print a message
		show_menu3_admin(id) // Show the main admin menu and stop
		return;
	}
	
	static menuid, menu[128], i, szTempid[10], buffer[32] // Create vars necessary for displaying the game modes menu
	
	if(zombie) {
		formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_SP_Z") // Title
		menuid = menu_create(menu, "custom_zm_sp_handler")
		
		for(i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++) {
			if(ArrayGetCell(g_zm_special_enable, (i - MAX_SPECIALS_ZOMBIES)) == 0) continue;
				
			ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, i);
			if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue;

			ArrayGetString(g_zm_special_name, (i - MAX_SPECIALS_ZOMBIES), buffer, charsmax(buffer)) // Retrieve the game mode's name
			
			// Check for access flags and other conditions
			if(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, i-MAX_SPECIALS_ZOMBIES) && g_fwDummyResult < ZP_PLUGIN_HANDLED) {
				formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
				num_to_str(i, szTempid, 9);
				menu_additem(menuid, menu, szTempid)
			}
			else {
				formatex(menu, charsmax(menu), "\d%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
				num_to_str(i, szTempid, 9);
				menu_additem(menuid, menu, szTempid, 0, menu_makecallback("CallbackMenu"))
			}
		}
		if(menu_items(menuid) <= 0) { // No items to display?
			zp_colored_print(id, 1, "%L", id, "CMD_NOT_CUSTOM_SP") // Print a message
			show_menu3_admin(id)
			menu_destroy(menuid)
			return;
		}
		
		// Back - Next - Exit
		formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
		formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
		formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)
		
		MENU_PAGE_CUSTOM_SP_Z = min(MENU_PAGE_CUSTOM_SP_Z, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value

		if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

		menu_display(id, menuid, MENU_PAGE_CUSTOM_SP_Z)
	}
	else {
		formatex(menu, charsmax(menu), "%L \r", id, "MENU_ADMIN_CUSTOM_SP_H") // Title
		menuid = menu_create(menu, "custom_hm_sp_handler")
		
		for(i = MAX_SPECIALS_HUMANS; i < g_hm_specials_i; i++) {
			if(ArrayGetCell(g_hm_special_enable, i - MAX_SPECIALS_HUMANS) == 0) continue;
				
			ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, i);
			if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue

			ArrayGetString(g_hm_special_name, (i - MAX_SPECIALS_HUMANS), buffer, charsmax(buffer)) // Retrieve the game mode's name
			
			// Check for access flags and other conditions
			if(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, i-MAX_SPECIALS_HUMANS) && g_fwDummyResult < ZP_PLUGIN_HANDLED) {
				formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
				num_to_str(i, szTempid, 9);
				menu_additem(menuid, menu, szTempid)
			}
			else {
				formatex(menu, charsmax(menu), "\d%L", id, "MENU_MAKE_CUSTOM_SP", buffer)
				num_to_str(i, szTempid, 9);
				menu_additem(menuid, menu, szTempid, 0, menu_makecallback("CallbackMenu"))
			}
		}
		if(menu_items(menuid) <= 0) { // No items to display?
			zp_colored_print(id, 1, "%L", id, "CMD_NOT_CUSTOM_SP") // Print a message
			show_menu3_admin(id)
			menu_destroy(menuid)
			return;
		}
		
		// Back - Next - Exit
		formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
		formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
		formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)
		
		
		MENU_PAGE_CUSTOM_SP_H = min(MENU_PAGE_CUSTOM_SP_H, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value

		if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

		menu_display(id, menuid, MENU_PAGE_CUSTOM_SP_H)
	}	
}
public custom_hm_sp_handler(id, menuid, item) {
	if(!is_user_connected(id)) {
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}

	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_CUSTOM_SP_H)
	if(item == MENU_EXIT) {
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	static data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	PL_ACTION = str_to_num(data)
	
	ExecuteForward(g_forwards[HM_SP_CHOSSED_PRE], g_fwDummyResult, id, PL_ACTION);

	if(ArrayGetCell(g_hm_special_enable, PL_ACTION-MAX_SPECIALS_HUMANS) == 0 || g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	if(!(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, PL_ACTION-MAX_SPECIALS_HUMANS))) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	make_user_sp_pl(id, 0)
	return PLUGIN_CONTINUE
}
public custom_zm_sp_handler(id, menuid, item) {
	if(!is_user_connected(id)) {
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_CUSTOM_SP_Z)

	if(item == MENU_EXIT) {
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	static data[6], iName[64], access, callback
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback)
	PL_ACTION = str_to_num(data)
	
	ExecuteForward(g_forwards[ZM_SP_CHOSSED_PRE], g_fwDummyResult, id, PL_ACTION);
	
	if(ArrayGetCell(g_zm_special_enable, PL_ACTION-MAX_SPECIALS_ZOMBIES) == 0 || g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	if(!(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, PL_ACTION-MAX_SPECIALS_ZOMBIES))) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	
	make_user_sp_pl(id, 1)
	return PLUGIN_CONTINUE
}
public make_user_sp_pl(id, zombie) {
	
	new menu[256], special_name[128], player, szTempid[10]
	if(zombie) ArrayGetString(g_zm_special_name, PL_ACTION-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else ArrayGetString(g_hm_special_name, PL_ACTION-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
	
	formatex(menu, charsmax(menu), "%L", id, "MENU_MAKE_CUSTOM_SP", special_name)
	new menuid = menu_create(menu, "make_custom_sp")

	// Player List
	for(player = 1; player <= g_maxplayers; player++) {
		if(!g_isconnected[player]) continue; // Skip if not connected
		
		if(g_zombie[player] && g_zm_special[player] >= MAX_SPECIALS_ZOMBIES) ArrayGetString(g_zm_special_name, g_zm_special[player]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
		else if(!g_zombie[player] && g_hm_special[player] >= MAX_SPECIALS_HUMANS) ArrayGetString(g_hm_special_name, g_hm_special[player]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
		else formatex(special_name, charsmax(special_name), "%L", id, g_zombie[player] ? zm_special_class_langs[g_zm_special[player]] : hm_special_class_langs[g_hm_special[player]])

		// Format text depending on the action to take
		if(allowed_special(player, zombie, PL_ACTION)) formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
		else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
		
		// Add player
		formatex(szTempid, charsmax(szTempid), zombie ? "Z:%d" : "H:%d", player)
		menu_additem(menuid, menu, szTempid)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)

	MENU_PAGE_PLAYERS = min(MENU_PAGE_PLAYERS, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menuid, MENU_PAGE_PLAYERS)
	return PLUGIN_CONTINUE
}
public make_custom_sp(id, menuid, item) {
	if(!is_user_connected(id)) {
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}

	static data[6], iName[64], access, callback, player, menudummy
	menu_item_getinfo(menuid, item, access, data, 5, iName, 63, callback) 
	player_menu_info(id, menudummy, menudummy, MENU_PAGE_PLAYERS) // Remember player's menu page
	player = str_to_num(data[2])
	
	if(data[0] == 'H') {
		if(item == MENU_EXIT) {
			menu_destroy(menuid)
			show_menu_make_special(id, 0)
			return PLUGIN_HANDLED;
		}
		if(ArrayGetCell(g_hm_special_enable, PL_ACTION-MAX_SPECIALS_HUMANS) == 0) {
			zp_colored_print(id, 1, "%L", id, "CMD_NOT")
			menu_destroy(menuid)
			show_menu_make_special(id, 0)
			return PLUGIN_HANDLED;
		}
		if(!(get_user_flags(id) & ArrayGetCell(g_hm_special_flags, PL_ACTION-MAX_SPECIALS_HUMANS))) {
			zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			menu_destroy(menuid)
			show_menu_make_special(id, 0)
			return PLUGIN_HANDLED;
		}
		if(allowed_special(player, 0, PL_ACTION)) command_custom_special(id, player, PL_ACTION, 0)
		else zp_colored_print(id, 1, "%L", id, "CMD_NOT")

		make_user_sp_pl(id, 0)
	}
	else {
		if(item == MENU_EXIT) {
			menu_destroy(menuid)
			show_menu_make_special(id, 1)
			return PLUGIN_HANDLED;
		}
		if(ArrayGetCell(g_zm_special_enable, PL_ACTION-MAX_SPECIALS_ZOMBIES) == 0) {
			zp_colored_print(id, 1, "%L", id, "CMD_NOT")
			menu_destroy(menuid)
			show_menu_make_special(id, 1)
			return PLUGIN_HANDLED;
		}
		if(!(get_user_flags(id) & ArrayGetCell(g_zm_special_flags, PL_ACTION-MAX_SPECIALS_ZOMBIES))) {
			zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			menu_destroy(menuid)
			show_menu_make_special(id, 1)
			return PLUGIN_HANDLED;
		}
		if(allowed_special(player, 1, PL_ACTION)) command_custom_special(id, player, PL_ACTION, 1)
		else zp_colored_print(id, 1, "%L", id, "CMD_NOT")

		make_user_sp_pl(id, 1)
	}
	return PLUGIN_HANDLED;
}

show_menu_player_list(id) { // Player List Menu
	static menuid, menu[9999], player, userflags, buffer[4], special_name[128]
	userflags = get_user_flags(id)

	switch (PL_ACTION) { // Title
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
	
	for(player = 1; player <= g_maxplayers; player++) { // Player List
		if(!g_isconnected[player]) continue;

		if(g_zombie[player] && g_zm_special[player] >= MAX_SPECIALS_ZOMBIES) ArrayGetString(g_zm_special_name, g_zm_special[player]-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
		else if(!g_zombie[player] && g_hm_special[player] >= MAX_SPECIALS_HUMANS) ArrayGetString(g_hm_special_name, g_hm_special[player]-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))
		else formatex(special_name, charsmax(special_name), "%L", id, g_zombie[player] ? zm_special_class_langs[g_zm_special[player]] : hm_special_class_langs[g_hm_special[player]])

		switch (PL_ACTION) { // Format text depending on the action to take
			case ACTION_ZOMBIEFY_HUMANIZE: {  // Zombiefy/Humanize command
				if(!g_zombie[player] && allowed_zombie(player) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_INFECTION : ACCESS_MAKE_ZOMBIE]))
				|| g_zombie[player] && allowed_human(player) && (userflags & g_access_flag[ACCESS_MAKE_HUMAN]))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_NEMESIS: { // Nemesis command
				if(allowed_special(player, 1, NEMESIS) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_NEMESIS : ACCESS_MAKE_NEMESIS])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SURVIVOR: { // Survivor command
				if(allowed_special(player, 0, SURVIVOR) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_SURVIVOR : ACCESS_MAKE_SURVIVOR])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SNIPER: { // Sniper command
				if(allowed_special(player, 0, SNIPER) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_SNIPER : ACCESS_MAKE_SNIPER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_ASSASSIN: { // Assassin command
				if(allowed_special(player, 1, ASSASSIN) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_ASSASSIN : ACCESS_MAKE_ASSASSIN])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_PREDATOR: { // Predator command
				if(allowed_special(player, 1, PREDATOR) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_PREDATOR : ACCESS_MAKE_PREDATOR])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_BOMBARDIER: { // Bombardier command
				if(allowed_special(player, 1, BOMBARDIER) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_BOMBARDIER : ACCESS_MAKE_BOMBARDIER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_BERSERKER: { // Berserker command
				if(allowed_special(player, 0, BERSERKER) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_BERSERKER : ACCESS_MAKE_BERSERKER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_WESKER: { // Wesker command
				if(allowed_special(player, 0, WESKER) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_WESKER : ACCESS_MAKE_WESKER])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_SPY: { // Spy command
				if(allowed_special(player, 0, SPY) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_SPY : ACCESS_MAKE_SPY])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}
			case ACTION_MAKE_DRAGON: { // Dragon command
				if(allowed_special(player, 1, DRAGON) && ((userflags & g_access_flag[g_newround ? ACCESS_MODE_DRAGON : ACCESS_MAKE_DRAGON])))
					formatex(menu, charsmax(menu), "%s %s[%s]", g_playername[player], g_zombie[player] ? "\r" : "\y", special_name)
				else formatex(menu, charsmax(menu), "\d%s [%s]", g_playername[player], special_name)
			}		
			case ACTION_RESPAWN_PLAYER: { // Respawn command
				if(allowed_respawn(player) && (userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS])) formatex(menu, charsmax(menu), "%s", g_playername[player])
				else formatex(menu, charsmax(menu), "\d%s", g_playername[player])
			}
		}
		
		// Add player
		buffer[0] = player; buffer[1] = 0
		menu_additem(menuid, menu, buffer)
	}
	
	// Back - Next - Exit
	formatex(menu, charsmax(menu), "%L", id, "MENU_BACK"); menu_setprop(menuid, MPROP_BACKNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_NEXT"); menu_setprop(menuid, MPROP_NEXTNAME, menu)
	formatex(menu, charsmax(menu), "%L", id, "MENU_EXIT"); menu_setprop(menuid, MPROP_EXITNAME, menu)

	MENU_PAGE_PLAYERS = min(MENU_PAGE_PLAYERS, menu_pages(menuid)-1) // If remembered page is greater than number of pages, clamp down the value
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menuid, MENU_PAGE_PLAYERS)
	return PLUGIN_CONTINUE;
}

/*================================================================================
 [Menu Handlers]
=================================================================================*/
public menu_game(id, key) { // Game Menu
	switch (key) {
		case 0: { // Buy Weapons
			if(get_pcvar_num(cvar_buycustom)) { // Custom buy menus enabled?
				WPN_AUTO_ON = 0 // Disable the remember selection setting
				zp_colored_print(id, 1, "%L", id, "BUY_ENABLED")

				// Show menu if player hasn't yet bought anything
				if(g_canbuy[id] == 2) show_menu_buy(id, 0)
				else if(g_canbuy[id] == 1) show_menu_buy(id, 1)
			}
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		}
		case 1: { // Extra Items
			
			if(get_pcvar_num(cvar_extraitems)) { // Extra items enabled?
				// Check whether the player is able to buy anything
				if(g_newround && !get_pcvar_num(cvar_allow_buy_no_start)) zp_colored_print(id, 1, "%L", id, "WAIT_ROUND_BEGINS")
				else if(g_endround) zp_colored_print(id, 1, "%L", id, "ROUND_ENDED")
				else if(g_isalive[id]) show_menu_extras(id)
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
			}
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_EXTRAS")
		}
		case 2: { // Zombie Classes
			if(get_pcvar_num(cvar_zclasses)) show_menu_zclass(id) // Zombie classes enabled?
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ZCLASSES")
		}
		case 3: { // Unstuck
			if(g_isalive[id]) { // Check if player is stuck
				ExecuteForward(g_forwards[UNSTUCK_PRE], g_fwDummyResult, id);

				if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
					zp_colored_print(id, 1, "%L", id, "CMD_NOT")
					return PLUGIN_HANDLED;
				}
				else if(!g_zombie[id] && !get_pcvar_num(cvar_human_unstuck))
					zp_colored_print(id, 1, "%L", id, "CMD_ZOMBIE_ONLY")
				else {
					if(is_player_stuck(id)) {
						// Move to an initial spawn
						if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
						else do_random_spawn(id, 1) // regular spawn
					}
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT_STUCK")
				}
			}
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		}
		case 4: show_menu_personal(id) // Personal Options
		case 6: { // Player alive?
			if(g_isalive[id]) {
				// Prevent abuse by non-admins if block suicide setting is enabled
				if(get_pcvar_num(cvar_blocksuicide) && !(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU])) {
					zp_colored_print(id, 1, "%L", id, "CMD_NOT")
					return PLUGIN_HANDLED;
				}
				check_round(id) // Check that we still have both humans and zombies to keep the round going
				dllfunc(DLLFunc_ClientKill, id) // Kill him before he switches team
			}
			if(get_pcvar_num(cvar_statssave)) save_stats(id) // Temporarily save player stats?
			
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
		case 8: { // Admin Menu
			// Check if player has the required access
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3]) show_menu3_admin(id)
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		}
	}
	return PLUGIN_HANDLED;
}
public menu_buy(id, key) { // Buy Menu
	if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] > 0) return PLUGIN_HANDLED;
	
	// Special keys / weapon list exceeded
	if(key >= MENU_KEY_AUTOSELECT || WPN_SELECTION >= ArraySize(g_weapon_name[WPN_TYPE])) {
		switch (key) {
			case MENU_KEY_AUTOSELECT: WPN_AUTO_ON = 1 - WPN_AUTO_ON // toggle auto select
			case MENU_KEY_NEXT: { // next/back
				if(WPN_STARTID+7 < ArraySize(g_weapon_name[WPN_TYPE])) WPN_STARTID += 7
				else WPN_STARTID = 0
			}
			case MENU_KEY_EXIT: return PLUGIN_HANDLED; // exit
		}
		show_menu_buy(id, WPN_TYPE) // Show buy menu again
		return PLUGIN_HANDLED;
	}
	if(WPN_TYPE == 0) {
		WPN_AUTO_PRI = WPN_SELECTION // Store selected weapon id
		buy_weapon(id, WPN_AUTO_PRI, 0) // Buy primary weapon
		WPN_STARTID = 0
		show_menu_buy(id, 1) // Show pistols menu
	}
	else {
		WPN_AUTO_SEC = WPN_SELECTION // Store selected weapon id
		buy_weapon(id, WPN_AUTO_SEC, 1) // Buy primary weapon
	}
	
	return PLUGIN_HANDLED;
}
buy_weapon(id, selection, sec) { // Buy Primary/Secondary Weapon
	static weaponid, wname[32]

	// Small Bug Prevention
	if(sec > 1) sec = 1
	if(sec < 0) sec = 0

	ExecuteForward(g_forwards[WEAPON_SELECTED_PRE], g_fwDummyResult, id, sec, selection);
		
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
		WPN_AUTO_ON = 0
		show_menu_buy(id, sec)
		return;
	}
	if(!sec) {
		drop_weapons(id, 1) // Drop previous weapons
		fm_strip_user_weapons(id) // Strip off from weapons
		fm_give_item(id, "weapon_knife")

		// Give additional items
		for(new i = 0; i < ArraySize(g_additional_items); i++) {
			ArrayGetString(g_additional_items, i, wname, charsmax(wname))
			fm_give_item(id, wname)
		}
	}
	drop_weapons(id, 2) // Drop secondary gun

	if(!ArrayGetCell(g_weapon_is_custom[sec], selection)) {
		// Get weapon's id and name
		weaponid = ArrayGetCell(g_weapon_ids[sec], selection)
		ArrayGetString(g_weapon_realname[sec], selection, wname, charsmax(wname))
		
		// Give the new weapon and full ammo
		fm_give_item(id, wname)
		ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid])
	}
	g_canbuy[id] = sec ? 0 : 1 // Weapons bought
	ExecuteForward(g_forwards[WEAPON_SELECTED_POST], g_fwDummyResult, id, sec, selection);
}
public menu_extras(id, menuid, item) { // Extra Items Menu
	if(!is_user_connected(id)) { // Player disconnected?
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}

	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_EXTRAS)
	
	if(item == MENU_EXIT) { // Menu was closed
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	if(!g_isalive[id]) { // Dead players are not allowed to buy items
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	static buffer[2], dummy, itemid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	itemid = buffer[0]
	
	ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid); // Item selected Pre forward

	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}

	buy_extra_item(id, itemid) // Attempt to buy the item
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}
buy_extra_item(id, itemid, ignorecost = 0) { // Buy Extra Item
	static team; team = ArrayGetCell(g_extraitem_team, itemid)

	if(g_zombie[id] && !IsTeam(ArrayGetCell(itens_teams_index_zombie, g_zm_special[id])) || !g_zombie[id] && !IsTeam(ArrayGetCell(itens_teams_index_human, g_hm_special[id]))) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		return;
	}
	
	// Check for unavailable items
	if((itemid == EXTRA_NVISION && !get_pcvar_num(cvar_extranvision)) || (itemid == EXTRA_ANTIDOTE && ((!get_pcvar_num(cvar_extraantidote) && !g_escape_map)|| (!get_pcvar_num(cvar_extraantidote_ze) && g_escape_map)
	|| g_antidotecounter >= get_pcvar_num(cvar_antidotelimit))) || (itemid == EXTRA_MADNESS && ((!get_pcvar_num(cvar_extramadness) && !g_escape_map) || (!get_pcvar_num(cvar_extramadness_ze) && g_escape_map)
	|| g_madnesscounter >= get_pcvar_num(cvar_madnesslimit))) || (itemid == EXTRA_INFBOMB && ((!get_pcvar_num(cvar_extrainfbomb) && !g_escape_map) || (!get_pcvar_num(cvar_extrainfbomb_ze) && g_escape_map) || g_endround || g_newround && !get_pcvar_num(cvar_allow_buy_no_start)
	|| g_infbombcounter >= get_pcvar_num(cvar_infbomblimit))) || (itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1 && !get_pcvar_num(cvar_extraweapons))) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		return;
	}
	// Check for hard coded items with special conditions
	if((itemid == EXTRA_ANTIDOTE && (g_endround || g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI || fnGetZombies() <= 1 || (get_pcvar_num(cvar_deathmatch) && !get_pcvar_num(cvar_respawnafterlast) && fnGetHumans() == 1)))
	|| (itemid == EXTRA_INFBOMB && (g_endround || g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI))) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_CANTUSE")
		return;
	}
	if(itemid == EXTRA_ANTIDOTE && native_get_zombie_count() < get_pcvar_num(cvar_antidote_minzms)) {
		zp_colored_print(id, 1, "%L", id, "ANTIDOTE_NOT_AVALIABLE1", get_pcvar_num(cvar_antidote_minzms))
		return;
	}
	if(itemid == EXTRA_NVISION && g_nvision[id] || itemid == EXTRA_MADNESS && g_nodamage[id]) {
		zp_colored_print(id, 1, "%L", id, "CMD_HAVE_ITEM")
		return;
	}

	if(itemid == EXTRA_MADNESS && g_madness_used[id] && get_pcvar_float(cvar_madness_use_countdown) > 0.0) {
		zp_colored_print(id, 1, "%L", id, "CMD_WAIT_USE")
		return;
	}

	if(!ignorecost) { // Ignore item's cost?
		// Check that we have enough ammo packs
		if(g_ammopacks[id] < ArrayGetCell(g_extraitem_cost, itemid)) {
			zp_colored_print(id, 1, "%L", id, "NOT_ENOUGH_AMMO")
			return;
		}
		g_ammopacks[id] -= ArrayGetCell(g_extraitem_cost, itemid) // Deduce item cost
	}
	if(g_isbot[id]) g_bot_extra_count[id]++

	ExecuteForward(g_forwards[ITEM_SELECTED_PRE], g_fwDummyResult, id, itemid); // Item selected pre forward
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) { // Item purchase blocked, restore buyer's ammo packs
		if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
		show_menu_extras(id)
		return;
	}
	ExecuteForward(g_forwards[ITEM_SELECTED_POST], g_fwDummyResult, id, itemid); // Item selected post forward
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) { // Item purchase blocked, restore buyer's ammo packs
		if(!ignorecost) g_ammopacks[id] += ArrayGetCell(g_extraitem_cost, itemid)
		return;
	}

	switch (itemid) { // Check which kind of item we're buying
		case EXTRA_NVISION: { // Night Vision
			g_nvision[id] = true
			if(!g_isbot[id]) {
				g_nvisionenabled[id] = true
				user_nightvision(id, 1)
			}
			else cs_set_user_nvg(id, 1)
		}
		case EXTRA_ANTIDOTE: {
			g_antidotecounter++ // Increase antidote purchase count for this round
			humanme(id, 0, 0)
		}
		case EXTRA_MADNESS: { // Zombie Madness
			g_madnesscounter++ // Increase madness purchase count for this round
			g_nodamage[id] = true
			g_madness_used[id] = true
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
			set_task(get_pcvar_float(cvar_madnessduration), "madness_over", id+TASK_BLOOD)
			set_pev(id, pev_takedamage, DAMAGE_NO)
			
			if(ArraySize(ar_sound[9]) > 0) {
				static sound[64]
				ArrayGetString(ar_sound[9], random_num(0, ArraySize(ar_sound[9]) - 1), sound, charsmax(sound))
				emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			}
		}
		case EXTRA_INFBOMB: { // Infection Bomb
			g_infbombcounter++ // Increase infection bomb purchase count for this round			
			if(user_has_weapon(id, CSW_HEGRENADE)) { // Already own one
				cs_set_user_bpammo(id, CSW_HEGRENADE, cs_get_user_bpammo(id, CSW_HEGRENADE) + 1) // Increase BP ammo on it instead

				// Flash ammo in hud
				message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
				write_byte(AMMOID[CSW_HEGRENADE]) // ammo id
				write_byte(1) // ammo amount
				message_end()

				emit_sound(id, CHAN_ITEM, cs_sounds[1], 1.0, ATTN_NORM, 0, PITCH_NORM) // Play clip purchase sound

				return; // stop here
			}

			fm_give_item(id, "weapon_hegrenade") // Give weapon to the player

			if(g_isbot[id] && user_has_weapon(id, CSW_HEGRENADE)) {
				engclient_cmd(id, "weapon_hegrenade");
				if(pev_valid(id) == PDATA_SAFE) ExecuteHam(Ham_Weapon_PrimaryAttack, get_pdata_cbase(id, 373, 5));
			}
		}
		default: {
			if(itemid >= EXTRA_WEAPONS_STARTID && itemid <= EXTRAS_CUSTOM_STARTID-1) { // Weapons
				static weaponid, wname[32]
				ArrayGetString(g_extraweapon_items, itemid - EXTRA_WEAPONS_STARTID, wname, charsmax(wname))
				weaponid = cs_weapon_name_to_id(wname)
				
				if(MAXBPAMMO[weaponid] > 2) { // If we are giving a primary/secondary weapon
					if((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM) drop_weapons(id, 1)
					else drop_weapons(id, 2)

					ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[weaponid], AMMOTYPE[weaponid], MAXBPAMMO[weaponid]) // Give full BP ammo for the new one
				}
				else if(user_has_weapon(id, weaponid)) { // If we are giving a grenade which the user already owns
					cs_set_user_bpammo(id, weaponid, cs_get_user_bpammo(id, weaponid) + 1) // Increase BP ammo on it instead
					
					// Flash ammo in hud
					message_begin(MSG_ONE_UNRELIABLE, g_msgAmmoPickup, _, id)
					write_byte(AMMOID[weaponid]) // ammo id
					write_byte(1) // ammo amount
					message_end()

					emit_sound(id, CHAN_ITEM, cs_sounds[1], 1.0, ATTN_NORM, 0, PITCH_NORM) // Play clip purchase sound
					return; // stop here
				}
				
				fm_give_item(id, wname) // Give weapon to the player
			}
		}
	}
}
public menu_zclass(id, menuid, item) { // Zombie Class Menu?
	if(!is_user_connected(id)) {
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}	
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_ZCLASS) // Remember player's menu page
	
	if(item == MENU_EXIT) { // Menu was closed
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}

	static buffer[2], dummy, classid
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	classid = buffer[0]
	
	if(g_isalive[id] && g_zombie[id] && g_zm_special[id] <= 0 && !g_choosed_zclass[id] && get_pcvar_num(cvar_chosse_instantanly)) {
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid); // Class selected Pre forward
	
		// Not Show the Zombie Class
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
			show_menu_zclass(id)
			menu_destroy(menuid)
			return PLUGIN_HANDLED;
		}
		
		g_zombieclassnext[id] = classid
		g_choosed_zclass[id] = true
		zombieme(id, 0, 0, 2, 0)

		static name[32]; ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))

		// Show selected zombie class info and stats
		zp_colored_print(id, 1, "%L^x01:^x04 %s", id, "ZOMBIE_SELECT_NOW", name)
		zp_colored_print(id, 1, "%L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
		id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))

		ExecuteForward(g_forwards[CLASS_CHOOSED_POST], g_fwDummyResult, id, classid);
	}
	else {
		ExecuteForward(g_forwards[CLASS_CHOOSED_PRE], g_fwDummyResult, id, classid); // Class selected Pre forward
						
		// Not Show the Zombie Class
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
			show_menu_zclass(id)
			menu_destroy(menuid)
			return PLUGIN_HANDLED;
		}

		// Store selection for the next infection
		g_zombieclassnext[id] = classid
		if(!g_choosed_zclass[id]) g_choosed_zclass[id] = true

		static name[32]; ArrayGetString(g_zclass_name, g_zombieclassnext[id], name, charsmax(name))
		
		// Show selected zombie class info and stats
		zp_colored_print(id, 1, "%L^x01:^x04 %s", id, "ZOMBIE_SELECT", name)
		zp_colored_print(id, 1, "%L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d^x01 |^x01 %L^x01:^x04 %d%%", id, "ZOMBIE_ATTRIB1", ArrayGetCell(g_zclass_hp, g_zombieclassnext[id]), id, "ZOMBIE_ATTRIB2", ArrayGetCell(g_zclass_spd, g_zombieclassnext[id]),
		id, "ZOMBIE_ATTRIB3", floatround(Float:ArrayGetCell(g_zclass_grav, g_zombieclassnext[id]) * 800.0), id, "ZOMBIE_ATTRIB4", floatround(Float:ArrayGetCell(g_zclass_kb, g_zombieclassnext[id]) * 100.0))

		ExecuteForward(g_forwards[CLASS_CHOOSED_POST], g_fwDummyResult, id, classid);
	}
	menu_destroy(menuid)
	return PLUGIN_HANDLED;
}
public menu_mode(id, menuid, item) { // Custom game mode menu
	if(!is_user_connected(id)) {
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_GAMEMODES) // Remember gamemode's menu page

	if(item == MENU_EXIT) {
		menu_destroy(menuid)
		show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}

	static buffer[2], dummy , gameid // Create some necassary vars
	
	// Retrieve the id of the game mode which was chosen
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	gameid = buffer[0]
	
	ExecuteForward(g_forwards[GM_SELECTED_PRE], g_fwDummyResult, id, gameid);
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT")
		show_menu_game_mode(id)
		return PLUGIN_HANDLED;
	}
	
	if(get_user_flags(id) & ArrayGetCell(g_gamemode_flag, (gameid - MAX_GAME_MODES))) { // Check users access level
		// Only allow the game mode to proceed after some checks
		if(allowed_custom_game() && is_gamemode_enable(gameid)) command_custom_game(gameid, id)
		else zp_colored_print(id, 1, "%L", id, "CMD_NOT")

		show_menu_game_mode(id) // Show the menu again
		return PLUGIN_HANDLED;
	}
	else {
		zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS") // Player deosnt haves the required access level
		show_menu_game_mode(id) // Show the menu again
	}
	menu_destroy(menuid);
	return PLUGIN_HANDLED;
}
public menu_admin(id, menu, item) { // Admin Menu
	if(!is_user_connected(id)) {
		menu_destroy(menu)
		return PLUGIN_HANDLED;
	}
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_SPECIAL_CLASS)
	
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu3_admin(id)
		return PLUGIN_HANDLED
	}

	static userflags; userflags = get_user_flags(id)

	static data[6], iName[64], access, callback, key
	menu_item_getinfo(menu, item, access, data, 6, iName, 63, callback)
	key = str_to_num(data)  
	
	switch (key) {
		case 1: { // Zombiefy/Humanize command
			if(g_newround && userflags & (g_access_flag[ACCESS_MODE_INFECTION])
			|| !g_newround && userflags & (g_access_flag[ACCESS_MAKE_ZOMBIE] | g_access_flag[ACCESS_MAKE_HUMAN])) {
				PL_ACTION = ACTION_ZOMBIEFY_HUMANIZE
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 2: { // Nemesis command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_NEMESIS : ACCESS_MAKE_NEMESIS])) {
				PL_ACTION = ACTION_MAKE_NEMESIS
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 3: { // Survivor command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SURVIVOR : ACCESS_MAKE_SURVIVOR])) {
				PL_ACTION = ACTION_MAKE_SURVIVOR
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 4: { // Sniper command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SNIPER : ACCESS_MAKE_SNIPER])) {
				PL_ACTION = ACTION_MAKE_SNIPER // Show player list for admin to pick a target
				show_menu_player_list(id)
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 5: { // Assassin command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_ASSASSIN : ACCESS_MAKE_ASSASSIN])) {
				PL_ACTION = ACTION_MAKE_ASSASSIN
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 6: { // Berserker command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_BERSERKER : ACCESS_MAKE_BERSERKER])) {
				PL_ACTION = ACTION_MAKE_BERSERKER
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}		
		case 7: { // Predator command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_PREDATOR : ACCESS_MAKE_PREDATOR])) {
				PL_ACTION = ACTION_MAKE_PREDATOR
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 8: { // Wesker command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_WESKER : ACCESS_MAKE_WESKER])) {
				PL_ACTION = ACTION_MAKE_WESKER
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 9: { // Bombardier command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_BOMBARDIER : ACCESS_MAKE_BOMBARDIER])) {
				PL_ACTION = ACTION_MAKE_BOMBARDIER
				show_menu_player_list(id) // Show player list for admin to pick a target
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 10: { // Spy command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_SPY : ACCESS_MAKE_SPY])) {
				PL_ACTION = ACTION_MAKE_SPY
				show_menu_player_list(id)
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
		case 11: { // Dragon command
			if(userflags & (g_access_flag[g_newround ? ACCESS_MODE_DRAGON : ACCESS_MAKE_DRAGON])) {
				PL_ACTION = ACTION_MAKE_DRAGON
				show_menu_player_list(id)
			}
			else {
				zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
				show_menu_admin(id)
			}
		}
	}
	return PLUGIN_HANDLED;
}
public menu2_admin(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu3_admin(id)
		return PLUGIN_HANDLED
	}

	// Remember player's menu page
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_START_MODES)
	static userflags; userflags = get_user_flags(id)
	static data[6], iName[64], access, callback, key
	menu_item_getinfo(menu, item, access, data, 6, iName, 63, callback)
	key = str_to_num(data)

	ExecuteForward(g_forwards[GM_SELECTED_PRE], g_fwDummyResult, id, key);
	
	if((userflags & g_access_flag[key]) && allowed_game_mode(key) && g_fwDummyResult < ZP_PLUGIN_HANDLED) {
		remove_task(TASK_MAKEZOMBIE) // Remove Start mode task
		switch (key) { // Log and Print Message
			case MODE_INFECTION: start_infection_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_INFECTION")
			case MODE_NEMESIS: start_nemesis_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_NEMESIS")
			case MODE_ASSASSIN: start_assassin_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_ASSASSIN")
			case MODE_PREDATOR: start_predator_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_PREDATOR")
			case MODE_BOMBARDIER: start_bombardier_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_BOMBARDIER")
			case MODE_DRAGON: start_dragon_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_DRAGON")
			case MODE_SURVIVOR: start_survivor_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_SURVIVOR")
			case MODE_SNIPER: start_sniper_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_SNIPER")
			case MODE_BERSERKER: start_berserker_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_BERSERKER")
			case MODE_WESKER: start_wesker_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_WESKER")
			case MODE_SPY: start_spy_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MODE_SPY")
			case MODE_SWARM: start_swarm_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_SWARM")
			case MODE_MULTI: start_multi_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_MULTI")
			case MODE_PLAGUE: start_plague_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_PLAGUE")
			case MODE_LNJ: start_lnj_mode(0, MODE_SET), zp_log_message(id, 0, "CMD_LNJ")
		}
		ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, key, id)
	}
	else zp_colored_print(id, 1, "%L", id, (userflags & g_access_flag[key]) ? "CMD_NOT" : "CMD_NOT_ACCESS")

	menu_destroy(menu)
	show_menu2_admin(id)
	return PLUGIN_HANDLED;
}
public menu3_admin(id, key) {
	switch (key) {
		case 0: { // Admin Menu Mode
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU]) show_menu_admin(id) // Check if player has the required access
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		}
		case 1: { // Admin Menu Class
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU2]) show_menu2_admin(id) // Check if player has the required access
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		}
		case 2: { // Admin Menu of Custom Game modes
			if(get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MENU3]) show_menu_game_mode(id) // Check if player has the required access
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
		}
		case 3: { // Respawn Player
			if(get_user_flags(id) & g_access_flag[ACCESS_RESPAWN_PLAYERS]) {
				PL_ACTION = ACTION_RESPAWN_PLAYER
				show_menu_player_list(id); // Show player list for admin to pick a target
			}
			else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS");
		}
		case 4: show_menu_make_special(id, 0)
		case 5: show_menu_make_special(id, 1)
	}
	return PLUGIN_HANDLED;
}
public menu_player_list(id, menuid, item) { // Player List Menu
	if(!is_user_connected(id)) { // Player disconnected?
		menu_destroy(menuid)
		return PLUGIN_HANDLED;
	}
	static menudummy; player_menu_info(id, menudummy, menudummy, MENU_PAGE_PLAYERS) // Remember player's menu page
	if(item == MENU_EXIT) { // Menu was closed
		menu_destroy(menuid)
		if(PL_ACTION != ACTION_RESPAWN_PLAYER) show_menu_admin(id)
		else show_menu3_admin(id)
		return PLUGIN_HANDLED;
	}
	static buffer[2], dummy, playerid // Retrieve player id
	menu_item_getinfo(menuid, item, dummy, buffer, charsmax(buffer), _, _, dummy)
	playerid = buffer[0]
	
	// Perform action on player
	static userflags; userflags = get_user_flags(id) // Get admin flags
	if(g_isconnected[playerid]) { // Make sure it's still connected
		switch (PL_ACTION) { // Perform the right action if allowed
			case ACTION_ZOMBIEFY_HUMANIZE: { // Zombiefy/Humanize command
				if(g_newround && (userflags & g_access_flag[ACCESS_MODE_INFECTION])
				|| !g_newround && (userflags & g_access_flag[g_zombie[playerid] ? ACCESS_MAKE_HUMAN : ACCESS_MAKE_ZOMBIE])) {
					if(!g_zombie[playerid] && allowed_zombie(playerid)) command_zombie(id, playerid)
					else if(g_zombie[playerid] && allowed_human(playerid)) command_human(id, playerid)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_NEMESIS: { // Nemesis command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_NEMESIS : ACCESS_MAKE_NEMESIS]) {
					if(allowed_special(playerid, 1, NEMESIS)) command_special(id, playerid, NEMESIS, 1)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SURVIVOR: { // Survivor command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_SURVIVOR : ACCESS_MAKE_SURVIVOR]) {
					if(allowed_special(playerid, 0, SURVIVOR)) command_special(id, playerid, SURVIVOR, 0)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SNIPER: { // Sniper command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_SNIPER : ACCESS_MAKE_SNIPER]) {
					if(allowed_special(playerid, 0, SNIPER)) command_special(id, playerid, SNIPER, 0)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_ASSASSIN: { // Assassin command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_ASSASSIN : ACCESS_MAKE_ASSASSIN]) {
					if(allowed_special(playerid, 1, ASSASSIN)) command_special(id, playerid, ASSASSIN, 1)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_PREDATOR: { // Predator command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_PREDATOR : ACCESS_MAKE_PREDATOR]) {
					if(allowed_special(playerid, 1, PREDATOR)) command_special(id, playerid, PREDATOR, 1)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_BERSERKER: { // Berserker command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_BERSERKER : ACCESS_MAKE_BERSERKER]) {
					if(allowed_special(playerid, 0, BERSERKER)) command_special(id, playerid, BERSERKER, 0)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_WESKER: { // Wesker command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_WESKER : ACCESS_MAKE_WESKER]) {
					if(allowed_special(playerid, 0, WESKER)) command_special(id, playerid, WESKER, 0)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_BOMBARDIER: { // Bombardier command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_BOMBARDIER : ACCESS_MAKE_BOMBARDIER]) {
					if(allowed_special(playerid, 1, BOMBARDIER)) command_special(id, playerid, BOMBARDIER, 1)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_SPY: { // Spy command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_SPY : ACCESS_MAKE_SPY]) {
					if(allowed_special(playerid, 0, SPY)) command_special(id, playerid, SPY, 0)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_MAKE_DRAGON: { // Dragon command
				if(userflags & g_access_flag[g_newround ? ACCESS_MODE_DRAGON : ACCESS_MAKE_DRAGON]) {
					if(allowed_special(playerid, 1, DRAGON)) command_special(id, playerid, DRAGON, 1)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
			case ACTION_RESPAWN_PLAYER: { // Respawn command
				if(userflags & g_access_flag[ACCESS_RESPAWN_PLAYERS]) {
					if(allowed_respawn(playerid)) command_respawn(id, playerid)
					else zp_colored_print(id, 1, "%L", id, "CMD_NOT")
				}
				else zp_colored_print(id, 1, "%L", id, "CMD_NOT_ACCESS")
			}
		}
	}
	else zp_colored_print(id, 1, "%L", id, "CMD_NOT")

	menu_destroy(menuid)
	show_menu_player_list(id)
	return PLUGIN_HANDLED;
}
/*================================================================================
 [Admin Commands]
=================================================================================*/
public cmd_zombie(id, level, cid) { // zp_zombie [target]
	// Check for access flag depending on the resulting action
	// Start Mode Infection / Make Zombie
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_INFECTION : ACCESS_MAKE_ZOMBIE], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target

	if(!allowed_zombie(player)) { // Target not allowed to be zombie
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED
	}
	command_zombie(id, player)
	return PLUGIN_HANDLED;
}
public cmd_human(id, level, cid) { // zp_human [target]
	// Check for access flag - Make Human
	if(!cmd_access(id, g_access_flag[ACCESS_MAKE_HUMAN], cid, 2)) return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_human(player)) { // Target not allowed to be human
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_human(id, player)
	return PLUGIN_HANDLED;
}
public cmd_survivor(id, level, cid) { // zp_survivor [target]
	if(!hm_special_enable[SURVIVOR]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Survivor
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_SURVIVOR : ACCESS_MAKE_SURVIVOR], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 0, SURVIVOR)) { // Target not allowed to be survivor
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, SURVIVOR, 0)
	return PLUGIN_HANDLED;
}
public cmd_nemesis(id, level, cid) { // zp_nemesis [target]
	if(!zm_special_enable[NEMESIS]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Nemesis
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_NEMESIS : ACCESS_MAKE_NEMESIS], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target

	if(!allowed_special(player, 1, NEMESIS)) { // Target not allowed to be nemesis
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, NEMESIS, 1)
	return PLUGIN_HANDLED;
}
public cmd_respawn(id, level, cid) { // zp_respawn [target]
	// Check for access flag - Respawn
	if(!cmd_access(id, g_access_flag[ACCESS_RESPAWN_PLAYERS], cid, 2)) return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, CMDTARGET_ALLOW_SELF)
	
	if(!player) return PLUGIN_HANDLED; // Invalid target

	if(!allowed_respawn(player)) { // Target not allowed to be respawned
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	
	command_respawn(id, player)
	return PLUGIN_HANDLED;
}
public cmd_swarm(id, level, cid) { // zp_swarm
	// Check for access flag - Mode Swarm
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_SWARM], cid, 2))
		return PLUGIN_HANDLED;

	if(!allowed_game_mode(MODE_SWARM)) { // Swarm mode not allowed
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_swarm(id)
	return PLUGIN_HANDLED;
}
public cmd_multi(id, level, cid) { // zp_multi
	// Check for access flag - Mode Multi
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_MULTI], cid, 2))
		return PLUGIN_HANDLED;
	
	if(!allowed_game_mode(MODE_MULTI)) { // Multi infection mode not allowed
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_multi(id)
	return PLUGIN_HANDLED;
}
public cmd_plague(id, level, cid) { // zp_plague
	if(!zm_special_enable[NEMESIS] || !hm_special_enable[SURVIVOR]) return PLUGIN_HANDLED;

	// Check for access flag - Mode Plague
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_PLAGUE], cid, 2))
		return PLUGIN_HANDLED;
	
	if(!allowed_game_mode(MODE_PLAGUE)) { // Plague mode not allowed
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_plague(id)
	return PLUGIN_HANDLED;
}
public cmd_sniper(id, level, cid) { // zp_sniper [target]
	if(!hm_special_enable[SNIPER]) return PLUGIN_HANDLED;

	// Start Mode / Make Sniper
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_SNIPER : ACCESS_MAKE_SNIPER], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target

	if(!allowed_special(player, 0, SNIPER)) { // Target not allowed to be sniper
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}

	command_special(id, player, SNIPER, 0)
	return PLUGIN_HANDLED;
}
public cmd_assassin(id, level, cid) { // zp_assassin [target]
	if(!zm_special_enable[ASSASSIN]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Assassin
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_ASSASSIN : ACCESS_MAKE_ASSASSIN], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 1, ASSASSIN)) { // Target not allowed to be assassin
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, ASSASSIN, 1)
	return PLUGIN_HANDLED;
}
public cmd_predator(id, level, cid) { // zp_predator [target]
	if(!zm_special_enable[PREDATOR]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Predator
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_PREDATOR : ACCESS_MAKE_PREDATOR], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 1, PREDATOR)) { // Target not allowed to be predator
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, PREDATOR, 1)
	return PLUGIN_HANDLED;
}
public cmd_bombardier(id, level, cid) { // zp_bombardier [target]
	if(!zm_special_enable[BOMBARDIER]) 
		return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Bombardier
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_BOMBARDIER : ACCESS_MAKE_BOMBARDIER], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 1, BOMBARDIER)) { // Target not allowed to be bombardier
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, BOMBARDIER, 1)
	return PLUGIN_HANDLED;
}
public cmd_dragon(id, level, cid) { // zp_dragon [target]
	if(!zm_special_enable[DRAGON]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode Assassin
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_DRAGON : ACCESS_MAKE_DRAGON], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 1, DRAGON)) { // Target not allowed to be dragon
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, DRAGON, 1)
	return PLUGIN_HANDLED;
}
public cmd_berserker(id, level, cid) { // zp_berserker [target]
	if(!hm_special_enable[BERSERKER]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Berserker
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_BERSERKER : ACCESS_MAKE_BERSERKER], cid, 2))
		return PLUGIN_HANDLED;

	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 0, BERSERKER)) { // Target not allowed to be berserker
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, BERSERKER, 0)
	return PLUGIN_HANDLED;
}
public cmd_wesker(id, level, cid) { // zp_wesker [target]
	if(!hm_special_enable[WESKER]) return PLUGIN_HANDLED;

	// Check for access flag depending on the resulting action
	// Start Mode / Make Wesker
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_WESKER : ACCESS_MAKE_WESKER], cid, 2))
		return PLUGIN_HANDLED;
	
	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target
	
	if(!allowed_special(player, 0, WESKER)) { // Target not allowed to be wesker
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, WESKER, 0)
	return PLUGIN_HANDLED;
}
public cmd_spy(id, level, cid) { // zp_spy [target]
	if(!hm_special_enable[SPY]) return PLUGIN_HANDLED;
	
	// Check for access flag depending on the resulting action
	// Start Mode / Make Spy
	if(!cmd_access(id, g_access_flag[g_newround ? ACCESS_MODE_SPY : ACCESS_MAKE_SPY], cid, 2))
		return PLUGIN_HANDLED;

	static arg[32], player; read_argv(1, arg, charsmax(arg)) // Retrieve arguments
	player = cmd_target(id, arg, (CMDTARGET_ONLY_ALIVE | CMDTARGET_ALLOW_SELF))
	
	if(!player) return PLUGIN_HANDLED; // Invalid target

	if(!allowed_special(player, 0, SPY)) { // Target not allowed to be spy
		client_print(id, print_console, "[ZP] %L", id, "CMD_NOT")
		return PLUGIN_HANDLED;
	}
	command_special(id, player, SPY, 0)
	return PLUGIN_HANDLED;
}
public cmd_lnj(id, level, cid) { // zp_lnj
	if(!zm_special_enable[NEMESIS] || !hm_special_enable[SURVIVOR]) 
		return PLUGIN_HANDLED;

	// Check for access flag - Mode Apocalypse
	if(!cmd_access(id, g_access_flag[ACCESS_MODE_LNJ], cid, 2))
		return PLUGIN_HANDLED;
	
	if(!allowed_game_mode(MODE_LNJ)) { // Apocalypse mode not allowed
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
public message_cur_weapon(msg_id, msg_dest, msg_entity) {
	if(!g_isalive[msg_entity] || g_zombie[msg_entity] || g_hm_special[msg_entity] == BERSERKER) return; // Not alive or zombie
	if(get_msg_arg_int(1) != 1) return; // Not an active weapon
	
	// Unlimited clip disabled for class
	if(g_hm_special[msg_entity] >= MAX_SPECIALS_HUMANS) if(ArrayGetCell(g_hm_special_uclip, g_hm_special[msg_entity]-MAX_SPECIALS_HUMANS) <= 1) return;
	if(g_hm_special[msg_entity] < MAX_SPECIALS_HUMANS) if(get_pcvar_num(cvar_hm_infammo[g_hm_special[msg_entity]]) <= 1) return;

	static weapon; weapon = get_msg_arg_int(2) // Get weapon's id
	if(MAXBPAMMO[weapon] > 2) { // Unlimited Clip Ammo for this weapon?
		cs_set_weapon_ammo(fm_cs_get_current_weapon_ent(msg_entity), MAXCLIP[weapon]) // Max out clip ammo
		set_msg_arg_int(3, get_msg_argtype(3), MAXCLIP[weapon]) // HUD should show full clip all the time
	}
}
public message_money(msg_id, msg_dest, msg_entity) { // Take off player's money
	if(!get_pcvar_num(cvar_removemoney)) return PLUGIN_CONTINUE; // Remove money setting enabled?

	fm_cs_set_user_money(msg_entity, 0)
	return PLUGIN_HANDLED;
}
public message_health(msg_id, msg_dest, msg_entity) { // Fix for the HL engine bug when HP is multiples of 256
	static health; health = get_msg_arg_int(1) // Get player's health
	if(health < 256) return; // Don't bother
	if(health % 256 == 0) fm_set_user_health(msg_entity, pev(msg_entity, pev_health) + 1); // Check if we need to fix it
	set_msg_arg_int(1, get_msg_argtype(1), 255) // HUD can only show as much as 255 hp
}
public message_armor(msg_id, msg_dest, msg_entity) { // Fix Hud when armor is multiples of 999
	
	static armor; armor = get_msg_arg_int(1) // Get player's health
	if(armor < 1000) return; // Don't bother	
	set_msg_arg_int(1, get_msg_argtype(1), 999) // HUD can only show as much as 999 armor
}
public message_flashbat() { // Block flashlight battery messages if custom flashlight is enabled instead
	if(g_cached_customflash) return PLUGIN_HANDLED;
	return PLUGIN_CONTINUE;
}
public message_screenfade(msg_id, msg_dest, msg_entity) { // Flashbangs should only affect zombies
	if(get_msg_arg_int(4) != 255 || get_msg_arg_int(5) != 255 || get_msg_arg_int(6) != 255 || get_msg_arg_int(7) < 200)
		return PLUGIN_CONTINUE;

	if(g_zombie[msg_entity] && g_zm_special[msg_entity] <= 0) { // Nemesis/Assassin shouldn't be FBed
		switch(g_nv_color[1][msg_entity]) {
			case 1: g_nvrgb = { 255, 255, 255 }
			case 2: g_nvrgb = { 255, 0, 0 }
			case 3: g_nvrgb = { 0, 255, 0 }
			case 4: g_nvrgb = { 0, 0, 255 }
			case 5: g_nvrgb = { 0, 255, 255 }
			case 6: g_nvrgb = { 255, 0, 255 }
			case 7: g_nvrgb = { 255, 255, 0 }
			default: {
				g_nvrgb[0] = get_pcvar_num(cvar_zombie_nvsion_rgb[0])
				g_nvrgb[1] = get_pcvar_num(cvar_zombie_nvsion_rgb[1])
				g_nvrgb[2] = get_pcvar_num(cvar_zombie_nvsion_rgb[2])
			}
		}
		// Set flash color to nighvision's
		set_msg_arg_int(4, get_msg_argtype(4), g_nvrgb[0])
		set_msg_arg_int(5, get_msg_argtype(5), g_nvrgb[1])
		set_msg_arg_int(6, get_msg_argtype(6), g_nvrgb[2])
		return PLUGIN_CONTINUE;
	}
	return PLUGIN_HANDLED;
}
public message_nvgtoggle() return PLUGIN_HANDLED; // Prevent spectators' nightvision from being turned off when switching targets, etc.
public message_clcorpse() set_msg_arg_string(1, g_playermodel[get_msg_arg_int(12)]) // Set correct model on player corpses

public message_weappickup(msg_id, msg_dest, msg_entity) { // Prevent zombies from seeing any weapon pickup icon
	if(g_zombie[msg_entity]) return PLUGIN_HANDLED;
	return PLUGIN_CONTINUE;
}
public message_ammopickup(msg_id, msg_dest, msg_entity) { // Prevent zombies from seeing any ammo pickup icon
	if(g_zombie[msg_entity]) return PLUGIN_HANDLED;
	return PLUGIN_CONTINUE;
}
public message_scenario() { // Block hostage HUD display
	if(get_msg_args() > 1) {
		static sprite[8]; get_msg_arg_string(2, sprite, charsmax(sprite))
		if(equal(sprite, "hostage")) return PLUGIN_HANDLED;
	}
	return PLUGIN_CONTINUE;
}
public message_hostagepos() return PLUGIN_HANDLED; // Block hostages from appearing on radar

public message_textmsg() { // Block some text messages
	static textmsg[22]; get_msg_arg_string(2, textmsg, charsmax(textmsg))
	
	if(equal(textmsg, "#Game_will_restart_in")) { // Game restarting, reset scores and call round end to balance the teams
		logevent_round_end()
		g_scorehumans = 0
		g_scorezombies = 0
	}
	else if(equal(textmsg, "#Game_Commencing")) { // Game commencing, reset scores only (round end is automatically triggered)
		g_gamecommencing = true
		g_scorehumans = 0
		g_scorezombies = 0
	}
	// Block round end related messages
	else if(equal(textmsg, "#Hostages_Not_Rescued") || equal(textmsg, "#Round_Draw") || equal(textmsg, "#Terrorists_Win") || equal(textmsg, "#CTs_Win"))
		return PLUGIN_HANDLED;
	
	return PLUGIN_CONTINUE;
}
public message_sendaudio() { // Block CS round win audio messages, since we're playing our own instead
	static audio[17]; get_msg_arg_string(2, audio, charsmax(audio))
	if(equal(audio[7], "terwin") || equal(audio[7], "ctwin") || equal(audio[7], "rounddraw")) return PLUGIN_HANDLED;
	return PLUGIN_CONTINUE;
}
public message_teamscore() { // Send actual team scores (T = zombies // CT = humans)
	static team[2]; get_msg_arg_string(1, team, charsmax(team))
	switch (team[0]) {
		case 'C': set_msg_arg_int(2, get_msg_argtype(2), g_scorehumans) // CT
		case 'T': set_msg_arg_int(2, get_msg_argtype(2), g_scorezombies) // Terrorist
	}
}
public message_teaminfo(msg_id, msg_dest) { // Team Switch (or player joining a team for first time)
	if(msg_dest != MSG_ALL && msg_dest != MSG_BROADCAST) return; // Only hook global messages
	if(g_switchingteam) return; // Don't pick up our own TeamInfo messages for this player (bugfix)

	static id; id = get_msg_arg_int(1) // Get player's id
	if(!(1 <= id <= g_maxplayers)) return; // Invalid player id? (bugfix)

	set_task(0.2, "spec_nvision", id) // Enable spectators' nightvision if not spawning right away
	if(g_newround) return; // Round didn't start yet, nothing to worry about
	
	static team[2]; get_msg_arg_string(2, team, charsmax(team)) // Get his new team
	switch (team[0]) { // Perform some checks to see if they should join a different team instead
		case 'C': { // CT
			if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM && fnGetHumans()) { // survivor, sniper and berserker alive --> switch to T and spawn as zombie
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
			else if(!fnGetZombies()) { // no zombies alive --> switch to T and spawn as zombie
				g_respawn_as_zombie[id] = true;
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_T)
				set_msg_arg_string(2, "TERRORIST")
			}
		}
		case 'T': { // Terrorist
			if(g_currentmode >= MODE_SURVIVOR && g_currentmode <= MODE_SWARM && fnGetHumans()) // survivor/sniper/berserker alive or swarm round w\ humans --> spawn as zombie
				g_respawn_as_zombie[id] = true;

			else if(fnGetZombies()) { // zombies alive --> switch to CT
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
public make_zombie_task() { // Make Zombie Task

	static iPlayersnum; iPlayersnum = fnGetAlive() // Get alive players count		
	if(iPlayersnum < 1) { // Not enough players, come back later!
		set_task(2.0, "make_zombie_task", TASK_MAKEZOMBIE)
		return;
	}

	if(g_nextmode > 0 && g_nextmode < g_gamemodes_i) {
		native_start_game_mode(g_nextmode, 0)
		g_nextmode = MODE_NONE
	}
	else start_swarm_mode(0, MODE_NONE) // Start the game modes cycle
}
start_swarm_mode(id, mode) { // Start swarm mode
	// Get alive players count
	static iPlayersnum, enable
	iPlayersnum = fnGetAlive()
	
	enable = is_gamemode_enable(MODE_SWARM)

	static sound[64], iZombies, iMaxZombies, is_zombie[33]
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_SWARM) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_SWARM])) == enable && 
	floatround(iPlayersnum*get_pcvar_float(cvar_swarmratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_swarmratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_SWARM]))
	|| mode == MODE_SET)
	{
		// Swarm Mode
		g_currentmode = MODE_SWARM
		g_lastmode = MODE_SWARM
		
		g_allowinfection = false // Allow Infection
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround(iPlayersnum*get_pcvar_float(cvar_swarmratio), floatround_ceil)
		iZombies = 0

		// Randomly turn iMaxZombies players into zombies
		while(iZombies < iMaxZombies) {
			if(++id > g_maxplayers) id = 1 // Keep looping through all players
			if(!g_isalive[id]) continue; // Dead or already a zombie

			if(g_zombie[id] && g_zm_special[id] == 0) {
				is_zombie[id] = true
				iZombies++
				continue;
			}
			if(random_num(0, 1)) { // Random chance
				zombieme(id, 0, 0, 1, 0) // Turn into a zombie
				is_zombie[id] = true
				
				if(g_escape_map) { // Escape Map Support	
					if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
					else do_random_spawn(id, 1) // regular spawn
				}
				iZombies++
			}
		}
		
		// Turn the remaining players into humans
		for(id = 1; id <= g_maxplayers; id++) {
			if(!g_isalive[id]) continue; // Only those of them who aren't zombies

			if(!is_zombie[id] && g_zombie[id] || g_hm_special[id])
				humanme(id, 0, 1)
			
			// Switch to CT
			if(!g_zombie[id]) {
				if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
					remove_task(id+TASK_TEAM)
					fm_cs_set_user_team(id, FM_CS_TEAM_CT)
					fm_user_team_update(id)
				}
			}
			else {
				if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) { // need to change team?
					remove_task(id+TASK_TEAM)
					fm_cs_set_user_team(id, FM_CS_TEAM_T)
					fm_user_team_update(id)
				}
			}
		}
		// Play swarm sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Swarm HUD notice
		set_hudmessage(20, 255, 20, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_SWARM")
		
		if(g_ambience_sounds[AMBIENCE_SOUNDS_SWARM]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		g_modestarted = true // Mode fully started!
		g_newround = false

		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_SWARM, 0); // Round start forward
		
		return 1; // Stop here [BUGFIX]
	}

	if(mode != MODE_SET) start_plague_mode(0, MODE_NONE) // Give chance to another game mode
	return 0
}
start_plague_mode(id, mode) { // Start plague mode
	if(!zm_special_enable[NEMESIS] || !hm_special_enable[SURVIVOR]) {
		if(mode != MODE_SET) start_multi_mode(0, MODE_NONE)
		return 0;
	}
		
	// Get alive players count
	static iPlayersnum, enable, sound[64], iZombies, iMaxZombies
	iPlayersnum = fnGetAlive()
	enable = is_gamemode_enable(MODE_PLAGUE)

	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_PLAGUE) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_PLAGUE])) == enable 
	&& floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) >= 1 && 
	iPlayersnum-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) >= 1 
	&& iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_PLAGUE])) || mode == MODE_SET)
	{
		// Plague Mode
		g_currentmode = MODE_PLAGUE
		g_lastmode = MODE_PLAGUE
		
		g_allowinfection = false // Prevent Infection
		
		// Turn specified amount of players into Survivors
		static iSurvivors, iMaxSurvivors
		iMaxSurvivors = get_pcvar_num(cvar_plaguesurvnum)

		if(fnGetSpecials(0, SURVIVOR) < iMaxSurvivors) {
			iSurvivors = 0
			while(iSurvivors < iMaxSurvivors) {
				id = fnGetRandomAlive(random_num(1, iPlayersnum)) // Choose random guy
				
				if(g_hm_special[id] == SURVIVOR) continue; // Already a survivor?
				
				humanme(id, SURVIVOR, 0) // If not, turn him into one
				iSurvivors++

				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguesurvhpmulti))) // Apply survivor health multiplier
			}
		}
		
		// Turn specified amount of players into Nemesis
		static iNemesis, iMaxNemesis
		iMaxNemesis = get_pcvar_num(cvar_plaguenemnum)

		if(fnGetSpecials(1, NEMESIS) < iMaxNemesis) {
			iNemesis = 0
			while(iNemesis < iMaxNemesis) {
				id = fnGetRandomAlive(random_num(1, iPlayersnum)) // Choose random guy
				
				// Already a survivor or nemesis?
				if(g_hm_special[id] == SURVIVOR || g_zm_special[id] == NEMESIS) continue;

				zombieme(id, 0, NEMESIS, 0, 0) // If not, turn him into one
				
				if(g_escape_map) { // Escape Map Support	
					if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
					else do_random_spawn(id, 1) // regular spawn
				}
				iNemesis++
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_plaguenemhpmulti))) // Apply nemesis health multiplier
			}
		}
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)
		iZombies = 0
		while(iZombies < iMaxZombies) {
			if(++id > g_maxplayers) id = 1 // Keep looping through all players

			// Dead or already a zombie or survivor
			if(!g_isalive[id] || g_zm_special[id] == NEMESIS || g_hm_special[id] == SURVIVOR) continue;
			
			if(random_num(0, 1)) { // Random chance
				zombieme(id, 0, 0, 1, 0) // Turn into a zombie

				if(g_escape_map) { // Escape Map Support	
					if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
					else do_random_spawn(id, 1) // regular spawn
				}
				iZombies++
			}
		}

		for(id = 1; id <= g_maxplayers; id++) { // Turn the remaining players into humans
			if(!g_isalive[id] || g_zombie[id] || g_hm_special[id] == SURVIVOR) continue; // Only those of them who arent zombies or survivor
			
			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
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

		if(g_ambience_sounds[AMBIENCE_SOUNDS_PLAGUE]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		g_modestarted = true // Mode fully started!
		g_newround = false // No more a new round

		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_PLAGUE, 0); // Round start forward
		return 1; // Stop here [BUGFIX]
	}

	if(mode != MODE_SET) start_multi_mode(0, MODE_NONE) // Give chance to other game modes
	return 0
}

start_multi_mode(id, mode) { // Start multiple infection mode
	// Get alive players count
	static iPlayersnum, enable, sound[64], iZombies, iMaxZombies, is_zombie[33]
	iPlayersnum = fnGetAlive()
	enable = is_gamemode_enable(MODE_MULTI)
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_MULTI) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_MULTI])) == enable && 
	floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) >= 2 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_MULTI]))
	|| mode == MODE_SET) {
		// Multi Infection Mode
		g_currentmode = MODE_MULTI
		g_lastmode = MODE_MULTI
		
		g_allowinfection = true // Allow Infection
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil)
		iZombies = 0

		while(iZombies < iMaxZombies) { // Randomly turn iMaxZombies players into zombies
			if(++id > g_maxplayers) id = 1 // Keep looping through all players
			
			if(!g_isalive[id]) continue; // Dead or already a zombie

			if(g_zombie[id] && g_zm_special[id] == 0) {
				is_zombie[id] = true
				iZombies++
				continue;
			}
			if(random_num(0, 1)) { // Random chance
				// Turn into a zombie
				zombieme(id, 0, 0, 1, 0)
				is_zombie[id] = true
				
				if(g_escape_map) { // Escape Map Support	
					if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
					else do_random_spawn(id, 1) // regular spawn
				}
				iZombies++
			}
		}

		for(id = 1; id <= g_maxplayers; id++) { // Turn the remaining players into humans
			if(!g_isalive[id]) continue; // Only those of them who aren't zombies

			if(!is_zombie[id] && g_zombie[id] || g_hm_special[id]) humanme(id, 0, 1)

			if(!g_zombie[id]) {
				if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) // need to change team?
				{
					remove_task(id+TASK_TEAM)
					fm_cs_set_user_team(id, FM_CS_TEAM_CT)
					fm_user_team_update(id)
				}
			}
			else {
				if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) // need to change team?
				{
					remove_task(id+TASK_TEAM)
					fm_cs_set_user_team(id, FM_CS_TEAM_T)
					fm_user_team_update(id)
				}
			}
		}
		// Play multi infection sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);

		// Show Multi Infection HUD notice
		set_hudmessage(200, 50, 0, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_MULTI")
		
		if(g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		g_modestarted = true // Mode fully started!
		g_newround = false // No more a new round

		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_MULTI, 0); // Round start forward
		return 1; // Stop here
		
	}
	
	if(mode != MODE_SET) start_lnj_mode(0, MODE_NONE) // Give chance to other game modes
	return 0
}
start_lnj_mode(id, mode) { // Start LNJ mode
	if(!zm_special_enable[NEMESIS] || !hm_special_enable[SURVIVOR]) {
		if(mode != MODE_SET) start_sniper_mode(0, MODE_NONE)
		return 0;
	}

	// Get alive players count
	static iPlayersnum, enable, sound[64], iZombies, iMaxZombies
	iPlayersnum = fnGetAlive()
	enable = is_gamemode_enable(MODE_LNJ)
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != MODE_LNJ) && random_num(1, get_pcvar_num(cvar_mod_chance[MODE_LNJ])) == enable &&
	iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[MODE_LNJ]) && floatround(iPlayersnum*get_pcvar_float(cvar_lnjratio), floatround_ceil) >= 1 && floatround(iPlayersnum*get_pcvar_float(cvar_multiratio), floatround_ceil) < iPlayersnum)
	|| mode == MODE_SET) {
		// Armageddon Mode
		g_currentmode = MODE_LNJ
		g_lastmode = MODE_LNJ

		g_allowinfection = false // Prevent Infection
		
		// iMaxZombies is rounded up, in case there aren't enough players
		iMaxZombies = floatround((iPlayersnum * get_pcvar_float(cvar_lnjratio)), floatround_ceil)
		iZombies = fnGetSpecials(1, NEMESIS)
		
		while(iZombies < iMaxZombies) { // Randomly turn iMaxZombies players into Nemesis
			if(++id > g_maxplayers) id = 1 // Keep looping through all players			
			if(!g_isalive[id] || g_zm_special[id] == NEMESIS) continue; // Dead or already a nemesis
			
			if(random_num(0, 1)) { // Random chance
				// Turn into a Nemesis
				zombieme(id, 0, NEMESIS, 0, 0)
				fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjnemhpmulti)))
				
				if(g_escape_map) { // Escape Map Support	
					if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
					else do_random_spawn(id, 1) // regular spawn
				}

				iZombies++
			}
		}

		for(id = 1; id <= g_maxplayers; id++) { // Turn the remaining players into survivors
			if(!g_isalive[id] || g_zm_special[id] == NEMESIS) continue; // Only those of them who arent nemesis
			humanme(id, SURVIVOR, 0) // Turn into a Survivor
			fm_set_user_health(id, floatround(float(pev(id, pev_health)) * get_pcvar_float(cvar_lnjsurvhpmulti)))
		}
		
		// Play armageddon sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Armageddon HUD notice
		set_hudmessage(181 , 62, 244, -1.0, 0.17, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_LNJ")
		
		if(g_ambience_sounds[AMBIENCE_SOUNDS_LNJ]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}

		g_modestarted = true // Mode fully started!
		g_newround = false // No more a new round

		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_LNJ, 0); // Round start forward
		
		return 1; // Stop here
		
	}
	if(mode != MODE_SET) start_sniper_mode(0, MODE_NONE) // Give chance to other game modes
	return 0 
}
start_survivor_mode(id, mode) { // Start survivor mode
	if(!set_special_human_mode(id, mode, SURVIVOR)) { // Give chance to other game modes
		start_assassin_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_sniper_mode(id, mode) { // Start sniper mode
	if(!set_special_human_mode(id, mode, SNIPER)) { // Give chance to other game modes
		start_survivor_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_berserker_mode(id, mode) { // Start berserker mode
	if(!set_special_human_mode(id, mode, BERSERKER)) { // Give chance to other game modes
		start_predator_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_wesker_mode(id, mode) { // Start wesker mode
	if(!set_special_human_mode(id, mode, WESKER)) { // Give chance to other game modes
		start_bombardier_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_spy_mode(id, mode) { // Start spy mode
	if(!set_special_human_mode(id, mode, SPY)) { // Give chance to other game modes
		start_dragon_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_nemesis_mode(id, mode) { // Start nemesis mode
	if(!set_special_zombie_mode(id, mode, NEMESIS)) { // Give chance to other game modes
		start_berserker_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_assassin_mode(id, mode) { // Start assassin mode
	if(!set_special_zombie_mode(id, mode, ASSASSIN)) { // Give chance to other game modes
		start_nemesis_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_predator_mode(id, mode) { // Start predator mode
	if(!set_special_zombie_mode(id, mode, PREDATOR)) { // Give chance to other game modes
		start_wesker_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_bombardier_mode(id, mode) { // Start bombardier mode
	if(!set_special_zombie_mode(id, mode, BOMBARDIER)) { // Give chance to other game modes
		start_spy_mode(0, MODE_NONE)
		return 0
	}
	return 1
}
start_dragon_mode(id, mode) { // Start dragon mode
	if(!set_special_zombie_mode(id, mode, DRAGON)) { // Give chance to other game modes
		start_custom_mode()
		return 0
	}
	return 1
}
new const hm_notice_lang[MAX_SPECIALS_HUMANS][] = { "UNKNOWN", "NOTICE_SURVIVOR", "NOTICE_SNIPER", "NOTICE_BERSERKER", "NOTICE_WESKER", "NOTICE_SPY" }
set_special_human_mode(id, mode, class) {
	if(class >= MAX_SPECIALS_HUMANS) return 0
	if(!hm_special_enable[class] || g_escape_map && mode == MODE_NONE) return 0;

	static mode_id, amb_id
	mode_id = 0
	amb_id = 0
	switch(class) {
		case SURVIVOR: mode_id = MODE_SURVIVOR, amb_id = AMBIENCE_SOUNDS_SURVIVOR
		case SNIPER: mode_id = MODE_SNIPER, amb_id = AMBIENCE_SOUNDS_SNIPER
		case BERSERKER: mode_id = MODE_BERSERKER, amb_id = AMBIENCE_SOUNDS_BERSERKER
		case WESKER: mode_id = MODE_WESKER, amb_id = AMBIENCE_SOUNDS_WESKER
		case SPY: mode_id = MODE_SPY, amb_id = AMBIENCE_SOUNDS_SPY
	}
	// Get alive players count
	static iPlayersnum, enable, forward_id, sound[64]
	iPlayersnum = fnGetAlive()
	enable = is_gamemode_enable(mode_id)
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != mode_id) && random_num(1, get_pcvar_num(cvar_mod_chance[mode_id])) == enable && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[mode_id]))
	|| mode == MODE_SET) {
		// Special Human Game Mode
		g_currentmode = mode_id
		g_lastmode = mode_id
		
		g_allowinfection = false // Prevent Infection

		if(mode == MODE_NONE || !id && mode == MODE_SET) id = fnGetRandomAlive(random_num(1, iPlayersnum)) // Choose player randomly?

		forward_id = id // Remember id for calling our forward later
		humanme(id, class, 0) // Turn player into a special human
		
		for(id = 1; id <= g_maxplayers; id++) { // Turn the remaining players into zombies
			if(!g_isalive[id]) continue; // Not alive
			
			
			if(id == forward_id || g_zombie[id] && g_zm_special[id] == 0) continue; // special human or already a zombie
			
			zombieme(id, 0, 0, 1, 0) // Turn into a zombie
		}

		// Play Special human sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show Special Class HUD notice
		set_hudmessage(0, 10, 255, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, hm_notice_lang[class], g_playername[forward_id])
		
		if(g_ambience_sounds[amb_id]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}
		
		g_modestarted = true // Mode fully started!
		g_newround = false // No more a new round
		
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, mode_id, forward_id); // Round start forward
		remove_task(TASK_MAKEZOMBIE) // Bug Fix
		return 1; // Stop here
	}
	return 0;
}
new const zm_notice_lang[MAX_SPECIALS_ZOMBIES][] = { "UNKNOWN", "NOTICE_NEMESIS", "NOTICE_ASSASSIN", "NOTICE_PREDATOR", "NOTICE_BOMBARDIER", "NOTICE_DRAGON" }
set_special_zombie_mode(id, mode, class) {
	if(class >= MAX_SPECIALS_ZOMBIES) return 0
	if(!zm_special_enable[class]) return 0;

	static mode_id, amb_id
	mode_id = 0
	amb_id = 0
	switch(class) {
		case NEMESIS: mode_id = MODE_NEMESIS, amb_id = AMBIENCE_SOUNDS_NEMESIS
		case ASSASSIN: mode_id = MODE_ASSASSIN, amb_id = AMBIENCE_SOUNDS_ASSASSIN
		case PREDATOR: mode_id = MODE_PREDATOR, amb_id = AMBIENCE_SOUNDS_PREDATOR
		case BOMBARDIER: mode_id = MODE_BOMBARDIER , amb_id = AMBIENCE_SOUNDS_BOMBARDIER
		case DRAGON: mode_id = MODE_DRAGON, amb_id = AMBIENCE_SOUNDS_DRAGON
	}

	// Get alive players count
	static iPlayersnum, enable, forward_id, sound[64]
	iPlayersnum = fnGetAlive()
	enable = is_gamemode_enable(mode_id)
	
	if((mode == MODE_NONE && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != mode_id) && random_num(1, get_pcvar_num(cvar_mod_chance[mode_id])) == enable && iPlayersnum >= get_pcvar_num(cvar_mod_minplayers[mode_id]))
	|| mode == MODE_SET) {

		// Special Zombie Mode
		g_currentmode = mode_id
		g_lastmode = mode_id
		g_allowinfection = false // Prevent Infection

		if(mode == MODE_NONE || !id && mode == MODE_SET) id = fnGetRandomAlive(random_num(1, iPlayersnum)) // Choose player randomly?

		forward_id = id // Remember id for calling our forward later		
		zombieme(id, 0, class, 0, 0) // Turn player into special zombie
		
		if(g_escape_map) { // Escape Map Support
			if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
			else do_random_spawn(id, 1) // regular spawn
		}

		if(class == ASSASSIN) { // Turn off the lights [Taken From Speeds Zombie Mutilation]
			static ent
			ent = -1
			while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "light")) != 0)
				dllfunc(DLLFunc_Use, ent, 0);
		}

		for(id = 1; id <= g_maxplayers; id++) { // Remaining players should be humans (CTs)
			if(!g_isalive[id]) continue; // Not alive
			
			if(forward_id == id) continue;
			
			if(g_zombie[id] || g_hm_special[id]) humanme(id, 0, 1) // Turn others players to human (When forces start round after round alterady started by native)

			// Switch to CT
			if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
				remove_task(id+TASK_TEAM)
				fm_cs_set_user_team(id, FM_CS_TEAM_CT)
				fm_user_team_update(id)
			}

			set_screenfadein(id, 5, get_pcvar_num(cvar_zm_red[class]), get_pcvar_num(cvar_zm_green[class]), get_pcvar_num(cvar_zm_blue[class]), 255)

			// Make a screen shake [Make it horrorful]
			message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
			write_short(UNIT_SECOND*75) // amplitude
			write_short(UNIT_SECOND*7) // duration
			write_short(UNIT_SECOND*75) // frequency
			message_end()
		}

		// Play Special Class sound
		if(g_currentmode > 1) ArrayGetString(sound_mod[g_currentmode], random_num(0, ArraySize(sound_mod[g_currentmode]) - 1), sound, charsmax(sound))
		PlaySound(sound);
		
		// Show HUD notice
		set_hudmessage(get_pcvar_num(cvar_zm_red[class]), get_pcvar_num(cvar_zm_green[class]), get_pcvar_num(cvar_zm_blue[class]), HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
		ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, zm_notice_lang[class], g_playername[forward_id])
		
		if(g_ambience_sounds[amb_id]) { // Start ambience sounds
			remove_task(TASK_AMBIENCESOUNDS)
			set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
		}

		g_modestarted = true // Mode fully started!
		g_newround = false // No more a new round
		lighting_effects() // Set Fast Lights
		
		ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, mode_id, forward_id); // Round start forward
		remove_task(TASK_MAKEZOMBIE) // Bug Fix
		return 1; // Stop here
		
	}
	return 0 // Give chance to other game modes
}

start_custom_mode() { // Start custom game mode
	if(g_gamemodes_i == MAX_GAME_MODES) { // No custom game modes registered
		start_infection_mode(0, MODE_NONE) // Start our infection mode 
		return;
	}

	g_newround = false // No more a new round
	
	// Loop through every custom game mode present
	// This is to ensure that every game mode is given a chance
	static game
	for(game = MAX_GAME_MODES; game < g_gamemodes_i; game++) {
		// Apply chance level and check if the last played mode was not the same as this one
		if((random_num(1, ArrayGetCell(g_gamemode_chance, (game - MAX_GAME_MODES))) == 1) && (!get_pcvar_num(cvar_preventconsecutive) || g_lastmode != game) 
		&& is_gamemode_enable(game)) {
			// Execute our round start pre forward
			// This is were the game mode will decide whether to run itself or block it self
			ExecuteForward(g_forwards[ROUND_START_PRE], g_fwDummyResult, game)
			
			// The game mode didnt accept some conditions
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) 
				continue; // Give other game modes a chance
			
			else { // Game mode has accepted the conditions
				// Current game mode and last game mode are equal to the game mode id
				g_currentmode = game
				g_lastmode = game

				g_allowinfection = (ArrayGetCell(g_gamemode_allow, (game - MAX_GAME_MODES)) == 1) ? true : false // Check whether or not to allow infection during this game mode
				g_deathmatchmode = ArrayGetCell(g_gamemode_dm, (game - MAX_GAME_MODES)) // Check the death match mode required by the game mode
				g_modestarted = true // Our custom game mode has fully started
				
				ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, game, 0) // Execute our round start forward with the game mode id
				
				
				static id // Turn the remaining players into humans [BUGFIX]
				for(id = 1; id <= g_maxplayers; id++) {
					update_team(id) // Only those of them who arent zombies or survivor

					if(g_zombie[id] && g_escape_map) { // Escape Map Support
						if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
						else do_random_spawn(id, 1) // regular spawn
					}
				}
				remove_task(TASK_MAKEZOMBIE) // Fix Bug
				break; // Stop the loop and prevent other game modes from being given a chance [BUGFIX]
			}
		}
		else continue; // The game mode was not given a chance then continue the loop
	}
	if(!g_modestarted) start_infection_mode(0, MODE_NONE) // No game mode has started then start our good old infection mode [BUGFIX]
}
public update_team(id) {
	if(!g_isalive[id]) return

	if(!g_zombie[id]) {
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
	}
	else {
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) { // need to change team?
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			fm_user_team_update(id)
		}
	}
}
start_infection_mode(id, mode) { // Start the default infection mode
	// Get alive players count
	static iPlayersnum, forward_id
	iPlayersnum = fnGetAlive()
	
	// Single Infection Mode
	g_currentmode = MODE_INFECTION
	g_lastmode = MODE_INFECTION	
	g_allowinfection = true // Allow Infection

	if(mode == MODE_NONE || !id && mode == MODE_SET) id = fnGetRandomAlive(random_num(1, iPlayersnum)) // Choose player randomly?

	zombieme(id, 0, 0, 0, 0) // Turn player into the first zombie
	
	if(g_escape_map) {
		if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
		else do_random_spawn(id, 1) // regular spawn
	}
	forward_id = id // Remember id for calling our forward later

	for(id = 1; id <= g_maxplayers; id++) { // Remaining players should be humans (CTs)
		// Not alive / First zombie
		if(!g_isalive[id] || forward_id == id) continue;

		if(g_zombie[id] || g_hm_special[id])
			humanme(id, 0, 1)
		
		// Switch to CT
		if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
			remove_task(id+TASK_TEAM)
			fm_cs_set_user_team(id, FM_CS_TEAM_CT)
			fm_user_team_update(id)
		}
	}
	
	// Show First Zombie HUD notice
	set_hudmessage(255, 0, 0, HUD_EVENT_X, HUD_EVENT_Y, 0, 0.0, 5.0, 1.0, 1.0, -1)
	ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_FIRST", g_playername[forward_id])

	if(g_ambience_sounds[AMBIENCE_SOUNDS_INFECTION]) { // Start ambience sounds
		remove_task(TASK_AMBIENCESOUNDS)
		set_task(2.0, "ambience_sound_effects", TASK_AMBIENCESOUNDS)
	}
	g_modestarted = true // Mode fully started!
	g_newround = false // No more a new round
	remove_task(TASK_MAKEZOMBIE) // Bug Fix
	ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, MODE_INFECTION, forward_id); // Round start forward
	return 1
}
// Zombie Me Function (player id, infector, turn into a nemesis, silent mode, deathmsg and rewards, turn into assassin)
zombieme(id, infector, classid, silentmode, rewards) {
	ExecuteForward(g_forwards[INFECT_ATTEMP], g_fwDummyResult, id, infector, classid) // User infect attempt forward
	
	// One or more plugins blocked the infection. Only allow this after making sure it's
	// not going to leave us with no zombies. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first zombie e.g.
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetZombies() > g_lastplayerleaving) return;
	
	ExecuteForward(g_forwards[INFECTED_PRE], g_fwDummyResult, id, infector, classid) // Pre user infect forward

	remove_task(id+TASK_AURA) // Remove aura (bugfix)
	
	if(silentmode != 2) remove_task(id) // Nao buga a frozen
	
	// Show zombie class menu if they haven't chosen any (e.g. just connected)
	if(g_zombieclassnext[id] == ZCLASS_NONE && get_pcvar_num(cvar_zclasses) && classid <= 0
	|| !g_choosed_zclass[id] && get_pcvar_num(cvar_zclasses) && classid <= 0 && get_pcvar_num(cvar_chosse_instantanly))
		set_task(0.2, "show_menu_zclass", id)
	
	g_zombieclass[id] = g_zombieclassnext[id]

	if(g_zombieclass[id] == ZCLASS_NONE) g_zombieclass[id] = 0
	
	// Way to go...
	g_zombie[id] = true
	g_zm_special[id] = 0
	g_hm_special[id] = 0
	g_damagedealt[id] = 0

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
	if(rewards && infector) {
		// Send death notice and fix the "dead" attrib on scoreboard
		SendDeathMsg(infector, id)
		FixDeadAttrib(id)
		
		// Reward frags, deaths, health, and ammo packs
		UpdateFrags(infector, id, get_pcvar_num(cvar_fragsinfect), 1, 1)
		g_ammopacks[infector] += get_pcvar_num(cvar_ammoinfect)
		fm_set_user_health(infector, pev(infector, pev_health) + get_pcvar_num(cvar_zm_basehp[0]))
	}
	
	// Cache speed, and name for player's class
	g_spd[id] = float(ArrayGetCell(g_zclass_spd, g_zombieclass[id]))
	g_zombie_knockback[id] = Float:ArrayGetCell(g_zclass_kb, g_zombieclass[id])
	ArrayGetString(g_zclass_name, g_zombieclass[id], g_zombie_classname[id], charsmax(g_zombie_classname[]))
	
	static sound[64] // Set zombie attributes based on the mode
	if(!silentmode) {
		if(classid >= MAX_SPECIALS_ZOMBIES) {
			g_zm_special[id] = classid
			
			static special_id; special_id = g_zm_special[id]-MAX_SPECIALS_ZOMBIES

			if(ArrayGetCell(g_zm_special_health, special_id) == 0) fm_set_user_health(id, get_pcvar_num(cvar_zm_health[0]) * fnGetAlive()) // Set Health [0 = auto]
			else fm_set_user_health(id, ArrayGetCell(g_zm_special_health, special_id))
			
			// Set gravity, unless frozen
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zm_special_gravity, special_id))
			else g_frozen_gravity[id] = Float:ArrayGetCell(g_zm_special_gravity, special_id)
			
			g_spd[id] = float(ArrayGetCell(g_zm_special_speed, special_id))
			g_custom_leap_cooldown[id] = Float:ArrayGetCell(g_zm_special_leap_c, special_id)
			g_zombie_knockback[id] = Float:ArrayGetCell(g_zm_special_knockback, special_id)
			
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		}
		else if(classid > 0 && zm_special_enable[classid]) {
			g_zm_special[id] = classid
			
			// Set health [0 = auto]
			if(get_pcvar_num(cvar_zm_health[classid]) == 0) {
				if(get_pcvar_num(cvar_zm_basehp[classid]) == 0) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, 0) * fnGetAlive())
				else fm_set_user_health(id, get_pcvar_num(cvar_zm_basehp[classid]) * fnGetAlive())
			}
			else fm_set_user_health(id, get_pcvar_num(cvar_zm_health[classid]))
				
			// Set gravity, unless frozen
			if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_zmgravity[classid]))
			else g_frozen_gravity[id] = get_pcvar_float(cvar_zmgravity[classid])
			
			if(classid == PREDATOR) { // Predator Powers
				g_zm_special[id] = PREDATOR
				set_task(1.0, "turn_invisible", id)
			}
			else if(classid == BOMBARDIER) { // Bombardier Powers
				give_hegrenade_bombardier(id+1213131)
				set_task(3.0, "give_hegrenade_bombardier", id+1213131, _, _, "b")
			}
			else if(classid == DRAGON) {
				if(g_isbot[id]) set_task(random_float(5.0, 15.0), "use_cmd", id, _, _, "b") // Dragon Skills Bot Suport
				zp_colored_print(id, 1, "%L", id, "DRAGON_INFO") // Dragon Info Msg
			}
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		}
		else if((fnGetZombies() == 1) && g_zm_special[id] <= 0) {
			g_firstzombie[id] = true // First zombie
			if(silentmode != 2) fm_set_user_health(id, floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zm_health[0])))
			
			// Set gravity, if frozen set the restore gravity value instead
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])
			
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set zombie maxspeed
			
			// Infection sound
			ArrayGetString(ar_sound[0], random_num(0, ArraySize(ar_sound[0]) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
		}
		else { // Infected by someone
			// Set health and gravity, unless frozen
			if(silentmode != 2) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id]))
			
			// Set gravity, if frozen set the restore gravity value instead
			if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
			else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])
			
			ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set zombie maxspeed
			ArrayGetString(ar_sound[0], random_num(0, ArraySize(ar_sound[0]) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM) // Infection sound
			
			// Show Infection HUD notice
			set_hudmessage(255, 0, 0, HUD_INFECT_X, HUD_INFECT_Y, 0, 0.0, 5.0, 1.0, 1.0, -1)
			if(infector) ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT2", g_playername[id], g_playername[infector])
			else ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_INFECT", g_playername[id])
		}
	}
	else { // Silent mode, no HUD messages, no infection sounds
		// Set health and gravity, unless frozen
		if(silentmode != 2) fm_set_user_health(id, ArrayGetCell(g_zclass_hp, g_zombieclass[id])) // Dont change HP when choose other zclass instantanly
		if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id]))
		else g_frozen_gravity[id] = Float:ArrayGetCell(g_zclass_grav, g_zombieclass[id])

		ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set zombie maxspeed
	}
	
	// Remove previous tasks
	remove_task(id+TASK_MODEL)
	remove_task(id+TASK_BLOOD)
	remove_task(id+TASK_AURA)
	remove_task(id+TASK_BURN)
	
	// Switch to T
	if(fm_cs_get_user_team(id) != FM_CS_TEAM_T) { // need to change team?
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_T)
		fm_user_team_update(id)
	}
	
	reset_player_models(id) 
	if(!g_frozen[id]) reset_user_rendering(id)

	cs_set_user_zoom(id, CS_RESET_ZOOM, 1) // Remove any zoom (bugfix)
	cs_set_user_armor(id, 0, CS_ARMOR_NONE) // Remove armor
	
	// Drop weapons when infected
	drop_weapons(id, 1)
	drop_weapons(id, 2)
	
	// Strip zombies from guns and give them a knife
	fm_strip_user_weapons(id)
	fm_give_item(id, "weapon_knife")
	
	infection_effects(id) // Fancy effects
	
	// Nemesis aura task
	if(g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
		if(g_zm_special[id] > 0 && zm_special_enable[g_zm_special[id]] && get_pcvar_num(cvar_zm_aura[g_zm_special[id]]))
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
	}
	else {
		if(ArrayGetCell(g_zm_special_aurarad, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0)
			set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
	}
	
	if(cs_get_user_nvg(id)) { // Remove CS nightvision if player owns one (bugfix)
		cs_set_user_nvg(id, 0)
		nvision_toggle_off(id)
	}

	static enable; enable = 0 // Give Zombies Night Vision?
	if(classid >= MAX_SPECIALS_ZOMBIES) enable = ArrayGetCell(g_zm_special_nvision, classid-MAX_SPECIALS_ZOMBIES)
	else enable = get_pcvar_num(cvar_zm_nvggive[classid])
	
	if(enable) {
		g_nvision[id] = true
		if(!g_isbot[id]) {
			if(enable == 1) { // Turn on Night Vision automatically?
				g_nvisionenabled[id] = true
				user_nightvision(id, 1)
			}
			else nvision_toggle_off(id)
		}
		else cs_set_user_nvg(id, 1); // turn on NVG for bots
	}
	else if(g_nvision[id]) { // Disable nightvision when turning into human/survivor (bugfix)
		nvision_toggle_off(id)
		g_nvision[id] = false
	}

	if(get_pcvar_num(cvar_zombiefov) != 90 && get_pcvar_num(cvar_zombiefov) != 0) { // Set custom FOV?
		message_begin(MSG_ONE, g_msgSetFOV, _, id)
		write_byte(get_pcvar_num(cvar_zombiefov)) // fov angle
		message_end()
	}
	
	if(g_zm_special[id] <= 0 && get_pcvar_num(cvar_zombiebleeding)) set_task(0.7, "make_blood", id+TASK_BLOOD, _, _, "b") // Call the bloody task

	if(g_zm_special[id] <= 0) set_task(random_float(50.0, 70.0), "zombie_play_idle", id+TASK_BLOOD, _, _, "b") // Idle sounds task
	
	turn_off_flashlight(id) // Turn off zombie's flashlight

	reset_player_models(id) 
	if(!g_frozen[id]) reset_user_rendering(id)

	ExecuteForward(g_forwards[INFECTED_POST], g_fwDummyResult, id, infector, classid) // Post user infect forward
	fnCheckLastZombie() // Last Zombie Check
}
humanme(id, classid, silentmode) { // Function Human Me (player id, turn into a survivor, silent mode)
	ExecuteForward(g_forwards[HUMANIZE_ATTEMP], g_fwDummyResult, id, classid) // User humanize attempt forward
	
	// One or more plugins blocked the "humanization". Only allow this after making sure it's
	// not going to leave us with no humans. Take into account a last player leaving case.
	// BUGFIX: only allow after a mode has started, to prevent blocking first survivor e.g.
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED && g_modestarted && fnGetHumans() > g_lastplayerleaving) return;

	ExecuteForward(g_forwards[HUMANIZED_PRE], g_fwDummyResult, id, classid) // Pre user humanize forward
	
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
	g_canbuy[id] = 2
	g_user_custom_speed[id] = false
	g_choosed_zclass[id] = false
	g_buytime[id] = get_gametime()
	g_damagedealt[id] = 0

	remove_task(id+TASK_AURA) // Remove survivor/sniper/berserker's aura (bugfix)
	
	// Remove spawn protection (bugfix)
	g_nodamage[id] = false
	set_pev(id, pev_takedamage, DAMAGE_AIM)
	set_pev(id, pev_effects, pev(id, pev_effects) &~ EF_NODRAW)

	native_set_user_frozen(id, 0)

	g_burning_dur[id] = 0 // Reset burning duration counter (bugfix)

	if(cs_get_user_nvg(id)) { // Remove CS nightvision if player owns one (bugfix)
		cs_set_user_nvg(id, 0)
		nvision_toggle_off(id)
	}

	drop_weapons(id, 1) // Drop previous weapons
	drop_weapons(id, 2)
	
	// Strip off from weapons
	fm_strip_user_weapons(id) 
	fm_give_item(id, "weapon_knife")

	if(classid >= MAX_SPECIALS_HUMANS) { // Set human attributes based on the mode
		g_hm_special[id] = classid
		
		static special_id; special_id = g_hm_special[id]-MAX_SPECIALS_HUMANS

		if(ArrayGetCell(g_hm_special_health, special_id) == 0) fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]) * fnGetAlive()) // Set Health [0 = auto]
		else fm_set_user_health(id, ArrayGetCell(g_hm_special_health, special_id))
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, Float:ArrayGetCell(g_hm_special_gravity, special_id))
		else g_frozen_gravity[id] = Float:ArrayGetCell(g_hm_special_gravity, special_id)
		
		g_spd[id] = float(ArrayGetCell(g_hm_special_speed, special_id))
		g_custom_leap_cooldown[id] = Float:ArrayGetCell(g_hm_special_leap_c, special_id)

		ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set human maxspeed
		turn_off_flashlight(id) // Turn off his flashlight

		if(ArrayGetCell(g_hm_special_aurarad, special_id) > 0) set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b") // Give the special a nice aura

		// Special Humans bots will also need nightvision to see in the dark
		if(g_isbot[id]) {
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}
	}
	else if(classid > 0 && hm_special_enable[classid]) {
		g_hm_special[id] = classid
			
		// Set Health [0 = auto]
		if(get_pcvar_num(cvar_hm_health[classid]) == 0) {
			if(get_pcvar_num(cvar_hm_basehp[classid]) == 0) fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0]) * fnGetAlive())
			else fm_set_user_health(id, get_pcvar_num(cvar_hm_basehp[classid]) * fnGetAlive())
		}
		else fm_set_user_health(id, get_pcvar_num(cvar_hm_health[classid]))
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[classid]))
		else g_frozen_gravity[id] = get_pcvar_float(cvar_hmgravity[classid])

		ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set human maxspeed
		turn_off_flashlight(id) // Turn off his flashlight

		if(get_pcvar_num(cvar_hm_aura[classid])) set_task(0.1, "human_aura", id+TASK_AURA, _, _, "b") // Give the class a nice aura
		
		// Special Humans bots will also need nightvision to see in the dark
		if(g_isbot[id]) {
			g_nvision[id] = true
			cs_set_user_nvg(id, 1)
		}

		// Set human attributes based on the mode
		if(g_hm_special[id] == SURVIVOR) {
			static survweapon[32]; get_pcvar_string(cvar_survweapon, survweapon, charsmax(survweapon))
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
		else if(g_hm_special[id] == SPY) {
			fm_give_item(id, "weapon_m3")
			ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[CSW_M3], AMMOTYPE[CSW_M3], MAXBPAMMO[CSW_M3])
			set_task(1.0, "turn_invisible", id)
		}
	}
	else { // Human taking an antidote
		fm_set_user_health(id, get_pcvar_num(cvar_hm_health[0])) // Set health
		
		// Set gravity, unless frozen
		if(!g_frozen[id]) set_pev(id, pev_gravity, get_pcvar_float(cvar_hmgravity[0]))
		else g_frozen_gravity[id] = get_pcvar_float(cvar_hmgravity[0])

		ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Set human maxspeed
		
		if(get_pcvar_num(cvar_buycustom)) set_task(0.2, "menu_buy_show", id+TASK_SPAWN) // Show custom buy menu?

		if(!silentmode) { // Silent mode = no HUD messages, no antidote sound
			// Antidote sound
			static sound[64]
			ArrayGetString(ar_sound[18], random_num(0, ArraySize(ar_sound[18]) - 1), sound, charsmax(sound))
			emit_sound(id, CHAN_ITEM, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
			
			// Show Antidote HUD notice
			set_hudmessage(10, 255, 235, HUD_INFECT_X, HUD_INFECT_Y, 1, 0.0, 5.0, 1.0, 1.0, -1)
			ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_ANTIDOTE", g_playername[id])
		}
	}
	
	// Switch to CT
	if(fm_cs_get_user_team(id) != FM_CS_TEAM_CT) { // need to change team?
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
	
	// Give nvision for humans ?
	static enable; enable = 0
	if(classid >= MAX_SPECIALS_HUMANS) enable = ArrayGetCell(g_hm_special_nvision, classid-MAX_SPECIALS_HUMANS)
	else enable = get_pcvar_num(cvar_hm_nvggive[classid])

	if(enable) {
		g_nvision[id] = true
		if(!g_isbot[id]) {
			if(enable == 1) { // Turn on Night Vision automatically?
				g_nvisionenabled[id] = true
				user_nightvision(id, 1)
			}
			else nvision_toggle_off(id)
		}
		else cs_set_user_nvg(id, 1); // turn on NVG for bots
	}
	else if(g_nvision[id]) { // Disable nightvision when turning into human/survivor (bugfix)
		nvision_toggle_off(id)
		g_nvision[id] = false
	}

	reset_user_rendering(id) // Reset user Rendering

	ExecuteForward(g_forwards[HUMANIZED_POST], g_fwDummyResult, id, classid) // Post user humanize forward
	fnCheckLastZombie() // Last Zombie Check
}
/*================================================================================
 [Other Functions and Tasks]
=================================================================================*/
public cache_cvars() {
	g_cached_zombiesilent = get_pcvar_num(cvar_zombiesilent)
	g_cached_customflash = get_pcvar_num(cvar_customflash)
	g_cached_buytime = get_pcvar_float(cvar_buyzonetime)

	new i
	for(i = 1; i < MAX_SPECIALS_HUMANS; i++) {
		g_hm_cached_leap[i] = get_pcvar_num(cvar_leap_hm_allow[i])
		g_hm_cached_cooldown[i] = get_pcvar_float(cvar_leap_hm_cooldown[i])
	}
	for(i = 0; i < MAX_SPECIALS_ZOMBIES; i++)  {
		g_zm_cached_leap[i] = get_pcvar_num(cvar_leap_zm_allow[i])
		g_zm_cached_cooldown[i] = get_pcvar_float(cvar_leap_zm_cooldown[i])
	}
}
load_customization_from_files() {
	new path[64]; get_configsdir(path, charsmax(path))
	format(path, charsmax(path), "%s/%s", path, ZP_CUSTOMIZATION_FILE)

	// File not present
	if(!file_exists(path)) {
		new error[100]
		formatex(error, charsmax(error), "[ZP Special] Cannot load customization file %s!", path)
		set_fail_state(error)
		return;
	}

	// Zombie Escape Map Suport
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Escape Maps", "ZOMBIE ESCAPE SUPPORT MAPS", g_escape_maps)
	if(is_escape_map()) g_escape_map = true

	new i, x, szKey[150], num
	new zombie_special_names[MAX_SPECIALS_ZOMBIES][] = { "ZOMBIE", "NEMESIS", "ASSASSIN", "PREDATOR", "BOMBARDIER", "DRAGON" }
	new human_special_names[MAX_SPECIALS_HUMANS][] = { "HUMAN", "SURVIVOR", "SNIPER", "BERSERKER", "WESKER", "SPY" }

	// Section Main Configs
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Main Configs", "GAME NAME", g_modname, charsmax(g_modname));
	amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Main Configs", "NADE EXPLOSION RADIUS", NADE_EXPLOSION_RADIUS);

	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) {
		num = 0
		formatex(szKey, charsmax(szKey), "ENABLE %s", zombie_special_names[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Main Configs", szKey, num)

		if(num == 1 || num == 2 && !g_escape_map || num >= 3 && g_escape_map) zm_special_enable[i] =  true
		else zm_special_enable[i] =  false
	}

	for(i = 1; i < MAX_SPECIALS_HUMANS; i++) {
		num = 0
		formatex(szKey, charsmax(szKey), "ENABLE %s", human_special_names[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Main Configs", szKey, num)
		
		if(num == 1 || num == 2 && !g_escape_map || num >= 3 && g_escape_map) hm_special_enable[i] =  true
		else hm_special_enable[i] =  false
	}

	// Section Access Flags
	new user_access[40]
	new access_names[MAX_ACCESS_FLAGS][] = { "ADMIN MENU OF CLASSES", "START MODE INFECTION", "START MODE NEMESIS", "START MODE ASSASSIN", "START MODE PREDATOR", 
	"START MODE BOMBARDIER", "START MODE DRAGON", "START MODE SURVIVOR", "START MODE SNIPER", "START MODE BERSERKER", "START MODE WESKER", "START MODE SPY", 
	"START MODE SWARM", "START MODE MULTI", "START MODE PLAGUE", "START MODE LNJ", 	"ADMIN MENU OF MODES", "ADMIN MENU MAIN ACCESS", "ADMIN MODELS", "VIP MODELS", 
	"RESPAWN PLAYERS",	"MAKE ZOMBIE", "MAKE HUMAN", "MAKE NEMESIS", "MAKE SURVIVOR", "MAKE SNIPER", "MAKE ASSASSIN","MAKE BERSERKER", "MAKE PREDATOR", "MAKE WESKER", 
	"MAKE BOMBARDIER", "MAKE SPY", "MAKE DRAGON" }

	for(i = 0; i < MAX_ACCESS_FLAGS; i++) {
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Access Flags", access_names[i], user_access, charsmax(user_access)); 
		g_access_flag[i] = read_flags(user_access);
	}	

	// Player Models
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++) amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", human_special_names[i], model_human[i])
	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", zombie_special_names[i], model_zm_special[i])

	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN ZOMBIE", model_admin_zombie)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "VIP ZOMBIE", model_vip_zombie)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ADMIN HUMAN", model_admin_human)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "VIP HUMAN", model_vip_human)

	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "FORCE CONSISTENCY", g_force_consistency)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Player Models", "SAME MODELS FOR ALL", g_same_models_for_all)

	if(g_same_models_for_all) {
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Player Models", "ZOMBIE", g_zclass_playermodel)

		for(i = 0; i < ArraySize(g_zclass_playermodel); i++) { // Precache model and retrieve its modelindex
			ArrayGetString(g_zclass_playermodel, i, szKey, charsmax(szKey))
			ArrayPushCell(g_zclass_modelindex, precache_player_model(szKey))			
		}
		
	}

	// Weapon Models
	for(i = 1; i < MAX_SPECIALS_ZOMBIES; i++) {
		formatex(szKey, charsmax(szKey), "V_KNIFE %s", zombie_special_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_vknife_zm_special[i], charsmax(model_vknife_zm_special[]))
	}

	new special_hm_wpn_names[MAX_SPECIALS_HUMANS][] = { "KNIFE HUMAN", "WEAPON SURVIVOR", "AWP SNIPER", "KNIFE BERSERKER", "DEAGLE WESKER", "M3 SPY" }
	for(i = 0; i < MAX_SPECIALS_HUMANS; i++) {
		formatex(szKey, charsmax(szKey), "V_%s", special_hm_wpn_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_v_weapon_human[i], charsmax(model_v_weapon_human[]));
		formatex(szKey, charsmax(szKey), "P_%s", special_hm_wpn_names[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_p_weapon_human[i], charsmax(model_p_weapon_human[]));
	}
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE ADMIN HUMAN", model_knife_admin_human[VIEW_MODEL], charsmax(model_knife_admin_human[]))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE ADMIN HUMAN", model_knife_admin_human[PLAYER_MODEL], charsmax(model_knife_admin_human[]))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE VIP HUMAN", model_knife_vip_human[VIEW_MODEL], charsmax(model_knife_vip_human[]))	
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "P_KNIFE VIP HUMAN", model_knife_vip_human[PLAYER_MODEL], charsmax(model_knife_vip_human[]))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE ADMIN ZOMBIE", model_vknife_admin_zombie, charsmax(model_vknife_admin_zombie))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", "V_KNIFE VIP ZOMBIE", model_vknife_vip_zombie, charsmax(model_vknife_vip_zombie))

	new wpn_mdl_type[MAX_WPN_MDL][] = { "V", "P", "W" }
	for(i = 0; i < MAX_WPN_MDL; i++) {
		formatex(szKey, charsmax(szKey), "%s_GRENADE INFECT", wpn_mdl_type[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_grenade_infect[i], charsmax(model_grenade_infect[]))

		formatex(szKey, charsmax(szKey), "%s_GRENADE BOMBARDIER", wpn_mdl_type[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_grenade_bombardier[i], charsmax(model_grenade_bombardier[]))

		formatex(szKey, charsmax(szKey), "%s_GRENADE FIRE", wpn_mdl_type[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_grenade_fire[i], charsmax(model_grenade_fire[]))

		formatex(szKey, charsmax(szKey), "%s_GRENADE FROST", wpn_mdl_type[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_grenade_frost[i], charsmax(model_grenade_frost[]))

		formatex(szKey, charsmax(szKey), "%s_GRENADE FLARE", wpn_mdl_type[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Weapon Models", szKey, model_grenade_flare[i], charsmax(model_grenade_flare[]))
	}

	// Grenade Sprites
	new const grenade_type_str[MAX_GRENADES][] = { "FIRE", "FROST", "FLARE", "INFECTION" }
	new rgb_str[32], rgb[3][10]
	for(i = 0; i < MAX_GRENADES; i++) {
		formatex(szKey, charsmax(szKey), "ENABLE %s TRAIL", grenade_type_str[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, enable_trail[i])

		formatex(szKey, charsmax(szKey), "%s TRAIL", grenade_type_str[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, sprite_grenade_trail[i], charsmax(sprite_grenade_trail[]))

		if(i == FLARE) continue;

		formatex(szKey, charsmax(szKey), "ENABLE %s EXPLODE", grenade_type_str[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, enable_explode[i])

		formatex(szKey, charsmax(szKey), "%s EXPLODE", grenade_type_str[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, sprite_grenade_explode[i], charsmax(sprite_grenade_explode[]))

		formatex(szKey, charsmax(szKey), "ENABLE %s GIB", grenade_type_str[i])
		amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, enable_gib[i])

		formatex(szKey, charsmax(szKey), "%s GIB", grenade_type_str[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, sprite_grenade_gib[i], charsmax(sprite_grenade_gib[]))

		formatex(szKey, charsmax(szKey), "%s GRENADE RGB", grenade_type_str[i])
		amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", szKey, rgb_str, charsmax(rgb_str))

		parse(rgb_str, rgb[0], charsmax(rgb[]), rgb[1], charsmax(rgb[]), rgb[2], charsmax(rgb[]))
		grenade_rgb[i][0] = str_to_num(rgb[0])
		grenade_rgb[i][1] = str_to_num(rgb[1])
		grenade_rgb[i][2] = str_to_num(rgb[2])
		//log_amx("RGB %s = %d %d %d", grenade_type_str[i], grenade_rgb[i][0], grenade_rgb[i][1], grenade_rgb[i][2])
	}
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "RING", sprite_grenade_ring, charsmax(sprite_grenade_ring))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "FIRE", sprite_grenade_fire, charsmax(sprite_grenade_fire))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "SMOKE", sprite_grenade_smoke, charsmax(sprite_grenade_smoke))
	amx_load_setting_string(ZP_CUSTOMIZATION_FILE, "Grenade Sprites", "GLASS", sprite_grenade_glass, charsmax(sprite_grenade_glass))

	// Sounds
	new const ar_sounds_str[MAX_ARRAY_SOUNDS][] = { "ZOMBIE INFECT", "ZOMBIE DIE", "ZOMBIE FALL", "ZOMBIE MISS SLASH", "ZOMBIE MISS WALL", "ZOMBIE HIT NORMAL", "ZOMBIE HIT STAB",
	"ZOMBIE IDLE", "ZOMBIE IDLE LAST", "ZOMBIE MADNESS", "GRENADE INFECT EXPLODE", "GRENADE INFECT PLAYER", "GRENADE FIRE EXPLODE", "GRENADE FIRE PLAYER", "GRENADE FROST EXPLODE",
	"GRENADE FROST PLAYER", "GRENADE FROST BREAK", "GRENADE FLARE", "ANTIDOTE", "THUNDER" }
	
	for(i = 0; i < MAX_ARRAY_SOUNDS; i++) 
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", ar_sounds_str[i], ar_sound[i])

	for(i = 0; i < MAX_SPECIALS_ZOMBIES; i++) {
		if(i == 0) { // Backwards Compat
			formatex(szKey, charsmax(szKey), "DEFAULT ZOMBIE PAIN", zombie_special_names[i])
			
			if(!amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, zombie_pain[i])) {
				formatex(szKey, charsmax(szKey), "%s PAIN", zombie_special_names[i])
				amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, zombie_pain[i])
			}
		}
		else {
			formatex(szKey, charsmax(szKey), "%s PAIN", zombie_special_names[i])
			amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, zombie_pain[i])
		}
	}

	new mode_name_str[MAX_GAME_MODES][] = { "NONE", "INFECTION", "NEMESIS", "ASSASSIN", "PREDATOR", "BOMBARDIER", "DRAGON",
	"SURVIVOR", "SNIPER", "BERSERKER", "WESKER", "SPY", "SWARM", "MULTI", "PLAGUE", "LNJ" }

	for(i = 2; i < MAX_GAME_MODES; i++) {
		formatex(szKey, charsmax(szKey), "ROUND %s", mode_name_str[i])
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, sound_mod[i])
	}

	// End Round Sound
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "End Round Sound", "ENABLE END ROUND SOUNDS", g_enable_end_round_sounds)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "End Round Sound", "WIN ZOMBIES", sound_win_zombies)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "End Round Sound", "WIN HUMANS", sound_win_humans)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "End Round Sound", "WIN NO ONE", sound_win_no_one)

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
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "PRIMARY", g_weapon_realname[0])
	for(i = 0; i < ArraySize(g_weapon_realname[0]); i++) {
		ArrayGetString(g_weapon_realname[0], i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_weapon_ids[0], cs_weapon_name_to_id(wpn_ids))
		ArrayPushString(g_weapon_name[0], WEAPONNAMES[cs_weapon_name_to_id(wpn_ids)])		
		ArrayPushCell(g_weapon_is_custom[0], 0)
		g_weapon_i[0]++
	}	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "SECONDARY", g_weapon_realname[1])
	for(i = 0; i < ArraySize(g_weapon_realname[1]); i++) {
		ArrayGetString(g_weapon_realname[1], i, wpn_ids, charsmax(wpn_ids))
		ArrayPushCell(g_weapon_ids[1], cs_weapon_name_to_id(wpn_ids))
		ArrayPushString(g_weapon_name[1], WEAPONNAMES[cs_weapon_name_to_id(wpn_ids)])		
		ArrayPushCell(g_weapon_is_custom[1], 0)
		g_weapon_i[1]++
	}
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Buy Menu Weapons", "ADDITIONAL ITEMS", g_additional_items)

	// Extra Items: Weapons and their costs
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "NAMES", g_extraweapon_names)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "ITEMS", g_extraweapon_items)
	amx_load_setting_int_arr(ZP_CUSTOMIZATION_FILE, "Extra Items: Weapons and their costs", "COSTS", g_extraweapon_costs)	

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

	// Custom Skies
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "Custom Skies", "ENABLE", g_sky_enable)
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Custom Skies", "SKY NAMES", g_sky_names)

	if(g_sky_enable) { // Choose random sky and precache sky files
		new path[128], skyname[32]
		for(i = 0; i < ArraySize(g_sky_names); i++) {
			ArrayGetString(g_sky_names, i, skyname, charsmax(skyname))
			formatex(path, charsmax(path), "gfx/env/%sbk.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
			formatex(path, charsmax(path), "gfx/env/%sdn.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
			formatex(path, charsmax(path), "gfx/env/%sft.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
			formatex(path, charsmax(path), "gfx/env/%slf.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
			formatex(path, charsmax(path), "gfx/env/%srt.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
			formatex(path, charsmax(path), "gfx/env/%sup.tga", skyname); engfunc(EngFunc_PrecacheGeneric, path);
		}
	}
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Lightning Lights Cycle", "LIGHTS", lights_thunder) // Lightning Lights Cycle
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Zombie Decals", "DECALS", zombie_decals) // Zombie Decals

	// Knockback Power for Weapons
	new wpn_key
	for(i = 1; i < sizeof WEAPONENTNAMES; i++) {
		if(!WEAPONENTNAMES[i][0]) continue;

		wpn_key = cs_weapon_name_to_id(WEAPONENTNAMES[i])
		static buffer[32]; format(buffer, charsmax(buffer), "%s", WEAPONENTNAMES[i])
		replace_all(buffer, charsmax(buffer), "weapon_", "")
		strtoupper(buffer)
		amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "Knockback Power for Weapons", buffer, kb_weapon_power[wpn_key])
	}
	
	amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Objective Entities", "CLASSNAMES", g_objective_ents) // Objective Entities

	// SVC_BAD Prevention
	amx_load_setting_float(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "MODELCHANGE DELAY", g_modelchange_delay)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "HANDLE MODELS ON SEPARATE ENT", g_handle_models_on_separate_ent)
	amx_load_setting_int(ZP_CUSTOMIZATION_FILE, "SVC_BAD Prevention", "SET MODELINDEX OFFSET", g_set_modelindex_offset)

	// Load Zombie Special Class Death Sounds //
	temp_array[0] = ArrayCreate(64, 1)
	for(x = 1; x < MAX_SPECIALS_ZOMBIES; x++) {
		ArrayPushCell(g_zm_sp_deathsnd_start, ArraySize(g_zm_sp_deathsnd))
		formatex(szKey, charsmax(szKey), "%s DEATH", zombie_special_names[x])
		amx_load_setting_string_arr(ZP_CUSTOMIZATION_FILE, "Sounds", szKey, temp_array[0])
		
		if(ArraySize(temp_array[0]) > 0) {
			for(i = 0; i < ArraySize(temp_array[0]); i++) {
				ArrayGetString(temp_array[0], i, szKey, charsmax(szKey))
				ArrayPushString(g_zm_sp_deathsnd, szKey)
			}
		}
		else { // Backwards Compatibility
			for(i = 0; i < ArraySize(ar_sound[1]); i++) {
				ArrayGetString(ar_sound[1], i, szKey, charsmax(szKey))
				ArrayPushString(g_zm_sp_deathsnd, szKey)
			}
		}
		ArrayPushCell(g_zm_sp_deathsnd_end, ArraySize(g_zm_sp_deathsnd))
	}
	ArrayDestroy(temp_array[0])
}
save_customization() { // Save customization from files
	new i, buffer[512], section[64], Float:value_f, value, k, gameid, specialid

	for(i = 0; i < ArraySize(g_zclass_name); i++) { // Add any new zombie classes data at the end if needed
		if(ArrayGetCell(g_zclass_new, i)) {
			
			ArrayGetString(g_zclass_real_name, i, section, charsmax(section)) // Get real name

			ArrayGetString(g_zclass_name, i, buffer, charsmax(buffer)) // Add name
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))	
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "NAME", buffer)
			
			ArrayGetString(g_zclass_info, i, buffer, charsmax(buffer)) // Add info
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "INFO", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "INFO", buffer) 
			
			temp_array[0] = ArrayCreate(32, 1)	
			for(k = ArrayGetCell(g_zclass_modelsstart, i); k < ArrayGetCell(g_zclass_modelsend, i); k++) {
				ArrayGetString(g_zclass_playermodel, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[0], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "MODELS", temp_array[0]))
				amx_save_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "MODELS", temp_array[0]) // Add models

			ArrayDestroy(temp_array[0])

			temp_array[1] = ArrayCreate(64, 1)
			for(k = ArrayGetCell(g_zclass_deathsnd_start, i); k < ArrayGetCell(g_zclass_deathsnd_end, i); k++) {
				ArrayGetString(g_zclass_deathsnd, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[1], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "DEATH SOUND", temp_array[1]))
				amx_save_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "DEATH SOUND", temp_array[1])

			ArrayDestroy(temp_array[1])


			temp_array[2] = ArrayCreate(64, 1)
			for(k = ArrayGetCell(g_zclass_painsnd_start, i); k < ArrayGetCell(g_zclass_painsnd_end, i); k++) {
					ArrayGetString(g_zclass_painsnd, k, buffer, charsmax(buffer))
					ArrayPushString(temp_array[2], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "PAIN SOUND", temp_array[2]))
				amx_save_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "PAIN SOUND", temp_array[2])

			ArrayDestroy(temp_array[2])

			ArrayGetString(g_zclass_clawmodel, i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "CLAWMODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_ZOMBIECLASSES_FILE, section, "CLAWMODEL", buffer) // Add clawmodel
			
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

	for(i = EXTRAS_CUSTOM_STARTID; i < ArraySize(g_extraitem_realname); i++) { // Add any new extra items data at the end if needed
		if(ArrayGetCell(g_extraitem_new, i)) {
			ArrayGetString(g_extraitem_realname, i, section, charsmax(section)) // Add real name
			
			ArrayGetString(g_extraitem_name, i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", buffer) // Add Name

			value = ArrayGetCell(g_extraitem_cost, i)
			if(!amx_load_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", value))
				amx_save_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", value) // Add Cost

			static szTeam[32], team;
			temp_array[0] = ArrayCreate(32, 1)
			team = ArrayGetCell(g_extraitem_team, i)
			for(new t = 0; t < ArraySize(ZP_TEAM_NAMES); t++) {
				if(IsTeam(t)) {
					ArrayGetString(ZP_TEAM_NAMES, t, szTeam, charsmax(szTeam))
					ArrayPushString(temp_array[0], szTeam)
				}
			}
			if(!amx_load_setting_string_arr(ZP_EXTRAITEMS_FILE, section, "TEAMS", temp_array[0]))
				amx_save_setting_string_arr(ZP_EXTRAITEMS_FILE, section, "TEAMS", temp_array[0]) // Add Team

			ArrayDestroy(temp_array[0])
		}
	}

	for(i = MAX_GAME_MODES; i < g_gamemodes_i; i++) { // Add any new gamemodes data at the end if needed
		gameid = i-MAX_GAME_MODES
		if(ArrayGetCell(g_gamemodes_new, gameid)) {

			ArrayGetString(g_gamemode_realname, gameid, section, charsmax(section)) // Add real name
			
			ArrayGetString(g_gamemode_name, gameid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", buffer) // Add Name

			value = ArrayGetCell(g_gamemode_enable, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value) // Add Value
				
			value = ArrayGetCell(g_gamemode_enable_on_ze_map, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE ON ESCAPE MAP", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE ON ESCAPE MAP", value) // Add Value

			value = ArrayGetCell(g_gamemode_chance, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value) // Add Value
				
			value = ArrayGetCell(g_gamemode_dm, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value) // Add Value

			value = ArrayGetCell(g_gamemode_respawn_limit, gameid)
			if(!amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN LIMIT", value))
				amx_save_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN LIMIT", value) // Add Value
		}
	}

	for(i = MAX_SPECIALS_HUMANS; i < g_hm_specials_i; i++) { // Add any new special classes data at the end if needed
		specialid = i-MAX_SPECIALS_HUMANS
		if(ArrayGetCell(g_hm_specials, specialid)) {
			ArrayGetString(g_hm_special_realname, specialid, section, charsmax(section)) // Add real name

			ArrayGetString(g_hm_special_name, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer)
			
			temp_array[0] = ArrayCreate(32, 1)
			for(k = ArrayGetCell(g_hm_special_modelstart, specialid); k < ArrayGetCell(g_hm_special_modelsend, specialid); k++) {
				ArrayGetString(g_hm_special_model, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[0], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0]))
				amx_save_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0]) // Add models

			ArrayDestroy(temp_array[0])

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

			value = ArrayGetCell(g_hm_special_nvision, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value) // Add Value
				
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
				
			value = ArrayGetCell(g_hm_special_enable, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value) // Add Value
		}
	}

	for(i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++) {
		specialid = i-MAX_SPECIALS_ZOMBIES
		if(ArrayGetCell(g_zm_specials, specialid)) {
			ArrayGetString(g_zm_special_realname, specialid, section, charsmax(section)) // Add real name

			ArrayGetString(g_zm_special_name, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer)
			
			temp_array[0] = ArrayCreate(32, 1)
			for(k = ArrayGetCell(g_zm_special_modelstart, specialid); k < ArrayGetCell(g_zm_special_modelsend, specialid); k++) {
				ArrayGetString(g_zm_special_model, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[0], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0]))
				amx_save_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0]) // Add models

			ArrayDestroy(temp_array[0])

			ArrayGetString(g_zm_special_knifemodel, specialid, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", buffer)
			
			temp_array[1] = ArrayCreate(64, 1)
			for(k = ArrayGetCell(g_zm_special_painsndstart, specialid); k < ArrayGetCell(g_zm_special_painsndsend, specialid); k++) {
				ArrayGetString(g_zm_special_painsound, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[1], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", temp_array[1]))
				amx_save_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", temp_array[1])

			ArrayDestroy(temp_array[1])
				
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

			value = ArrayGetCell(g_zm_special_nvision, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value) // Add Value
				
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
				
			value = ArrayGetCell(g_zm_special_allow_burn, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW BURN", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW BURN", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_allow_frost, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW FROST", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW FROST", value) // Add Value
				
			value = ArrayGetCell(g_zm_special_enable, specialid)
			if(!amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value))
				amx_save_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value) // Add Value

			temp_array[1] = ArrayCreate(64, 1)
			for(k = ArrayGetCell(g_zm_sp_deathsnd_start, i-1); k < ArrayGetCell(g_zm_sp_deathsnd_end, i-1); k++) {
				ArrayGetString(g_zm_sp_deathsnd, k, buffer, charsmax(buffer))
				ArrayPushString(temp_array[1], buffer)
			}
			if(!amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "DEATH SOUND", temp_array[1]))
				amx_save_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "DEATH SOUND", temp_array[1])

			ArrayDestroy(temp_array[1])
		}
	}

	for(i = 0; i < ArraySize(g_weapon_name[0]); i++) { // Add any new custom weapons data at the end if needed
		if(ArrayGetCell(g_weapon_is_custom[0], i)) {
			ArrayGetString(g_weapon_realname[0], i, section, charsmax(section)) // Add real name
			
			ArrayGetString(g_weapon_name[0], i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_WEAPONS_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_WEAPONS_FILE, section, "NAME", buffer) // Add Name
		}
	}
	for(i = 0; i < ArraySize(g_weapon_name[1]); i++) {
		if(ArrayGetCell(g_weapon_is_custom[1], i)) {
			ArrayGetString(g_weapon_realname[1], i, section, charsmax(section)) // Add real name
			
			ArrayGetString(g_weapon_name[1], i, buffer, charsmax(buffer))
			if(!amx_load_setting_string(ZP_WEAPONS_FILE, section, "NAME", buffer, charsmax(buffer)))
				amx_save_setting_string(ZP_WEAPONS_FILE, section, "NAME", buffer) // Add Name
		}
	}

	// Free arrays containing class/item overrides
	ArrayDestroy(g_zclass_new)
	ArrayDestroy(g_zm_specials)
	ArrayDestroy(g_hm_specials)
	ArrayDestroy(g_gamemodes_new)
	ArrayDestroy(g_extraitem_new)
}
public register_ham_czbots(id) { // Register Ham Forwards for CZ bots
	if(g_hamczbots || !g_isconnected[id] || !get_pcvar_num(cvar_botquota)) return; // Make sure it's a CZ bot and it's still connected
	
	RegisterHamFromEntity(Ham_Spawn, id, "fw_PlayerSpawn_Post", 1)
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled")
	RegisterHamFromEntity(Ham_Killed, id, "fw_PlayerKilled_Post", 1)
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage")
	RegisterHamFromEntity(Ham_TakeDamage, id, "fw_TakeDamage_Post", 1)
	RegisterHamFromEntity(Ham_TraceAttack, id, "fw_TraceAttack")

	g_hamczbots = true // Ham forwards for CZ bots succesfully registered

	if(is_user_alive(id)) fw_PlayerSpawn_Post(id) // If the bot has already spawned, call the forward manually for him
}
public disable_minmodels(id) { // Disable minmodels task
	if(!g_isconnected[id]) return;
	client_cmd(id, "cl_minmodels 0")
	client_cmd(id, "gl_fog 1")
}
public bot_buy_extras(taskid) { // Bots automatically buy extra items
	// Specials bots have nothing to buy by default
	if(!g_isalive[ID_SPAWN] || g_hm_special[ID_SPAWN] > 0 || g_zm_special[ID_SPAWN] > 0 || g_bot_extra_count[ID_SPAWN] >= get_pcvar_num(cvar_bot_maxitem)) return;
	
	if(!g_zombie[ID_SPAWN]) buy_extra_item(ID_SPAWN, EXTRA_NVISION, 1) // Attempt to buy Night Vision	
	buy_extra_item(ID_SPAWN, random_num(0, g_extraitem_i-1), 1) // Attempt to buy a item

	set_task(get_pcvar_float(cvar_bot_buyitem_interval), "bot_buy_extras", ID_SPAWN+TASK_SPAWN)
}
public refill_bpammo(const args[], id) { // Refill BP Ammo Task
	if(!g_isalive[id] || g_zombie[id]) return; // Player died or turned into a zombie
	
	set_msg_block(g_msgAmmoPickup, BLOCK_ONCE)
	ExecuteHamB(Ham_GiveAmmo, id, MAXBPAMMO[REFILL_WEAPONID], AMMOTYPE[REFILL_WEAPONID], MAXBPAMMO[REFILL_WEAPONID])
}
balance_teams() { // Balance Teams Task
	static iPlayersnum; iPlayersnum = fnGetPlaying() // Get amount of users playing
	
	if(iPlayersnum < 1) return; // No players, don't bother
	
	// Split players evenly
	static iTerrors, iMaxTerrors, id, team[33]
	iMaxTerrors = iPlayersnum/2
	iTerrors = 0
	
	// First, set everyone to CT
	for(id = 1; id <= g_maxplayers; id++) {
		if(!g_isconnected[id]) continue; // Skip if not connected

		team[id] = fm_cs_get_user_team(id)
		if(team[id] == FM_CS_TEAM_SPECTATOR || team[id] == FM_CS_TEAM_UNASSIGNED) continue; // Skip if not playing
		
		remove_task(id+TASK_TEAM)
		fm_cs_set_user_team(id, FM_CS_TEAM_CT) // Set team
		team[id] = FM_CS_TEAM_CT
	}

	while(iTerrors < iMaxTerrors) { // Then randomly set half of the players to Terrorists
		if(++id > g_maxplayers) id = 1 // Keep looping through all players

		if(!g_isconnected[id]) continue; // Skip if not connected

		if(team[id] != FM_CS_TEAM_CT) continue; // Skip if not playing or already a Terrorist

		if(random_num(0, 1)) { // Random chance
			fm_cs_set_user_team(id, FM_CS_TEAM_T)
			team[id] = FM_CS_TEAM_T
			iTerrors++
		}
	}
}
public welcome_msg() { // Welcome Message Task
	zp_colored_print(0, 0, "^x01**** ^x04Zombie Plague Special %s^x01 ****", VERSION) // Show mod info
	zp_colored_print(0, 1, "%L", LANG_PLAYER, "NOTICE_INFO1")
	if(!get_pcvar_num(cvar_hm_infammo[0])) zp_colored_print(0, 1, "%L", LANG_PLAYER, "NOTICE_INFO2")

	set_hudmessage(0, 125, 200, HUD_EVENT_X, HUD_EVENT_Y, 1, 0.0, 3.0, 2.0, 1.0, -1) // Show T-virus HUD notice
	ShowSyncHudMsg(0, g_MsgSync[0], "%L", LANG_PLAYER, "NOTICE_VIRUS_FREE")
}
public respawn_player_check_task(taskid) { // Respawn Player Check Task (if killed by worldspawn)
	if(g_isalive[ID_SPAWN] || g_endround) return; // Successfully spawned or round ended

	static team; team = fm_cs_get_user_team(ID_SPAWN) // Get player's team

	if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED) return; // Player moved to spectators

	// If player was being spawned as a zombie, set the flag again
	if(g_zombie[ID_SPAWN]) g_respawn_as_zombie[ID_SPAWN] = true
	else g_respawn_as_zombie[ID_SPAWN] = false
	
	respawn_player_manually(ID_SPAWN)
}
public respawn_player_task(taskid) { // Respawn Player Task
	static team; team = fm_cs_get_user_team(ID_SPAWN) // Get player's team

	if(team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED)
		return;
		
	if((!g_endround && !g_isalive[ID_SPAWN]) && (!(g_currentmode > MODE_LNJ) || (g_deathmatchmode > 0))) {
		// Infection rounds = none of the above
		if(g_currentmode == MODE_NONE) {
			g_respawn_as_zombie[ID_SPAWN] = false
			respawn_player_manually(ID_SPAWN)
			return;
		}
		else {
			if(!get_pcvar_num(cvar_mod_allow_respawn[MODE_INFECTION]) && (g_currentmode == MODE_INFECTION || g_currentmode == MODE_MULTI))
				return;
				
			if(g_currentmode < MAX_GAME_MODES && g_currentmode != MODE_INFECTION && g_currentmode != MODE_MULTI) {
				if(!get_pcvar_num(cvar_mod_allow_respawn[g_currentmode])) 
					return;
			}
			 
			// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
			if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[ID_SPAWN] = true
			else if(g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR) g_respawn_as_zombie[ID_SPAWN] = false
			
			g_respawn_count[ID_SPAWN]++
			respawn_player_manually(ID_SPAWN)
		}
	}
}
respawn_player_manually(id) { // Respawn Player Manually (called after respawn checks are done)
	// Set proper team before respawning, so that the TeamInfo message that's sent doesn't confuse PODBots
	if(g_respawn_as_zombie[id]) fm_cs_set_user_team(id, FM_CS_TEAM_T)
	else fm_cs_set_user_team(id, FM_CS_TEAM_CT)
	
	ExecuteHamB(Ham_CS_RoundRespawn, id) // Respawning a player has never been so easy
}

check_round(leaving_player) { // Check Round Task -check that we still have both zombies and humans on a round-
	if(g_endround || task_exists(TASK_MAKEZOMBIE)) return; // Round ended or make_a_zombie task still active
	
	// Get alive players count
	static iPlayersnum, id
	iPlayersnum = fnGetAlive()

	if(iPlayersnum < 2) return; // Last alive player, don't bother
	
	if(g_zombie[leaving_player] && fnGetZombies() == 1) { // Last zombie disconnecting
		if(fnGetHumans() == 1 && fnGetCTs() == 1) return; // Only one CT left, don't bother
		
		// Pick a random one to take his place
		while((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player) { /* keep looping */ }

		zp_colored_print(0, 1, "%L", LANG_PLAYER, "LAST_ZOMBIE_LEFT", g_playername[id]) // Show last zombie left notice

		g_lastplayerleaving = true // Set player leaving flag
		zombieme(id, 0, g_zm_special[leaving_player], 0, 0) // Turn into a Special class or just a zombie?
		g_lastplayerleaving = false // Remove player leaving flag
		
		// If Specials, set chosen player's health to that of the one who's leaving
		if(get_pcvar_num(cvar_keephealthondisconnect) && g_zm_special[leaving_player] > 0 && g_zm_special[leaving_player] < MAX_SPECIALS_ZOMBIES)
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
	else if(!g_zombie[leaving_player] && fnGetHumans() == 1) { // Last human disconnecting
		if(fnGetZombies() == 1 && fnGetTs() == 1) return; // Only one T left, don't bother
		
		// Pick a random one to take his place
		while((id = fnGetRandomAlive(random_num(1, iPlayersnum))) == leaving_player) { /* keep looping */ }
		
		zp_colored_print(0, 1, "%L", LANG_PLAYER, "LAST_HUMAN_LEFT", g_playername[id]) // Show last human left notice

		g_lastplayerleaving = true // Set player leaving flag
		humanme(id, g_hm_special[leaving_player], 0) // Turn into a Special class or just a human?
		g_lastplayerleaving = false // Remove player leaving flag
		
		if(get_pcvar_num(cvar_keephealthondisconnect) && (g_hm_special[leaving_player] > 0))
			fm_set_user_health(id, pev(leaving_player, pev_health))
	}
}
public lighting_effects() { // Lighting Effects Task
	cache_cvars() // Cache some CVAR values at every 5 secs
	
	// Get lighting style
	static lighting[2]
	if(g_custom_light) formatex(lighting, charsmax(lighting), custom_lighting)	
	else if(g_currentmode == MODE_ASSASSIN) formatex(lighting, charsmax(lighting), "a") // no lighting in assassin round
	else get_pcvar_string(cvar_lighting, lighting, charsmax(lighting))

	strtolower(lighting)

	if(lighting[0] == '0') return; // Lighting disabled? ["0"]
	
	if(lighting[0] >= 'a' && lighting[0] <= 'd') { // Darkest light settings?
		static thunderclap_in_progress, Float:thunder
		thunderclap_in_progress = task_exists(TASK_THUNDER)
		thunder = get_pcvar_float(cvar_thunder)
		
		if(thunder > 0.0 && !task_exists(TASK_THUNDER_PRE) && !thunderclap_in_progress) { // Set thunderclap tasks if not existant
			g_lights_i = 0
			ArrayGetString(lights_thunder, random_num(0, ArraySize(lights_thunder) - 1), g_lights_cycle, charsmax(g_lights_cycle))
			g_lights_cycle_len = strlen(g_lights_cycle)
			set_task(thunder, "thunderclap", TASK_THUNDER_PRE)
		}

		if(!thunderclap_in_progress) {
			//engfunc(EngFunc_LightStyle, 0, lighting) // Set lighting only when no thunderclaps are going on
			set_all_light(lighting)
		}
	}
	else {
		remove_task(TASK_THUNDER_PRE) // Remove thunderclap tasks
		remove_task(TASK_THUNDER)
		set_all_light(lighting)
		//engfunc(EngFunc_LightStyle, 0, lighting)  // Set lighting
	}
}
public thunderclap() { // Thunderclap task
	if(g_lights_i == 0) { // Play thunder sound
		static sound[64]
		ArrayGetString(ar_sound[19], random_num(0, ArraySize(ar_sound[19]) - 1), sound, charsmax(sound))
		PlaySound(sound)
	}

	// Set lighting
	static light[2]
	light[0] = g_lights_cycle[g_lights_i]
	//engfunc(EngFunc_LightStyle, 0, light)
	set_all_light(light)

	g_lights_i++

	if(g_lights_i >= g_lights_cycle_len) { // Lighting cycle end?
		remove_task(TASK_THUNDER)
		lighting_effects()
	}
	else if(!task_exists(TASK_THUNDER)) set_task(0.1, "thunderclap", TASK_THUNDER, _, _, "b") // Lighting cycle start?
}
public ambience_sound_effects(taskid) { // Ambience Sound Effects Task
	static sound[64], iRand, duration, str_dur[32], ambience_id // Play a random sound depending on the round

	switch (g_currentmode) { // Check for current game mode
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

	PlaySound(sound) // Play it on clients
	set_task(float(duration), "ambience_sound_effects", TASK_AMBIENCESOUNDS) // Set the task for when the sound is done playing
}

ambience_sound_stop() client_cmd(0, "mp3 stop; stopsound") // Ambience Sounds Stop Task

public flashlight_charge(taskid) { // Flashlight Charge Task
	// Drain or charge?
	if(g_flashlight[ID_CHARGE]) g_flashbattery[ID_CHARGE] -= get_pcvar_num(cvar_flashdrain)
	else g_flashbattery[ID_CHARGE] += get_pcvar_num(cvar_flashcharge)

	if(g_flashbattery[ID_CHARGE] >= 100) { // Battery fully charged

		g_flashbattery[ID_CHARGE] = 100 // Don't exceed 100%

		// Update flashlight battery on HUD
		message_begin(MSG_ONE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(100) // battery
		message_end()

		remove_task(taskid); // Task not needed anymore
		return;
	}

	if(g_flashbattery[ID_CHARGE] <= 0) { // Battery depleted
		
		g_flashlight[ID_CHARGE] = false // Turn it off
		g_flashbattery[ID_CHARGE] = 0
		
		emit_sound(ID_CHARGE, CHAN_ITEM, cs_sounds[0], 1.0, ATTN_NORM, 0, PITCH_NORM) // Play flashlight toggle sound
		
		// Update flashlight status on HUD
		message_begin(MSG_ONE, g_msgFlashlight, _, ID_CHARGE)
		write_byte(0) // toggle
		write_byte(0) // battery
		message_end()

		remove_task(ID_CHARGE+TASK_FLASH) // Remove flashlight task for this player
	}
	else { // Update flashlight battery on HUD
		message_begin(MSG_ONE_UNRELIABLE, g_msgFlashBat, _, ID_CHARGE)
		write_byte(g_flashbattery[ID_CHARGE]) // battery
		message_end()
	}
}
public remove_spawn_protection(taskid) { // Remove Spawn Protection Task
	if(!g_isalive[ID_SPAWN]) return; // Not alive
	
	// Remove spawn protection
	g_nodamage[ID_SPAWN] = false
	set_pev(ID_SPAWN, pev_takedamage, DAMAGE_AIM)
	set_pev(ID_SPAWN, pev_effects, pev(ID_SPAWN, pev_effects) & ~EF_NODRAW)
}
public task_hide_money(taskid) { // Hide Player's Money Task
	if(!g_isalive[ID_SPAWN]) return; // Not alive

	// Hide money
	message_begin(MSG_ONE, g_msgHideWeapon, _, ID_SPAWN)
	write_byte(HIDE_MONEY) // what to hide bitsum
	message_end()

	// Hide the HL crosshair that's drawn
	message_begin(MSG_ONE, g_msgCrosshair, _, ID_SPAWN)
	write_byte(0) // toggle
	message_end()
}
turn_off_flashlight(id) { // Turn Off Flashlight and Restore Batteries
	fm_cs_set_user_batteries(id, 100) // Restore batteries for the next use
	
	// Check if flashlight is on
	if(pev(id, pev_effects) & EF_DIMLIGHT) set_pev(id, pev_impulse, IMPULSE_FLASHLIGHT) // Turn it off
	else set_pev(id, pev_impulse, 0) // Clear any stored flashlight impulse (bugfix)

	if(g_cached_customflash) { // Turn off custom flashlight
		g_flashlight[id] = false // Turn it off
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
public event_show_status(id) { // Some one aimed at someone
	if(!g_isbot[id] && g_isconnected[id] && get_pcvar_num(cvar_aiminfo)) { // Not a bot and is still connected
		
		static aimid; aimid = read_data(2) // Retrieve the aimed player's id
		if(g_zombie[id] == g_zombie[aimid] || get_pcvar_num(cvar_aiminfo) == 2) {
			static class[32], spid[32]

			if(g_zombie[aimid] && g_zm_special[aimid] >= MAX_SPECIALS_ZOMBIES) {
				ArrayGetString(g_zm_special_name, g_zm_special[aimid]-MAX_SPECIALS_ZOMBIES, spid, charsmax(spid))
				formatex(class, charsmax(class), "%L %s", id, "CLASS_CLASS", spid)
			}
			else if(!g_zombie[aimid] && g_hm_special[aimid] >= MAX_SPECIALS_HUMANS) {
				ArrayGetString(g_hm_special_name, g_hm_special[aimid]-MAX_SPECIALS_HUMANS, spid, charsmax(spid))
				formatex(class, charsmax(class), "%L %s", id, "CLASS_CLASS", spid)
			}
			else formatex(class, charsmax(class), "%L %L", id, "CLASS_CLASS", aimid, g_zombie[aimid] ? zm_special_class_langs[g_zm_special[aimid]] : hm_special_class_langs[g_hm_special[aimid]])
			
			// Show the notice
			set_hudmessage(g_zombie[aimid] ? 255 : 0, 50, g_zombie[aimid] ? 0 : 255, -1.0, 0.60, 1, 0.01, 3.0, 0.01, 0.01, -1)
			ShowSyncHudMsg(id, g_MsgSync[2],"%L", id, "AIM_INFO", g_playername[aimid], class, pev(aimid, pev_health), pev(aimid, pev_armorvalue), g_ammopacks[aimid])
		}
		else {
			set_hudmessage(g_zombie[aimid] ? 255 : 0, 50, g_zombie[aimid] ? 0 : 255, -1.0, 0.60, 1, 0.01, 3.0, 0.01, 0.01, -1)
			ShowSyncHudMsg(id, g_MsgSync[2],"%s", g_playername[aimid])
		}
	}
}
public event_hide_status(id) ClearSyncHud(id, g_MsgSync[2]) // Remove the aim-info message

grenade_explode(ent, type) { // Grenade Explosion
	if(g_endround && type == NADE_TYPE_INFECTION) return; // Round ended (bugfix)

	static Float:originF[3], attacker, sound[64], victim
	pev(ent, pev_origin, originF) // Get origin

	switch(type) {
		case NADE_TYPE_INFECTION: {
			create_blast(originF, INFECTION_BOMB) // Make the explosion
			ArrayGetString(ar_sound[10], random_num(0, ArraySize(ar_sound[10]) - 1), sound, charsmax(sound))
		}
		case NADE_TYPE_FROST: {
			create_blast(originF, FROST) // Make the explosion
			ArrayGetString(ar_sound[14], random_num(0, ArraySize(ar_sound[14]) - 1), sound, charsmax(sound))
		}
		case NADE_TYPE_NAPALM: {
			create_blast(originF, FIRE) // Make the explosion
			ArrayGetString(ar_sound[12], random_num(0, ArraySize(ar_sound[12]) - 1), sound, charsmax(sound))
		}
	}

	emit_sound(ent, CHAN_WEAPON, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)  // Infection nade explode sound
	
	attacker = pev(ent, pev_owner) // Get attacker
	victim = -1 

	if(!is_user_valid_connected(attacker)) { // Infection bomb owner disconnected? (bugfix)
		engfunc(EngFunc_RemoveEntity, ent) // Get rid of the grenade
		return;
	}

	while((victim = engfunc(EngFunc_FindEntityInSphere, victim, originF, NADE_EXPLOSION_RADIUS)) != 0) { // Collisions		
		if(!is_user_valid_alive(victim) || g_nodamage[victim]) continue; // Only effect alive players

		if(type == NADE_TYPE_INFECTION) {
			if(g_zombie[victim]) continue; // Only effect alive humans

			ExecuteForward(g_forwards[INFECTED_BY_BOMB_PRE], g_fwDummyResult, victim, attacker);

			if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) continue;
			if(fnGetHumans() == 1 || g_zm_special[attacker] == BOMBARDIER || !g_allowinfection) { // Last human is killed / Bombardier bomb can kill only
				ExecuteHamB(Ham_Killed, victim, attacker, 0)
				continue;
			}

			ArrayGetString(ar_sound[11], random_num(0, ArraySize(ar_sound[11]) - 1), sound, charsmax(sound))
			emit_sound(victim, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM) // Infected victim's sound

			zombieme(victim, attacker, 0, 1, 1) // Turn into zombie
			ExecuteForward(g_forwards[INFECTED_BY_BOMB_POST], g_fwDummyResult, victim, attacker);
		}
		else {
			if(!g_zombie[victim] || g_frozen[victim] && type == NADE_TYPE_FROST)  continue; // Only effect zombies

			if(type == NADE_TYPE_FROST) native_set_user_frozen(victim, 1)
			else native_set_user_burn(victim, 1)
		}
	}
	engfunc(EngFunc_RemoveEntity, ent) // Get rid of the grenade
}
public remove_freeze(id) { // Remove freeze task
	if(!g_isalive[id] || !g_frozen[id]) return; // Not alive or not frozen anymore
		
	
	g_frozen[id] = false; // Unfreeze
	
	// Restore gravity and maxspeed (bugfix)
	set_pev(id, pev_gravity, g_frozen_gravity[id])
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
	
	reset_user_rendering(id) // Reset Glow
	
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

	static sound[64] // Broken glass sound
	ArrayGetString(ar_sound[16], random_num(0, ArraySize(ar_sound[16]) - 1), sound, charsmax(sound))
	emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	
	static origin2[3]; get_user_origin(id, origin2) // Get player's origin
	
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
public remove_stuff() { // Remove Stuff Task
	static ent; ent = -1;
	if(get_pcvar_num(cvar_removedoors) > 0) { // Remove rotating doors
		while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door_rotating")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	if(get_pcvar_num(cvar_removedoors) > 1) { // Remove all doors
		while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "func_door")) != 0)
			engfunc(EngFunc_SetOrigin, ent, Float:{8192.0 ,8192.0 ,8192.0})
	}
	if(!get_pcvar_num(cvar_triggered)) { // Triggered lights
		while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", "light")) != 0) {
			dllfunc(DLLFunc_Use, ent, 0); // turn off the light
			set_pev(ent, pev_targetname, 0) // prevent it from being triggered
		}
	}
}
replace_weapon_models(id, weaponid) { // Set Custom Weapon Models
	switch (weaponid) {
		case CSW_KNIFE: { // Custom knife models
			if(g_zombie[id]) { // Zombies
				static szKnifeModel[64]
				if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
					ArrayGetString(g_zm_special_knifemodel, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, szKnifeModel, charsmax(szKnifeModel))
					set_pev(id, pev_viewmodel2, szKnifeModel)
				}
				else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
					if(zm_special_enable[g_zm_special[id]]) set_pev(id, pev_viewmodel2, model_vknife_zm_special[g_zm_special[id]])
				}
				else {
					// Admin knife models?
					if(get_pcvar_num(cvar_adminknifemodelszombie) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]) set_pev(id, pev_viewmodel2, model_vknife_admin_zombie)
					else if(get_pcvar_num(cvar_vipknifemodelszombie) && get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]) set_pev(id, pev_viewmodel2, model_vknife_vip_zombie)
					else {
						static clawmodel[100]
						ArrayGetString(g_zclass_clawmodel, g_zombieclass[id], clawmodel, charsmax(clawmodel))
						format(clawmodel, charsmax(clawmodel), "models/zombie_plague/%s", clawmodel)
						set_pev(id, pev_viewmodel2, clawmodel)
					}
				}
				set_pev(id, pev_weaponmodel2, "")
			}
			else { // Humans
				if(g_hm_special[id] == BERSERKER && hm_special_enable[BERSERKER]) {
					set_pev(id, pev_viewmodel2, model_v_weapon_human[BERSERKER])
					set_pev(id, pev_weaponmodel2, model_p_weapon_human[BERSERKER])
				}
				else if(get_pcvar_num(cvar_adminknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS]) {
					set_pev(id, pev_viewmodel2, model_knife_admin_human[VIEW_MODEL])
					set_pev(id, pev_weaponmodel2, model_knife_admin_human[PLAYER_MODEL])
				}
				else if(get_pcvar_num(cvar_vipknifemodelshuman) && get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS]) {
					set_pev(id, pev_viewmodel2, model_knife_vip_human[VIEW_MODEL])
					set_pev(id, pev_weaponmodel2, model_knife_vip_human[PLAYER_MODEL])
				}
				else {
					set_pev(id, pev_viewmodel2, model_v_weapon_human[0])
					set_pev(id, pev_weaponmodel2, model_p_weapon_human[0])
				}
			}
		}
		case CSW_AWP: { // Sniper's AWP
			if(g_hm_special[id] == SNIPER && hm_special_enable[SNIPER]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[SNIPER])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[SNIPER])
			}
		}
		case CSW_DEAGLE: { // Wesker's Deagle
			if(g_hm_special[id] == WESKER && hm_special_enable[WESKER]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[WESKER])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[WESKER])
			}
		}
		case CSW_M3: { // Spy's M3
			if(g_hm_special[id] == SPY && hm_special_enable[SPY]) {
				set_pev(id, pev_viewmodel2, model_v_weapon_human[SPY])
				set_pev(id, pev_weaponmodel2, model_p_weapon_human[SPY])
			}
				
		}
		case CSW_HEGRENADE: { // Infection bomb or fire grenade
			if(g_zombie[id]) {
				set_pev(id, pev_viewmodel2, g_zm_special[id] == BOMBARDIER ? model_grenade_bombardier[VIEW_MODEL] : model_grenade_infect[VIEW_MODEL])
				set_pev(id, pev_weaponmodel2, g_zm_special[id] == BOMBARDIER ? model_grenade_bombardier[PLAYER_MODEL] : model_grenade_infect[PLAYER_MODEL])
			}
			else {
				set_pev(id, pev_viewmodel2, model_grenade_fire[VIEW_MODEL])
				set_pev(id, pev_weaponmodel2, model_grenade_fire[PLAYER_MODEL])
			}
		}
		case CSW_FLASHBANG: { // Frost grenade
			set_pev(id, pev_viewmodel2, model_grenade_frost[VIEW_MODEL])
			set_pev(id, pev_weaponmodel2, model_grenade_frost[PLAYER_MODEL])
		}
		case CSW_SMOKEGRENADE: { // Flare grenade
			set_pev(id, pev_viewmodel2, model_grenade_flare[VIEW_MODEL])
			set_pev(id, pev_weaponmodel2, model_grenade_flare[PLAYER_MODEL])
		}
	}
	static survweaponname[32] // Survivor's custom weapon model
	get_pcvar_string(cvar_survweapon, survweaponname, charsmax(survweaponname))
	if(g_hm_special[id] == SURVIVOR && weaponid == cs_weapon_name_to_id(survweaponname)) {
		set_pev(id, pev_viewmodel2, model_v_weapon_human[SURVIVOR])
		set_pev(id, pev_weaponmodel2, model_p_weapon_human[SURVIVOR])
	}

	if(g_handle_models_on_separate_ent) fm_set_weaponmodel_ent(id) // Update model on weaponmodel ent
}
reset_vars(id, resetall) { // Reset Player Vars
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
	g_canbuy[id] = 2
	g_burning_dur[id] = 0
	g_user_custom_speed[id] = false
	g_madness_used[id] = false

	if(resetall) {
		g_ammopacks[id] = get_pcvar_num(cvar_startammopacks)
		g_zombieclass[id] = ZCLASS_NONE
		g_zombieclassnext[id] = ZCLASS_NONE
		g_choosed_zclass[id] = false
		g_damagedealt[id] = 0
		WPN_AUTO_ON = 0
		WPN_STARTID = 0
		PL_ACTION = 0
		MENU_PAGE_ZCLASS = 0
		MENU_PAGE_EXTRAS = 0
		MENU_PAGE_PLAYERS = 0
		MENU_PAGE_GAMEMODES = 0
		MENU_PAGE_SPECIAL_CLASS = 0
		MENU_PAGE_CUSTOM_SP_Z = 0
		MENU_PAGE_CUSTOM_SP_H = 0
	}
}
public spec_nvision(id) { // Set spectators nightvision
	if(!g_isconnected[id] || g_isalive[id] || g_isbot[id]) return; // Not connected, alive, or bot

	if(get_pcvar_num(cvar_spec_nvggive)) { // Give Night Vision?
		g_nvision[id] = true

		if(get_pcvar_num(cvar_spec_nvggive) == 1) { // Turn on Night Vision automatically?
			g_nvisionenabled[id] = true
			user_nightvision(id, 1)
		}
	}
}

public ShowHUD(taskid) { // Show HUD Task
	if(!get_pcvar_num(cvar_huddisplay)) return;
	
	static id; id = ID_SHOWHUD;
	
	if(!g_isalive[id]) { // Player died?
		id = pev(id, PEV_SPEC_TARGET) // Get spectating target
		if(!g_isalive[id]) return; // Target not alive
	}
	
	static class[32], rgb[3] // Format classname
	
	switch(g_hud_color[g_zombie[id] ? 1 : 0][id]) { // Hud Color
		case 0: rgb = { 255, 255, 255 }
		case 1: rgb = { 255, 0, 0 }
		case 2: rgb = { 0, 255, 0 }
		case 3: rgb = { 0, 0, 255 }
		case 4: rgb = { 0, 255, 255 }
		case 5: rgb = { 255, 0, 255 }
		case 6: rgb = { 255, 255, 0 }
	}

	if(g_zombie[id]) { // Zombies	
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) ArrayGetString(g_zm_special_name, g_zm_special[id]-MAX_SPECIALS_ZOMBIES, class, charsmax(class))
		else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) formatex(class, charsmax(class), "%L", ID_SHOWHUD, zm_special_class_langs[g_zm_special[id]])
		else copy(class, charsmax(class), g_zombie_classname[id])
	}
	else { // Humans
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) ArrayGetString(g_hm_special_name, g_hm_special[id]-MAX_SPECIALS_HUMANS, class, charsmax(class))
		else formatex(class, charsmax(class), "%L", ID_SHOWHUD, hm_special_class_langs[g_hm_special[id]])
	}
	
	if(id != ID_SHOWHUD) { // Spectating someone else?
		// Show name, health, class, and ammo packs and armor
		set_hudmessage(rgb[0], rgb[1], rgb[2], HUD_SPECT_X, HUD_SPECT_Y, 1, 6.0, 1.1, 0.0, 0.0, -1)
		ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "%L %s^nHP: %s - %L %s - %L %s - %L %s", ID_SHOWHUD, "SPECTATING", g_playername[id],
		add_point(pev(id, pev_health)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[id]), ID_SHOWHUD, "ARMOR", add_point(pev(id, pev_armorvalue)))
	}
	else {		
		static g_ModeName[64]
		if(g_currentmode >= MAX_GAME_MODES && !g_endround) ArrayGetString(g_gamemode_name, (g_currentmode - MAX_GAME_MODES), g_ModeName, charsmax(g_ModeName))
		else formatex(g_ModeName, charsmax(g_ModeName), "%L", ID_SHOWHUD, g_endround ? "ROUND_ENDED" : mode_langs[g_currentmode])
	
		if(g_hud_type[ID_SHOWHUD] == 0) { // Default
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.78, 0.18, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %s]^n[%L %s]^n[%L %s]^n[%L: %s]^n[%L: %d]^n[%L: %i]^n[%L: %d]^n[%L: %s]", id, "ZOMBIE_ATTRIB1", add_point(pev(ID_SHOWHUD, pev_health)), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(id)), id, "ZOMBIE_ATTRIB8", get_user_deaths(id), id, "ZOMBIE_ATTRIB7", get_user_frags(id), id, "ZOMBIE_ATTRIB2", fm_get_speed(id), id, "ZOMBIE_ATTRIB6", g_ModeName);
		}
		else if(g_hud_type[ID_SHOWHUD] == 1) { // Classic
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.02, 0.9, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "HP: %s - %L %s - %L %s", add_point(get_user_health(ID_SHOWHUD)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]))
		}
		else if(g_hud_type[ID_SHOWHUD] == 2) { // Center
			set_hudmessage(rgb[0], rgb[1], rgb[2], -1.0, 0.60, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %s]^n[%L %s]^n[%L %s]^n[%L: %s]^n[%L: %d]^n[%L: %i]^n[%L: %d]^n[%L: %s]", id, "ZOMBIE_ATTRIB1", add_point(pev(ID_SHOWHUD, pev_health)), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(id)), id, "ZOMBIE_ATTRIB8", get_user_deaths(id), id, "ZOMBIE_ATTRIB7", get_user_frags(id), id, "ZOMBIE_ATTRIB2", fm_get_speed(id), id, "ZOMBIE_ATTRIB6", g_ModeName);
		}
		else if(g_hud_type[ID_SHOWHUD] == 3) { // Antrax Style
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.57, 0.75, 1, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s]", g_playername[ID_SHOWHUD], id, "ZOMBIE_ATTRIB1", add_point(get_user_health(ID_SHOWHUD)), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(ID_SHOWHUD)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", 
			add_point(g_ammopacks[ID_SHOWHUD]), id, "CURRENT_MODE", g_ModeName)
		}
		else if(g_hud_type[ID_SHOWHUD] == 4) { // Under Radar
			set_hudmessage(rgb[0], rgb[1], rgb[2], 0.01, 0.22, 0, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%L: %s]^n[%L %s]^n[%L %s]^n[%L: %s]^n[%L: %d]^n[%L: %i]^n[%L: %d]^n[%L: %s]", id, "ZOMBIE_ATTRIB1", add_point(pev(ID_SHOWHUD, pev_health)), ID_SHOWHUD, "CLASS_CLASS",
			class, ID_SHOWHUD, "AMMO_PACKS1", add_point(g_ammopacks[ID_SHOWHUD]), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(id)), id, "ZOMBIE_ATTRIB8", get_user_deaths(id), id, "ZOMBIE_ATTRIB7", get_user_frags(id), id, "ZOMBIE_ATTRIB2", fm_get_speed(id), id, "ZOMBIE_ATTRIB6", g_ModeName);
		}
		else if(g_hud_type[ID_SHOWHUD] == 5) { // Center Antrax
			set_hudmessage(rgb[0], rgb[1], rgb[2], -1.0, 0.75, 1, 6.0, 1.1, 0.0, 0.0, -1)
			ShowSyncHudMsg(ID_SHOWHUD, g_MsgSync[1], "[%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s] - [%L] [%s]^n[%L] [%s]", g_playername[ID_SHOWHUD], id, "ZOMBIE_ATTRIB1", add_point(get_user_health(ID_SHOWHUD)), id, "ZOMBIE_ATTRIB5", add_point(get_user_armor(ID_SHOWHUD)), ID_SHOWHUD, "CLASS_CLASS", class, ID_SHOWHUD, "AMMO_PACKS1", 
			add_point(g_ammopacks[ID_SHOWHUD]), id, "CURRENT_MODE", g_ModeName)
		}
	}
}
public zombie_play_idle(taskid) { // Play idle zombie sounds
	if(g_endround || g_newround || !get_pcvar_num(cvar_zm_idle_sound)) return; // Round ended/new one starting
	
	static sound[64]
	ArrayGetString(g_lastzombie[ID_BLOOD] ? ar_sound[8] : ar_sound[7], random_num(0, ArraySize(g_lastzombie[ID_BLOOD] ? ar_sound[8] : ar_sound[7]) - 1), sound, charsmax(sound))
	emit_sound(ID_BLOOD, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
}

public madness_over(taskid) {
	g_nodamage[ID_BLOOD] = false
	set_pev(ID_BLOOD, pev_takedamage, DAMAGE_AIM)
	
	if(get_pcvar_float(cvar_madness_use_countdown) > 0.0)
		set_task(get_pcvar_float(cvar_madness_use_countdown), "delay_madness", ID_BLOOD+TASK_MADNESS)
	else 
		g_madness_used[ID_BLOOD] = false

	static sound[64]
	ArrayGetString(ar_sound[9], random_num(0, ArraySize(ar_sound[9]) - 1), sound, charsmax(sound))
	emit_sound(ID_BLOOD, CHAN_VOICE, sound, 0.0, ATTN_NORM, 0, PITCH_NORM)
	remove_task(ID_BLOOD+TASK_BLOOD)
}
public delay_madness(id) {
	id -= TASK_MADNESS
	g_madness_used[id] = false
}
do_random_spawn(id, regularspawns = 0) { // Place user at a random spawn
	static hull, sp_index, i

	hull = (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN // Get whether the player is crouching

	if(!regularspawns) { // Use regular spawns?

		if(!g_spawnCount) return; // No spawns?

		sp_index = random_num(0, g_spawnCount - 1) // Choose random spawn to start looping at

		for(i = sp_index + 1; /*no condition*/; i++) { // Try to find a clear spawn
			if(i >= g_spawnCount) i = 0 // Start over when we reach the end
			
			if(is_hull_vacant(g_spawns[i], hull)) { // Free spawn space?
				engfunc(EngFunc_SetOrigin, id, g_spawns[i]) // Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				break;
			}
			if(i == sp_index) break; // Loop completed, no free space found
		}
		ExecuteForward(g_forwards[UNSTUCK_POST], g_fwDummyResult, id);
	}
	else {
		if(!g_spawnCount2) return; // No spawns?

		sp_index = random_num(0, g_spawnCount2 - 1) // Choose random spawn to start looping at

		for(i = sp_index + 1; /*no condition*/; i++) { // Try to find a clear spawn
			if(i >= g_spawnCount2) i = 0 // Start over when we reach the end

			if(is_hull_vacant(g_spawns2[i], hull)) { // Free spawn space?
				engfunc(EngFunc_SetOrigin, id, g_spawns2[i]) // Engfunc_SetOrigin is used so ent's mins and maxs get updated instantly
				break;
			}
			if(i == sp_index) break; // Loop completed, no free space found
		}
		ExecuteForward(g_forwards[UNSTUCK_POST], g_fwDummyResult, id);
	}
}
fnGetZombies() { // Get Zombies -returns alive zombies number-
	static iZombies, id; iZombies = 0
	for(id = 1; id <= g_maxplayers; id++) if(g_isalive[id] && g_zombie[id]) iZombies++

	return iZombies;
}
fnGetHumans() { // Get Humans -returns alive humans number-
	static iHumans, id; iHumans = 0
	for(id = 1; id <= g_maxplayers; id++) if(g_isalive[id] && !g_zombie[id]) iHumans++

	return iHumans;
}
fnGetSpecials(zombie, specialid) { // Get Specials -returns alive Specials number-
	static count, id; count = 0
	for(id = 1; id <= g_maxplayers; id++) if(g_isalive[id] && (zombie && g_zm_special[id] == specialid || !zombie && g_hm_special[id] == specialid)) count++
	
	return count;
}
stock fnGetAlive(const team = 0) { // Get Alive -returns alive players number-
	static iAlive, id; iAlive = 0
	
	for(id = 1; id <= g_maxplayers; id++) {
		if(!g_isalive[id]) continue;

		if(team == 1 && g_zombie[id] || team >= 2 && !g_zombie[id]) continue

		iAlive++
	}	
	return iAlive;
}
stock fnGetRandomAlive(n) { // Get Random Alive -returns index of alive player number n -
	static iAlive, id; iAlive = 0
	for(id = 1; id <= g_maxplayers; id++) {
		if(!g_isalive[id]) continue;

		iAlive++

		if(iAlive == n) return id;
	}
	return -1;
}
stock fnGetRandomAliveByTeam(const team = 0) {
	static iRandom, id
	id = 0
	iRandom = 0

	if(!fnGetAlive() || !fnGetZombies() && team == 2 || !fnGetHumans() && team == 1) return -1

	while(iRandom == 0) {
		if((++id) > g_maxplayers) id = 1 // Keep looping through all players

		if(!g_isalive[id]) continue; // Dead

		if(team == 1 && g_zombie[id] || team >= 2 && !g_zombie[id]) continue; // Check Team
		
		if(random_num(1, 5) == 1) { // Random chance
			iRandom = id;
			break;
		}
	}

	if(iRandom) return iRandom; 

	return -1;
}
fnGetPlaying() { // Get Playing -returns number of users playing-
	static iPlaying, id, team; iPlaying = 0
	for(id = 1; id <= g_maxplayers; id++) {
		if(g_isconnected[id]) {
			team = fm_cs_get_user_team(id)
			if(team != FM_CS_TEAM_SPECTATOR && team != FM_CS_TEAM_UNASSIGNED) iPlaying++
		}
	}
	return iPlaying;
}
fnGetCTs() { // Get CTs -returns number of CTs connected-
	static iCTs, id; iCTs = 0
	for(id = 1; id <= g_maxplayers; id++) if(g_isconnected[id]) if(fm_cs_get_user_team(id) == FM_CS_TEAM_CT) iCTs++

	return iCTs;
}
fnGetTs() { // Get Ts -returns number of Ts connected-
	static iTs, id; iTs = 0
	for(id = 1; id <= g_maxplayers; id++) if(g_isconnected[id]) if(fm_cs_get_user_team(id) == FM_CS_TEAM_T) iTs++

	return iTs;
}
fnCheckLastZombie() { // Last Zombie Check -check for last zombie and set its flag-
	for(new id = 1; id <= g_maxplayers; id++) {
		if(g_isalive[id] && g_zombie[id] && g_zm_special[id] <= 0 && fnGetZombies() == 1) { // Last zombie
			if(!g_lastzombie[id]) ExecuteForward(g_forwards[USER_LAST_ZOMBIE], g_fwDummyResult, id); // Last zombie forward
			g_lastzombie[id] = true
		}
		else g_lastzombie[id] = false

		if(g_isalive[id] && !g_zombie[id] && g_hm_special[id] <= 0 && fnGetHumans() == 1) { // Last human
			if(!g_lasthuman[id]) {
				ExecuteForward(g_forwards[USER_LAST_HUMAN], g_fwDummyResult, id); // Last human forward				
				fm_set_user_health(id, pev(id, pev_health) + get_pcvar_num(cvar_hm_basehp[0])) // Reward extra hp
			}
			g_lasthuman[id] = true
		}
		else g_lasthuman[id] = false
	}
}
save_stats(id) { // Save player's stats to database
	if(db_name[id][0] && !equal(g_playername[id], db_name[id])) { // Check whether there is another record already in that slot
		if(db_slot_i >= sizeof db_name) db_slot_i = g_maxplayers+1 // If DB size is exceeded, write over old records
		
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

	// Save Player Configuration
	client_cmd(id, "setinfo ^"zpspdata^" ^"%d-%d-%d-%d-%d-%d^"", g_hud_type[id], g_hud_color[0][id], g_hud_color[1][id], g_flashlight_color[id], g_nv_color[0][id], g_nv_color[1][id])
}

load_stats(id) { // Load player's stats from database (if a record is found)
	static i // Look for a matching record
	for(i = 0; i < sizeof db_name; i++) {
		if(equal(g_playername[id], db_name[i])) { // Bingo!
			g_ammopacks[id] = db_ammopacks[i]
			g_zombieclass[id] = db_zombieclass[i]
			g_zombieclassnext[id] = db_zombieclass[i]
			return;
		}
	}

	// Load configuration
	static data[64], value[6][32]
	get_user_info(id, "zpspdata", data, charsmax(data))
	replace_all(data, charsmax(data), "-"," ");

	parse(data, value[0], charsmax(value[]), value[1], charsmax(value[]), value[2], charsmax(value[]), value[3], charsmax(value[]), value[4], charsmax(value[]),
	value[5], charsmax(value[]));

	if(value[0][0]) g_hud_type[id] = str_to_num(value[0])
	if(value[1][0]) g_hud_color[0][id] = str_to_num(value[1])
	if(value[2][0]) g_hud_color[1][id] = str_to_num(value[2])
	if(value[3][0]) g_flashlight_color[id] = str_to_num(value[3])
	if(value[4][0]) g_nv_color[0][id] = str_to_num(value[4])
	if(value[5][0]) g_nv_color[1][id] = str_to_num(value[5])
}
allowed_zombie(id) { // Checks if a player is allowed to be zombie 
	if((g_zombie[id] && g_zm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
		return false;
	
	return true;
}
allowed_human(id) { // Checks if a player is allowed to be human
	if((!g_zombie[id] && g_hm_special[id] <= 0) || g_endround || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
		return false;
	
	return true;
}
allowed_special(id, zombie, specialid) { // Checks if a player is allowed to be a special class
	if(zombie) {
		if(specialid < MAX_SPECIALS_ZOMBIES) if(!zm_special_enable[specialid]) return false;

		if(g_endround || g_zm_special[id] == specialid || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && !g_zombie[id] && fnGetHumans() == 1))
			return false;
	}
	else {
		if(specialid < MAX_SPECIALS_HUMANS) if(!hm_special_enable[specialid]) return false;

		if(g_endround || g_hm_special[id] == specialid || !g_isalive[id] || task_exists(TASK_WELCOMEMSG) || (!g_newround && g_zombie[id] && fnGetZombies() == 1))
			return false;
	}
	return true;
}
allowed_respawn(id) { // Checks if a player is allowed to respawn
	static team; team = fm_cs_get_user_team(id)
	if(g_endround || team == FM_CS_TEAM_SPECTATOR || team == FM_CS_TEAM_UNASSIGNED || g_isalive[id]) return false;

	return true;
}
allowed_game_mode(mode) {
	switch(mode) {
		case MODE_NEMESIS: if(!zm_special_enable[NEMESIS]) return -1;
		case MODE_ASSASSIN: if(!zm_special_enable[ASSASSIN]) return -1;
		case MODE_PREDATOR: if(!zm_special_enable[PREDATOR]) return -1;
		case MODE_BOMBARDIER: if(!zm_special_enable[BOMBARDIER]) return -1;
		case MODE_DRAGON: if(!zm_special_enable[DRAGON]) return -1;
		case MODE_SURVIVOR: if(!hm_special_enable[SURVIVOR]) return -1;
		case MODE_SNIPER: if(!hm_special_enable[SNIPER]) return -1;
		case MODE_BERSERKER: if(!hm_special_enable[BERSERKER]) return -1;
		case MODE_WESKER: if(!hm_special_enable[WESKER]) return -1;
		case MODE_SPY: if(!hm_special_enable[SPY]) return -1;
		case MODE_MULTI: {
			if(floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) < 2 || floatround(fnGetAlive()*get_pcvar_float(cvar_multiratio), floatround_ceil) >= fnGetAlive())
				return 0;
		}
		case MODE_PLAGUE: {
			if(!hm_special_enable[SURVIVOR] || !zm_special_enable[NEMESIS]) return -1

			if(floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil) < 1
			|| fnGetAlive()-(get_pcvar_num(cvar_plaguesurvnum)+get_pcvar_num(cvar_plaguenemnum)+floatround((fnGetAlive()-(get_pcvar_num(cvar_plaguenemnum)+get_pcvar_num(cvar_plaguesurvnum)))*get_pcvar_float(cvar_plagueratio), floatround_ceil)) < 1)
				return 0;
		}
		case MODE_LNJ: if(!hm_special_enable[SURVIVOR] || !zm_special_enable[NEMESIS]) return -1;
	}

	if(g_endround || !g_newround || task_exists(TASK_WELCOMEMSG)) return 0;

	if(mode > MODE_INFECTION && mode < MAX_GAME_MODES) if(fnGetAlive() < get_pcvar_num(cvar_mod_minplayers[mode])) return 0;

	return 1;
}
allowed_custom_game() { // Checks if a custom game mode is allowed
	if(g_endround || !g_newround || task_exists(TASK_WELCOMEMSG) || fnGetAlive() < 2) return false;
	
	return true;
}
command_zombie(id, player) { // Admin Command. zp_zombie
	zp_log_message(id, player, "CMD_INFECT") // Log and Print Message

	if(g_newround) { // New round?
		remove_task(TASK_MAKEZOMBIE)
		start_infection_mode(player, MODE_SET) // Set as first zombie
		
		ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, MODE_INFECTION, id)
	}
	else zombieme(player, 0, 0, 0, 0) // Just infect
}
command_human(id, player) { // Admin Command. zp_human
	zp_log_message(id, player, "CMD_DISINFECT") // Log and Print Message
	humanme(player, 0, 0) // Turn to human
}

new const hm_cmd_langs[MAX_SPECIALS_HUMANS-1][] = { "CMD_SURVIVAL", "CMD_SNIPER", "CMD_BERSERKER", "CMD_WESKER", "CMD_SPY" }
new const zm_cmd_langs[MAX_SPECIALS_ZOMBIES-1][] = { "CMD_NEMESIS", "CMD_ASSASSIN", "CMD_PREDATOR", "CMD_BOMBARDIER", "CMD_DRAGON" }
command_special(id, player, spid, zm) {
	if(!hm_special_enable[spid] && !zm || !zm_special_enable[spid] && zm) return
	
	ExecuteForward(g_forwards[zm ? ZM_SP_CHOSSED_PRE : HM_SP_CHOSSED_PRE], g_fwDummyResult, id, spid);
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return
	
	zp_log_message(id, player, zm ? zm_cmd_langs[spid-1] : hm_cmd_langs[spid-1] ) // Log and Print Message

	static mode_id; mode_id = 0
	if(g_newround) { // New round?
		remove_task(TASK_MAKEZOMBIE)
		if(zm) {
			switch(spid) {
				case NEMESIS: mode_id = MODE_NEMESIS
				case ASSASSIN: mode_id = MODE_ASSASSIN
				case PREDATOR: mode_id = MODE_PREDATOR
				case BOMBARDIER: mode_id = MODE_BOMBARDIER
				case DRAGON: mode_id = MODE_DRAGON
			}
			set_special_zombie_mode(player, MODE_SET, spid)
			ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, mode_id, id)
		}
		else {
			switch(spid) {
				case SURVIVOR: mode_id = MODE_SURVIVOR
				case SNIPER: mode_id = MODE_SNIPER
				case BERSERKER: mode_id = MODE_BERSERKER
				case WESKER: mode_id = MODE_WESKER
				case SPY: mode_id = MODE_SPY
			}
			set_special_human_mode(player, MODE_SET, spid)
			ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, mode_id, id)
		}
	}
	else { // Turn player into a Special Class
		if(zm) zombieme(player, 0, spid, 0, 0)
		else humanme(player, spid, 0)
	}
	ExecuteForward(g_forwards[zm ? ZM_SP_CHOSSED_POST : HM_SP_CHOSSED_POST], g_fwDummyResult, id, spid);
}
command_custom_special(id, player, spid, zombie) {
	ExecuteForward(g_forwards[zombie ? ZM_SP_CHOSSED_POST : HM_SP_CHOSSED_PRE], g_fwDummyResult, id, spid);
	if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return
	
	static special_name[32]
	if(zombie) ArrayGetString(g_zm_special_name, spid-MAX_SPECIALS_ZOMBIES, special_name, charsmax(special_name))
	else ArrayGetString(g_hm_special_name, spid-MAX_SPECIALS_HUMANS, special_name, charsmax(special_name))

	switch (get_pcvar_num(cvar_showactivity)) {
		case 1: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t- %L", g_playername[player], LANG_PLAYER, "CMD_CUSTOM_SP", special_name)
		case 2: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t-!y %s!t %L", g_playername[id], g_playername[player], LANG_PLAYER, "CMD_CUSTOM_SP", special_name)
	}
	
	if(get_pcvar_num(cvar_logcommands)) { // Log to Zombie Plague log file?
		static logdata[500], authid[32], ip[16], filename[100]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)
		formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, "CMD_CUSTOM_SP", special_name, fnGetPlaying(), g_maxplayers)
		
		format_time(filename, charsmax(filename), "%d-%m-%Y");
		format(filename, charsmax(filename), "zombie_plague_special_%s.log", filename);
		log_to_file(filename, logdata)
	}
	if(zombie) zombieme(player, 0, spid, 0, 0)
	else humanme(player, spid, 0)

	ExecuteForward(g_forwards[zombie ? ZM_SP_CHOSSED_POST : HM_SP_CHOSSED_POST], g_fwDummyResult, id, spid);
}
command_respawn(id, player) { // Admin Command. zp_respawn
	zp_log_message(id, player, "CMD_RESPAWN") // Log and Print Message

	// Respawn as zombie?
	if(g_currentmode > MODE_LNJ) { // Custom round ?
		if(g_deathmatchmode == 2 || (g_deathmatchmode == 3 && random_num(0, 1)) || (g_deathmatchmode == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	else { // Normal round
		if(get_pcvar_num(cvar_deathmatch) == 2 || (get_pcvar_num(cvar_deathmatch) == 3 && random_num(0, 1)) || (get_pcvar_num(cvar_deathmatch) == 4 && (fnGetZombies() < (fnGetAlive()/2))))
			g_respawn_as_zombie[player] = true
	}
	
	// Override respawn as zombie setting on nemesis, assassin, survivor, sniper and berserker rounds
	if(g_currentmode >= MODE_SURVIVOR && g_currentmode < MODE_SWARM) g_respawn_as_zombie[player] = true
	else if(g_currentmode >= MODE_NEMESIS && g_currentmode < MODE_SURVIVOR) g_respawn_as_zombie[player] = false
	
	respawn_player_manually(player);
}
command_swarm(id) { // Admin Command. zp_swarm
	zp_log_message(id, 0, "CMD_SWARM") // Log and Print Message
	
	// Call Swarm Mode
	remove_task(TASK_MAKEZOMBIE)
	start_swarm_mode(0, MODE_SET)
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, MODE_SWARM, id)
}
command_multi(id) { // Admin Command. zp_multi
	zp_log_message(id, 0, "CMD_MULTI") // Log and Print Message
	
	// Call Multi Infection
	remove_task(TASK_MAKEZOMBIE)
	start_multi_mode(0, MODE_SET)
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, MODE_MULTI, id)
}
command_plague(id) { // Admin Command. zp_plague
	if(!hm_special_enable[SURVIVOR] || !zm_special_enable[NEMESIS]) return

	zp_log_message(id, 0, "CMD_PLAGUE") // Log and Print Message

	// Call Plague Mode
	remove_task(TASK_MAKEZOMBIE)
	start_plague_mode(0, MODE_SET)
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, MODE_PLAGUE, id)
}
command_lnj(id) { // Admin Command. zp_lnj
	if(!hm_special_enable[SURVIVOR] || !zm_special_enable[NEMESIS]) return 

	zp_log_message(id, 0, "CMD_LNJ") // Log and Print Message
	
	// Call Armageddon Mode
	remove_task(TASK_MAKEZOMBIE)
	start_lnj_mode(0, MODE_SET)
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, MODE_LNJ, id)
}
command_custom_game(gameid, id) { // Admin command for a custom game mode
	// Retrieve the game mode name as it will be used
	static buffer[32]; ArrayGetString(g_gamemode_name, (gameid - MAX_GAME_MODES), buffer, charsmax(buffer))
	
	if(id != 0) {
		switch (get_pcvar_num(cvar_showactivity)) { // Show activity?
			case 1: zp_colored_print(0, 0, "!t*ADMIN*!t - %L %s", LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
			case 2: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t- %L %s", g_playername[id], LANG_PLAYER, "MENU_ADMIN2_CUSTOM", buffer)
		}

		if(get_pcvar_num(cvar_logcommands)) { // Log to Zombie Plague Special log file?
			static logdata[500], authid[32], ip[16], filename[100]
			get_user_authid(id, authid, charsmax(authid))
			get_user_ip(id, ip, charsmax(ip), 1)
			formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %L %s (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, "MENU_ADMIN2_CUSTOM", buffer, fnGetPlaying(), g_maxplayers)
			
			format_time(filename, charsmax(filename), "%d-%m-%Y");
			format(filename, charsmax(filename), "zombie_plague_special_%s.log", filename);
			log_to_file(filename, logdata)
		}
	}
	
	
	remove_task(TASK_MAKEZOMBIE) // Remove make a zombie task
	g_newround = false // No more a new round
	g_currentmode = gameid // Current game mode and last game mode are equal to the game mode id
	g_lastmode = gameid
	g_allowinfection = (ArrayGetCell(g_gamemode_allow, (gameid - MAX_GAME_MODES)) == 1) ? true : false // Check whether or not to allow infection during this game mode	
	g_deathmatchmode = ArrayGetCell(g_gamemode_dm, (gameid - MAX_GAME_MODES)) // Check the death match mode required by the game mode
	g_modestarted = true // Our custom game mode has fully started
	ExecuteForward(g_forwards[ROUND_START], g_fwDummyResult, gameid, 0) // Execute our round start forward with the game mode id [BUGFIX]
	ExecuteForward(g_forwards[GAME_MODE_SELECTED], g_fwDummyResult, gameid, id) // Execute our game mode selected forward
	
	for(new i = 1; i <= g_maxplayers; i++) {
		update_team(i)	// Fix Team Change
		if(g_zombie[i] && g_escape_map) { // Escape Map Support
			if(get_pcvar_num(cvar_randspawn)) do_random_spawn(i) // random spawn (including CSDM)
			else do_random_spawn(i, 1) // regular spawn
		}
	}
}
stock zp_log_message(id, player, const lang[]) {
	if(player > 0) {
		switch (get_pcvar_num(cvar_showactivity)) { // Show activity?
			case 1: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t- %L", g_playername[player], LANG_PLAYER, lang)
			case 2: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t-!y %s!t %L", g_playername[id], g_playername[player], LANG_PLAYER, lang)
		}
	}
	else {
		switch (get_pcvar_num(cvar_showactivity)) { // Show activity?
			case 1: zp_colored_print(0, 0, "!g*ADMIN*!t - %L", LANG_PLAYER, lang)
			case 2: zp_colored_print(0, 0, "!g*ADMIN*!y %s !t- %L", g_playername[id], LANG_PLAYER, lang)
		}
	}

	if(get_pcvar_num(cvar_logcommands)) { // Log to Zombie Plague log file?
		static logdata[500], authid[32], ip[16], filename[100]
		get_user_authid(id, authid, charsmax(authid))
		get_user_ip(id, ip, charsmax(ip), 1)

		if(player > 0) formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %s %L (Players: %d/%d)", g_playername[id], authid, ip, g_playername[player], LANG_SERVER, lang, fnGetPlaying(), g_maxplayers)
		else formatex(logdata, charsmax(logdata), "*ADMIN* %s <%s><%s> - %L (Players: %d/%d)", g_playername[id], authid, ip, LANG_SERVER, lang, fnGetPlaying(), g_maxplayers)

		format_time(filename, charsmax(filename), "%d-%m-%Y");
		format(filename, charsmax(filename), "zombie_plague_special_%s.log", filename);
		log_to_file(filename, logdata)
	}
}
/*================================================================================
 [Custom Natives]
=================================================================================*/
public native_get_user_zombie(id) { // Native: zp_get_user_zombie
	if(!is_user_valid(id)) return -1;
	return g_zombie[id];
}
public native_get_user_nemesis(id) { // Native: zp_get_user_nemesis
	if(!is_user_valid(id)) return -1;

	return g_zm_special[id] == NEMESIS;
}
public native_get_user_survivor(id) { // Native: zp_get_user_survivor
	if(!is_user_valid(id)) return -1;

	return g_hm_special[id] == SURVIVOR;
}
public native_get_user_first_zombie(id) { // Native: zp_get_user_first_zombie
	if(!is_user_valid(id)) return -1;
	return g_firstzombie[id];
}
public native_get_human_special_class(id) { // Native: zp_get_human_special_class
	if(!is_user_valid(id)) return -1;
	return g_zombie[id] ? 0 : g_hm_special[id];
}
public native_get_zombie_special_class(id) { // Native: zp_get_zombie_special_class
	if(!is_user_valid(id)) return -1;
	return g_zombie[id] ? g_zm_special[id] : 0
}
public native_get_user_last_zombie(id) { // Native: zp_get_user_last_zombie
	if(!is_user_valid(id)) return -1;
	return g_lastzombie[id];
}
public native_get_user_last_human(id) { // Native: zp_get_user_last_human
	if(!is_user_valid(id)) return -1;
	return g_lasthuman[id];
}
public native_get_user_madness(id) { // Native: zp_get_user_madness
	if(!is_user_valid(id)) return -1;
	return g_nodamage[id];
}
public native_get_user_zombie_class(id) { // Native: zp_get_user_zombie_class
	if(!is_user_valid(id)) return -1;
	if(g_zm_special[id] > 0) return -1 // Fix Bug of Special Classes using Zombie Classes's Skills
	return g_zombieclass[id];
}
public native_get_user_next_class(id) { // Native: zp_get_user_next_class
	if(!is_user_valid(id)) return -1;
	return g_zombieclassnext[id];
}
public native_set_user_zombie_class(id, classid) { // Native: zp_set_user_zombie_class
	if(!is_user_valid(id)) return false;
	
	if(classid < 0 || classid >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", classid)
		return false;
	}
	g_zombieclassnext[id] = classid
	return true;
}
public native_get_user_ammo_packs(id) { // Native: zp_get_user_ammo_packs
	if(!is_user_valid(id)) return -1;
	return g_ammopacks[id];
}
public native_set_user_ammo_packs(id, amount) { // Native: zp_set_user_ammo_packs
	if(!is_user_valid(id)) return false;
	g_ammopacks[id] = amount;
	return true;
}
public native_get_user_frozen(id) { // Native: zp_get_user_frozen
	if(!is_user_valid(id)) return -1;
	return g_frozen[id];
}
public native_get_user_burn(id) { // Native: zp_get_user_burn
	if(!is_user_valid(id)) return -1;
	return g_burning_dur[id] > 0
}
public native_get_user_infectnade(id) { // Native: zp_get_user_infectnade
	if(!is_user_valid(id)) return -1;
	return (g_zombie[id] && g_zm_special[id] <= 0 && user_has_weapon(id, CSW_HEGRENADE));
}
public native_get_zombie_maxhealth(id) { // Native: zp_get_zombie_maxhealth
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!is_user_valid(id)) return -1;

	if(!g_zombie[id] || g_zm_special[id] > 0) {
		log_error(AMX_ERR_NATIVE, "[ZP] Player not a normal zombie (%d)", id)
		return -1;
	}
	
	if(g_zombie[id] && g_zm_special[id] <= 0) {
		if(g_firstzombie[id]) return floatround(float(ArrayGetCell(g_zclass_hp, g_zombieclass[id])) * get_pcvar_float(cvar_zm_health[0]))
		else return ArrayGetCell(g_zclass_hp, g_zombieclass[id])
	}
	return -1;
}
public native_get_user_batteries(id) { // Native: zp_get_user_batteries
	if(!is_user_valid(id)) return -1;
	return g_flashbattery[id];
}
public native_set_user_batteries(id, value) { // Native: zp_set_user_batteries
	if(!g_pluginenabled) return false; // ZP Special disabled
	if(!is_user_valid(id) || !is_user_valid_connected(id)) return false;
	
	g_flashbattery[id] = clamp(value, 0, 100);
	if(g_cached_customflash) { // Set the flashlight charge task to update battery status
		remove_task(id+TASK_CHARGE)
		set_task(1.0, "flashlight_charge", id+TASK_CHARGE, _, _, "b")
	}
	return true;
}
public native_get_user_nightvision(id) { // Native: zp_get_user_nightvision
	if(!is_user_valid(id)) return -1;

	if(g_nvisionenabled[id])
		return 2;

	if(g_nvision[id])
		return 1;

	return 0;
}
public native_set_rendering(id, fx, r, g, b, render, amount) { // Native: zp_set_user_rendering
	if(!is_user_valid(id)) return false;
	if(!g_isconnected[id] || !g_isalive[id]) return false;

	fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, fx, r, g, b, render, amount)
	return true;
}
public native_reset_user_rendering(id) { // Native: zp_reset_user_rendering
	if(!is_user_valid(id)) return false;
	reset_user_rendering(id)
	return true
}
public native_get_extra_item_cost(itemid) { // Native: zp_get_extra_item_cost
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return -1;
	}
	return ArrayGetCell(g_extraitem_cost, itemid)
}
public native_get_extra_item_name(plugin_id, param_nums) { // Native: zp_get_extra_item_name
	if(param_nums != 3) return -1;

	static itemid, buffer[50]
	itemid = get_param(1)
	
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return -1;
	}
	ArrayGetString(g_extraitem_name, itemid, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	return 1;
}
public native_get_weapon_name(plugin_id, param_nums) { // Native: zp_get_weapon_name
	if(param_nums != 4)
		return -1;
	
	static wpn_type, itemid, buffer[50]
	wpn_type = get_param(1)
	itemid = get_param(2)
	
	if(itemid < 0 || itemid >= g_weapon_i[wpn_type]) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Weapon id (%d)", itemid)
		return -1;
	}
	
	ArrayGetString(g_weapon_name[wpn_type], itemid, buffer, charsmax(buffer))
	set_string(3, buffer, get_param(4))
	return 1;
}
public native_get_weapon_realname(plugin_id, param_nums) { // Native: zp_get_weapon_realname
	if(param_nums != 4) return -1;

	static wpn_type, itemid, buffer[50]
	wpn_type = get_param(1)
	itemid = get_param(2)
	
	if(itemid < 0 || itemid >= g_weapon_i[wpn_type]) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Weapon id (%d)", itemid)
		return -1;
	}
	ArrayGetString(g_weapon_realname[wpn_type], itemid, buffer, charsmax(buffer))
	set_string(3, buffer, get_param(4))
	return 1;
}
public native_weapon_is_custom(wpn_type, wpn_id) { // Native: zp_weapon_is_custom
	if(wpn_id < 0 || wpn_id >= g_weapon_i[wpn_type]) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Weapon id (%d)", wpn_id)
		return -1;
	}
	return ArrayGetCell(g_weapon_is_custom[wpn_type], wpn_id);
}
public native_weapon_count(wpn_type, skip_def_custom) { // Native: zp_weapon_count
	if(!skip_def_custom) return g_weapon_i[wpn_type]

	static count, i; count = 0
	for(i = 0; i < ArraySize(g_weapon_realname[wpn_type]); i++) {
		if(skip_def_custom == 1 && !ArrayGetCell(g_weapon_is_custom[wpn_type], i) || skip_def_custom == 2 && ArrayGetCell(g_weapon_is_custom[wpn_type], i))
			continue;

		count++
	}
	return count
}
public native_special_class_name(plugin_id, param_nums) { // Native: zp_get_special_class_name
	if(param_nums != 3) return -1;
	if(!g_pluginenabled) return -1; // ZP Special disabled
	
	static id; id = get_param(1)
	
	if(!is_user_valid(id)) return -1;
	if(!g_isconnected[id]) return 0;

	new zm_specials_names[][] = { "Zombie", "Nemesis", "Assassin", "Predator", "Bombardier", "Dragon" }
	new hm_specials_names[][] = { "Human", "Survivor", "Sniper", "Berserker", "Wesker", "Spy" }

	static sp_name[64]
	if(g_zombie[id]) {
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) ArrayGetString(g_zm_special_realname, (g_zm_special[id] - MAX_SPECIALS_ZOMBIES), sp_name, charsmax(sp_name))
		else formatex(sp_name, charsmax(sp_name), "%s", zm_specials_names[g_zm_special[id]])
	}
	else {
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) ArrayGetString(g_hm_special_realname, (g_hm_special[id] - MAX_SPECIALS_HUMANS), sp_name, charsmax(sp_name))
		else formatex(sp_name, charsmax(sp_name), "%s", hm_specials_names[g_hm_special[id]])
	}
	set_string(2, sp_name, get_param(3))
	
	return 1;
}
public native_get_current_mode_name(plugin_id, param_nums) { // Native: zp_get_current_mode_name(name[], len) 
	if(param_nums != 2) return -1;

	new const mode_name[][] = { "None", "Infection", "Nemesis", "Assassin", "Predator", "Bombardier", "Dragon",
	"Survivor", "Sniper", "Berserker", "Wesker", "Spy", "Swarm", "Multi-Infection", "Plague", "Armageddon", "Undefined" }
	
	static g_ModeName[64]
	if(g_currentmode >= MAX_GAME_MODES) ArrayGetString(g_gamemode_name, (g_currentmode - MAX_GAME_MODES), g_ModeName, charsmax(g_ModeName))
	else formatex(g_ModeName, charsmax(g_ModeName), "%s", mode_name[g_currentmode])

	set_string(1, g_ModeName, get_param(2))
	
	return 1;
}
public native_get_gamemode_id(const name[]) { // Native: zp_get_gamemode_id(const name[])
	param_convert(1)
	
	new const mode_name[][] = { "None", "Infection", "Nemesis", "Assassin", "Predator", "Bombardier", "Dragon",
	"Survivor", "Sniper", "Berserker", "Wesker", "Spy", "Swarm", "Multi-Infection", "Plague", "Armageddon", "Undefined" }
	
	new i, mode_id; mode_id = -1

	for(i = 0; i < sizeof mode_name; i++) if(equal(name, mode_name[i])) mode_id = i

	if(mode_id == -1) {	
		static gameid, custom_gamemode_name[32]
		for(i = MAX_GAME_MODES; i < g_gamemodes_i; i++) {
			gameid = i-MAX_GAME_MODES
			if(ArrayGetCell(g_gamemodes_new, gameid)) {
				ArrayGetString(g_gamemode_realname, gameid, custom_gamemode_name, charsmax(custom_gamemode_name)) // Add real name
				if(equal(name, custom_gamemode_name)) mode_id = i
			}
		}
	}
	if(mode_id == -1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Game Mode (%s) Not Found", name)
		return -1;
	}
	return mode_id	
}
public native_get_extra_item_realname(plugin_id, param_nums) { // Native: zp_get_extra_item_realname
	if(param_nums != 3) return -1;
	
	static itemid, buffer[50]
	itemid = get_param(1)
	
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return -1;
	}
	ArrayGetString(g_extraitem_realname, itemid, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	return 1;
}
public native_get_zombie_class_name(plugin_id, param_nums) { // Native: zp_get_zombie_class_name
	if(param_nums != 3) return -1;
	
	static class, buffer[50]
	class = get_param(1)
	
	if(class < 0 || class >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", class)
		return -1;
	}
	ArrayGetString(g_zclass_name, class, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	return 1;
}
public native_get_zclass_realname(plugin_id, param_nums) { // Native: zp_get_zombie_class_realname
	if(param_nums != 3) return -1;
	
	static class, buffer[50]
	class = get_param(1)
	
	if(class < 0 || class >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", class)
		return -1;
	}
	ArrayGetString(g_zclass_real_name, class, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	return 1;
}
public native_get_zombie_class_info(plugin_id, param_nums) { // Native: zp_get_zombie_class_info
	if(param_nums != 3) return -1;
	
	static class, buffer[50]
	class = get_param(1)
	
	if(class < 0 || class >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", class)
		return -1;
	}
	ArrayGetString(g_zclass_info, class, buffer, charsmax(buffer))
	set_string(2, buffer, get_param(3))
	return 1;
}
public native_set_zombie_class_info(class, const newinfo[]) { // Native: zp_set_zombie_class_info
	param_convert(2)
	
	if(class < 0 || class >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", class)
		return false;
	}
	ArraySetString(g_zclass_info, class, newinfo)
	return true
}
public native_set_zombie_class_name(class, const newname[]) { // Native: zp_set_zombie_class_name
	param_convert(2)
	if(class < 0 || class >= g_zclass_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid zombie class id (%d)", class)
		return false;
	}
	ArraySetString(g_zclass_name, class, newname)
	return true
}
public native_set_extra_item_team(itemid, team) { // Native: zp_set_extra_item_team
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return false;
	}
	ArraySetCell(g_extraitem_team, itemid, team)
	return true
}
public native_set_extra_item_cost(itemid, cost) { // Native: zp_set_extra_item_cost
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return false;
	}
	ArraySetCell(g_extraitem_cost, itemid, cost)
	return true;
}
public native_set_extra_item_name(itemid, const newname[]) { // Native: zp_set_extra_item_name
	param_convert(2)
	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return false;
	}
	ArraySetString(g_extraitem_name, itemid, newname)
	return true
}
public native_set_weapon_name(wpn_type, itemid, const newname[]) { // Native: zp_set_weapon_name
	param_convert(3)
	if(itemid < 0 || itemid >= g_weapon_i[wpn_type]) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Weapon id (%d)", itemid)
		return false;
	}
	ArraySetString(g_weapon_name[wpn_type], itemid, newname)
	return true
}

// Native: zp_set_extra_damage
public native_set_extra_damage(victim, attacker, damage, const weaponDescription[], dmg_dealth) { 
	param_convert(4)
	return native_set_user_extra_damage(victim, attacker, damage, weaponDescription, 0);
}

// Native: zp_set_user_extra_damage
public native_set_user_extra_damage(victim, attacker, damage, const weaponDescription[], dmg_dealth) { 
	param_convert(4)

	if(!is_user_valid_alive(attacker) || !is_user_valid_alive(victim)) 
		return 0;

	if(pev(victim, pev_takedamage) == DAMAGE_NO || damage <= 0 || g_nodamage[victim]) 
		return 0;

	if(get_user_health(victim) - damage <= 0 ) {
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
		
		static kname[32], vname[32], kauthid[32], vauthid[32], kteam[10], vteam[10];
		get_user_name(attacker, kname, 31); get_user_team(attacker, kteam, 9); get_user_authid(attacker, kauthid, 31);
		get_user_name(victim, vname, 31); get_user_team(victim, vteam, 9); get_user_authid(victim, vauthid, 31);
		
		log_message("^"%s<%d><%s><%s>^" killed ^"%s<%d><%s><%s>^" with ^"%s^"", kname, get_user_userid(attacker), kauthid, kteam, 
		vname, get_user_userid(victim), vauthid, vteam, weaponDescription);
	}
	else {
		ExecuteHam(Ham_TakeDamage, victim, 0, attacker, float(damage), DMG_BLAST)

		if(dmg_dealth)
			damage_dealth(attacker, victim, damage);
		
	}
	return 1;
}

public native_set_user_maxspeed(id, Float:Speed) { // Native: zp_set_user_maxspeed
	if(!is_user_valid(id)) return false;

	if(!g_isalive[id]) return false;
	
	g_user_custom_speed[id] = true
	g_current_maxspeed[id] = Speed
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)

	return true
}
public Float:native_get_user_maxspeed(id) { // Native: zp_get_user_maxspeed
	if(!is_user_valid(id)) return -1.0;
	
	if(g_user_custom_speed[id]) return g_current_maxspeed[id]
	else if(g_zombie[id]) return (g_zm_special[id] > 0 ? get_pcvar_float(cvar_zm_spd[g_zm_special[id]]) : g_spd[id])
	else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) return g_spd[id]

	return get_pcvar_float(cvar_hm_spd[g_hm_special[id]])
}
public native_reset_user_maxspeed(id) { // Native: zp_reset_user_maxspeed
	if(!is_user_valid(id)) return false;

	if(g_user_custom_speed[id]) {
		g_user_custom_speed[id] = false
		g_current_maxspeed[id] = 0.0
	}	
	ExecuteHamB(Ham_Player_ResetMaxSpeed, id)
	return true;
}
public native_set_user_nightvision(id, set) { // Native: zp_set_user_nightvision
	if(!is_user_valid_connected(id)) return false;

	if(!g_pluginenabled) return false; // ZP Special disabled

	if(set) {
		g_nvision[id] = true
		
		if(!g_isbot[id]) {
			g_nvisionenabled[id] = (set == 1) ? true : false
			user_nightvision(id, set)
		}
		else cs_set_user_nvg(id, 1)
	}
	else {
		cs_set_user_nvg(id, 0) // Remove CS nightvision if player owns one (bugfix)
		g_nvision[id] = false
		nvision_toggle_off(id)
	}
	return true;
}
public native_set_user_madness(id, set) {
	if(!is_user_valid(id)) return false;
	
	if(!g_pluginenabled) return false;
	
	if(set) {
		if(g_nodamage[id]) return false;
		
		g_nodamage[id] = true
		set_task(0.1, "zombie_aura", id+TASK_AURA, _, _, "b")
		set_task(get_pcvar_float(cvar_madnessduration), "madness_over", id+TASK_BLOOD)
		set_pev(id, pev_takedamage, DAMAGE_NO)
			
		static sound[64]
		ArrayGetString(ar_sound[9], random_num(0, ArraySize(ar_sound[9]) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	else madness_over(id+TASK_BLOOD)

	return true;
}
public native_set_user_frozen(id, set) {
	if(!is_user_valid(id)) return false;

	if(!g_pluginenabled) return false;
	
	static sound[64]
	if(set) {
		if(!is_user_valid_alive(id) || g_nodamage[id] || g_frozen[id]) return false; // Only effect alive unfrozen zombies

		ExecuteForward(g_forwards[FROZEN_PRE], g_fwDummyResult, id);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return false;

		if(set < 2) { // Specials Zombies shouldn't be frozen
			if(!get_allowed_frost(id) || g_hm_special[id] > 0) {
				
				static origin2[3]; get_user_origin(id, origin2) // Get player's origin

				ArrayGetString(ar_sound[16], random_num(0, ArraySize(ar_sound[16]) - 1), sound, charsmax(sound))
				emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM) // Broken glass sound
				
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
				
				return true;
			}
		}
		if(get_pcvar_num(cvar_hudicons)) { // Freeze icon?
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

		ArrayGetString(ar_sound[15], random_num(0, ArraySize(ar_sound[15]) - 1), sound, charsmax(sound))
		emit_sound(id, CHAN_BODY, sound, 1.0, ATTN_NORM, 0, PITCH_NORM) // Freeze sound
		
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

		g_frozen[id] = true; // Set a task to remove the freeze
		pev(id, pev_gravity, g_frozen_gravity[id]) // Save player's old gravity (bugfix)
		
		// Prevent from jumping
		if(pev(id, pev_flags) & FL_ONGROUND) set_pev(id, pev_gravity, 999999.9) // set really high
		else set_pev(id, pev_gravity, 0.000001) // no gravity

		ExecuteHamB(Ham_Player_ResetMaxSpeed, id) // Prevent from moving
		ExecuteForward(g_forwards[FROZEN_POST], g_fwDummyResult, id);
		set_task(get_pcvar_float(cvar_freezeduration), "remove_freeze", id)
	}
	else remove_freeze(id)

	return true
}
public native_set_user_burn(id, set) {
	if(!is_user_valid(id)) return false;
	if(!g_pluginenabled) return false;
	
	if(set) {
		if(!is_user_valid_alive(id) || g_nodamage[id]) return false; // Only effect alive zombies
			
		ExecuteForward(g_forwards[BURN_PRE], g_fwDummyResult, id);
		if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return false;

		if(get_pcvar_num(cvar_hudicons)) { // Heat icon?
			message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
			write_byte(0) // damage save
			write_byte(0) // damage take
			write_long(DMG_BURN) // damage type
			write_coord(0) // x
			write_coord(0) // y
			write_coord(0) // z
			message_end()
		}

		if(!get_allowed_burn(id)  && set > 2|| g_hm_special[id] > 0 && set > 2) g_burning_dur[id] += get_pcvar_num(cvar_fireduration)
		else g_burning_dur[id] += get_pcvar_num(cvar_fireduration) * 5
		
		if(g_burning_dur[id] > 0) ExecuteForward(g_forwards[BURN_POST], g_fwDummyResult, id);

		if(!task_exists(id+TASK_BURN)) set_task(0.2, "burning_flame", id+TASK_BURN, _, _, "b") // Set burning task on id if not present
	}
	else g_burning_dur[id] = 0

	return true
}
public native_set_user_infectnade(id, set) {
	if(!is_user_valid_alive(id)) return false;
	if(!g_pluginenabled || !g_zombie[id] || !g_isalive[id]) return false;

	if(set) fm_give_item(id, "weapon_hegrenade");
	else cs_set_user_bpammo(id, CSW_HEGRENADE, 0), engclient_cmd(id, "weapon_knife")

	return true;

}
public native_infect_user(id, infector, silent, rewards) { // Native: zp_infect_user
	if(!g_pluginenabled) return false; // ZP Special disabled
	if(!is_user_valid_alive(id)) return false;	
	if(!allowed_zombie(id)) return false; // Not allowed to be zombie
	
	if(g_newround) { // New round?
		remove_task(TASK_MAKEZOMBIE)
		start_infection_mode(id, MODE_SET) // Set as first zombie
	}
	else zombieme(id, is_user_valid_alive(infector) ? infector : 0, 0, (silent == 1) ? 1 : 0, (rewards == 1) ? 1 : 0) // Just infect (plus some checks)
	
	return true;
}
public native_disinfect_user(id, silent) { // Native: zp_disinfect_user
	if(!g_pluginenabled) return false; // ZP Special disabled
	if(!is_user_valid_alive(id)) return false;
	if(!allowed_human(id)) return false; // Not allowed to be human

	humanme(id, 0, (silent == 1) ? 1 : 0) // Turn to human
	return true;
}
public native_make_user_nemesis(id) return native_make_user_special(id, NEMESIS, 1) // Native: zp_make_user_nemesis
public native_make_user_survivor(id) return native_make_user_special(id, SURVIVOR, 0) // Native: zp_make_user_survivor
public native_make_user_sniper(id) return native_make_user_special(id, SNIPER, 0); // Native: zp_make_user_sniper
public native_make_user_assassin(id) return native_make_user_special(id, ASSASSIN, 1) // Native: zp_make_user_assassin
public native_make_user_predator(id) return native_make_user_special(id, PREDATOR, 1)  // Native: zp_make_user_predator
public native_make_user_bombardier(id) return native_make_user_special(id, BOMBARDIER, 1)  // Native: zp_make_user_bombardier
public native_make_user_dragon(id) return native_make_user_special(id, DRAGON, 1)  // Native: zp_make_user_dragon
public native_make_user_berserker(id) return native_make_user_special(id, BERSERKER, 0) // Native: zp_make_user_berserker
public native_make_user_wesker(id) return native_make_user_special(id, WESKER, 0) // Native: zp_make_user_wesker
public native_make_user_spy(id) return native_make_user_special(id, SPY, 0) // Native: zp_make_user_spy

public native_make_user_special(id, spid, zombie) { // Native: zp_make_user_special
	if(!is_user_valid_alive(id)) return -1;

	if(spid >= g_zm_specials_i && zombie || spid >= g_hm_specials_i && !zombie) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Special class id (%d)", spid)
		return -1;
	}
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!allowed_special(id, zombie, spid)) return 0; // Not allowed to be special

	if(g_newround && spid < MAX_SPECIALS_HUMANS && !zombie || g_newround && spid < MAX_SPECIALS_ZOMBIES && zombie) { // New round?
		remove_task(TASK_MAKEZOMBIE)
		if(zombie) set_special_zombie_mode(id, MODE_SET, spid)
		else set_special_human_mode(id, MODE_SET, spid)
	}
	else { // Turn player into a Special Class
		if(zombie)  zombieme(id, 0, spid, 0, 0)
		else humanme(id, spid, 0)
	}
	return 1;
}
public native_respawn_user(id, team) { // Native: zp_respawn_user
	if(!g_pluginenabled) return false; // ZP Special disabled
	if(!is_user_valid_connected(id)) return false;
	if(!allowed_respawn(id)) return false; // Respawn not allowed

	g_respawn_as_zombie[id] = (team == GetTeamIndex(TEAM_ZOMBIE)) ? true : false // Respawn as zombie?
	respawn_player_manually(id) // Respawnish!
	return true;
}
public native_force_buy_extra_item(id, itemid, ignorecost) { // Native: zp_force_buy_extra_item
	if(!g_pluginenabled) return false; // ZP Special disabled	
	if(!is_user_valid_alive(id)) return false;

	if(itemid < 0 || itemid >= g_extraitem_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid extra item id (%d)", itemid)
		return false;
	}
	buy_extra_item(id, itemid, ignorecost)
	return true;
}
public native_get_user_sniper(id) { // Native: zp_get_user_sniper
	if(!is_user_valid(id)) return -1;
	return g_hm_special[id] == SNIPER;
}
public native_get_user_assassin(id) { // Native: zp_get_user_assassin
	if(!is_user_valid(id)) return -1;
	return g_zm_special[id] == ASSASSIN;
}
public native_get_user_predator(id) { // Native: zp_get_user_predator
	if(!is_user_valid(id)) return -1;
	return g_zm_special[id] == PREDATOR;
}
public native_get_user_bombardier(id) { // Native: zp_get_user_bombardier
	if(!is_user_valid(id)) return -1;
	return g_zm_special[id] == BOMBARDIER;
}
public native_get_user_dragon(id) { // Native: zp_get_user_dragon
	if(!is_user_valid(id)) return -1;
	return g_zm_special[id] == DRAGON;
}
public native_get_user_berserker(id) { // Native: zp_get_user_berserker
	if(!is_user_valid(id)) return -1;
	return g_hm_special[id] == BERSERKER;
}
public native_get_user_wesker(id) { // Native: zp_get_user_wesker
	if(!is_user_valid(id)) return -1;
	return g_hm_special[id] == WESKER;
}
public native_get_user_spy(id) { // Native: zp_get_user_spy
	if(!is_user_valid(id)) return -1;
	return g_hm_special[id] == SPY;
}
public native_get_user_model(plugin_id, param_nums) { // Native: zp_get_user_model
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(param_nums != 3) return -1; // Insufficient number of arguments

	static id; id = get_param(1) // Retrieve the player's index
	if(!is_user_valid_alive(id)) return 0; // Not an alive player or invalid player

	static current_model[32] // Retrieve the player's current model
	fm_cs_get_user_model(id, current_model, charsmax(current_model))
	
	set_string(2, current_model, get_param(3)) // Copy the model name into the array passed
	return 1;
}
public native_override_user_model(id, const newmodel[], modelindex) { // Native: zp_override_user_model
	if(!g_pluginenabled) return false; // ZP Special disabled
	if(!is_user_valid_alive(id)) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Player (%d)", id)
		return false;
	}

	param_convert(2) // Strings passed byref
	ExecuteForward(g_forwards[MODEL_CHANGE_PRE], g_fwDummyResult, id, newmodel)

	if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) return false // The game mode didnt accept some conditions
	remove_task(id+TASK_MODEL) // Remove previous tasks

	static currentmodel[32] // Custom models stuff
	if(g_handle_models_on_separate_ent) {
		copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
		if(g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex) // Set the right model

		fm_set_playermodel_ent(id) // Set model on player model entity
	}
	else {
		fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel))// Get current model for comparing it with the current one
		if(!equal(currentmodel, newmodel)) { // Set the right model, after checking that we don't already have it
			copy(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
			if(g_set_modelindex_offset && modelindex) fm_cs_set_user_model_index(id, modelindex)
			
			// An additional delay is offset at round start
			// since SVC_BAD is more likely to be triggered there
			if(g_newround) set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else fm_user_model_update(id+TASK_MODEL)
		}
	}
	ExecuteForward(g_forwards[MODEL_CHANGE_POST], g_fwDummyResult, id, newmodel)
	return true;
}
public native_has_round_started() { // Native: zp_has_round_started
	if(g_newround) return 0; // not started
	if(g_modestarted) return 1; // started
	return 2; // starting
}
public native_get_current_mode() return g_currentmode; // Native: zp_get_current_mode
public native_get_last_mode() return g_lastmode; // Native: zp_get_last_mode
public native_has_round_ended() return g_endround;  // Native: zp_has_round_ended
public native_is_nemesis_round() return (g_currentmode == MODE_NEMESIS); // Native: zp_is_nemesis_round
public native_is_survivor_round() return (g_currentmode == MODE_SURVIVOR); // Native: zp_is_survivor_round
public native_is_swarm_round() return (g_currentmode == MODE_SWARM); // Native: zp_is_swarm_round
public native_is_plague_round() return (g_currentmode == MODE_PLAGUE); // Native: zp_is_plague_round
public native_get_zombie_count() return fnGetZombies(); // Native: zp_get_zombie_count
public native_get_human_count() return fnGetHumans(); // Native: zp_get_human_count
public native_get_nemesis_count() return fnGetSpecials(1, NEMESIS); // Native: zp_get_nemesis_count
public native_get_survivor_count() return fnGetSpecials(0, SURVIVOR); // Native: zp_get_survivor_count
public native_is_sniper_round() return (g_currentmode == MODE_SNIPER); // Native: zp_is_sniper_round
public native_get_sniper_count() return fnGetSpecials(0, SNIPER); // Native: zp_get_sniper_count
public native_is_assassin_round() return (g_currentmode == MODE_ASSASSIN); // Native: zp_is_assassin_round
public native_get_assassin_count() return fnGetSpecials(1, ASSASSIN); // Native: zp_get_assassin_count
public native_is_predator_round() return (g_currentmode == MODE_PREDATOR); // Native: zp_is_predator_round
public native_get_predator_count() return fnGetSpecials(1, PREDATOR); // Native: zp_get_predator_count
public native_is_bombardier_round() return (g_currentmode == MODE_BOMBARDIER); // Native: zp_is_bombardier_round
public native_get_bombardier_count() return fnGetSpecials(1, BOMBARDIER); // Native: zp_get_bombardier_count
public native_is_dragon_round() return (g_currentmode == MODE_DRAGON); // Native: zp_is_dragon_round
public native_get_dragon_count() return fnGetSpecials(1, DRAGON); // Native: zp_get_dragon_count
public native_is_berserker_round() return (g_currentmode == MODE_BERSERKER); // Native: zp_is_berserker_round
public native_is_wesker_round() return (g_currentmode == MODE_WESKER); // Native: zp_is_wesker_round
public native_is_spy_round() return (g_currentmode == MODE_SPY); // Native: zp_is_spy_round
public native_get_berserker_count() return fnGetSpecials(0, BERSERKER); // Native: zp_get_berserker_count
public native_get_wesker_count() return fnGetSpecials(0, WESKER); // Native: zp_get_wesker_count
public native_get_spy_count() return fnGetSpecials(0, SPY); // Native: zp_get_spy_count
public native_is_lnj_round() return (g_currentmode == MODE_LNJ); // Native: zp_is_lnj_round
public native_get_special_count(is_zombie, specialid) {	
	if(specialid < 0 || specialid >= g_zm_specials_i && is_zombie || specialid >= g_hm_specials_i && !is_zombie) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid Special class id (%d)", specialid)
		return -1;
	}
	return fnGetSpecials(is_zombie, specialid);
}

// Native: zp_register_human_special
public native_register_human_special(const name[], const model[], hp, speed, Float:gravity, flags, clip_type, aura_radius, glow, r, g, b) {
	if(!g_pluginenabled) return -1; // ZP Special disabled

	if(!g_arrays_created) return -1; // Arrays not yet initialized
	
	param_convert(1); param_convert(2) // Strings passed byref
			
	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register Custom Special Class with an empty name")
		return -1;
	}

	static index, sp_name[32]
	for(index = MAX_SPECIALS_HUMANS; index < g_hm_specials_i; index++) {
		ArrayGetString(g_hm_special_realname, index-MAX_SPECIALS_HUMANS, sp_name, charsmax(sp_name))
		if(equali(name, sp_name)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Custom Special Class already registered (%s)", sp_name)
			return -1;
		}
	}
	
	ArrayPushString(g_hm_special_realname, name)
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
	ArrayPushCell(g_hm_special_nvision, 1)
	ArrayPushCell(g_hm_special_painfree, 0)
	ArrayPushCell(g_hm_special_enable, 1)
	ArrayPushCell(g_hm_specials, 1)
	ArrayPushCell(ZP_TEAM_INDEX, ArraySize(ZP_TEAM_NAMES))
	ArrayPushCell(itens_teams_index_human, ArraySize(ZP_TEAM_NAMES))

	formatex(sp_name, charsmax(sp_name), name)
	strtoupper(sp_name)
	ArrayPushString(ZP_TEAM_NAMES, sp_name)
	
	new section[64]
	new specialid = g_hm_specials_i-MAX_SPECIALS_HUMANS
	ArrayGetString(g_hm_special_realname, specialid, section, charsmax(section))
	
	// Load Custom Special Classes
	new buffer[64], value, Float:value_f
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value)) {
		if(value == 1 || value == 2 && !g_escape_map || value >= 3 && g_escape_map) ArraySetCell(g_hm_special_enable, specialid, 1)
		else ArraySetCell(g_hm_special_enable, specialid, 0)
	}
	
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer))) ArraySetString(g_hm_special_name, specialid, buffer)
	
	// Load Models //
	temp_array[0] = ArrayCreate(32, 1) // Create a Temporary Array
	ArrayPushCell(g_hm_special_modelstart, ArraySize(g_hm_special_model))
	amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0])
	if(ArraySize(temp_array[0]) > 0) {
		for(new i = 0; i < ArraySize(temp_array[0]); i++) {
			ArrayGetString(temp_array[0], i, buffer, charsmax(buffer))
			ArrayPushString(g_hm_special_model, buffer)
			ArrayPushCell(g_hm_special_modelindex, -1)
		}
	}
	else {
		ArrayPushString(g_hm_special_model, model)
		ArrayPushCell(g_hm_special_modelindex, -1)
	}
	ArrayPushCell(g_hm_special_modelindex, -1)
	ArrayPushCell(g_hm_special_modelsend, ArraySize(g_hm_special_model))
	ArrayDestroy(temp_array[0]) // Destroy a Temporary Array
	//----------------------------------------------------------------------------
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value)) ArraySetCell(g_hm_special_health, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value)) ArraySetCell(g_hm_special_speed, specialid, value);
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f)) ArraySetCell(g_hm_special_gravity, specialid, value_f);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value)) ArraySetCell(g_hm_special_aurarad, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value)) ArraySetCell(g_hm_special_glow, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value)) ArraySetCell(g_hm_special_nvision, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value)) ArraySetCell(g_hm_special_r, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value)) ArraySetCell(g_hm_special_g, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value)) ArraySetCell(g_hm_special_b, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value)) ArraySetCell(g_hm_special_leap, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value)) ArraySetCell(g_hm_special_leap_f, specialid, value);
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f)) ArraySetCell(g_hm_special_leap_h, specialid, value_f);
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f)) ArraySetCell(g_hm_special_leap_c, specialid, value_f);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "CLIP TYPE", value)) ArraySetCell(g_hm_special_uclip, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value)) ArraySetCell(g_hm_special_ignorefrag, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value)) ArraySetCell(g_hm_special_ignoreammo, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value)) ArraySetCell(g_hm_special_respawn, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value)) ArraySetCell(g_hm_special_painfree, specialid, value);
	
	if(ArrayGetCell(g_hm_special_enable, specialid) >= 1) {
		// Precache player model
		for(new i = ArrayGetCell(g_hm_special_modelstart, specialid); i < ArrayGetCell(g_hm_special_modelsend, specialid); i++) {
			ArrayGetString(g_hm_special_model, i, buffer, charsmax(buffer))
			ArraySetCell(g_hm_special_modelindex, i, precache_player_model(buffer))
		}
	}
	g_hm_specials_i++ // Increase registered special humans counter
	return (g_hm_specials_i-1); // Return id under which we registered the human special 
}
// Native: zp_register_zombie_special
public native_register_zombie_special(const name[], const model[], const knifemodel[], const pain_sound[], hp, speed, Float:gravity, flags, Float:knockback, aura_radius, glow, r, g, b) {
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized

	param_convert(1); param_convert(2); param_convert(3); param_convert(4) // Strings passed byref
	
	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register Custom Special Class with an empty name")
		return -1;
	}

	static index, sp_name[32]
	for(index = MAX_SPECIALS_ZOMBIES; index < g_zm_specials_i; index++) {
		ArrayGetString(g_zm_special_realname, index-MAX_SPECIALS_ZOMBIES, sp_name, charsmax(sp_name))
		if(equali(name, sp_name)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Custom Special Class already registered (%s)", sp_name)
			return -1;
		}
	}

	ArrayPushString(g_zm_special_realname, name)
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
	ArrayPushCell(g_zm_special_nvision, 1)
	ArrayPushCell(g_zm_special_knockback, knockback)
	ArrayPushCell(g_zm_special_ignorefrag, 0)
	ArrayPushCell(g_zm_special_ignoreammo, 0)
	ArrayPushCell(g_zm_special_respawn, 1)
	ArrayPushCell(g_zm_special_enable, 1)
	ArrayPushCell(g_zm_special_painfree, 0)
	ArrayPushCell(g_zm_special_allow_burn, 0)
	ArrayPushCell(g_zm_special_allow_frost, 0)
	ArrayPushCell(ZP_TEAM_INDEX, ArraySize(ZP_TEAM_NAMES))
	ArrayPushCell(itens_teams_index_zombie, ArraySize(ZP_TEAM_NAMES))
	formatex(sp_name, charsmax(sp_name), name)
	strtoupper(sp_name)
	ArrayPushString(ZP_TEAM_NAMES, sp_name)

	ArrayPushCell(g_zm_specials, 1)

	new section[64]
	new specialid = g_zm_specials_i-MAX_SPECIALS_ZOMBIES
	ArrayGetString(g_zm_special_realname, specialid, section, charsmax(section))
	
	// Load Custom Special Classes
	new buffer[64], value, Float:value_f, i
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ENABLE", value)) {
		if(value == 1 || value == 2 && !g_escape_map || value >= 3 && g_escape_map) ArraySetCell(g_zm_special_enable, specialid, 1)
		else ArraySetCell(g_zm_special_enable, specialid, 0)
	}
	
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "NAME", buffer, charsmax(buffer))) ArraySetString(g_zm_special_name, specialid, buffer)
		
	// Load Models //
	temp_array[0] = ArrayCreate(32, 1) // Create a Temporary Array
	ArrayPushCell(g_zm_special_modelstart, ArraySize(g_zm_special_model))
	amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "MODEL", temp_array[0])
	if(ArraySize(temp_array[0]) > 0) {
		for(i = 0; i < ArraySize(temp_array[0]); i++) {
			ArrayGetString(temp_array[0], i, buffer, charsmax(buffer))
			ArrayPushString(g_zm_special_model, buffer)
			ArrayPushCell(g_zm_special_modelindex, -1)
		}
	}
	else {
		ArrayPushString(g_zm_special_model, model)
		ArrayPushCell(g_zm_special_modelindex, -1)
	}
	ArrayPushCell(g_zm_special_modelindex, -1)
	ArrayPushCell(g_zm_special_modelsend, ArraySize(g_zm_special_model))
	ArrayDestroy(temp_array[0])
	//----------------------------------------------------------------------------

	// Knife model //
	if(amx_load_setting_string(ZP_SPECIAL_CLASSES_FILE, section, "V_KNIFE MODEL", buffer, charsmax(buffer))) 
		ArraySetString(g_zm_special_knifemodel, specialid, buffer)

	//----------------------------------------------------------------------------

	// Load Pain Sounds //
	temp_array[1] = ArrayCreate(64, 1)
	ArrayPushCell(g_zm_special_painsndstart, ArraySize(g_zm_special_painsound))
	amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "PAIN SOUND", temp_array[1])
	if(ArraySize(temp_array[1]) > 0) {
		for(i = 0; i < ArraySize(temp_array[1]); i++) {
			ArrayGetString(temp_array[1], i, buffer, charsmax(buffer))
			ArrayPushString(g_zm_special_painsound, buffer)
		}
	}
	else ArrayPushString(g_zm_special_painsound, pain_sound)

	ArrayPushCell(g_zm_special_painsndsend, ArraySize(g_zm_special_painsound))
	ArrayDestroy(temp_array[1])
	
	//-----------------------------------------------------------------------------
	
	// Load Death Sounds //
	temp_array[2] = ArrayCreate(64, 1)
	ArrayPushCell(g_zm_sp_deathsnd_start, ArraySize(g_zm_sp_deathsnd))
	amx_load_setting_string_arr(ZP_SPECIAL_CLASSES_FILE, section, "DEATH SOUND", temp_array[2])
	if(ArraySize(temp_array[2]) > 0) {
		for(i = 0; i < ArraySize(temp_array[2]); i++) {
			ArrayGetString(temp_array[2], i, buffer, charsmax(buffer))
			ArrayPushString(g_zm_sp_deathsnd, buffer)
		}
	}
	else { 
		for(i = 0; i < ArraySize(ar_sound[1]); i++) {
			ArrayGetString(ar_sound[1], i, buffer, charsmax(buffer))
			ArrayPushString(g_zm_sp_deathsnd, buffer)
		}
	}

	ArrayPushCell(g_zm_sp_deathsnd_end, ArraySize(g_zm_sp_deathsnd))
	ArrayDestroy(temp_array[2])
	//-----------------------------------------------------------------------------


	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "HEALTH", value)) ArraySetCell(g_zm_special_health, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "SPEED", value)) ArraySetCell(g_zm_special_speed, specialid, value);		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "GRAVITY", value_f)) ArraySetCell(g_zm_special_gravity, specialid, value_f);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "AURA SIZE", value)) ArraySetCell(g_zm_special_aurarad, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GLOW ENABLE", value)) ArraySetCell(g_zm_special_glow, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "NVISION ENABLE", value)) ArraySetCell(g_zm_special_nvision, specialid, value);
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "RED", value)) ArraySetCell(g_zm_special_r, specialid, value);	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "GREEN", value)) ArraySetCell(g_zm_special_g, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "BLUE", value)) ArraySetCell(g_zm_special_b, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW LEAP", value)) ArraySetCell(g_zm_special_leap, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "LEAP FORCE", value)) ArraySetCell(g_zm_special_leap_f, specialid, value);	
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP HEIGHT", value_f)) ArraySetCell(g_zm_special_leap_h, specialid, value_f);		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "LEAP COOLDOWN", value_f)) ArraySetCell(g_zm_special_leap_c, specialid, value_f);		
	if(amx_load_setting_float(ZP_SPECIAL_CLASSES_FILE, section, "KNOCKBACK", value_f)) ArraySetCell(g_zm_special_knockback, specialid, value_f);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE FRAG", value)) ArraySetCell(g_zm_special_ignorefrag, specialid, value);	
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "IGNORE AMMO", value)) ArraySetCell(g_zm_special_ignoreammo, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW RESPAWN", value)) ArraySetCell(g_zm_special_respawn, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "PAINFREE", value)) ArraySetCell(g_zm_special_painfree, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW BURN", value)) ArraySetCell(g_zm_special_allow_burn, specialid, value);		
	if(amx_load_setting_int(ZP_SPECIAL_CLASSES_FILE, section, "ALLOW FROST", value)) ArraySetCell(g_zm_special_allow_frost, specialid, value);			

	if(ArrayGetCell(g_zm_special_enable, specialid) >= 1) {
		ArrayGetString(g_zm_special_knifemodel, specialid, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheModel, buffer)  // Precache Knife Model

		for(i = ArrayGetCell(g_zm_special_painsndstart, specialid); i < ArrayGetCell(g_zm_special_painsndsend, specialid); i++) {
			ArrayGetString(g_zm_special_painsound, i, buffer, charsmax(buffer))
			engfunc(EngFunc_PrecacheSound, buffer) // Precache Pain Sound
		}
		for(i = ArrayGetCell(g_zm_special_modelstart, specialid); i < ArrayGetCell(g_zm_special_modelsend, specialid); i++) {
			ArrayGetString(g_zm_special_model, i, buffer, charsmax(buffer))
			ArraySetCell(g_zm_special_modelindex, i, precache_player_model(buffer)) // Precache player model
		}
		for(i = ArrayGetCell(g_zm_sp_deathsnd_start, specialid); i < ArrayGetCell(g_zm_sp_deathsnd_end, specialid); i++) {
			ArrayGetString(g_zm_sp_deathsnd, i, buffer, charsmax(buffer))
			engfunc(EngFunc_PrecacheSound, buffer) // Precache Pain Sound
		}
	}
	g_zm_specials_i++ // Increase registered special humans counter

	return (g_zm_specials_i-1); // Return id under which we registered the human special 
}
public native_register_game_mode(const name[], flags, chance, allow, dm_mode) { // Native: zp_register_game_mode
	return native_register_gamemode(name, flags, chance, allow, dm_mode, 0, 1)
}

public native_register_gamemode(const name[], flags, chance, allow, dm_mode, resp_limit, enable_in_ze) { // Native: zpsp_register_gamemode
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized

	param_convert(1) // Strings passed byref

	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register Game Mode with an empty name")
		return -1;
	}
	static index, gm_name[32]
	for(index = MAX_GAME_MODES; index < g_gamemodes_i; index++) {
		ArrayGetString(g_gamemode_realname, index-MAX_GAME_MODES, gm_name, charsmax(gm_name))
		if(equali(name, gm_name)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Game Mode already registered (%s)", gm_name)
			return -1;
		}
	}
	// Add the game mode
	ArrayPushString(g_gamemode_realname, name)
	ArrayPushString(g_gamemode_name, name)
	ArrayPushCell(g_gamemode_flag, flags)
	ArrayPushCell(g_gamemode_chance, chance)
	ArrayPushCell(g_gamemode_allow, allow)
	ArrayPushCell(g_gamemode_dm, dm_mode)
	ArrayPushCell(g_gamemode_respawn_limit, resp_limit)
	ArrayPushCell(g_gamemode_enable_on_ze_map, enable_in_ze)
	ArrayPushCell(g_gamemode_enable, 1)
	ArrayPushCell(g_gamemodes_new, 1)

	new section[64], szName[32], value
	new gameid = g_gamemodes_i-MAX_GAME_MODES
	ArrayGetString(g_gamemode_realname, gameid, section, charsmax(section))
	
	// Load Custom Game Modes	
	if(amx_load_setting_string(ZP_CUSTOM_GM_FILE, section, "GAMEMODE NAME", szName, charsmax(szName))) ArraySetString(g_gamemode_name, gameid, szName);
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE", value)) ArraySetCell(g_gamemode_enable, gameid, value);
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE ENABLE ON ESCAPE MAP", value)) ArraySetCell(g_gamemode_enable_on_ze_map, gameid, value);
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE CHANCE", value)) ArraySetCell(g_gamemode_chance, gameid, value);
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN MODE", value)) ArraySetCell(g_gamemode_dm, gameid, value);
	if(amx_load_setting_int(ZP_CUSTOM_GM_FILE, section, "GAMEMODE RESPAWN LIMIT", value)) ArraySetCell(g_gamemode_respawn_limit, gameid, value);

	g_gamemodes_i++ // Increase registered game modes counter
	return (g_gamemodes_i-1); // Return id under which we registered the game mode
}
// Native: zp_zombie_class_textadd / zp_extra_item_textadd / zp_weapon_menu_textadd
public native_menu_textadd(const text[]) {
	param_convert(1)	
	format(g_AdditionalMenuText, charsmax(g_AdditionalMenuText), "%s%s", g_AdditionalMenuText, text)
}
// Native: zp_register_extra_item
public native_register_extra_item(const name[], cost, team) {
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized

	static i, itemname[32]

	if(team == ZP_TEAM_ANY) team = GetTeamIndex(TEAM_HUMAN)|GetTeamIndex(TEAM_ZOMBIE) // For backwards compatibility
	// For easy making extra for any classes
	else if(team == ZP_TEAM_ALL) for(i = 0; i < ArraySize(ZP_TEAM_NAMES); i++) team |= GetTeamIndex(i);
	else if(team == ZP_TEAM_ANY_SPECIAL) for(i = 2; i < ArraySize(ZP_TEAM_NAMES); i++) team |= GetTeamIndex(i);
	else if(team == ZP_TEAM_HUMAN_SPECIAL) for(i = 1; i < ArraySize(itens_teams_index_human); i++) team |= GetTeamIndex(ArrayGetCell(itens_teams_index_human, i));
	else if(team == ZP_TEAM_ZOMBIE_SPECIAL) for(i = 1; i < ArraySize(itens_teams_index_zombie); i++) team |= GetTeamIndex(ArrayGetCell(itens_teams_index_zombie, i));

	param_convert(1) // Strings passed byref

	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register extra item with an empty name")
		return -1;
	}
	for(i = 0; i < g_extraitem_i; i++) {
		ArrayGetString(g_extraitem_realname, i, itemname, charsmax(itemname))
		if(equali(name, itemname)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Extra Item already registered (%s)", itemname)
			return -1;
		}
	}

	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	ArrayPushString(g_extraitem_realname, name)

	temp_array[0] = ArrayCreate(32, 1)	// Create a Temporary Array
	ArrayPushCell(g_extraitem_new, 1) // Set temporary new item flag
	
	new section[64], sz_custom_name[32], cost2, team2, szTeam[32], szTeam2[32]
	ArrayGetString(g_extraitem_realname, g_extraitem_i, section, charsmax(section))

	if(amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", sz_custom_name, charsmax(sz_custom_name))) ArraySetString(g_extraitem_name, g_extraitem_i, sz_custom_name)
	if(amx_load_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", cost2)) ArraySetCell(g_extraitem_cost, g_extraitem_i, cost2)
	
	team2 = 0
	if(amx_load_setting_string_arr(ZP_EXTRAITEMS_FILE, section, "TEAMS", temp_array[0])) {
		for(new t = 0; t < ArraySize(ZP_TEAM_NAMES); t++) {
			for(i = 0; i < ArraySize(temp_array[0]); i++) {
				ArrayGetString(temp_array[0], i, szTeam, charsmax(szTeam))
				ArrayGetString(ZP_TEAM_NAMES, t, szTeam2, charsmax(szTeam2))

				if(equal(szTeam, szTeam2)) team2 |= GetTeamIndex(t)
			}
		}
		ArraySetCell(g_extraitem_team, g_extraitem_i, team2)
	}
	
	g_extraitem_i++ // Increase registered items counter	
	ArrayDestroy(temp_array[0])
	return (g_extraitem_i-1); // Return id under which we registered the item 
}
native_register_extra_item2(const name[], cost, team) { // Function: zp_register_extra_item (to be used within this plugin only)
	ArrayPushString(g_extraitem_realname, name)
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushCell(g_extraitem_team, team)
	ArrayPushCell(g_extraitem_new, 1) // Set temporary new item flag
	g_extraitem_i++ // Increase registered items counter
}
public native_register_extra_item3(const name[], cost, const szTeam[]) { // Native: zpsp_register_extra_item
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized
	
	param_convert(1); param_convert(3) // Strings passed byref
	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register extra item with an empty name")
		return -1;
	}
	static index, itemname[32]
	for(index = 0; index < g_extraitem_i; index++) {
		ArrayGetString(g_extraitem_realname, index, itemname, charsmax(itemname))
		if(equali(name, itemname)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Extra Item already registered (%s)", itemname)
			return -1;
		}
	}

	// Add the item
	ArrayPushString(g_extraitem_name, name)
	ArrayPushCell(g_extraitem_cost, cost)
	ArrayPushString(g_extraitem_realname, name)

	static key[64], value[512], team, buffer[32]
	team = 0
	formatex(value, charsmax(value), szTeam)
	while(value[0] != 0 && strtok(value, key, charsmax(key), value, charsmax(value), ',')) {
		trim(key); trim(value) // Trim spaces
		for(new t = 0; t < ArraySize(ZP_TEAM_NAMES); t++) {
			ArrayGetString(ZP_TEAM_NAMES, t, buffer, charsmax(buffer))
			if(equal(key, buffer)) team |= GetTeamIndex(t)
		}
	}
	ArrayPushCell(g_extraitem_team, team)

	temp_array[0] = ArrayCreate(32, 1)	// Create a Temporary Array
	ArrayPushCell(g_extraitem_new, 1) // Set temporary new item flag

	new section[64], _value, szTeam2[32]
	ArrayGetString(g_extraitem_realname, g_extraitem_i, section, charsmax(section))

	if(amx_load_setting_string(ZP_EXTRAITEMS_FILE, section, "NAME", buffer, charsmax(buffer)))
		ArraySetString(g_extraitem_name, g_extraitem_i, buffer)
	
	if(amx_load_setting_int(ZP_EXTRAITEMS_FILE, section, "COST", _value))
		ArraySetCell(g_extraitem_cost, g_extraitem_i, _value)

	_value = 0
	if(amx_load_setting_string_arr(ZP_EXTRAITEMS_FILE, section, "TEAMS", temp_array[0])) {
		for(new t = 0; t < ArraySize(ZP_TEAM_NAMES); t++) {
			for(index = 0; index < ArraySize(temp_array[0]); index++) {
				ArrayGetString(temp_array[0], index, buffer, charsmax(buffer))
				ArrayGetString(ZP_TEAM_NAMES, t, szTeam2, charsmax(szTeam2))
				if(equal(buffer, szTeam2)) _value |= GetTeamIndex(t)
			}
		}
		ArraySetCell(g_extraitem_team, g_extraitem_i, _value)
	}
	g_extraitem_i++ // Increase registered items counter
	ArrayDestroy(temp_array[0])
	return (g_extraitem_i-1); // Return id under which we registered the item
}
// Native: zp_register_zombie_class
public native_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback) {
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized

	param_convert(1); param_convert(2); param_convert(3); param_convert(4) // Strings passed byref
	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register zombie class with an empty name")
		return -1;
	}

	static index, zombieclass_name[32]
	for(index = 0; index < g_zclass_i; index++) {
		ArrayGetString(g_zclass_real_name, index, zombieclass_name, charsmax(zombieclass_name))
		if(equali(name, zombieclass_name)) {
			log_error(AMX_ERR_NATIVE, "[ZP] Zombie class already registered (%s)", name)
			return -1;
		}
	}
	
	// Add the class
	ArrayPushString(g_zclass_real_name, name)
	ArrayPushString(g_zclass_name, name)
	ArrayPushString(g_zclass_info, info)	
	ArrayPushString(g_zclass_clawmodel, clawmodel)
	ArrayPushCell(g_zclass_hp, hp)
	ArrayPushCell(g_zclass_spd, speed)
	ArrayPushCell(g_zclass_grav, gravity)
	ArrayPushCell(g_zclass_kb, knockback)

	ArrayPushCell(g_zclass_new, 1) // Set temporary new class flag
	
	new section[64], buffer[64], prec_mdl[64], value, Float:value_f, i
	ArrayGetString(g_zclass_real_name, g_zclass_i, section, charsmax(section))
	
	// Replace Name
	if(amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "NAME", buffer, charsmax(buffer))) ArraySetString(g_zclass_name, g_zclass_i, buffer)
	
	// Replace/Load Models
	if(g_same_models_for_all) { // Using same zombie models for all classes?
		ArrayPushCell(g_zclass_modelsstart, 0)
		ArrayPushCell(g_zclass_modelsend, ArraySize(g_zclass_playermodel))
	}
	else {
		temp_array[0] = ArrayCreate(32, 1) // Create Temporary Array
		ArrayPushCell(g_zclass_modelsstart, ArraySize(g_zclass_playermodel))
		amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "MODELS", temp_array[0])
		if(ArraySize(temp_array[0]) > 0) {
			for(i = 0; i < ArraySize(temp_array[0]); i++) {
				ArrayGetString(temp_array[0], i, buffer, charsmax(buffer))
				ArrayPushString(g_zclass_playermodel, buffer)
			}
		}
		else ArrayPushString(g_zclass_playermodel, model)

		ArrayPushCell(g_zclass_modelsend, ArraySize(g_zclass_playermodel))
		ArrayDestroy(temp_array[0])
	}

	if(amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "INFO", buffer, charsmax(buffer))) ArraySetString(g_zclass_info, g_zclass_i, buffer); // Replace info	
	if(amx_load_setting_string(ZP_ZOMBIECLASSES_FILE, section, "CLAWMODEL", buffer, charsmax(buffer))) ArraySetString(g_zclass_clawmodel, g_zclass_i, buffer); // Replace clawmodel
	if(amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, section, "HEALTH", value)) ArraySetCell(g_zclass_hp, g_zclass_i, value); // Replace health	
	if(amx_load_setting_int(ZP_ZOMBIECLASSES_FILE, section, "SPEED", value)) ArraySetCell(g_zclass_spd, g_zclass_i, value); // Replace speed	
	if(amx_load_setting_float(ZP_ZOMBIECLASSES_FILE, section, "GRAVITY", value_f)) ArraySetCell(g_zclass_grav, g_zclass_i, value_f); // Replace gravity	
	if(amx_load_setting_float(ZP_ZOMBIECLASSES_FILE, section, "KNOCKBACK", value_f)) ArraySetCell(g_zclass_kb, g_zclass_i, value_f); // Replace knockback

	if(!g_same_models_for_all) {
		for(i = ArrayGetCell(g_zclass_modelsstart, g_zclass_i); i < ArrayGetCell(g_zclass_modelsend, g_zclass_i); i++) {
			ArrayGetString(g_zclass_playermodel, i, buffer, charsmax(buffer))
			ArrayPushCell(g_zclass_modelindex, precache_player_model(buffer))
		}
	}	

	// Load Pain Sounds //
	temp_array[1] = ArrayCreate(64, 1)
	ArrayPushCell(g_zclass_painsnd_start, ArraySize(g_zclass_painsnd))
	amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "PAIN SOUND", temp_array[1])
	if(ArraySize(temp_array[1]) > 0) {
		for(i = 0; i < ArraySize(temp_array[1]); i++) {
			ArrayGetString(temp_array[1], i, buffer, charsmax(buffer))
			ArrayPushString(g_zclass_painsnd, buffer)
		}
	}
	else { 
		for(i = 0; i < ArraySize(zombie_pain[0]); i++) {
			ArrayGetString(zombie_pain[0], i, buffer, charsmax(buffer))
			ArrayPushString(g_zclass_painsnd, buffer)
		}
	}

	ArrayPushCell(g_zclass_painsnd_end, ArraySize(g_zclass_painsnd))
	ArrayDestroy(temp_array[1])
	//--------------------------------------------------------------

	// Load Death Sounds //
	temp_array[2] = ArrayCreate(64, 1)
	ArrayPushCell(g_zclass_deathsnd_start, ArraySize(g_zclass_deathsnd))
	amx_load_setting_string_arr(ZP_ZOMBIECLASSES_FILE, section, "DEATH SOUND", temp_array[2])
	if(ArraySize(temp_array[2]) > 0) {
		for(i = 0; i < ArraySize(temp_array[2]); i++) {
			ArrayGetString(temp_array[2], i, buffer, charsmax(buffer))
			ArrayPushString(g_zclass_deathsnd, buffer)
		}
	}
	else { 
		for(i = 0; i < ArraySize(ar_sound[1]); i++) {
			ArrayGetString(ar_sound[1], i, buffer, charsmax(buffer))
			ArrayPushString(g_zclass_deathsnd, buffer)
		}
	}

	ArrayPushCell(g_zclass_deathsnd_end, ArraySize(g_zclass_deathsnd))
	ArrayDestroy(temp_array[2])
	//-----------------------------------------------------------------

	// Precache Section
	for(i = ArrayGetCell(g_zclass_deathsnd_start, g_zclass_i); i < ArrayGetCell(g_zclass_deathsnd_end, g_zclass_i); i++) {
		ArrayGetString(g_zclass_deathsnd, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer) // Precache Death Sound
	}

	for(i = ArrayGetCell(g_zclass_painsnd_start, g_zclass_i); i < ArrayGetCell(g_zclass_painsnd_end, g_zclass_i); i++) {
		ArrayGetString(g_zclass_painsnd, i, buffer, charsmax(buffer))
		engfunc(EngFunc_PrecacheSound, buffer) // Precache Pain Sound
	}

	ArrayGetString(g_zclass_clawmodel, g_zclass_i, buffer, charsmax(buffer))
	formatex(prec_mdl, charsmax(prec_mdl), "models/zombie_plague/%s", buffer)
	engfunc(EngFunc_PrecacheModel, prec_mdl) // Precache default clawmodel

	//-----------------------------------------------------------------------------
	
	g_zclass_i++ // Increase registered classes counter
	return (g_zclass_i-1); // Return id under which we registered the class
}
public native_get_extra_item_id(const name[]) { // Native: zp_get_extra_item_id
	if(!g_pluginenabled) return -1; // ZP Special disabled

	param_convert(1) // Strings passed byref
	
	// Loop through every item
	static i, item_name[32], itemid
	itemid = -1
	for(i = 0; i < g_extraitem_i; i++) {
		ArrayGetString(g_extraitem_realname, i, item_name, charsmax(item_name))
		if(equali(name, item_name)) { // Check if this is the item to retrieve
			itemid = i
			break;
		}
	}
	return itemid;
}
public native_get_zombie_class_id(const name[]) { // Native: zp_get_zombie_class_id
	if(!g_pluginenabled) return -1; // ZP Special disabled
	
	param_convert(1); // Strings passed byref
	
	// Loop through every class
	static i, class_name[32], classid
	classid = -1
	for(i = 0; i < g_zclass_i; i++) {
		ArrayGetString(g_zclass_real_name, i, class_name, charsmax(class_name))
		if(equali(name, class_name)) { // Check if this is the class to retrieve
			classid = i;
			break;
		}
	}
	return classid;
}
public native_get_special_class_id(is_zombie, const _name[]) { // Native: zp_get_special_class_id
	if(!g_pluginenabled) return -1; // ZP Special disabled
	
	param_convert(2); // Strings passed byref
	
	// Loop through every item
	static i, class_name[32], name[32]
	formatex(name, charsmax(name), _name)
	strtolower(name)

	if(is_zombie) {
		if(equali(name, "nemesis")) return NEMESIS;			
		else if(equali(name, "assassin")) return ASSASSIN;			
		else if(equali(name, "predator")) return PREDATOR;			
		else if(equali(name, "bombardier")) return BOMBARDIER;			
		else if(equali(name, "dragon")) return DRAGON;

		for(i = MAX_SPECIALS_ZOMBIES; i < g_zm_specials_i; i++) {
			ArrayGetString(g_zm_special_realname, i-MAX_SPECIALS_ZOMBIES, class_name, charsmax(class_name))
			strtolower(class_name)
			if(equali(name, class_name)) return i; // Check if this is the item to retrieve
		}
	}
	
	else {
		if(equali(name, "survivor")) return SURVIVOR;			
		else if(equali(name, "sniper")) return SNIPER;			
		else if(equali(name, "berserker")) return BERSERKER;			
		else if(equali(name, "wesker")) return WESKER;			
		else if(equali(name, "spy")) return SPY;

		for(i = MAX_SPECIALS_HUMANS; i < g_hm_specials_i; i++) {
			ArrayGetString(g_hm_special_realname, i-MAX_SPECIALS_HUMANS, class_name, charsmax(class_name))
			strtolower(class_name)
			if(equali(name, class_name)) return i; // Check if this is the item to retrieve
		}
	}
	return -1;
}
public native_set_custom_game_mod(gameid) { // Native: zp_set_custom_game_mod
	if(gameid < MAX_GAME_MODES || gameid >= g_gamemodes_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid game mod id (%d)", gameid)
		return -1;
	}
	if(!g_endround && g_newround && !task_exists(TASK_WELCOMEMSG)) { // Fix Bug on Custom Special Classes Game modes not start when have one people on server
		command_custom_game(gameid, 0)
		return 1;
	}
	return 0		
}
public native_start_game_mode(gameid, force_start) { // Native: zp_start_game_mode
	if(gameid < 0 || gameid >= g_gamemodes_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid game mod id (%d)", gameid)
		return -1;
	}

	static started; started = 0
	if(!g_endround && (g_newround || force_start) && !task_exists(TASK_WELCOMEMSG)) {
		switch (gameid) {
			case MODE_INFECTION: started = start_infection_mode(0, MODE_SET)
			case MODE_NEMESIS: started = start_nemesis_mode(0, MODE_SET)
			case MODE_ASSASSIN: started = start_assassin_mode(0, MODE_SET)
			case MODE_PREDATOR: started = start_predator_mode(0, MODE_SET)
			case MODE_BOMBARDIER: started = start_bombardier_mode(0, MODE_SET)
			case MODE_DRAGON: started = start_dragon_mode(0, MODE_SET)
			case MODE_SURVIVOR: started = start_survivor_mode(0, MODE_SET)
			case MODE_SNIPER: started = start_sniper_mode(0, MODE_SET)
			case MODE_BERSERKER: started = start_berserker_mode(0, MODE_SET)
			case MODE_WESKER: started = start_wesker_mode(0, MODE_SET)
			case MODE_SPY: started = start_spy_mode(0, MODE_SET)
			case MODE_SWARM: started = start_swarm_mode(0, MODE_SET)
			case MODE_MULTI: started = start_multi_mode(0, MODE_SET)
			case MODE_PLAGUE: started = start_plague_mode(0, MODE_SET)
			case MODE_LNJ: started = start_lnj_mode(0, MODE_SET)
			default: {
				command_custom_game(gameid, 0)
				started = 1;
			}
		}
		if(started) remove_task(TASK_MAKEZOMBIE)
	}
	return started
}
public native_set_next_game_mode(gameid) { // Native: zp_set_next_game_mode
	if(gameid < 0 || gameid >= g_gamemodes_i) {
		log_error(AMX_ERR_NATIVE, "[ZP] Invalid game mod id (%d)", gameid)
		return -1;
	}
	g_nextmode = gameid
	return 1
}
public native_reset_player_model(id) { // Native: zp_reset_player_model
	if(!is_user_valid_alive(id)) return false;

	reset_player_models(id)
	return true
}
public native_get_extra_item_count() return g_extraitem_i; // Native: zp_get_extra_item_count
public native_get_zclass_count() return g_zclass_i; // Native: zp_get_zclass_count
public native_get_gamemodes_count() return (g_gamemodes_i - MAX_GAME_MODES); // Native: zp_get_gamemodes_count
public native_get_custom_special_count(zm) return zm ? (g_zm_specials_i - MAX_SPECIALS_ZOMBIES) : (g_hm_specials_i - MAX_SPECIALS_HUMANS); // Native: zp_get_custom_special_count
public native_is_escape_map() return g_escape_map; // Native: zp_is_escape_map
public native_get_custom_extra_start() return EXTRAS_CUSTOM_STARTID;

public native_do_random_spawn(id) { // Native: zp_do_random_spawn
	if(!is_user_valid_alive(id)) return 0
	if(get_pcvar_num(cvar_randspawn)) do_random_spawn(id) // random spawn (including CSDM)
	else do_random_spawn(id, 1) // regular spawn
	
	return 1
}
public native_reload_csdm_respawn() { // Native: zp_reload_csdm_respawn
	g_spawnCount = 0
	g_spawnCount2 = 0
	load_spawns()
	return 1
}
public native_set_lighting(const light[]) { // Native: zp_set_lighting
	param_convert(1)
	formatex(custom_lighting, charsmax(custom_lighting), light)
	g_custom_light = true
	lighting_effects()
	return 1
}
public native_reset_lighting() { // Native: zp_reset_lighting
	custom_lighting[0] = 0
	g_custom_light = false
	lighting_effects()
	return 1
}
public native_is_user_stuck(id) return is_player_stuck(id) // Native: zp_is_user_stuck
public native_register_weapon(const name[], secondary) { // Native: zp_register_weapon
	if(!g_pluginenabled) return -1; // ZP Special disabled
	if(!g_arrays_created) return -1; // Arrays not yet initialized

	// Small Bug Prevention
	if(secondary > 1) secondary = 1
	if(secondary < 0) secondary = 0

	param_convert(1); // Strings passed byref

	if(strlen(name) < 1) {
		log_error(AMX_ERR_NATIVE, "[ZP] Can't register weapon with an empty name")
		return -1;
	}

	static index, wpn_name[32]
	for(index = 0; index < g_weapon_i[secondary]; index++) {
		ArrayGetString(g_weapon_realname[secondary], index, wpn_name, charsmax(wpn_name))
		if(equali(name, wpn_name) && ArrayGetCell(g_weapon_is_custom[secondary], index))
		{
			log_error(AMX_ERR_NATIVE, "[ZP] Custom Weapon already registered (%s)", name)
			return -1;
		}
	}
	
	// Add the item
	ArrayPushString(g_weapon_name[secondary], name)
	ArrayPushString(g_weapon_realname[secondary], name)
	ArrayPushCell(g_weapon_is_custom[secondary], 1)

	ArrayPushCell(secondary ? g_weapon_ids[1] : g_weapon_ids[0], 0) // Small Bug Prevention
	
	static section[64], sz_custom_name[32]
	ArrayGetString(g_weapon_realname[secondary], g_weapon_i[secondary], section, charsmax(section))
	if(amx_load_setting_string(ZP_WEAPONS_FILE, section, "NAME", sz_custom_name, charsmax(sz_custom_name))) ArraySetString(g_weapon_name[secondary], g_weapon_i[secondary], sz_custom_name)
	
	g_weapon_i[secondary]++ // Increase registered items counter
	return (g_weapon_i[secondary]-1); // Return id under which we registered the item
}
public native_get_random_player(team) { // Native: zp_get_random_player(const team = 0)
	static iPlayersnum; iPlayersnum = fnGetAlive()
	if(team) return fnGetRandomAliveByTeam(team);
	return fnGetRandomAlive(random_num(1, iPlayersnum))
}
public native_set_fw_param_string(string[]) { // Native: zp_set_model_param(string[])
	param_convert(1)
	formatex(g_ForwardParameter, charsmax(g_ForwardParameter), string)
	return 1;
}
public native_is_special_class_enable(is_zm, classid) { // Native: zp_is_special_class_enable(is_zm, classid)
	if(classid <= 0) return 0

	if(is_zm) {
		if(classid < MAX_SPECIALS_ZOMBIES) return zm_special_enable[classid];
		if((classid-MAX_SPECIALS_ZOMBIES) >= ArraySize(g_zm_special_enable)) return 0;
		if(ArrayGetCell(g_zm_special_enable, (classid - MAX_SPECIALS_ZOMBIES)) == 0) return 0;	
	}
	else {
		if(classid < MAX_SPECIALS_HUMANS) return hm_special_enable[classid];
		if((classid-MAX_SPECIALS_HUMANS) >= ArraySize(g_hm_special_enable)) return 0;
		if(ArrayGetCell(g_hm_special_enable, (classid - MAX_SPECIALS_HUMANS)) == 0) return 0;	
	}
	return 1;
}
public native_is_gamemode_enable(modeid) return is_gamemode_enable(modeid) // Native: zp_is_gamemode_enable(modeid)

/*================================================================================
 [Custom Messages]
=================================================================================*/
public set_user_nvision(taskid) { // Custom Night Vision
	if(!is_user_valid_connected(ID_NVISION)) {
		remove_task(taskid)
		return;
	}

	static origin[3]; get_user_origin(ID_NVISION, origin) // Get player's origin
	
	// Nightvision message
	message_begin(MSG_ONE_UNRELIABLE, SVC_TEMPENTITY, _, ID_NVISION)
	write_byte(TE_DLIGHT) // TE id
	write_coord(origin[0]) // x
	write_coord(origin[1]) // y
	write_coord(origin[2]) // z
	write_byte(get_pcvar_num(cvar_nvgsize)) // radius
	
	// Special Class / Madness / Spectator in a special round
	if(g_zm_special[ID_NVISION] >= MAX_SPECIALS_ZOMBIES) {
		write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // r
		write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // g
		write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[ID_NVISION]-MAX_SPECIALS_ZOMBIES)) // b
	}
	else if(g_zm_special[ID_NVISION] > 0 && g_zm_special[ID_NVISION] < MAX_SPECIALS_ZOMBIES) {
		write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[ID_NVISION]])) // r
		write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[ID_NVISION]])) // g
		write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[ID_NVISION]])) // b
	}

	// Human / Spectator in normal round
	else if(!g_zombie[ID_NVISION] || !g_isalive[ID_NVISION]) {
		if(g_hm_special[ID_NVISION] >= MAX_SPECIALS_HUMANS) {
			write_byte(ArrayGetCell(g_hm_special_r, g_hm_special[ID_NVISION]-MAX_SPECIALS_HUMANS)) // r
			write_byte(ArrayGetCell(g_hm_special_g, g_hm_special[ID_NVISION]-MAX_SPECIALS_HUMANS)) // g
			write_byte(ArrayGetCell(g_hm_special_b, g_hm_special[ID_NVISION]-MAX_SPECIALS_HUMANS)) // b
		}
		else if(g_hm_special[ID_NVISION] > 0 && g_hm_special[ID_NVISION] < MAX_SPECIALS_HUMANS) {
			write_byte(get_pcvar_num(cvar_hm_red[g_hm_special[ID_NVISION]])) // r
			write_byte(get_pcvar_num(cvar_hm_green[g_hm_special[ID_NVISION]])) // g
			write_byte(get_pcvar_num(cvar_hm_blue[g_hm_special[ID_NVISION]])) // b
		}
		else {		
			switch(g_nv_color[0][ID_NVISION]) {
				case 1: g_nvrgb = { 255, 255, 255 }
				case 2: g_nvrgb = { 255, 0, 0 }
				case 3: g_nvrgb = { 0, 255, 0 }
				case 4: g_nvrgb = { 0, 0, 255 }
				case 5: g_nvrgb = { 0, 255, 255 }
				case 6: g_nvrgb = { 255, 0, 255 }
				case 7: g_nvrgb = { 255, 255, 0 }
				default: {
					g_nvrgb[0] = get_pcvar_num(cvar_hm_red[0])
					g_nvrgb[1] = get_pcvar_num(cvar_hm_green[0])
					g_nvrgb[2] = get_pcvar_num(cvar_hm_blue[0])
				}
			}
			write_byte(g_nvrgb[0]) // r
			write_byte(g_nvrgb[1]) // g
			write_byte(g_nvrgb[2]) // b
		}
	}

	// Zombie
	else {
		switch(g_nv_color[1][ID_NVISION]) {
			case 1: g_nvrgb = { 255, 255, 255 }
			case 2: g_nvrgb = { 255, 0, 0 }
			case 3: g_nvrgb = { 0, 255, 0 }
			case 4: g_nvrgb = { 0, 0, 255 }
			case 5: g_nvrgb = { 0, 255, 255 }
			case 6: g_nvrgb = { 255, 0, 255 }
			case 7: g_nvrgb = { 255, 255, 0 }
			default: {
				g_nvrgb[0] = get_pcvar_num(cvar_zombie_nvsion_rgb[0])
				g_nvrgb[1] = get_pcvar_num(cvar_zombie_nvsion_rgb[1])
				g_nvrgb[2] = get_pcvar_num(cvar_zombie_nvsion_rgb[2])
			}
		}
		write_byte(g_nvrgb[0]) // r
		write_byte(g_nvrgb[1]) // g
		write_byte(g_nvrgb[2]) // b	
	}
	write_byte(2) // life
	write_byte(0) // decay rate
	message_end()
}
set_user_gnvision(id, toggle) { // Game Nightvision
	// Toggle NVG message
	message_begin(MSG_ONE, g_msgNVGToggle, _, id)
	write_byte(toggle) // toggle
	message_end()
}
public set_user_flashlight(taskid) { // Custom Flashlight
	// Get player and aiming origins
	static Float:originF[3], Float:destoriginF[3]
	pev(ID_FLASH, pev_origin, originF)
	fm_get_aim_origin(ID_FLASH, destoriginF)

	if(get_distance_f(originF, destoriginF) > get_pcvar_float(cvar_flashdist)) return; // Max distance check
	
	// Send to all players?
	if(get_pcvar_num(cvar_flashshowall)) engfunc(EngFunc_MessageBegin, MSG_PVS, SVC_TEMPENTITY, destoriginF, 0)
	else message_begin(MSG_ONE_UNRELIABLE, SVC_TEMPENTITY, _, ID_FLASH)
	
	// Flashlight
	write_byte(TE_DLIGHT) // TE id
	engfunc(EngFunc_WriteCoord, destoriginF[0]) // x
	engfunc(EngFunc_WriteCoord, destoriginF[1]) // y
	engfunc(EngFunc_WriteCoord, destoriginF[2]) // z
	
	switch(g_flashlight_color[ID_FLASH]) {
		case 0: {
			if(g_currentmode == MODE_ASSASSIN) {
				g_flashlight_rgb[0] = get_pcvar_num(cvar_flashcolor2[0])
				g_flashlight_rgb[1] = get_pcvar_num(cvar_flashcolor2[1])
				g_flashlight_rgb[2] = get_pcvar_num(cvar_flashcolor2[2])
			}
			else {
				g_flashlight_rgb[0] = get_pcvar_num(cvar_flashcolor[0])
				g_flashlight_rgb[1] = get_pcvar_num(cvar_flashcolor[1])
				g_flashlight_rgb[2] = get_pcvar_num(cvar_flashcolor[2])
			}
		}
		case 1: g_flashlight_rgb = { 255, 255, 255 }
		case 2: g_flashlight_rgb = { 255, 0, 0 }
		case 3: g_flashlight_rgb = { 0, 255, 0 }
		case 4: g_flashlight_rgb = { 0, 0, 255 }
		case 5: g_flashlight_rgb = { 0, 255, 255 }
		case 6: g_flashlight_rgb = { 255, 0, 255 }
		case 7: g_flashlight_rgb = { 255, 255, 0 }
	}
	
	// Different flashlight in assassin round ?
	write_byte(get_pcvar_num(cvar_flashsize[g_currentmode == MODE_ASSASSIN ? 1 : 0])) // radius
	write_byte(g_flashlight_rgb[0]) // r
	write_byte(g_flashlight_rgb[1]) // g
	write_byte(g_flashlight_rgb[2]) // b
	write_byte(3) // life
	write_byte(0) // decay rate
	message_end()
}
infection_effects(id) { // Infection special effects
	if(!g_frozen[id] && get_pcvar_num(cvar_infectionscreenfade)) { // Screen fade? (unless frozen)
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
		write_short(UNIT_SECOND) // duration
		write_short(0) // hold time
		write_short(FFADE_IN) // fade type
		
		if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // r
			write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // g
			write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // b
		}
		else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
			write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[id]])) // r
			write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[id]])) // g
			write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[id]])) // b
		}
		else {
			switch(g_nv_color[1][id]) {
				case 1: g_nvrgb = { 255, 255, 255 }
				case 2: g_nvrgb = { 255, 0, 0 }
				case 3: g_nvrgb = { 0, 255, 0 }
				case 4: g_nvrgb = { 0, 0, 255 }
				case 5: g_nvrgb = { 0, 255, 255 }
				case 6: g_nvrgb = { 255, 0, 255 }
				case 7: g_nvrgb = { 255, 255, 0 }
				default: {
					g_nvrgb[0] = get_pcvar_num(cvar_zombie_nvsion_rgb[0])
					g_nvrgb[1] = get_pcvar_num(cvar_zombie_nvsion_rgb[1])
					g_nvrgb[2] = get_pcvar_num(cvar_zombie_nvsion_rgb[2])
				}
			}
			write_byte(g_nvrgb[0]) // r
			write_byte(g_nvrgb[1]) // g
			write_byte(g_nvrgb[2]) // b
		}
		write_byte (255) // alpha
		message_end()
	}
	if(get_pcvar_num(cvar_infectionscreenshake)) { // Screen shake?
		message_begin(MSG_ONE_UNRELIABLE, g_msgScreenShake, _, id)
		write_short(UNIT_SECOND*75) // amplitude
		write_short(UNIT_SECOND*5) // duration
		write_short(UNIT_SECOND*75) // frequency
		message_end()
	}
	if(get_pcvar_num(cvar_hudicons)) { // Infection icon?
		message_begin(MSG_ONE_UNRELIABLE, g_msgDamage, _, id)
		write_byte(0) // damage save
		write_byte(0) // damage take
		write_long(DMG_NERVEGAS) // damage type - DMG_RADIATION
		write_coord(0) // x
		write_coord(0) // y
		write_coord(0) // z
		message_end()
	}
	static origin[3]; get_user_origin(id, origin) // Get player's origin
	if(get_pcvar_num(cvar_infectiontracers)) { // Tracers?
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
	if(get_pcvar_num(cvar_infectionparticles)) { // Particle burst?
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
	if(get_pcvar_num(cvar_infectionsparkle)) { // Light sparkle?
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
public zombie_aura(taskid) { // Special Zombie / Zombie madness aura task
	// Not nemesis, not in zombie madness
	if(g_zm_special[ID_AURA] <= 0 && !g_nodamage[ID_AURA] || g_zm_special[ID_AURA] >= MAX_SPECIALS_ZOMBIES && ArrayGetCell(g_zm_special_aurarad, g_zm_special[ID_AURA]-MAX_SPECIALS_ZOMBIES) <= 0) {
		remove_task(taskid); // Task not needed anymore
		return;
	}

	static origin[3]; get_user_origin(ID_AURA, origin) // Get player's origin
	
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
public human_aura(taskid) { // Special Human aura task
	// Not survivor or sniper
	if(g_hm_special[ID_AURA] <= 0 || g_hm_special[ID_AURA] >= MAX_SPECIALS_HUMANS && ArrayGetCell(g_hm_special_aurarad, g_hm_special[ID_AURA]-MAX_SPECIALS_HUMANS) <= 0) {
		remove_task(taskid); // Task not needed anymore
		return;
	}
	
	// Get player's origin
	static origin[3]; get_user_origin(ID_AURA, origin)
	
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
public make_blood(taskid) { // Make zombies leave footsteps and bloodstains on the floor
	if(!(pev(ID_BLOOD, pev_flags) & FL_ONGROUND) || fm_get_speed(ID_BLOOD) < 80) return; // Only bleed when moving on ground
	
	static Float:originF[3]; pev(ID_BLOOD, pev_origin, originF) // Get user origin
	
	// If ducking set a little lower
	if(pev(ID_BLOOD, pev_bInDuck)) originF[2] -= 18.0
	else originF[2] -= 36.0
	
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
flare_lighting(entity, duration) { // Flare Lighting Effects
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
public burning_flame(taskid) { // Burning Flames
	// Get player origin and flags
	static origin[3], flags
	get_user_origin(ID_BURN, origin)
	flags = pev(ID_BURN, pev_flags)

	if(!g_isalive[ID_BURN] || g_nodamage[ID_BURN] || (flags & FL_INWATER) || g_burning_dur[ID_BURN] < 1) { // Madness mode - in water - burning stopped
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
		
		remove_task(taskid); // Task not needed anymore
		return;
	}
	
	// Randomly play burning zombie scream sounds (not for nemesis or assassin)
	if(g_zombie[ID_BURN] && g_zm_special[ID_BURN] <= 0 && !random_num(0, 20)) {
		static sound[64]
		ArrayGetString(ar_sound[13], random_num(0, ArraySize(ar_sound[13]) - 1), sound, charsmax(sound))
		emit_sound(ID_BURN, CHAN_VOICE, sound, 1.0, ATTN_NORM, 0, PITCH_NORM)
	}
	
	// Fire slow down, unless nemesis
	if(g_zm_special[ID_BURN] <= 0 && (flags & FL_ONGROUND) && get_pcvar_float(cvar_fireslowdown) > 0.0) {
		static Float:velocity[3]
		pev(ID_BURN, pev_velocity, velocity)
		xs_vec_mul_scalar(velocity, get_pcvar_float(cvar_fireslowdown), velocity)
		set_pev(ID_BURN, pev_velocity, velocity)
	}
	
	// Get player's health
	static health
	health = pev(ID_BURN, pev_health)
	
	// Take damage from the fire
	if(health - floatround(get_pcvar_float(cvar_firedamage), floatround_ceil) > 0) fm_set_user_health(ID_BURN, health - floatround(get_pcvar_float(cvar_firedamage), floatround_ceil))

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

	g_burning_dur[ID_BURN]-- // Decrease burning duration counter
}
create_blast(const Float:originF[3], grenade_type) { // Grenade Blast
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
	write_short(g_RingSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(grenade_rgb[grenade_type][0]) // red
	write_byte(grenade_rgb[grenade_type][1]) // green
	write_byte(grenade_rgb[grenade_type][2]) // blue
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
	write_short(g_RingSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(grenade_rgb[grenade_type][0]) // red
	write_byte(grenade_rgb[grenade_type][1]) // green
	write_byte(grenade_rgb[grenade_type][2]) // blue
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
	write_short(g_RingSpr) // sprite
	write_byte(0) // startframe
	write_byte(0) // framerate
	write_byte(size) // life
	write_byte(60) // width
	write_byte(0) // noise
	write_byte(grenade_rgb[grenade_type][0]) // red
	write_byte(grenade_rgb[grenade_type][1]) // green
	write_byte(grenade_rgb[grenade_type][2]) // blue
	write_byte(200) // brightness
	write_byte(0) // speed
	message_end()

	if(enable_gib[grenade_type]) {
		// TE_SPRITETRAIL
		engfunc(EngFunc_MessageBegin, MSG_BROADCAST ,SVC_TEMPENTITY, originF, 0)
		write_byte(TE_SPRITETRAIL) // TE ID
		engfunc(EngFunc_WriteCoord, originF[0]) // x axis
		engfunc(EngFunc_WriteCoord, originF[1]) // y axis
		engfunc(EngFunc_WriteCoord, originF[2]+70) // z axis
		engfunc(EngFunc_WriteCoord, originF[0]) // x axis
		engfunc(EngFunc_WriteCoord, originF[1]) // y axis
		engfunc(EngFunc_WriteCoord, originF[2]) // z axis
		write_short(g_GibSpr[grenade_type]) // Sprite Index
		write_byte(80) // Count
		write_byte(20) // Life
		write_byte(2) // Scale
		write_byte(50) // Velocity Along Vector
		write_byte(10) // Rendomness of Velocity
		message_end();    
	}

	if(enable_explode[grenade_type]) {
		// TE_EXPLOSION  
		engfunc(EngFunc_MessageBegin, MSG_BROADCAST,SVC_TEMPENTITY, originF, 0)
		write_byte(TE_EXPLOSION)
		engfunc(EngFunc_WriteCoord, originF[0]) // x axis
		engfunc(EngFunc_WriteCoord, originF[1]) // y axis
		engfunc(EngFunc_WriteCoord, originF[2]+75) // z axis
		write_short(g_ExplodeSpr[grenade_type])
		write_byte(22)
		write_byte(35)
		write_byte(TE_EXPLFLAG_NOSOUND)
		message_end() 
	}
}
FixDeadAttrib(id) { // Fix Dead Attrib on scoreboard
	message_begin(MSG_BROADCAST, g_msgScoreAttrib)
	write_byte(id) // id
	write_byte(0) // attrib
	message_end()
}
SendDeathMsg(attacker, victim) { // Send Death Message for infections
	message_begin(MSG_BROADCAST, g_msgDeathMsg)
	write_byte(attacker) // killer
	write_byte(victim) // victim
	write_byte(1) // headshot flag
	write_string("infection") // killer's weapon
	message_end()
}
UpdateFrags(attacker, victim, frags, deaths, scoreboard) { // Update Player Frags and Deaths
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) + frags)) // Set attacker frags
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) + deaths) // Set victim deaths

	if(scoreboard) { // Update scoreboard with attacker and victim info
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
RemoveFrags(attacker, victim) { // Remove Player Frags (when Nemesis/Survivor/Sniper/Berserker ignore_frags cvar is enabled)
	set_pev(attacker, pev_frags, float(pev(attacker, pev_frags) - 1)) // Remove attacker frags
	fm_cs_set_user_deaths(victim, cs_get_user_deaths(victim) - 1) // Remove victim deaths
}
precache_ambience(sound[]) {
	static buffer[150]
	if(equal(sound[strlen(sound)-4], ".mp3")) {
		if(!equal(sound, "sound/", 6) && !file_exists(sound) && !equal(sound, "media/", 6)) format(buffer, charsmax(buffer), "sound/%s", sound)
		else format(buffer, charsmax(buffer), "%s", sound)

		engfunc(EngFunc_PrecacheGeneric, buffer)
	}
	else  {
		if(equal(sound, "sound/", 6)) format(buffer, charsmax(buffer), "%s", sound[6])
		else format(buffer, charsmax(buffer), "%s", sound)

		engfunc(EngFunc_PrecacheSound, buffer)
	}
}
stock PlaySound(const sound[]) { // Plays a sound on clients
	static buffer[150]
	if(equal(sound[strlen(sound)-4], ".mp3")) {
		if(!equal(sound, "sound/", 6) && !file_exists(sound) && !equal(sound, "media/", 6)) format(buffer, charsmax(buffer), "sound/%s", sound)
		else format(buffer, charsmax(buffer), "%s", sound)

		client_cmd(0, "mp3 play ^"%s^"", buffer)
	}
	else {
		if(equal(sound, "sound/", 6)) format(buffer, charsmax(buffer), "%s", sound[6])
		else format(buffer, charsmax(buffer), "%s", sound)

		client_cmd(0, "spk ^"%s^"", buffer)
	}
}
// Prints a colored message to target (use 0 for everyone)
#if AMXX_VERSION_NUM < 183
new g_msgSayText
stock zp_colored_print(target, with_tag, const message[], any:...) {
	if(!g_msgSayText) g_msgSayText = get_user_msgid("SayText")

	static buffer[512], i, argscount
	argscount = numargs()

	// Format message for player
	vformat(buffer, charsmax(buffer), message, 4)

	if(with_tag) 
		format(buffer, charsmax(buffer), "%L %s", target ? target : LANG_PLAYER, "ZP_CHAT_TAG", buffer)

	replace_all(buffer, charsmax(buffer), "!g","^4");    // green
	replace_all(buffer, charsmax(buffer), "!y","^1");    // normal
	replace_all(buffer, charsmax(buffer), "!t","^3");    // team

	if(!target) { // Send to everyone
		static player
		for(player = 1; player <= g_maxplayers; player++) {
			if(!g_isconnected[player]) continue; // Not connected
			
			// Remember changed arguments
			static changed[5], changedcount // [5] = max LANG_PLAYER occurencies
			changedcount = 0
			
			for(i = 2; i < argscount; i++) { // Replace LANG_PLAYER with player id
				if(getarg(i) == LANG_PLAYER) {
					setarg(i, 0, player)
					changed[changedcount] = i
					changedcount++
				}
			}			
			// Send it
			message_begin(MSG_ONE_UNRELIABLE, g_msgSayText, _, player)
			write_byte(player)
			write_string(buffer)
			message_end()
			
			// Replace back player id's with LANG_PLAYER
			for(i = 0; i < changedcount; i++) setarg(changed[i], 0, LANG_PLAYER)
		}
	}
	else { // Send to specific target		
		// Send it
		message_begin(MSG_ONE, g_msgSayText, _, target)
		write_byte(target)
		write_string(buffer)
		message_end()
	}
}
#else
stock zp_colored_print(target, with_tag, const message[], any:...) {
	static szMsg[512];
	vformat(szMsg, charsmax(szMsg), message, 4);
	
	if(with_tag) 
		format(szMsg, charsmax(szMsg), "%L %s", target ? target : LANG_PLAYER, "ZP_CHAT_TAG", szMsg);

	replace_string(szMsg, charsmax(szMsg), "!g", "^4");    // green
	replace_string(szMsg, charsmax(szMsg), "!y", "^1");    // normal
	replace_string(szMsg, charsmax(szMsg), "!t", "^3");    // team
	client_print_color(target, print_team_default, "%s", szMsg)
}
#endif
/*================================================================================
 [Stocks]
=================================================================================*/
// Set an entity's key value (from fakemeta_util)
stock fm_set_kvd(entity, const key[], const value[], const classname[]) {
	set_kvd(0, KV_ClassName, classname)
	set_kvd(0, KV_KeyName, key)
	set_kvd(0, KV_Value, value)
	set_kvd(0, KV_fHandled, 0)

	dllfunc(DLLFunc_KeyValue, entity, 0)
}
// Set entity's rendering type (from fakemeta_util)
stock fm_set_rendering(entity, fx = kRenderFxNone, r = 255, g = 255, b = 255, render = kRenderNormal, amount = 16) {
	static Float:color[3]
	color[0] = float(r)
	color[1] = float(g)
	color[2] = float(b)
	
	set_pev(entity, pev_renderfx, fx)
	set_pev(entity, pev_rendercolor, color)
	set_pev(entity, pev_rendermode, render)
	set_pev(entity, pev_renderamt, float(amount))
}
stock fm_get_speed(entity) { // Get entity's speed (from fakemeta_util)
	static Float:velocity[3]
	pev(entity, pev_velocity, velocity)
	
	return floatround(vector_length(velocity));
}
stock fm_get_aim_origin(id, Float:origin[3]) { // Get entity's aim origins (from fakemeta_util)
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
stock fm_find_ent_by_owner(entity, const classname[], owner) { // Find entity by its owner (from fakemeta_util)
	while((entity = engfunc(EngFunc_FindEntityByString, entity, "classname", classname)) && pev(entity, pev_owner) != owner) { /* keep looping */ }
	return entity;
}
// Set player's health (from fakemeta_util)
stock fm_set_user_health(id, health) (health > 0) ? set_pev(id, pev_health, float(health)) : dllfunc(DLLFunc_ClientKill, id);

stock fm_give_item(id, const item[]) { // Give an item to a player (from fakemeta_util)
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, item))
	if(!pev_valid(ent)) return;
	
	static Float:originF[3]; pev(id, pev_origin, originF)
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
stock fm_strip_user_weapons(id) { // Strip user weapons (from fakemeta_util)
	static ent
	ent = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "player_weaponstrip"))
	if(!pev_valid(ent)) return;
	
	dllfunc(DLLFunc_Spawn, ent)
	dllfunc(DLLFunc_Use, ent, id)
	engfunc(EngFunc_RemoveEntity, ent)
}
stock load_spawns() { // Collect random spawn points
	// Check for CSDM spawns of the current map
	new cfgdir[32], mapname[32], filepath[100], linedata[64]
	get_configsdir(cfgdir, charsmax(cfgdir))
	get_mapname(mapname, charsmax(mapname))
	formatex(filepath, charsmax(filepath), "%s/csdm/%s.spawns.cfg", cfgdir, mapname)
	if(file_exists(filepath)) { // Load CSDM spawns if present
		new csdmdata[10][6], file = fopen(filepath,"rt")
		
		while(file && !feof(file)) {
			fgets(file, linedata, charsmax(linedata))
			
			if(!linedata[0] || str_count(linedata,' ') < 2) continue; // invalid spawn

			// get spawn point data
			parse(linedata,csdmdata[0],5,csdmdata[1],5,csdmdata[2],5,csdmdata[3],5,csdmdata[4],5,csdmdata[5],5,csdmdata[6],5,csdmdata[7],5,csdmdata[8],5,csdmdata[9],5)

			// origin
			g_spawns[g_spawnCount][0] = floatstr(csdmdata[0])
			g_spawns[g_spawnCount][1] = floatstr(csdmdata[1])
			g_spawns[g_spawnCount][2] = floatstr(csdmdata[2])

			g_spawnCount++ // increase spawn count
			if(g_spawnCount >= sizeof g_spawns) break;
		}
		if(file) fclose(file)
	}
	else { // Collect regular spawns
		collect_spawns_ent("info_player_start")
		collect_spawns_ent("info_player_deathmatch")
	}
	
	// Collect regular spawns for non-random spawning unstuck
	collect_spawns_ent2("info_player_start")
	collect_spawns_ent2("info_player_deathmatch")
}
stock collect_spawns_ent(const classname[]) { // Collect spawn points from entity origins
	new ent = -1
	while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0) {
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
stock collect_spawns_ent2(const classname[]) { // Collect spawn points from entity origins
	new ent = -1
	while((ent = engfunc(EngFunc_FindEntityByString, ent, "classname", classname)) != 0) {
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
stock drop_weapons(id, dropwhat) { // Drop primary/secondary weapons
	// Get user weapons
	static weapons[32], num, i, weaponid
	num = 0 // reset passed weapons count (bugfix)
	get_user_weapons(id, weapons, num)

	for(i = 0; i < num; i++) { // Loop through them and drop primaries or secondaries
		weaponid = weapons[i] // Prevent re-indexing the array
		if((dropwhat == 1 && ((1<<weaponid) & PRIMARY_WEAPONS_BIT_SUM)) || (dropwhat == 2 && ((1<<weaponid) & SECONDARY_WEAPONS_BIT_SUM))) {
			// Get weapon entity
			static wname[32], weapon_ent
			get_weaponname(weaponid, wname, charsmax(wname))
			weapon_ent = fm_find_ent_by_owner(-1, wname, id)

			set_pev(weapon_ent, PEV_ADDITIONAL_AMMO, cs_get_user_bpammo(id, weaponid)) // Hack: store weapon bpammo on PEV_ADDITIONAL_AMMO
			
			// Player drops the weapon and looses his bpammo
			engclient_cmd(id, "drop", wname)
			cs_set_user_bpammo(id, weaponid, 0)
		}
	}
}
stock str_count(const str[], searchchar) { // Stock by (probably) Twilight Suzuka -counts number of chars in a string
	new count, i, len = strlen(str)
	for(i = 0; i <= len; i++) {
		if(str[i] == searchchar)
			count++
	}	
	return count;
}
stock is_hull_vacant(Float:origin[3], hull) { // Checks if a space is vacant (credits to VEN)
	engfunc(EngFunc_TraceHull, origin, origin, 0, hull, 0, 0)
	if(!get_tr2(0, TR_StartSolid) && !get_tr2(0, TR_AllSolid) && get_tr2(0, TR_InOpen))
		return true;
	
	return false;
}
stock is_player_stuck(id) { // Check if a player is stuck (credits to VEN)
	if(!is_user_alive(id)) return false;

	static Float:originF[3]; pev(id, pev_origin, originF)
	engfunc(EngFunc_TraceHull, originF, originF, 0, (pev(id, pev_flags) & FL_DUCKING) ? HULL_HEAD : HULL_HUMAN, id, 0)
	if(get_tr2(0, TR_StartSolid) || get_tr2(0, TR_AllSolid) || !get_tr2(0, TR_InOpen)) return true;
	
	return false;
}
stock cs_weapon_name_to_id(const weapon[]) { // Simplified get_weaponid (CS only)
	static i
	for(i = 0; i < sizeof WEAPONENTNAMES; i++) if(equal(weapon, WEAPONENTNAMES[i])) return i;

	return 0;
}
stock fm_cs_get_current_weapon_ent(id) { // Get User Current Weapon Entity
	if(pev_valid(id) != PDATA_SAFE) return -1; // Prevent server crash if entity's private data not initalized

	return get_pdata_cbase(id, OFFSET_ACTIVE_ITEM, OFFSET_LINUX);
}
stock fm_cs_get_weapon_ent_owner(ent) { // Get Weapon Entity's Owner
	if(pev_valid(ent) != PDATA_SAFE) return -1; // Prevent server crash if entity's private data not initalized

	return get_pdata_cbase(ent, OFFSET_WEAPONOWNER, OFFSET_LINUX_WEAPONS);
}
stock fm_cs_set_user_deaths(id, value) { // Set User Deaths
	if(pev_valid(id) != PDATA_SAFE) return; // Prevent server crash if entity's private data not initalized

	set_pdata_int(id, OFFSET_CSDEATHS, value, OFFSET_LINUX)
}
stock fm_cs_get_user_team(id) { // Get User Team
	if(pev_valid(id) != PDATA_SAFE) return FM_CS_TEAM_UNASSIGNED; // Prevent server crash if entity's private data not initalized

	return get_pdata_int(id, OFFSET_CSTEAMS, OFFSET_LINUX);
}
stock fm_cs_set_user_team(id, team) { // Set a Player's Team
	if(pev_valid(id) != PDATA_SAFE) return; // Prevent server crash if entity's private data not initalized

	set_pdata_int(id, OFFSET_CSTEAMS, team, OFFSET_LINUX)
}
stock fm_cs_set_user_money(id, value) { // Set User Money
	if(pev_valid(id) != PDATA_SAFE) return; // Prevent server crash if entity's private data not initalized
		
	set_pdata_int(id, OFFSET_CSMONEY, value, OFFSET_LINUX)
}
stock fm_cs_set_user_batteries(id, value) { // Set User Flashlight Batteries
	if(pev_valid(id) != PDATA_SAFE) return; // Prevent server crash if entity's private data not initalized
	
	set_pdata_int(id, OFFSET_FLASHLIGHT_BATTERY, value, OFFSET_LINUX)
}
stock fm_user_team_update(id) { // Update Player's Team on all clients (adding needed delays)
	static Float:current_time
	current_time = get_gametime()
	
	if(current_time - g_teams_targettime >= 0.1) {
		set_task(0.1, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = current_time + 0.1
	}
	else {
		set_task((g_teams_targettime + 0.1) - current_time, "fm_cs_set_user_team_msg", id+TASK_TEAM)
		g_teams_targettime = g_teams_targettime + 0.1
	}
}
public fm_cs_set_user_team_msg(taskid) { // Send User Team Message
	// Note to self: this next message can now be received by other plugins
	g_switchingteam = true // Set the switching team flag
	
	// Tell everyone my new team
	emessage_begin(MSG_ALL, g_msgTeamInfo)
	ewrite_byte(ID_TEAM) // player
	ewrite_string(CS_TEAM_NAMES[fm_cs_get_user_team(ID_TEAM)]) // team
	emessage_end()

	g_switchingteam = false // Done switching team
}
stock fm_cs_set_user_model_index(id, value) { // Set the precached model index (updates hitboxes server side)
	if(pev_valid(id) != PDATA_SAFE) return; // Prevent server crash if entity's private data not initalized

	set_pdata_int(id, OFFSET_MODELINDEX, value, OFFSET_LINUX)
}
stock fm_set_playermodel_ent(id) { // Set Player Model on Entity
	// Make original player entity invisible without hiding shadows or firing effects
	fm_set_rendering(id, kRenderFxNone, 255, 255, 255, kRenderTransTexture, 1)
	
	static model[100] // Format model string
	formatex(model, charsmax(model), "models/player/%s/%s.mdl", g_playermodel[id], g_playermodel[id])

	if(!pev_valid(g_ent_playermodel[id])) { // Set model on entity or make a new one if unexistant
		g_ent_playermodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if(!pev_valid(g_ent_playermodel[id])) return;
		
		set_pev(g_ent_playermodel[id], pev_classname, MODEL_ENT_CLASSNAME)
		set_pev(g_ent_playermodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_playermodel[id], pev_aiment, id)
		set_pev(g_ent_playermodel[id], pev_owner, id)
	}
	engfunc(EngFunc_SetModel, g_ent_playermodel[id], model)
}
stock fm_set_weaponmodel_ent(id) { // Set Weapon Model on Entity
	static model[100] // Get player's p_ weapon model
	pev(id, pev_weaponmodel2, model, charsmax(model))

	if(!pev_valid(g_ent_weaponmodel[id])) { // Set model on entity or make a new one if unexistant
		g_ent_weaponmodel[id] = engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, "info_target"))
		if(!pev_valid(g_ent_weaponmodel[id])) return;

		set_pev(g_ent_weaponmodel[id], pev_classname, WEAPON_ENT_CLASSNAME)
		set_pev(g_ent_weaponmodel[id], pev_movetype, MOVETYPE_FOLLOW)
		set_pev(g_ent_weaponmodel[id], pev_aiment, id)
		set_pev(g_ent_weaponmodel[id], pev_owner, id)
	}
	engfunc(EngFunc_SetModel, g_ent_weaponmodel[id], model)
}


stock fm_remove_model_ents(id) { // Remove Custom Model Entities
	if(pev_valid(g_ent_playermodel[id])) { // Remove "playermodel" ent if present
		engfunc(EngFunc_RemoveEntity, g_ent_playermodel[id])
		g_ent_playermodel[id] = 0
	}
	if(pev_valid(g_ent_weaponmodel[id])) { // Remove "weaponmodel" ent if present
		engfunc(EngFunc_RemoveEntity, g_ent_weaponmodel[id])
		g_ent_weaponmodel[id] = 0
	}
}
public fm_cs_set_user_model(taskid) set_user_info(ID_MODEL, "model", g_playermodel[ID_MODEL]) // Set User Model
stock fm_cs_get_user_model(player, model[], len) get_user_info(player, "model", model, len) // Get User Model -model passed byref-

public fm_user_model_update(taskid) { // Update Player's Model on all clients (adding needed delays)
	static Float:current_time; current_time = get_gametime()
	if(current_time - g_models_targettime >= g_modelchange_delay) {
		fm_cs_set_user_model(taskid)
		g_models_targettime = current_time
	}
	else {
		set_task((g_models_targettime + g_modelchange_delay) - current_time, "fm_cs_set_user_model", taskid)
		g_models_targettime = g_models_targettime + g_modelchange_delay
	}
}

public turn_invisible(id) { // Predator/Spy Invisible Powers
	if(g_zm_special[id] == PREDATOR) {
		if(get_pcvar_num(cvar_zm_glow[PREDATOR])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, get_pcvar_num(cvar_zm_red[PREDATOR]), get_pcvar_num(cvar_zm_green[PREDATOR]), get_pcvar_num(cvar_zm_blue[PREDATOR]), kRenderTransAdd, 5)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAdd, 5)
	}
	
	if(g_hm_special[id] == SPY) {
		if(get_pcvar_num(cvar_hm_glow[SPY])) fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[SPY]), get_pcvar_num(cvar_hm_green[SPY]), get_pcvar_num(cvar_hm_blue[SPY]), kRenderTransAdd, 5)
		else fm_set_rendering(g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id, kRenderFxGlowShell, 0, 0, 0, kRenderTransAdd, 5)
	}
}

new const personal_color_langs[][] = { "MENU_COLOR_DEFAULT", "MENU_PERSONAL_COLOR1", "MENU_PERSONAL_COLOR2", "MENU_PERSONAL_COLOR3", "MENU_PERSONAL_COLOR4", 
"MENU_PERSONAL_COLOR5", "MENU_PERSONAL_COLOR6", "MENU_PERSONAL_COLOR7" }
enum { HUD = 0, FLASHLIGHT, NIGHTVISION }
public show_menu_personal(id) {
	if(!is_user_valid_connected(id))
		return;

	static szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_TITLE")
	new menu = menu_create(szText, "show_menu_personal_handler")
	
	if(get_pcvar_num(cvar_huddisplay)) {
		formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM1")
		menu_additem(menu, szText, "1", 0)
	}
	if(get_pcvar_num(cvar_customnvg) || get_pcvar_num(cvar_nvision_menu[0]) || get_pcvar_num(cvar_nvision_menu[1])) {
		formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM2")
		menu_additem(menu, szText, "2", 0)
	}
	
	if(get_pcvar_num(cvar_flashlight_menu)) {
		formatex(szText, charsmax(szText), "%L", id, "MENU_PERSONAL_ITEM3")
		menu_additem(menu, szText, "3", 0)
	}
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)

	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menu, 0)
}
public show_menu_personal_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		return PLUGIN_HANDLED
	}
	
	static data[6], iName[64], access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	new key = str_to_num(data)
	
	switch(key) {
		case 1: menu_hud_config(id)
		case 2: menu_nightvision(id)
		case 3: menu_color(id, 0, FLASHLIGHT)
	}
	
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public menu_hud_config(id) {
	if(!get_pcvar_num(cvar_huddisplay))
		return

	if(!is_user_valid_connected(id))
		return;
	
	new szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TITLE")
	new menu = menu_create(szText, "menu_hud_config_handler")
	
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM1"); menu_additem(menu, szText, "1", 0);
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM2"); menu_additem(menu, szText, "2", 0);
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_ITEM3"); menu_additem(menu, szText, "3", 0);
	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)
	
	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menu, 0)
}
public menu_hud_config_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}

	static data[6], iName[64], access, callback, key
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	
	key = str_to_num(data)
	
	switch(key) {
		case 1: menu_hud_config_type(id);
		case 2: menu_color(id, 0, HUD)
		case 3: menu_color(id, 1, HUD)
	}
	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public menu_color(id, zm, type) {
	if(!is_user_valid_connected(id))
		return;

	static szText[555], szItem[32], szItem2[32]

	switch(type) {
		case HUD: {
			if(!get_pcvar_num(cvar_huddisplay)) return
			formatex(szText, charsmax(szText), "%L", id, zm ? "MENU_CHOOSE_HUD_COLOR_TITLE1" : "MENU_CHOOSE_HUD_COLOR_TITLE2")
			formatex(szItem, charsmax(szItem), "%s", zm ? "HZ:" : "HH:")
		}
		case FLASHLIGHT: {
			if(!get_pcvar_num(cvar_flashlight_menu)) return
			formatex(szText, charsmax(szText), "%L", id, "MENU_CHOOSE_FLASH_COLOR_TITLE")
			formatex(szItem, charsmax(szItem), "Fl:")
		}
		case NIGHTVISION: {
			if(!get_pcvar_num(cvar_customnvg) || !get_pcvar_num(cvar_nvision_menu[zm ? 1 : 0])) return
			formatex(szText, charsmax(szText), "%L", id, zm ? "MENU_NVISION_COLOR_TITLE2" : "MENU_NVISION_COLOR_TITLE1")
			formatex(szItem, charsmax(szItem), "%s", zm ? "NZ:" : "NH:")
		}
	}

	new menu = menu_create(szText, "menu_color_handler")

	for(new i = 0; i < 8; i++) {
		if(i == 0 && type == HUD) continue; 

		formatex(szText, charsmax(szText), "%L", id, personal_color_langs[i])
		formatex(szItem2, charsmax(szItem2), "%s%d", szItem, i)
		menu_additem(menu, szText, szItem2, 0)
	}
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)

	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus
	
	menu_display(id, menu, 0)
}
public menu_color_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}

	static data[32], iName[64], access, callback
	menu_item_getinfo(menu, item, access, data, charsmax(data), iName, 63, callback);

	if(equal(data, "HH:", 3)) g_hud_color[0][id] = str_to_num(data[3])-1, menu_hud_config(id)
	else if(equal(data, "HZ:", 3)) g_hud_color[1][id] = str_to_num(data[3])-1, menu_hud_config(id)
	else if(equal(data, "Fl:", 3)) g_flashlight_color[id] = str_to_num(data[3]), show_menu_personal(id)
	else if(equal(data, "NH:", 3)) {
		g_nv_color[0][id] = str_to_num(data[3])
		menu_nightvision(id)

		if(g_nvisionenabled[id] && get_pcvar_num(cvar_customnvg) >= 2) 
			set_fade_nvg(id)
	}
	else if(equal(data, "NZ:", 3)) {	
		g_nv_color[1][id] = str_to_num(data[3])
		menu_nightvision(id)
		if(g_nvisionenabled[id] && get_pcvar_num(cvar_customnvg) >= 2) 
			set_fade_nvg(id)
	}

	menu_destroy(menu)
	return PLUGIN_HANDLED
}

new const hud_langs[][] = { "MENU_HUD_TYPE_ITEM1", "MENU_HUD_TYPE_ITEM2", "MENU_HUD_TYPE_ITEM3", "MENU_HUD_TYPE_ITEM4", "MENU_HUD_TYPE_ITEM5", "MENU_HUD_TYPE_ITEM6" }
public menu_hud_config_type(id) {
	if(!get_pcvar_num(cvar_huddisplay)) return

	if(!is_user_valid_connected(id))
		return;
	
	static szText[555], szKey[10]
	formatex(szText, charsmax(szText), "%L", id, "MENU_HUD_TYPE_TITLE")
	new menu = menu_create(szText, "menu_hud_config_type_handler")
	
	for(new i = 0; i < 6; i++) {	
		if(g_hud_type[id] == i) formatex(szText, charsmax(szText), "\d%L [\rX\d]", id, hud_langs[i] )
		else formatex(szText, charsmax(szText), "\w%L \d[]", id, hud_langs[i])

		num_to_str(i, szKey, 9)
		menu_additem(menu, szText, szKey, 0)
	}	
	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)

	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menu, 0)
}
public menu_hud_config_type_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		menu_hud_config(id)
		return PLUGIN_HANDLED
	}
	
	static data[6], iName[64], access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback); 
	g_hud_type[id] = str_to_num(data)

	menu_destroy(menu)
	menu_hud_config(id)
	return PLUGIN_HANDLED
	
}
public menu_nightvision(id) {
	if(!get_pcvar_num(cvar_customnvg) || !get_pcvar_num(cvar_nvision_menu[0]) && !get_pcvar_num(cvar_nvision_menu[1])) return

	if(!is_user_valid_connected(id))
		return;

	static szText[555]
	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_CONFIG_TITLE")
	new menu = menu_create(szText, "menu_nightvision_handler")

	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_ITEM1")
	if(get_pcvar_num(cvar_nvision_menu[1])) menu_additem(menu, szText, "1", 0)

	formatex(szText, charsmax(szText), "%L", id, "MENU_NVISION_ITEM2")
	if(get_pcvar_num(cvar_nvision_menu[0])) menu_additem(menu, szText, "0", 0)

	menu_setprop(menu, MPROP_EXIT, MEXIT_ALL)

	if(pev_valid(id) == PDATA_SAFE) set_pdata_int(id, OFFSET_CSMENUCODE, 0, OFFSET_LINUX) // Fix for AMXX custom menus

	menu_display(id, menu, 0)
}
public menu_nightvision_handler(id, menu, item) {
	if(item == MENU_EXIT) {
		menu_destroy(menu)
		show_menu_personal(id)
		return PLUGIN_HANDLED
	}

	static data[6], iName[64], access, callback
	menu_item_getinfo(menu, item, access, data,5, iName, 63, callback);
	menu_color(id, str_to_num(data), NIGHTVISION)

	menu_destroy(menu)
	return PLUGIN_HANDLED
	
}
public give_hegrenade_bombardier(id) {
	id -= 1213131
	if(g_isalive[id] && g_zombie[id] && g_zm_special[id] == BOMBARDIER && !user_has_weapon(id, CSW_HEGRENADE)) fm_give_item(id, "weapon_hegrenade")
	else if(!g_zombie[id] || g_zm_special[id] != BOMBARDIER) remove_task(id+1213131)

	if(g_isbot[id] && user_has_weapon(id, CSW_HEGRENADE)) {
		engclient_cmd(id, "weapon_hegrenade");
		if(pev_valid(id) == PDATA_SAFE) ExecuteHam(Ham_Weapon_PrimaryAttack, get_pdata_cbase(id, 373, 5));
	}
}

public use_cmd(player) { // Dragon Habilities
	if(g_zm_special[player] != DRAGON || !g_isalive[player]) return PLUGIN_HANDLED;
	if(get_gametime() - gLastUseCmd[player] < get_pcvar_float(cvar_dragon_power_cooldown)) return PLUGIN_HANDLED;
	
	gLastUseCmd[player] = get_gametime()
	
	new target, body
	get_user_aiming(player, target, body, get_pcvar_num(cvar_dragon_power_distance))
	if(is_user_valid_alive(target) && !g_zombie[target]) {
		switch(random_num(0,1)) {
			case 0: native_set_user_frozen(target, 2), sprite_control(player, 0)
			case 1: native_set_user_burn(target, 2), sprite_control(player, 1)
		}
	}
	else sprite_control(player, random_num(0,1))

	return PLUGIN_HANDLED
}
public te_spray(args[]) {
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
public sprite_control(player, fire) {
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
public PreThinkDragon(id) {
	if(g_zm_special[id] != DRAGON || !g_isalive[id]) return PLUGIN_CONTINUE
	
	static Float:fAim[3] , Float:fVelocity[3];
	velocity_by_aim(id, get_pcvar_num(cvar_dragon_flyspped), fAim)

	if(pev(id, pev_button) & IN_JUMP) {
		fVelocity[0] = fAim[0]; fVelocity[1] = fAim[1]; fVelocity[2] = fAim[2];
		set_pev(id, pev_velocity, fVelocity);
	}
	return PLUGIN_CONTINUE;
}
public sqrt(num) {
	new div = num
	new result = 1
	while(div > result) {
		div = (div + result) / 2
		result = num / div
	}
	return div
}
public reset_user_rendering(id) {
	static ent_id
	ent_id = g_handle_models_on_separate_ent ? g_ent_playermodel[id] : id
	
	ExecuteForward(g_forwards[RESET_RENDERING_PRE], g_fwDummyResult, id)

	if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) return; // The game mode didnt accept some conditions

	if(g_frozen[id]) fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 100, 200, kRenderNormal, 25) // Light blue glow while frozen
	else if(g_zombie[id]) {
		if(g_zm_special[id] <= 0) fm_set_rendering(ent_id)
			
		else if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_glow, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0) fm_set_rendering(ent_id, kRenderFxGlowShell, ArrayGetCell(g_zm_special_r, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_g, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_b, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), kRenderNormal, 20)
			else fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0,  kRenderNormal, 20)
		}
		else if(g_zm_special[id] > 0) {
			if(get_pcvar_num(cvar_zm_glow[g_zm_special[id]])) fm_set_rendering(ent_id, kRenderFxGlowShell, get_pcvar_num(cvar_zm_red[g_zm_special[id]]), get_pcvar_num(cvar_zm_green[g_zm_special[id]]), get_pcvar_num(cvar_zm_blue[g_zm_special[id]]), g_zm_special[id] == PREDATOR ? kRenderTransAdd : kRenderNormal, g_zm_special[id] == PREDATOR ?  5 : 20)
			else fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0, g_zm_special[id] == PREDATOR ? kRenderTransAdd : kRenderNormal, g_zm_special[id] == PREDATOR ?  5 : 20)
		}
	}
	else {
		if(g_hm_special[id] <= 0) fm_set_rendering(ent_id)

		else if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_glow, g_hm_special[id]-MAX_SPECIALS_HUMANS) > 0) fm_set_rendering(ent_id, kRenderFxGlowShell, ArrayGetCell(g_hm_special_r, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_g, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_b, g_hm_special[id]-MAX_SPECIALS_HUMANS), kRenderNormal, 20)
			else fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0,  kRenderNormal, 20)
		}
		else if(g_hm_special[id] > 0) {
			if(get_pcvar_num(cvar_hm_glow[g_hm_special[id]])) fm_set_rendering(ent_id, kRenderFxGlowShell, get_pcvar_num(cvar_hm_red[g_hm_special[id]]), get_pcvar_num(cvar_hm_green[g_hm_special[id]]), get_pcvar_num(cvar_hm_blue[g_hm_special[id]]), g_hm_special[id] == SPY ? kRenderTransAdd : kRenderNormal, g_hm_special[id] == SPY ? 5 : 20)
			else fm_set_rendering(ent_id, kRenderFxGlowShell, 0, 0, 0, g_hm_special[id] == SPY ? kRenderTransAdd : kRenderNormal, g_hm_special[id] == SPY ? 5 : 20)
		}
	}
	ExecuteForward(g_forwards[RESET_RENDERING_POST], g_fwDummyResult, id)
}
public reset_player_models(id) {
	static currentmodel[32], newmodel[32], already_has_model, i, iRand, size, model_index
	already_has_model = false
	
	if(g_handle_models_on_separate_ent) {
		if(g_zombie[id]) {
			// Set the right model
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				iRand = random_num(ArrayGetCell(g_zm_special_modelstart, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_modelsend, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) - 1)
				ArrayGetString(g_zm_special_model, iRand, newmodel, charsmax(newmodel))
				if(g_set_modelindex_offset) model_index = ArrayGetCell(g_zm_special_modelindex, iRand)
			}
			else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(g_zm_special[id] > 0 && zm_special_enable[g_zm_special[id]]) {
					iRand = random_num(0, ArraySize(model_zm_special[g_zm_special[id]]) - 1)
					ArrayGetString(model_zm_special[g_zm_special[id]], iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_zm_sp[g_zm_special[id]], iRand)
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					iRand = random_num(0, ArraySize(model_admin_zombie) - 1)
					ArrayGetString(model_admin_zombie, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_admin_zombie, iRand)
				}
				else if(get_pcvar_num(cvar_vipmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					iRand = random_num(0, ArraySize(model_vip_zombie) - 1)
					ArrayGetString(model_vip_zombie, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_vip_zombie, iRand)
				}
				else {
					iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
					ArrayGetString(g_zclass_playermodel, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_zclass_modelindex, iRand)
				}
			}
		}
		else { // Set the right model
			if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
				iRand = random_num(ArrayGetCell(g_hm_special_modelstart, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_modelsend, g_hm_special[id]-MAX_SPECIALS_HUMANS) - 1)
				ArrayGetString(g_hm_special_model, iRand, newmodel, charsmax(newmodel))
				if(g_set_modelindex_offset) model_index = ArrayGetCell(g_hm_special_modelindex, iRand)
			}
			else if(g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS) {	
				if(g_hm_special[id] > 0 && hm_special_enable[g_hm_special[id]]) {
					iRand = random_num(0, ArraySize(model_human[g_hm_special[id]]) - 1)
					ArrayGetString(model_human[g_hm_special[id]], iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_human[g_hm_special[id]], iRand)
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					iRand = random_num(0, ArraySize(model_admin_human) - 1)
					ArrayGetString(model_admin_human, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_admin_human, iRand)
				}
				else if(get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					iRand = random_num(0, ArraySize(model_vip_human) - 1)
					ArrayGetString(model_vip_human, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_vip_human, iRand)
				}
				else {
					iRand = random_num(0, ArraySize(model_human[0]) - 1)
					ArrayGetString(model_human[0], iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_human[0], iRand)
				}
			}
		}
		if(!equal(g_playermodel[id], newmodel)) {
			g_ForwardParameter[0] = 0
			ExecuteForward(g_forwards[MODEL_CHANGE_PRE], g_fwDummyResult, id, newmodel)			
			if(g_fwDummyResult >= ZP_PLUGIN_HANDLED) return;

			if(g_ForwardParameter[0]) formatex(newmodel, charsmax(newmodel), g_ForwardParameter) // Check if forward not changed the param

			formatex(g_playermodel[id], charsmax(g_playermodel[]), newmodel) // Set model on player model entity

			if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, model_index)
			fm_set_playermodel_ent(id)
			ExecuteForward(g_forwards[MODEL_CHANGE_POST], g_fwDummyResult, id, newmodel)
		}
	}
	else {
		if(g_zombie[id]) {
			fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel)) // Get current model for comparing it with the current one
			if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
				for(i = ArrayGetCell(g_zm_special_modelstart, g_zm_special[id]-MAX_SPECIALS_ZOMBIES); i < ArrayGetCell(g_zm_special_modelsend, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) - 1; i++) {
					ArrayGetString(g_zm_special_model, i, newmodel, charsmax(newmodel))
					if(equal(currentmodel, newmodel)) already_has_model = true
				}
				if(!already_has_model) {
					iRand = random_num(ArrayGetCell(g_zm_special_modelstart, g_zm_special[id]-MAX_SPECIALS_ZOMBIES), ArrayGetCell(g_zm_special_modelsend, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) - 1)
					ArrayGetString(g_zm_special_model, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_zm_special_modelindex, iRand)
				}
			}
			else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
				if(g_zm_special[id] > 0 && zm_special_enable[g_zm_special[id]]) {
					size = ArraySize(model_zm_special[g_zm_special[id]]) // Set the right model, after checking that we don't already have it
					for(i = 0; i < size; i++) {
						ArrayGetString(model_zm_special[g_zm_special[id]], i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_zm_special[g_zm_special[id]], iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_zm_sp[g_zm_special[id]], iRand)
					}
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					size = ArraySize(model_admin_zombie)
					for(i = 0; i < size; i++) {
						ArrayGetString(model_admin_zombie, i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_admin_zombie, iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_admin_zombie, iRand)
					}
				}
				else if(get_pcvar_num(cvar_vipmodelszombie) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					size = ArraySize(model_vip_zombie)
					for(i = 0; i < size; i++) {
						ArrayGetString(model_vip_zombie, i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_vip_zombie, iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_vip_zombie, iRand)
					}
				} 
				else {
					for(i = ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]); i < ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]); i++) {
						ArrayGetString(g_zclass_playermodel, i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(ArrayGetCell(g_zclass_modelsstart, g_zombieclass[id]), ArrayGetCell(g_zclass_modelsend, g_zombieclass[id]) - 1)
						ArrayGetString(g_zclass_playermodel, iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_zclass_modelindex, iRand)
					}
				}
			}
		}
		else {
			fm_cs_get_user_model(id, currentmodel, charsmax(currentmodel)) // Get current model for comparing it with the current one
			if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) { // Set the right model, after checking that we don't already have it
				for(i = ArrayGetCell(g_hm_special_modelstart, g_hm_special[id]-MAX_SPECIALS_HUMANS); i < ArrayGetCell(g_hm_special_modelsend, g_hm_special[id]-MAX_SPECIALS_HUMANS) - 1; i++) {
					ArrayGetString(g_hm_special_model, i, newmodel, charsmax(newmodel))
					if(equal(currentmodel, newmodel)) already_has_model = true
				}
				if(!already_has_model) {
					iRand = random_num(ArrayGetCell(g_hm_special_modelstart, g_hm_special[id]-MAX_SPECIALS_HUMANS), ArrayGetCell(g_hm_special_modelsend, g_hm_special[id]-MAX_SPECIALS_HUMANS) - 1)
					ArrayGetString(g_hm_special_model, iRand, newmodel, charsmax(newmodel))
					if(g_set_modelindex_offset) model_index = ArrayGetCell(g_hm_special_modelindex, iRand)
				}
			}			
			else if(g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS) {
				if(g_hm_special[id] > 0 && hm_special_enable[g_hm_special[id]]) {
					size = ArraySize(model_human[g_hm_special[id]])
					for(i = 0; i < size; i++) {
						ArrayGetString(model_human[g_hm_special[id]], i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_human[g_hm_special[id]], iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_human[g_hm_special[id]], iRand)
					}
				}
			}
			else {
				if(get_pcvar_num(cvar_adminmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_ADMIN_MODELS])) {
					size = ArraySize(model_admin_human)
					for(i = 0; i < size; i++) {
						ArrayGetString(model_admin_human, i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_admin_human, iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_admin_human, iRand)
					}
				}
				else if(get_pcvar_num(cvar_vipmodelshuman) && (get_user_flags(id) & g_access_flag[ACCESS_VIP_MODELS])) {
					size = ArraySize(model_vip_human)
					for(i = 0; i < size; i++) {
						ArrayGetString(model_vip_human, i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_vip_human, iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_vip_human, iRand)
					}
				}
				else {
					size = ArraySize(model_human[0])
					for(i = 0; i < size; i++) {
						ArrayGetString(model_human[0], i, newmodel, charsmax(newmodel))
						if(equal(currentmodel, newmodel)) already_has_model = true
					}
					if(!already_has_model) {
						iRand = random_num(0, size - 1)
						ArrayGetString(model_human[0], iRand, newmodel, charsmax(newmodel))
						if(g_set_modelindex_offset) model_index = ArrayGetCell(g_modelindex_human[0], iRand)
					}
				}
			}
		}
		if(!already_has_model) { // Need to change the model?
			g_ForwardParameter[0] = 0
			ExecuteForward(g_forwards[MODEL_CHANGE_PRE], g_fwDummyResult, id, newmodel)

			if(g_fwDummyResult >= ZP_PLUGIN_SUPERCEDE) return // The game mode didnt accept some conditions

			if(g_ForwardParameter[0]) formatex(newmodel, charsmax(newmodel), g_ForwardParameter) // Check if forward not changed the param

			formatex(g_playermodel[id], charsmax(g_playermodel[]), newmodel)
			if(g_set_modelindex_offset) fm_cs_set_user_model_index(id, model_index)
			
			if(g_newround) set_task(5.0 * g_modelchange_delay, "fm_user_model_update", id+TASK_MODEL)
			else fm_user_model_update(id+TASK_MODEL)
			ExecuteForward(g_forwards[MODEL_CHANGE_POST], g_fwDummyResult, id, newmodel)
		}
	}
}
public CallbackMenu(id, menu, item) return ITEM_DISABLED; 

stock add_point(number) { 
	new count, i, str[29], str2[35], len
	num_to_str(number, str, charsmax(str))
	len = strlen(str)

	for(i = 0; i < len; i++) {
		if(i != 0 && ((len - i) %3 == 0)) {
			add(str2, charsmax(str2), ".", 1)
			count++
			add(str2[i+count], 1, str[i], 1)
		}
		else add(str2[i+count], 1, str[i], 1)
	}
	return str2;
}
stock set_screenfadein(id, fadetime, r, g, b, alpha) {
	new players[32], count = 1
	if(id) players[0] = id; else get_players(players,count,"ch");
	for(new i=0;i<count;i++) {
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
bool:get_allowed_frost(id) {
	if(!g_zombie[id] || !g_isalive[id]) return false;

	if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
		if(get_pcvar_num(cvar_zm_allow_frost[g_zm_special[id]])) return true;

		return false;
	}
	else if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
		if(ArrayGetCell(g_zm_special_allow_frost, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0) return true;

		return false
	}
	return true
}
bool:get_allowed_burn(id) {
	if(!g_zombie[id] || !g_isalive[id]) return false;
		
	if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
		if(get_pcvar_num(cvar_zm_allow_burn[g_zm_special[id]])) return true;

		return false;
	}
	else if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
		if(ArrayGetCell(g_zm_special_allow_burn, g_zm_special[id]-MAX_SPECIALS_ZOMBIES) > 0) return true;

		return false
	}
	return true
}

bool:is_escape_map() {
	static map_name[32], buffer[32]
	get_mapname(map_name, sizeof(map_name))
	if(equal(map_name, "ze_", 3)) return true; // ze_ map prefix

	if(ArraySize(g_escape_maps) > 0) {
		for(new i = 0; i < ArraySize(g_escape_maps); i++) { // zombie escape maps that not have ze_ prefix 
			ArrayGetString(g_escape_maps, i, buffer, charsmax(buffer))
			if(equal(map_name, buffer))
				return true;
		}
	}
	return false
}

stock damage_dealth(attacker, victim, damage)
{
	if(!is_user_valid_alive(attacker) || !is_user_valid_alive(victim)) 
		return;

	if(victim == attacker || fm_cs_get_user_team(attacker) == fm_cs_get_user_team(victim) || get_pcvar_num(cvar_ammodamage_quantity) <= 0)
		return;

	if(!g_zombie[attacker]) { // Reward ammo packs	
		if(get_pcvar_num(cvar_ammodamage) <= 0)
			return;

		if(g_hm_special[attacker] >= MAX_SPECIALS_HUMANS) {
			if(ArrayGetCell(g_hm_special_ignoreammo, g_hm_special[attacker]-MAX_SPECIALS_HUMANS) <= 0)
				g_damagedealt[attacker] += damage // Store damage dealt
		}
		else {
			if(g_hm_special[attacker] <= 0 || (g_hm_special[attacker] > 0 && g_hm_special[attacker] < MAX_SPECIALS_HUMANS && !get_pcvar_num(cvar_hm_ignore_ammo[g_hm_special[attacker]])))
				g_damagedealt[attacker] += damage // Store damage dealt
		}

	}
	else {
		if(get_pcvar_num(cvar_ammodamage_zombie) <= 0)
			return;

		if(g_zm_special[attacker] >= MAX_SPECIALS_ZOMBIES) {
			if(ArrayGetCell(g_zm_special_ignoreammo, g_zm_special[attacker]-MAX_SPECIALS_ZOMBIES) <= 0)
				g_damagedealt[attacker] += damage // Store damage dealt
		}
		else {
			if(g_zm_special[attacker] <= 0 || (g_zm_special[attacker] > 0 && g_zm_special[attacker] < MAX_SPECIALS_ZOMBIES && !get_pcvar_num(cvar_zm_ignore_ammo[g_zm_special[attacker]])))
				g_damagedealt[attacker] += damage // Store damage dealt
		}
	}

	// Give rewards according to damage dealt [Like in zp 5.0]
	how_many_rewards = g_damagedealt[attacker] / get_pcvar_num(g_zombie[attacker] ? cvar_ammodamage_zombie : cvar_ammodamage)
	
	if(how_many_rewards > 10)
		how_many_rewards = 10; // Limiting to prevent farm

	if (how_many_rewards > 0) {
		g_ammopacks[attacker] += get_pcvar_num(cvar_ammodamage_quantity) * how_many_rewards
		//g_damagedealt[attacker] -= get_pcvar_num(cvar_ammodamage) * how_many_rewards
		g_damagedealt[attacker] = 0
	}
}

public is_gamemode_enable(modeid)
{
	if(modeid <= MODE_NONE)
		return 0

	if(modeid == MODE_INFECTION)
		return 1;

	if(modeid < MAX_GAME_MODES) // Internal Game Modes
	{
		if(!get_pcvar_num(cvar_mod_enable[modeid]) || get_pcvar_num(cvar_mod_enable[modeid]) == 2 && !g_escape_map || get_pcvar_num(cvar_mod_enable[modeid]) == 3 && g_escape_map)
			return 0

		switch(modeid) {
			case MODE_NEMESIS: if(!zm_special_enable[NEMESIS]) return 0;
			case MODE_ASSASSIN: if(!zm_special_enable[ASSASSIN]) return 0;
			case MODE_PREDATOR: if(!zm_special_enable[PREDATOR]) return 0;
			case MODE_BOMBARDIER: if(!zm_special_enable[BOMBARDIER]) return 0;
			case MODE_DRAGON: if(!zm_special_enable[DRAGON]) return 0;
			case MODE_SURVIVOR: if(!hm_special_enable[SURVIVOR]) return 0;
			case MODE_SNIPER: if(!hm_special_enable[SNIPER]) return 0;
			case MODE_BERSERKER: if(!hm_special_enable[BERSERKER]) return 0;
			case MODE_WESKER: if(!hm_special_enable[WESKER]) return 0;
			case MODE_SPY: if(!hm_special_enable[SPY]) return 0;
		}

		if((modeid == MODE_PLAGUE || modeid == MODE_LNJ) && (!zm_special_enable[NEMESIS] || !hm_special_enable[SURVIVOR]))
			return 0
	}
	else // Custom/External game modes
	{
		if((modeid-MAX_GAME_MODES) >= ArraySize(g_gamemode_enable))
			return 0

		if(ArrayGetCell(g_gamemode_enable, (modeid - MAX_GAME_MODES)) > 0 && !g_escape_map
		|| ArrayGetCell(g_gamemode_enable_on_ze_map, (modeid - MAX_GAME_MODES)) > 0 && g_escape_map)
			return 1
	}

	return 1
}
precache_player_model(const modelname[]) {
	static longname[128] , index
	formatex(longname, charsmax(longname), "models/player/%s/%s.mdl", modelname, modelname)  	
	index = engfunc(EngFunc_PrecacheModel, longname) 
	
	if(g_force_consistency == 1) force_unmodified(force_model_samebounds, {0,0,0}, {0,0,0}, longname)
	if(g_force_consistency == 2) force_unmodified(force_exactfile, {0,0,0}, {0,0,0}, longname)
	
	copy(longname[strlen(longname)-4], charsmax(longname) - (strlen(longname)-4), "T.mdl") 
	if(file_exists(longname)) engfunc(EngFunc_PrecacheModel, longname) 
	
	return index
}


public set_player_light(id, const LightStyle[])
{
	if(!is_user_connected(id))
		return
	
	message_begin(MSG_ONE_UNRELIABLE, SVC_LIGHTSTYLE, .player = id)
	write_byte(0)
	write_string(LightStyle)
	message_end()
}


public set_user_fade_nvg(id, nosound)
{
	if (!is_user_connected(id)) 
		return PLUGIN_HANDLED
	
	if(!nosound)
		client_cmd(id, "spk items/nvg_%s.wav", g_nvisionenabled[id] ? "on" : "off")
	
	set_fade_nvg(id)
	
	return 0
}

public set_fade_nvg(id)
{	
	if(!g_isconnected[id]) 
		return;

	static alpha
	if(g_nvisionenabled[id]) alpha = get_pcvar_num(cvar_nvg_alpha)
	else alpha = 0
	
	message_begin(MSG_ONE_UNRELIABLE, g_msgScreenFade, _, id)
	write_short(0) // duration
	write_short(0) // hold time
	write_short(0x0004) // fade type
	
	// Special Class / Madness / Spectator in a special round
	if(g_zm_special[id] >= MAX_SPECIALS_ZOMBIES) {
		write_byte(ArrayGetCell(g_zm_special_r, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // r
		write_byte(ArrayGetCell(g_zm_special_g, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // g
		write_byte(ArrayGetCell(g_zm_special_b, g_zm_special[id]-MAX_SPECIALS_ZOMBIES)) // b
	}
	else if(g_zm_special[id] > 0 && g_zm_special[id] < MAX_SPECIALS_ZOMBIES) {
		write_byte(get_pcvar_num(cvar_zm_red[g_zm_special[id]])) // r
		write_byte(get_pcvar_num(cvar_zm_green[g_zm_special[id]])) // g
		write_byte(get_pcvar_num(cvar_zm_blue[g_zm_special[id]])) // b
	}

	// Human / Spectator in normal round
	else if(!g_zombie[id] || !g_isalive[id]) {
		if(g_hm_special[id] >= MAX_SPECIALS_HUMANS) {
			write_byte(ArrayGetCell(g_hm_special_r, g_hm_special[id]-MAX_SPECIALS_HUMANS)) // r
			write_byte(ArrayGetCell(g_hm_special_g, g_hm_special[id]-MAX_SPECIALS_HUMANS)) // g
			write_byte(ArrayGetCell(g_hm_special_b, g_hm_special[id]-MAX_SPECIALS_HUMANS)) // b
		}
		else if(g_hm_special[id] > 0 && g_hm_special[id] < MAX_SPECIALS_HUMANS) {
			write_byte(get_pcvar_num(cvar_hm_red[g_hm_special[id]])) // r
			write_byte(get_pcvar_num(cvar_hm_green[g_hm_special[id]])) // g
			write_byte(get_pcvar_num(cvar_hm_blue[g_hm_special[id]])) // b
		}
		else {		
			switch(g_nv_color[0][id]) {
				case 1: g_nvrgb = { 255, 255, 255 }
				case 2: g_nvrgb = { 255, 0, 0 }
				case 3: g_nvrgb = { 0, 255, 0 }
				case 4: g_nvrgb = { 0, 0, 255 }
				case 5: g_nvrgb = { 0, 255, 255 }
				case 6: g_nvrgb = { 255, 0, 255 }
				case 7: g_nvrgb = { 255, 255, 0 }
				default: {
					g_nvrgb[0] = get_pcvar_num(cvar_hm_red[0])
					g_nvrgb[1] = get_pcvar_num(cvar_hm_green[0])
					g_nvrgb[2] = get_pcvar_num(cvar_hm_blue[0])
				}
			}
			write_byte(g_nvrgb[0]) // r
			write_byte(g_nvrgb[1]) // g
			write_byte(g_nvrgb[2]) // b
		}
	}
	// Zombie
	else {
		switch(g_nv_color[1][id]) {
			case 1: g_nvrgb = { 255, 255, 255 }
			case 2: g_nvrgb = { 255, 0, 0 }
			case 3: g_nvrgb = { 0, 255, 0 }
			case 4: g_nvrgb = { 0, 0, 255 }
			case 5: g_nvrgb = { 0, 255, 255 }
			case 6: g_nvrgb = { 255, 0, 255 }
			case 7: g_nvrgb = { 255, 255, 0 }
			default: {
				g_nvrgb[0] = get_pcvar_num(cvar_zombie_nvsion_rgb[0])
				g_nvrgb[1] = get_pcvar_num(cvar_zombie_nvsion_rgb[1])
				g_nvrgb[2] = get_pcvar_num(cvar_zombie_nvsion_rgb[2])
			}
		}
		write_byte(g_nvrgb[0]) // r
		write_byte(g_nvrgb[1]) // g
		write_byte(g_nvrgb[2]) // b	
	}

	write_byte(alpha) // alpha
	message_end()

	if(g_nvisionenabled[id]) {
		set_player_light(id, "z")
	} 
	else {
		static lighting[2]
		if(g_custom_light) formatex(lighting, charsmax(lighting), custom_lighting)	
		else if(g_currentmode == MODE_ASSASSIN) formatex(lighting, charsmax(lighting), "a") // no lighting in assassin round
		else get_pcvar_string(cvar_lighting, lighting, charsmax(lighting))
		strtolower(lighting)
		set_player_light(id, lighting)
	}
}
public user_nightvision(id, enable) { // Nightvision toggle

	if(g_nvg_enabled_mode[id] != get_pcvar_num(cvar_customnvg)) {
		nvision_toggle_off(id)
		if(enable) g_nvisionenabled[id] = true
	}

	if(g_nvision[id]) {
		switch(get_pcvar_num(cvar_customnvg)) {
			case 0: set_user_gnvision(id, enable)
			case 1: {
				remove_task(id+TASK_NVISION)
				if(enable) set_task(0.1, "set_user_nvision", id+TASK_NVISION, _, _, "b")
			}
			case 2: 
				set_user_fade_nvg(id, 0)
			
			default: 
				set_user_fade_nvg(id, 0)
		}
		if(enable) g_nvg_enabled_mode[id] = get_pcvar_num(cvar_customnvg)
	}

	return PLUGIN_HANDLED;
}
public set_all_light(const lighting[]) {
	for(new i = 1 ; i <= g_maxplayers; i++) {
		if(!g_isconnected[i])
			continue;

		if(g_nvisionenabled[i] && get_pcvar_num(cvar_customnvg) >= 2) 
			continue;

		set_player_light(i, lighting)
	}
}
public nvision_toggle_off(id) {
	if(!g_isconnected[id])
		return;

	if(g_nvisionenabled[id]) {
		g_nvisionenabled[id] = false
		switch(g_nvg_enabled_mode[id]) {
			case 0: set_user_gnvision(id, 0)
			case 1: remove_task(id+TASK_NVISION)
			case 2: set_user_fade_nvg(id, 0)
			default: set_user_fade_nvg(id, 0)
		}
	}
}
