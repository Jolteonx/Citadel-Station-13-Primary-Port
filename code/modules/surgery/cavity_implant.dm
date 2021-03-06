/datum/surgery/cavity_implant
	name = "cavity implant"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/incise, /datum/surgery_step/handle_cavity, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	location = "chest"
	requires_organic_chest = 1


//handle cavity
/datum/surgery_step/handle_cavity
	accept_hand = 1
	accept_any_item = 1
	time = 32
	var/obj/item/IC = null

/datum/surgery_step/handle_cavity/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	for(var/obj/item/I in target.internal_organs)
		if(!istype(I, /obj/item/organ))
			IC = I
			break
	if(tool)
		user.visible_message("<span class='notice'>[user] begins to insert [tool] into [target]'s [target_zone].</span>")
	else
		user.visible_message("<span class='notice'>[user] checks for items in [target]'s [target_zone].</span>")

/datum/surgery_step/handle_cavity/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(tool)
		if(IC || tool.w_class > 3 || NODROP in tool.flags || tool.GetTypeInAllContents(/obj/item/weapon/disk/nuclear) || istype(tool, /obj/item/weapon/disk/nuclear) || istype(tool, /obj/item/organ))
			user.visible_message("<span class='notice'>[user] can't seem to fit [tool] in [target]'s [target_zone].</span>")
			return 0
		else
			user.visible_message("<span class='notice'>[user] stuffs [tool] into [target]'s [target_zone]!</span>")
			user.drop_item()
			target.internal_organs += tool
			tool.loc = target
			return 1
	else
		if(IC)
			user.visible_message("<span class='notice'>[user] pulls [IC] out of [target]'s [target_zone]!</span>")
			user.put_in_hands(IC)
			target.internal_organs -= IC
			return 1
		else
			user.visible_message("<span class='notice'>[user] doesn't find anything in [target]'s [target_zone].</span>")
			return 0

//Butt surgery, woo

/datum/surgery/butt_removal
	name = "butt removal"
	steps = list(/datum/surgery_step/incise, /datum/surgery_step/clamp_bleeders, /datum/surgery_step/retract_skin, /datum/surgery_step/incise, /datum/surgery_step/handle_butt, /datum/surgery_step/close)
	species = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	location = "groin"
	requires_organic_chest = 1


//handle butt
/datum/surgery_step/handle_butt
	accept_hand = 1
	accept_any_item = 1
	time = 32
	var/obj/item/organ/butt/B = null

/datum/surgery_step/handle_butt/preop(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	B = locate() in target.internal_organs
	if(tool)
		user.visible_message("<span class='notice'>[user] begins to insert [tool] into [target]'s [target_zone].</span>")
	else
		user.visible_message("<span class='notice'>[user] checks for butt in [target]'s [target_zone].</span>")

/datum/surgery_step/handle_butt/success(mob/user, mob/living/carbon/target, target_zone, obj/item/tool, datum/surgery/surgery)
	if(tool)
		if(!istype(tool, /obj/item/organ/butt) || istype(B))
			user.visible_message("<span class='notice'>[user] can't seem to fit [tool] in [target]'s [target_zone].</span>")
			return 0
		else
			user.visible_message("<span class='notice'>[user] stuffs [tool] into [target]'s [target_zone]!</span>")
			user.drop_item()
			target.internal_organs += tool
			tool.loc = target
			return 1
	else
		if(istype(B))
			user.visible_message("<span class='notice'>[user] pulls [B] out of [target]'s [target_zone]!</span>")
			user.put_in_hands(B)
			target.internal_organs -= B
			return 1
		else
			user.visible_message("<span class='notice'>[user] doesn't find anything in [target]'s [target_zone].</span>")
			return 0