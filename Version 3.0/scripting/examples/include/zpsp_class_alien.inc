#if defined _zpsp_class_alien_included
  #endinput
#endif
#define _zpsp_class_alien_included

#if !defined _zombie_special_new_included
#include <zombie_plague_special>

#if ZPS_INC_VERSION < 30
	#assert Zombie Plague Special 3.0 Include File Required. Download Link: https://forums.alliedmods.net/showthread.php?t=260845
#endif

#endif

native zp_get_user_alien(id)
native zp_make_user_alien(id)
native zp_get_alien_count()
native zp_is_alien_round()
