#if defined _zombie_plague_special_included
  #endinput
#endif
#define _zombie_plague_special_included

/* Teams for zp_register_extra_item() */
#define ZP_TEAM_ZOMBIE (1<<0)
#define ZP_TEAM_HUMAN (1<<1)
#define ZP_TEAM_NEMESIS (1<<2)
#define ZP_TEAM_SURVIVOR (1<<3)
#define ZP_TEAM_SNIPER (1<<4)
#define ZP_TEAM_ASSASSIN (1<<5)
#define ZP_TEAM_BERSERKER (1<<6)
#define ZP_TEAM_PREDATOR (1<<7)
#define ZP_TEAM_PADRE = (1<<8)
#define ZP_TEAM_DRAGON = (1<<9)
#define ZP_TEAM_CHUCKNORIS = (1<<10)

/* Death Match modes for zp_register_game_mode */
enum
{
	ZP_DM_NONE = 0,	// Disable death match during the custom mode round
	ZP_DM_HUMAN, 	// Respawn as human only
	ZP_DM_ZOMBIE, 	// Respawn as zombie only
	ZP_DM_RANDOM,	// Respawn randomly as humans or zombies
	ZP_DM_BALANCE	// Respawn as humans or zombies to keep both team balanced
}
/* Game modes for zp_round_started() */
enum
{
	MODE_NONE = 0,
	MODE_INFECTION,
	MODE_NEMESIS,
	MODE_ASSASSIN,
	MODE_PREDATOR,
	MODE_DRAGON,
	MODE_SURVIVOR,
	MODE_SNIPER,
	MODE_BERSERKER,
	MODE_PADRE,
	MODE_CHUCKNORIS,
	MODE_SWARM,
	MODE_MULTI,
	MODE_PLAGUE,
	MODE_LNJ,
	MAX_GAME_MODES
}

/* Winner teams for zp_round_ended() */
enum
{
	WIN_NO_ONE = 0,
	WIN_ZOMBIES,
	WIN_HUMANS
}

/* Custom forward return values */
#define ZP_PLUGIN_HANDLED 97

/**
 * Returns whether a player is a zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_zombie(id)

/**
 * Returns whether a player is a nemesis.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_nemesis(id)

/**
 * Returns whether a player is a survivor.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_survivor(id)

/**
 * Returns whether a player is the first zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_first_zombie(id)

/**
 * Returns whether a player is the last zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_last_zombie(id)

/**
 * Returns whether a player is the last human.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_last_human(id)

/**
 * Returns a player's current zombie class ID.
 *
 * @param id		Player index.
 * @return		Internal zombie class ID, or -1 if not yet chosen.
 */
native zp_get_user_zombie_class(id)

/**
 * Returns a player's next zombie class ID (for the next infection).
 *
 * @param id		Player index.
 * @return		Internal zombie class ID, or -1 if not yet chosen.
 */
native zp_get_user_next_class(id)

/**
 * Sets a player's next zombie class ID (for the next infection).
 *
 * @param id		Player index.
 * @param classid	A valid zombie class ID.
 * @return		True on success, false otherwise.
 */
native zp_set_user_zombie_class(id, classid)

/**
 * Returns a player's ammo pack count.
 *
 * @param id		Player index.
 * @return		Number of ammo packs owned.
 */
native zp_get_user_ammo_packs(id)

/**
 * Sets a player's ammo pack count.
 *
 * @param id		Player index.
 * @param amount	New quantity of ammo packs owned.
 */
native zp_set_user_ammo_packs(id, amount)

/**
 * Returns the default maximum health of a zombie.
 *
 * Note: Takes into account first zombie's HP multiplier.
 *
 * @param id		Player index.
 * @return		Maximum amount of health points, or -1 if not a normal zombie.
 */
native zp_get_zombie_maxhealth(id)

/**
 * Returns a player's custom flashlight batteries charge.
 *
 * @param id		Player index.
 * @return		Charge percent (0 to 100).
 */
native zp_get_user_batteries(id)

/**
 * Sets a player's custom flashlight batteries charge.
 *
 * @param id		Player index.
 * @param value		New charge percent (0 to 100).
 */
native zp_set_user_batteries(id, charge)

/**
 * Returns whether a player has night vision.
 *
 * @param id		Player index.
 * @return		True if it has, false otherwise.
 */
native zp_get_user_nightvision(id)

/**
 * Sets whether a player has night vision.
 *
 * @param id		Player index.
 * @param set		True to give, false for removing it.
 */
native zp_set_user_nightvision(id, set)

/**
 * Forces a player to become a zombie.
 *
 * Note: Unavailable for last human/survivor/sniper/berserker.
 *
 * @param id		Player index to be infected.
 * @param infector	Player index who infected him (optional).
 * @param silent	If set, there will be no HUD messages or infection sounds.
 * @param rewards	Whether to show DeathMsg and reward frags, hp, and ammo packs to infector.
 * @return		True on success, false otherwise.
 */
native zp_infect_user(id, infector = 0, silent = 0, rewards = 0)

/**
 * Forces a player to become a human.
 *
 * Note: Unavailable for last zombie/nemesis.
 *
 * @param id		Player index to be cured.
 * @param silent	If set, there will be no HUD messages or antidote sounds.
 * @return		True on success, false otherwise.
 */
native zp_disinfect_user(id, silent = 0)

/**
 * Forces a player to become a nemesis.
 *
 * Note: Unavailable for last human/survivor/sniper/berserker.
 *
 * @param id		Player index to turn into nemesis.
 * @return		True on success, false otherwise.
 */
native zp_make_user_nemesis(id)

/**
 * Forces a player to become a survivor.
 *
 * Note: Unavailable for last zombie/nemesis.
 *
 * @param id		Player index to turn into survivor.
 * @return		True on success, false otherwise.
 */
native zp_make_user_survivor(id)

/**
 * Respawns a player into a specific team.
 *
 * @param id		Player index to be respawned.
 * @param team		Team to respawn the player into (ZP_TEAM_ZOMBIE or ZP_TEAM_HUMAN).
 * @return		True on success, false otherwise.
 */
native zp_respawn_user(id, team)

/**
 * Forces a player to buy an extra item.
 *
 * @param id		Player index.
 * @param itemid	A valid extra item ID.
 * @param ignorecost	If set, item's cost won't be deduced from player.
 * @return		True on success, false otherwise.
 */
native zp_force_buy_extra_item(id, itemid, ignorecost = 0)

/**
 * Returns whether a player is a sniper.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_sniper(id)

/**
 * Forces a player to become a sniper.
 *
 * Note: Unavailable for last zombie/nemesis/assassin.
 *
 * @param id		Player index to turn into sniper.
 * @return		True on success, false otherwise.
 */
native zp_make_user_sniper(id)

/**
 * Returns whether a player is an assassin.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_assassin(id)


/**
 * Forces a player to become a assassin.
 *
 * Note: Unavailable for last human/survivor/sniper.
 *
 * @param id		Player index to turn into assassin.
 * @return		True on success, false otherwise.
 */
native zp_make_user_assassin(id)

/**
 * Returns whether a player is an predator.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_predator(id)

/**
 * Forces a player to become a predator.
 *
 * Note: Unavailable for last human/survivor/sniper.
 *
 * @param id		Player index to turn into predator.
 * @return		True on success, false otherwise.
 */
native zp_make_user_predator(id)

/**
 * Returns whether a player is an dragon.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_dragon(id)

/**
 * Forces a player to become a dragon.
 *
 * Note: Unavailable for last human/survivor/sniper.
 *
 * @param id		Player index to turn into dragon.
 * @return		True on success, false otherwise.
 */
native zp_make_user_dragon(id)

/**
 * Returns whether a player is a sniper.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_berserker(id)

/**
 * Forces a player to become a berserker.
 *
 * Note: Unavailable for last zombie/nemesis/assassin.
 *
 * @param id		Player index to turn into berserker.
 * @return		True on success, false otherwise.
 */
native zp_make_user_berserker(id)

/**
 * Returns whether a player is a sniper.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_padre(id)

/**
 * Forces a player to become a padre.
 *
 * Note: Unavailable for last zombie/nemesis/assassin.
 *
 * @param id		Player index to turn into padre.
 * @return		True on success, false otherwise.
 */
native zp_make_user_padre(id)

/**
 * Returns whether a player is a sniper.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_chucknoris(id)

/**
 * Forces a player to become a chucknoris.
 *
 * Note: Unavailable for last zombie/nemesis/assassin.
 *
 * @param id		Player index to turn into chucknoris.
 * @return		True on success, false otherwise.
 */
native zp_make_user_chucknoris(id)

/**
 * Returns whether the ZP round has started, i.e. first zombie
 * has been chosen or a game mode has begun.
 *
 * @return		0 - Round not started
 *			1 - Round started
 *			2 - Round starting
 */
native zp_has_round_started()

/**
 * Returns whether the current round is a nemesis round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_nemesis_round()

/**
 * Returns whether the current round is a survivor round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_survivor_round()

/**
 * Returns whether the current round is a swarm round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_swarm_round()

/**
 * Returns whether the current round is a plague round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_plague_round()

/**
 * Returns whether the current round is a Armageddon round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_lnj_round()

/**
 * Returns number of alive zombies.
 *
 * @return		Zombie count.
 */
native zp_get_zombie_count()

/**
 * Returns number of alive humans.
 *
 * @return		Human count.
 */
native zp_get_human_count()

/**
 * Returns number of alive nemesis.
 *
 * @return		Nemesis count.
 */
native zp_get_nemesis_count()

/**
 * Returns number of alive survivors.
 *
 * @return		Survivor count.
 */
native zp_get_survivor_count()

/**
 * Returns whether the current round is a sniper round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_sniper_round()

/**
 * Returns whether the current round is a assassin round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_assassin_round()

/**
 * Returns whether the current round is a predator round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_predator_round()

/**
 * Returns whether the current round is a dragon round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_dragon_round()

/**
 * Returns whether the current round is a berserker round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_berserker_round()

/**
 * Returns whether the current round is a padre round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_padre_round()

/**
 * Returns whether the current round is a chucknoris round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_chucknoris_round()

/**
 * Returns number of alive snipers.
 *
 * @return		Sniper count.
 */
native zp_get_sniper_count()

/**
 * Returns number of alive assassins.
 *
 * @return		Assassin count.
 */
native zp_get_assassin_count()

/**
 * Returns number of alive predators.
 *
 * @return		predator count.
 */
native zp_get_predator_count()

/**
 * Returns number of alive dragons.
 *
 * @return		dragon count.
 */
native zp_get_dragon_count()

/**
 * Returns number of alive berserkers.
 *
 * @return		Berserker count.
 */
native zp_get_berserker_count()

/**
 * Returns number of alive chucknoriss.
 *
 * @return		chucknoris count.
 */
native zp_get_chucknoris_count()

/**
 * Returns number of alive padres.
 *
 * @return		padre count.
 */
native zp_get_padre_count()

/**
 * Returns the current game mode ID
 * 
 * Note: For default game modes you can use, for eg. MODE_SWARM,
 * to check if the current round is swarm mode.
 * 
 * Note: For custom game modes you must have the custom game
 * mode ID to detect it
 * 
 * @return		Current game mode ID
 */
native zp_get_current_mode()

/**
 * Returns an extra item's ID.
 *
 * @param name		Item name to look for.
 * @return		Internal extra item ID, or -1 if not found.
 */
native zp_get_extra_item_id(const name[])

/**
 * Returns a zombie class' ID.
 *
 * @param name		Class name to look for.
 * @return		Internal zombie class ID, or -1 if not found.
 */
native zp_get_zombie_class_id(const name[])

/**
 * Registers a custom game mode which will be added to the admin menu of ZP
 * 
 * Note: The returned game mode ID can later be used to detect the game mode
 * which is called in zp_round_started_pre. There you can start the game mode
 * externally by using this game mode ID.
 * 
 * @param name 		The game modes name which will also be used by other plugins
 * 			to identify this game mode
 * @param flags		Access flags required by the admins to start this game
 * 			mode via the admin menu.
 * @param chance	Chance level of this game mode. (1 in X) The higher the value
 * 			the lesser the chance that this game mode will be called
 * @param allow		Whether to permit infection or not after a zombie's attack
 * @param dm_mode	Death match mode during this game. Use ZP_DM_NONE to disable
 * 			respawning during this game mode
 * @return		An internal game mode ID or -1 on failure
 */
native zp_register_game_mode( const name[], flags, chance, allow, dm_mode)

/**
 * Registers a custom item which will be added to the extra items menu of ZP.
 *
 * Note: The returned extra item ID can be later used to catch item
 * purchase events for the zp_extra_item_selected() forward.
 *
 * Note: ZP_TEAM_NEMESIS, ZP_TEAM_SURVIVOR, ZP_TEAM_ASSASSIN, ZP_TEAM_SNIPER and ZP_TEAM_BERSERKER
 * can be used to make an item available to Nemesis,
 * Survivors, Assassins, Snipers and Berserkers.
 *
 * @param name		Caption to display on the menu.
 * @param cost		Ammo packs to be deducted on purchase.
 * @param teams		Bitsum of teams it should be available for.
 * @return		An internal extra item ID, or -1 on failure.
 */
native zp_register_extra_item(const name[], cost, teams)

/**
 * Registers a custom class which will be added to the zombie classes menu of ZP.
 *
 * Note: The returned zombie class ID can be later used to identify
 * the class when calling the zp_get_user_zombie_class() natives.
 *
 * @param name		Caption to display on the menu.
 * @param info		Brief description of the class.
 * @param model		Player model to be used.
 * @param clawmodel	Claws model to be used.
 * @param hp		Initial health points.
 * @param speed		Maximum speed.
 * @param gravity	Gravity multiplier.
 * @param knockback	Knockback multiplier.
 * @return		An internal zombie class ID, or -1 on failure.
 */
native zp_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback)

/**
 * Called when the ZP round starts, i.e. first zombie
 * is chosen or a game mode begins.
 *
 * @param gamemode	Mode which has started.
 * @param id		Affected player's index (if applicable).
 */
forward zp_round_started(gamemode, id)

/**
 * Called before the ZP round starts. This is only 
 * called for custom game modes.
 * 
 * Note: The custom game mode id can be used to start
 * the game mode externally
 * 
 * Note: returning ZP_PLUGIN_HANDLED will cause the
 * game mode to be blocked and other game modes will
 * be given a chance.
 * 
 * @param gameid	Custom mode id which is called
 */
forward zp_round_started_pre(gameid)

/**
 * Called when the round ends.
 *
 * @param winteam	Team which has won the round.
 */
forward zp_round_ended(winteam)

/**
 * Called when a player gets infected.
 *
 * @param id		Player index who was infected.
 * @param infector	Player index who infected him (if applicable).
 * @param nemesis	Whether the player was turned into a nemesis.
 */
forward zp_user_infected_pre(id, infector, nemesis)
forward zp_user_infected_post(id, infector, nemesis)

/**
 * Called when a player turns back to human.
 *
 * @param id		Player index who was cured.
 * @param survivor	Whether the player was turned into a survivor.
 */
forward zp_user_humanized_pre(id, survivor)
forward zp_user_humanized_post(id, survivor)
forward zp_user_humanized_pre(id, sniper)
forward zp_user_humanized_post(id, sniper)
forward zp_user_humanized_pre(id, berserker)
forward zp_user_humanized_post(id, berserker)

/**
 * Called on a player infect/cure attempt. You can use this to block
 * an infection/humanization by returning ZP_PLUGIN_HANDLED in your plugin.
 *
 * Note: Right now this is only available after the ZP round starts, since some
 * situations (like blocking a first zombie's infection) are not yet handled.
 */
forward zp_user_infect_attempt(id, infector, nemesis)
forward zp_user_humanize_attempt(id, survivor)
forward zp_user_humanize_attempt(id, sniper)
forward zp_user_humanize_attempt(id, berserker)

/**
 * Called when an admin selects a custom game mode from the ZP admin menu.
 *
 * Note: You should trigger the custom game mode here with out any checks
 *
 * @param gameid	Internal custom game mode ID
 * @param id		Player index who selected the game mode
 */
forward zp_game_mode_selected(gameid, id)

/**
 * Called when a player spawns. This is also called for CZ bots 
 * which are spawning
 *
 * Note: You should use this, instead of other spawn forwards,
 * when you want to change some one's class after spawning.
 * 
 * Note: If you have used this forward then you must return 
 * ZP_PLUGIN_HANDLED to inform the main plugin that you have used
 * this forward
 *
 * @param id		Player index who has spawned
 * @param resp_zombie	This is passed by the main plugin as 1 if
 * 			the player needs to be spawned as a zombie
 * 			otherwise it is passed as zero
 */
forward zp_player_spawn_post(id, resp_zombie)

/**
 * Called when a player buys an extra item from the ZP menu.
 *
 * Note: You can now return ZP_PLUGIN_HANDLED in your plugin to block
 * the purchase and the player will be automatically refunded.
 *
 * @param id		Player index of purchaser.
 * @param itemid	Internal extra item ID.
 */
forward zp_extra_item_selected(id, itemid)

/**
 * Called when a player gets unfrozen (frostnades).
 *
 * @param id		Player index.
 */
forward zp_user_unfrozen(id)

/**
 * Called when a player becomes the last zombie.
 *
 * Note: This is called for the first zombie too.
 *
 * @param id		Player index.
 */
forward zp_user_last_zombie(id)

/**
 * Called when a player becomes the last human.
 *
 * @param id		Player index.
 */
forward zp_user_last_human(id)

/**
 * @deprecated - Do not use!
 * For backwards compatibility only.
 */
#define ZP_TEAM_ANY 0


native zp_get_user_frozen(id)
native zp_set_user_frozen(id, set)
native zp_get_user_nodamage(id)
native zp_set_user_nodamage(id, set)
native zp_get_user_stucked(id)
native zp_set_user_unstucked(id)
native zp_get_user_burning(id)
native zp_set_user_burning(id, bool:isburning)
native zp_user_random_spawn(id)
native zp_get_zm_special_class(id)
native zp_get_hm_special_class(id)

native zp_get_user_model(id, const string[], len)

native zp_set_user_model(id, const model[])
