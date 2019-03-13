local capsules = {}

local turretUtils = require("utils/TurretUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local ammoUtils = require("utils/AmmoUtils")
local streamUtils = require("utils/StreamUtils")

local addEffectToTech = technologyUtils.addEffectToTech
local makeStream = streamUtils.makeStream
local makeAmmo = ammoUtils.makeAmmo
local makeRecipe = recipeUtils.makeRecipe
local makeAmmoTurret = turretUtils.makeAmmoTurret

local capsuleGrey = {r=0,g=0,b=0,a=0.9}
local particleGrey = {r=0,g=0,b=0,a=0.9}

local function CapsuleLauncherSheet()
    return
	{
	    layers =
		{
		    {
			filename = "__RampantArsenal__/graphics/entities/arty2x2-sheet.png",
			priority = "high",
			width = 168,
			height = 168,
			line_length = 8,
			axially_symmetrical = false,
			direction_count = 64,
			frame_count = 1,
			shift = {0, -1.4},
		    }
		}
	}
end



function capsules.enable()

    data:extend(
	{
	    {
		type = "item-subgroup",
		name = "launcher-capsule",
		group = "combat",
		order = "b-b"
	    },
	    {
		type = "ammo-category",
		name = "capsule-launcher",
	    },
            {
                type = "simple-entity-with-force",
                name = "rampant-clean-ghost-mine",
                render_layer = "object",
                icon = "__base__/graphics/icons/steel-chest.png",
                icon_size = 32,
                flags = {"placeable-neutral", "player-creation"},
                order = "s-e-w-f",
                minable = {mining_time = 1, result = "simple-entity-with-force"},
                max_health = 100,
                corpse = "small-remnants",
                -- collision_box = {{-0.35, -0.35}, {0.35, 0.35}},
                -- selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
                picture =
                    {
                        filename = "__core__/graphics/empty.png",
                        priority = "extra-high",
                        width = 1,
                        height = 1
                    }
            }
    })

    local slowCapsules = makeAmmo({
	    name = "slowdown-capsule",
	    icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "h[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "slowdown-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "area",
					    radius = 12,
					    force = "enemy",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-sticker",
							    sticker = "slowdown-sticker"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local paralysisCapsules = makeAmmo({
	    name = "paralysis-capsule",
	    icon = "__RampantArsenal__/graphics/icons/paralysis-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "i[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "paralysis-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-entity",
							    entity_name = "big-paralysis-cloud-rampant-arsenal"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local repairCapsules = makeAmmo({
	    name = "repair-capsule",
	    icon = "__RampantArsenal__/graphics/icons/repair-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "j[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "repair-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-entity",
							    show_in_tooltip = true,
							    entity_name = "big-repair-cloud-rampant-arsenal"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})


    local toxicCapsules = makeAmmo({
	    name = "toxic-capsule",
	    icon = "__RampantArsenal__/graphics/icons/toxic-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "g[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "toxic-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-entity",
							    show_in_tooltip = true,
							    entity_name = "big-toxic-cloud-rampant-arsenal"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local poisonCapsules = makeAmmo({
	    name = "poison-capsule",
	    icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "f[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,
		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "poison-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    type = "create-entity",
							    show_in_tooltip = true,
							    entity_name = "big-poison-cloud-rampant-arsenal"
							}
						}
					}
				}),
				max_length = 9,
				duration = 160
			    }
		    }
    }})

    local distractorCapsules = makeAmmo({
	    name = "distractor-capsule",
	    icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "l[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "distractor-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "distractor",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local defenderCapsules = makeAmmo({
	    name = "defender-capsule",
	    icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "k[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "defender-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "defender",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local destroyerCapsules = makeAmmo({
	    name = "destroyer-capsule",
	    icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "m[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "destroyer-capsule",
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					actions = {
					    type = "direct",
					    action_delivery =
						{
						    type = "instant",
						    target_effects =
							{
							    {
								type = "create-entity",
								show_in_tooltip = true,
								entity_name = "destroyer",
								offsets = {{0.5, -0.5},{-0.5, -0.5},{0, 0.5}}
							    }
							}
						}
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local landmineCapsules = makeAmmo({
	    name = "landmine-capsule",
	    icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "n[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "landmine-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
							    type = "create-entity",
							    entity_name = "landmine-ghostless-rampant-arsenal"
							}
						    }
					    },
					    {
						type = "cluster",
						cluster_count = 3,
						distance = 4,
						distance_deviation = 3,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    show_in_tooltip = true,
								    entity_name = "landmine-ghostless-rampant-arsenal"
								}
							    }
						    }
					}}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local incendiaryLandmineCapsules = makeAmmo({
	    name = "incendiary-landmine-capsule",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-landmine-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "w[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "incendiary-landmine-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "incendiary-landmine-ghostless-rampant-arsenal"
                                                            }
                                                        }
						    }
					    },
					    {
						type = "cluster",
						cluster_count = 2,
						distance = 4,
						distance_deviation = 3,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    show_in_tooltip = true,
								    entity_name = "incendiary-landmine-ghostless-rampant-arsenal"
								}
							    }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local heLandmineCapsules = makeAmmo({
	    name = "he-landmine-capsule",
	    icon = "__RampantArsenal__/graphics/icons/he-landmine-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "p[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "he-landmine-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "he-landmine-ghostless-rampant-arsenal"
                                                            }
                                                        }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local bioLandmineCapsules = makeAmmo({
	    name = "bio-landmine-capsule",
	    icon = "__RampantArsenal__/graphics/icons/bio-landmine-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "o[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "bio-landmine-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "bio-landmine-ghostless-rampant-arsenal"
                                                            }
                                                        }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local nuclearLandmineCapsules = makeAmmo({
	    name = "nuclear-landmine-capsule",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-landmine-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "x[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "nuclear-landmine-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 2,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects = {
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "nuclear-landmine-ghostless-rampant-arsenal"
                                                            }
                                                        }
						    }
					}}
				}),
				max_length = 9,
				duration = 160,
			    }
		    }
    }})

    local grenadeCapsules = makeAmmo({
	    name = "grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "a[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "grenade-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 64,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    entity_name = "medium-explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "small-scorchmark",
								    check_buildability = true
								}
							    }
						    }
					    },
					    {
						type = "area",
						radius = 9,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "damage",
								    damage = {amount = 300, type = "explosion"}
								},
								{
								    type = "create-entity",
								    entity_name = "explosion"
								}
							    }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 200,
			    }
		    }
    }})

    local bioGrenadeCapsules = makeAmmo({
	    name = "bio-grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/bio-grenade-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "b[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "bio-grenade-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 64,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    entity_name = "medium-explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "small-scorchmark",
								    check_buildability = true
								}
							    }
						    }
					    },
					    {
						type = "area",
						radius = 11,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "damage",
								    damage = {amount = 350, type = "poison"}
								},
								{
								    type = "damage",
								    damage = {amount = 50, type = "explosion"}
								},
								{
								    type = "create-entity",
								    entity_name = "explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "toxic-cloud-rampant-arsenal",
                                                                    show_in_tooltip = true
								}
							    }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 200,
			    }
		    }
    }})

    local heGrenadeCapsules = makeAmmo({
	    name = "he-grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/he-grenade-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "c[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "he-grenade-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 64,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    entity_name = "medium-explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "small-scorchmark",
								    check_buildability = true
								}
							    }
						    }
					    },
					    {
						type = "area",
						radius = 14,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "damage",
								    damage = {amount = 675, type = "explosion"}
								},
								{
								    type = "damage",
								    damage = {amount = 150, type = "physical"}
								},
								{
								    type = "create-entity",
								    entity_name = "big-explosion"
								}
							    }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 200,
			    }
		    }
    }})

    local incendiaryGrenadeCapsules = makeAmmo({
	    name = "incendiary-grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-grenade-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "d[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,

		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "incendiary-grenade-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 64,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    entity_name = "medium-explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "small-scorchmark",
								    check_buildability = true
								},
                                                                {
                                                                    type = "create-fire",
                                                                    entity_name = "fire-flame",
                                                                    initial_ground_flame_count = 4
                                                                }
							    }
						    }
					    },
					    {
						type = "area",
						radius = 11,
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "damage",
								    damage = {amount = 50, type = "explosion"}
								},
								{
								    type = "damage",
								    damage = {amount = 350, type = "fire"}
								},
								{
								    type = "create-entity",
								    entity_name = "explosion"
								},
								{
								    type = "create-sticker",
								    sticker = "small-fire-sticker-rampant-arsenal"
								},
                                                                {
                                                                    type = "create-fire",
                                                                    entity_name = "fire-flame",
                                                                    initial_ground_flame_count = 4
                                                                }
							    }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 200,
			    }
		    }
    }})

    local clusterGrenadeCapsules = makeAmmo({
	    name = "cluster-grenade-capsule",
	    icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
	    magSize = 1,
	    subgroup = "launcher-capsule",
	    order = "e[capsule]",
	    stackSize = 200,
	    ammoType = {
		category = "capsule-launcher",
		target_type = "position",
		clamp_position = true,
		action =
		    {
			type = "direct",
			action_delivery =
			    {
				type = "stream",
				stream = makeStream({
					name = "cluster-grenade-capsule",
					bufferSize = 1,
					spineAnimationTint = capsuleGrey,
					particleTint = particleGrey,
					spawnInterval = 64,
					actions = {
					    {
						type = "direct",
						action_delivery =
						    {
							type = "instant",
							target_effects =
							    {
								{
								    type = "create-entity",
								    entity_name = "explosion"
								},
								{
								    type = "create-entity",
								    entity_name = "small-scorchmark",
								    check_buildability = true
								}
							    }
						    }
					    },
					    {
						type = "cluster",
						cluster_count = 9,
						distance = 7,
						distance_deviation = 3,
						action_delivery =
						    {
							type = "instant",
							target_effects = {
                                                            type = "create-entity",
                                                            entity_name = "cluster-grenade"
                                                        }
						    }
					    }
					}
				}),
				max_length = 9,
				duration = 200,
			    }
		    }
    }})

    local slowCapsuleRecipe = makeRecipe({
	    name = "slow-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/slowdown-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"slowdown-capsule", 1},
		{"explosives", 1}
	    },
	    result = slowCapsules
    })

    local poisonCapsuleRecipe = makeRecipe({
	    name = "poison-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/poison-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"poison-capsule", 1},
		{"explosives", 1}
	    },
	    result = poisonCapsules
    })


    local toxicCapsuleRecipe = makeRecipe({
	    name = "toxic-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/toxic-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"toxic-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = toxicCapsules
    })

    local paralysisCapsuleRecipe = makeRecipe({
	    name = "paralysis-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/paralysis-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"paralysis-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = paralysisCapsules
    })

    local repairCapsuleRecipe = makeRecipe({
	    name = "repair-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/repair-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"repair-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = repairCapsules
    })


    local distractorCapsuleRecipe = makeRecipe({
	    name = "distractor-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/distractor-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"distractor-capsule", 1},
		{"explosives", 1}
	    },
	    result = distractorCapsules
    })

    local defenderCapsuleRecipe = makeRecipe({
	    name = "defender-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/defender-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"defender-capsule", 1},
		{"explosives", 1}
	    },
	    result = defenderCapsules
    })

    local destroyerCapsuleRecipe = makeRecipe({
	    name = "destroyer-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/destroyer-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"destroyer-capsule", 1},
		{"explosives", 1}
	    },
	    result = destroyerCapsules
    })

    local landmineCapsuleRecipe = makeRecipe({
	    name = "landmine-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"land-mine", 4},
		{"explosives", 1}
	    },
	    result = landmineCapsules
    })

    local incendiaryLandmineCapsuleRecipe = makeRecipe({
	    name = "incendiary-landmine-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"incendiary-landmine-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = incendiaryLandmineCapsules
    })

    local heLandmineCapsuleRecipe = makeRecipe({
	    name = "he-landmine-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/he-landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"he-landmine-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = heLandmineCapsules
    })


    local bioLandmineCapsuleRecipe = makeRecipe({
	    name = "bio-landmine-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/bio-landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"bio-landmine-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = bioLandmineCapsules
    })

    local nuclearLandmineCapsuleRecipe = makeRecipe({
	    name = "nuclear-landmine-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/nuclear-landmine-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"nuclear-landmine-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = nuclearLandmineCapsules
    })

    local grenadeCapsuleRecipe = makeRecipe({
	    name = "grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"grenade", 1},
		{"explosives", 1}
	    },
	    result = grenadeCapsules
    })

    local bioGrenadeCapsuleRecipe = makeRecipe({
	    name = "bio-grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/bio-grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"bio-grenade-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = bioGrenadeCapsules
    })

    local heGrenadeCapsuleRecipe = makeRecipe({
	    name = "he-grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/he-grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"he-grenade-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = heGrenadeCapsules
    })

    local incendiaryGrenadeCapsuleRecipe = makeRecipe({
	    name = "incendiary-grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/incendiary-grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"incendiary-grenade-capsule-rampant-arsenal", 1},
		{"explosives", 1}
	    },
	    result = incendiaryGrenadeCapsules
    })

    local clusterGrenadeCapsuleRecipe = makeRecipe({
	    name = "cluster-grenade-capsule-ammo",
	    icon = "__RampantArsenal__/graphics/icons/cluster-grenade-capsule-ammo.png",
	    enabled = false,
	    ingredients = {
		{"iron-plate", 2},
		{"cluster-grenade", 1},
		{"explosives", 1}
	    },
	    result = clusterGrenadeCapsules
    })

    local entity = {
	name = "capsule",
	icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	miningTime = 1,
	health = 1200,
	foldedAnimation = CapsuleLauncherSheet(),
	foldingAnimation = CapsuleLauncherSheet(),
	preparedAnimation = CapsuleLauncherSheet(),
	preparingAnimation = CapsuleLauncherSheet(),
	order = "b[turret]-d[acapsule-turret]",
        hasBaseDirection = true,
        rotationSpeed = 0.004
    }
    local capsuleTurret, capsuleTurretItem = makeAmmoTurret(entity, {
								type = "stream",
								ammo_category = "capsule-launcher",
								cooldown = 350,
								damage_modifier = 3,
								gun_center_shift = {
								    north = {0, 0},
								    east = {0, -4},
								    south = {0, 0},
								    west = {0, -4}
								},
								gun_barrel_length = 4,
                                                                min_range = 15,
                                                                turn_range = 0.30,
								range = 47,
								sound = make_heavy_gunshot_sounds()
    })

    local capsuleTurretRecipe = makeRecipe({
	    name = "capsule-turret",
	    icon = "__RampantArsenal__/graphics/icons/capsuleTurret.png",
	    enabled = false,
	    ingredients = {
		{"steel-plate", 10},
		{"engine-unit", 5},
		{"advanced-circuit", 15},
		{"explosives", 30}
	    },
	    result = capsuleTurretItem,
    })

    addEffectToTech("combat-robotics",
		    {
			type = "unlock-recipe",
			recipe = defenderCapsuleRecipe,
    })

    addEffectToTech("combat-robotics-2",
		    {
			type = "unlock-recipe",
			recipe = distractorCapsuleRecipe,
    })

    addEffectToTech("combat-robotics-3",
		    {
			type = "unlock-recipe",
			recipe = destroyerCapsuleRecipe,
    })

    addEffectToTech("land-mine",
		    {
			type = "unlock-recipe",
			recipe = landmineCapsuleRecipe,
    })

    addEffectToTech("incendiary-landmine",
		    {
			type = "unlock-recipe",
			recipe = incendiaryLandmineCapsuleRecipe,
    })

    addEffectToTech("he-landmine",
		    {
			type = "unlock-recipe",
			recipe = heLandmineCapsuleRecipe,
    })

    addEffectToTech("bio-landmine",
		    {
			type = "unlock-recipe",
			recipe = bioLandmineCapsuleRecipe,
    })

    addEffectToTech("military-4",
		    {
			type = "unlock-recipe",
			recipe = clusterGrenadeCapsuleRecipe,
    })

    addEffectToTech("uranium-ammo",
		    {
			type = "unlock-recipe",
			recipe = nuclearLandmineCapsuleRecipe,
    })

    addEffectToTech("military-2",
		    {
			type = "unlock-recipe",
			recipe = grenadeCapsuleRecipe,
    })

    addEffectToTech("bio-grenades",
		    {
			type = "unlock-recipe",
			recipe = bioGrenadeCapsuleRecipe,
    })

    addEffectToTech("regeneration",
		    {
			type = "unlock-recipe",
			recipe = repairCapsuleRecipe,
    })

    addEffectToTech("bio-capsules",
		    {
			type = "unlock-recipe",
			recipe = toxicCapsuleRecipe,
    })

    addEffectToTech("paralysis",
		    {
			type = "unlock-recipe",
			recipe = paralysisCapsuleRecipe,
    })

    addEffectToTech("he-grenades",
		    {
			type = "unlock-recipe",
			recipe = heGrenadeCapsuleRecipe,
    })

    addEffectToTech("incendiary-grenades",
		    {
			type = "unlock-recipe",
			recipe = incendiaryGrenadeCapsuleRecipe,
    })

    addEffectToTech("capsule-turret",
		    {
			{
			    type = "unlock-recipe",
			    recipe = capsuleTurretRecipe,
			},
			{
			    type = "unlock-recipe",
			    recipe = slowCapsuleRecipe,
			},
			{
			    type = "unlock-recipe",
			    recipe = poisonCapsuleRecipe,
			}
    })

    addEffectToTech("capsule-turret-damage-1",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.1
    })

    addEffectToTech("capsule-turret-damage-2",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.1
    })

    addEffectToTech("capsule-turret-damage-3",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.2
    })

    addEffectToTech("capsule-turret-damage-4",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.3
    })

    addEffectToTech("capsule-turret-damage-5",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.3
    })

    addEffectToTech("capsule-turret-damage-6",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.4
    })

    addEffectToTech("capsule-turret-damage-7",
		    {
			type = "turret-attack",
			turret_id = capsuleTurret,
			modifier = 0.2
    })

    addEffectToTech("stronger-explosives-1",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.2
    })

    addEffectToTech("stronger-explosives-2",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.2
    })

    addEffectToTech("stronger-explosives-3",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.3
    })

    addEffectToTech("stronger-explosives-4",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.3
    })

    addEffectToTech("stronger-explosives-5",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.4
    })

    addEffectToTech("stronger-explosives-6",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.2
    })

    addEffectToTech("stronger-explosives-7",
		    {
			type = "ammo-damage",
			ammo_category = "capsule-launcher",
			modifier = 0.2
    })


end

return capsules
