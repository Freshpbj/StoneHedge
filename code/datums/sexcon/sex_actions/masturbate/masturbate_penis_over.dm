/datum/sex_action/masturbate_penis_over
	name = "Jerk over them"
	check_same_tile = FALSE

/datum/sex_action/masturbate_penis_over/shows_on_menu(mob/living/user, mob/living/target)
	if(!target.bypasssexable && issimple(target))
		return FALSE
	if(user.client.prefs.defiant && issimple(target))
		return FALSE
	if(user == target)
		return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_over/can_perform(mob/living/user, mob/living/target)
	if(user == target)
		return FALSE
	if(ishuman(user))
		var/mob/living/carbon/human/userhuman = user
		if(userhuman.wear_pants)
			var/obj/item/clothing/under/roguetown/pantsies = userhuman.wear_pants
			if(pantsies.flags_inv & HIDECROTCH) 
				if(pantsies.genitalaccess == FALSE) 
					return FALSE
	if(!user.getorganslot(ORGAN_SLOT_PENIS))
		return FALSE
	if(!user.sexcon.can_use_penis())
		return
	return TRUE

/datum/sex_action/masturbate_penis_over/on_start(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] starts jerking over [target]..."))

/datum/sex_action/masturbate_penis_over/on_perform(mob/living/user, mob/living/target)
	var/chosen_verb = pick(list("jerks their cock", "strokes their cock", "masturbates", "jerks off"))
	user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] [chosen_verb] over [target]"))
	playsound(user, 'sound/misc/mat/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] cums over [target]'s body!"))
		user.sexcon.cum_onto()

/datum/sex_action/masturbate_penis_over/on_finish(mob/living/user, mob/living/target)
	user.visible_message(span_warning("[user] stops jerking off."))

/datum/sex_action/masturbate_penis_over/is_finished(mob/living/user, mob/living/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
