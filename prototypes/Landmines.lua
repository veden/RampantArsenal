local landmines = {}

local sounds = require("__base__.prototypes.entity.sounds")

local landmineUtils = require("utils/LandmineUtils")
local technologyUtils = require("utils/TechnologyUtils")
local recipeUtils = require("utils/RecipeUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeLandmine = landmineUtils.makeLandmine

function landmines.enable()

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        local nuclearLandmine = makeLandmine(
            {
                name = "nuclear",
                icon = "__RampantArsenal__/graphics/icons/nuclear-landmine.png",
                tint = {r=0.70,g=0.9,b=0.70,a=1},
                triggerRadius = 5,
                stackSize = 100,
                order="f[land-mine]-c[nuclear]"
            },
            {
                {
                    type = "area",
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 1000,
                    radius = 7,
                    force = "not-same",
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-ground-zero-projectile",
                            starting_speed = 0.6 * 0.8,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 1000,
                    radius = 35,
                    force = "not-same",
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave",
                            starting_speed = 0.5 * 0.7,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    show_in_tooltip = false,
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 1000,
                    radius = 26,
                    force = "not-same",
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                            starting_speed = 0.5 * 0.7,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    show_in_tooltip = false,
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 700,
                    force = "not-same",
                    radius = 4,
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    show_in_tooltip = false,
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 1000,
                    force = "not-same",
                    radius = 8,
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    show_in_tooltip = false,
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 300,
                    force = "not-same",
                    radius = 26,
                    action_delivery =
                        {
                            type = "projectile",
                            projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                            starting_speed = 0.5 * 0.65,
                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                        }
                },
                {
                    type = "area",
                    show_in_tooltip = false,
                    target_entities = false,
                    trigger_from_target = false,
                    repeat_count = 10,
                    radius = 8,
                    force = "not-same",
                    action_delivery =
                        {
                            type = "instant",
                            target_effects =
                                {
                                    {
                                        type = "create-entity",
                                        entity_name = "nuclear-smouldering-smoke-source",
                                        tile_collision_mask = { "water-tile" }
                                    }
                                }
                        }
                },
                {
                    type = "direct",
                    action_delivery =
                        {
                            type = "instant",
                            source_effects =
                                {
                                    {
                                        type = "set-tile",
                                        tile_name = "nuclear-ground",
                                        radius = 12,
                                        apply_projection = true,
                                        tile_collision_mask = { "water-tile" },
                                    },
                                    {
                                        type = "destroy-cliffs",
                                        radius = 9,
                                        explosion = "explosion"
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "nuke-explosion"
                                    },
                                    {
                                        type = "camera-effect",
                                        effect = "screen-burn",
                                        duration = 60,
                                        ease_in_duration = 5,
                                        ease_out_duration = 60,
                                        delay = 0,
                                        strength = 6,
                                        full_strength_max_distance = 200,
                                        max_distance = 800
                                    },
                                    {
                                        type = "play-sound",
                                        sound = sounds.nuclear_explosion(0.9),
                                        play_on_target_position = false,
                                        -- min_distance = 200,
                                        max_distance = 1000,
                                        -- volume_modifier = 1,
                                        audible_distance_modifier = 3
                                    },
                                    {
                                        type = "play-sound",
                                        sound = sounds.nuclear_explosion_aftershock(0.4),
                                        play_on_target_position = false,
                                        -- min_distance = 200,
                                        max_distance = 1000,
                                        -- volume_modifier = 1,
                                        audible_distance_modifier = 3
                                    },
                                    {
                                        type = "damage",
                                        damage = {amount = 400, type = "explosion"}
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "huge-scorchmark",
                                        check_buildability = true,
                                    },
                                    {
                                        type = "invoke-tile-trigger",
                                        repeat_count = 1,
                                    },
                                    {
                                        type = "destroy-decoratives",
                                        include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                                        include_decals = true,
                                        invoke_decorative_trigger = true,
                                        decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                                        radius = 14 -- large radius for demostrative purposes
                                    },
                                    {
                                        type = "create-decorative",
                                        decorative = "nuclear-ground-patch",
                                        spawn_min_radius = 11.5,
                                        spawn_max_radius = 12.5,
                                        spawn_min = 30,
                                        spawn_max = 40,
                                        apply_projection = true,
                                        spread_evenly = true
                                    }
                                }
                        }
                }
            }
        )

        local incendiaryLandmine = makeLandmine(
            {
                name = "incendiary",
                icon = "__RampantArsenal__/graphics/icons/incendiary-landmine.png",
                tint = {r=0.9,g=0.70,b=0.70,a=1},
                triggerRadius = 2.5,
                stackSize = 100,
                resistances = {
                    {
                        type = "fire",
                        percent = 100
                    }
                },
                order="f[land-mine]-b[incendiary]"
            },
            {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",
                        source_effects = {
                            {
                                type = "create-entity",
                                entity_name = "big-explosion"
                            },
                            {
                                type = "damage",
                                damage = { amount = 500, type = "explosion"}
                            },
                            {
                                type = "damage",
                                damage = { amount = 750, type = "fire"}
                            },
                            {
                                type = "invoke-tile-trigger",
                                repeat_count = 1,
                            },
                            {
                                type = "destroy-decoratives",
                                from_render_layer = "decorative",
                                to_render_layer = "object",
                                include_soft_decoratives = true,
                                include_decals = false,
                                invoke_decorative_trigger = true,
                                decoratives_with_trigger_only = false,
                                radius = 3
                            },
                            {
                                type = "nested-result",
                                affects_target = true,
                                action =
                                    {
                                        {
                                            type = "area",
                                            radius = 6,
                                            force = "not-same",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-sticker",
                                                                sticker = "small-fire-sticker-rampant-arsenal"
                                                            },
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 500, type = "fire" },
                                                                apply_damage_to_trees = false
                                                            },
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "fire-flame",
                                                                initial_ground_flame_count = 7,
                                                                check_buildability = true
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 22,
                                            distance = 4,
                                            distance_deviation = 3,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "fire-flame",
                                                                initial_ground_flame_count = 7,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                    }}
                            }
                        }
                    }
            }
        )

        local bioLandmine = makeLandmine(
            {
                name = "bio",
                icon = "__RampantArsenal__/graphics/icons/bio-landmine.png",
                tint = {r=0.9,g=0.60,b=0.9,a=1},
                triggerRadius = 2.5,
                stackSize = 100,
                order="f[land-mine]-c[bio]"
            },
            {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",
                        source_effects = {
                            {
                                type = "create-entity",
                                entity_name = "big-explosion"
                            },
                            {
                                type = "damage",
                                damage = { amount = 500, type = "explosion"}
                            },
                            {
                                type = "damage",
                                damage = { amount = 750, type = "poison"}
                            },
                            {
                                type = "create-entity",
                                entity_name = "toxic-cloud-rampant-arsenal",
                                show_in_tooltip = true
                            },
                            {
                                type = "invoke-tile-trigger",
                                repeat_count = 1,
                            },
                            {
                                type = "destroy-decoratives",
                                from_render_layer = "decorative",
                                to_render_layer = "object",
                                include_soft_decoratives = true,
                                include_decals = false,
                                invoke_decorative_trigger = true,
                                decoratives_with_trigger_only = false,
                                radius = 2
                            },
                            {
                                type = "nested-result",
                                affects_target = true,
                                action =
                                    {
                                        {
                                            type = "area",
                                            radius = 6,
                                            force = "not-same",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 450, type = "poison" }
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                        }
                    }
            }
        )

        local heLandmine = makeLandmine(
            {
                name = "he",
                icon = "__RampantArsenal__/graphics/icons/he-landmine.png",
                tint = {r=0.70,g=0.70,b=0.9,a=1},
                triggerRadius = 2.5,
                stackSize = 100,
                order="f[land-mine]-c[bio]"
            },
            {
                type = "direct",
                action_delivery =
                    {
                        type = "instant",
                        source_effects = {
                            {
                                type = "create-entity",
                                entity_name = "big-artillery-explosion"
                            },
                            {
                                type = "damage",
                                damage = { amount = 4500, type = "explosion"}
                            },
                            {
                                type = "invoke-tile-trigger",
                                repeat_count = 1,
                            },
                            {
                                type = "destroy-decoratives",
                                from_render_layer = "decorative",
                                to_render_layer = "object",
                                include_soft_decoratives = true,
                                include_decals = false,
                                invoke_decorative_trigger = true,
                                decoratives_with_trigger_only = false,
                                radius = 3
                            },
                            {
                                type = "nested-result",
                                affects_target = true,
                                action =
                                    {
                                        {
                                            type = "area",
                                            radius = 6,
                                            force = "not-same",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "push-back",
                                                                distance = 2.5
                                                            },
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 2000, type = "explosion" }
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                        }
                    }
            }
        )

        makeRecipe({
                name = nuclearLandmine,
                icon = "__RampantArsenal__/graphics/icons/nuclear-landmine.png",
                enabled = false,
                ingredients = {
                    {"land-mine", 1},
                    {"atomic-bomb", 1}
                },
                result = nuclearLandmine
        })

        makeRecipe({
                name = incendiaryLandmine,
                icon = "__RampantArsenal__/graphics/icons/incendiary-landmine.png",
                enabled = false,
                category = "chemistry",
                ingredients = {
                    {"land-mine", 1},
                    {"steel-plate", 1},
                    {type="fluid", name="light-oil", amount=40}
                },
                result = incendiaryLandmine
        })


        makeRecipe({
                name = heLandmine,
                icon = "__RampantArsenal__/graphics/icons/he-landmine.png",
                enabled = false,
                category = "chemistry",
                ingredients = {
                    {"land-mine", 1},
                    {"steel-plate", 1},
                    {"explosives", 4}
                },
                result = heLandmine
        })


        makeRecipe({
                name = bioLandmine,
                icon = "__RampantArsenal__/graphics/icons/bio-landmine.png",
                enabled = false,
                category = "chemistry",
                ingredients = {
                    {"land-mine", 1},
                    {"steel-plate", 1},
                    {"poison-capsule", 2}
                },
                result = bioLandmine
        })

        local landmine = data.raw["land-mine"]["land-mine"]

        landmine.action = {
            type = "direct",
            action_delivery =
                {
                    type = "instant",
                    source_effects =
                        {
                            {
                                type = "nested-result",
                                affects_target = true,
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery = {
                                                type = "instant",
                                                target_effects = {
                                                    {
                                                        type = "invoke-tile-trigger",
                                                        repeat_count = 1,
                                                    },
                                                    {
                                                        type = "destroy-decoratives",
                                                        from_render_layer = "decorative",
                                                        to_render_layer = "object",
                                                        include_soft_decoratives = true,
                                                        include_decals = false,
                                                        invoke_decorative_trigger = true,
                                                        decoratives_with_trigger_only = false,
                                                        radius = 3
                                                    }
                                                }
                                            }
                                        },
                                        {
                                            type = "area",
                                            radius = 6,
                                            force = "not-same",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 250, type = "explosion"}
                                                            },
                                                            {
                                                                type = "create-sticker",
                                                                sticker = "lite-slow-sticker-rampant-arsenal"
                                                            }
                                                        }
                                                }
                                    }}
                            },
                            {
                                type = "create-entity",
                                entity_name = "explosion"
                            },
                            {
                                type = "damage",
                                damage = { amount = 1000, type = "explosion"}
                            }
                        }
                }
        }

        addEffectToTech("uranium-ammo",
                        {
                            type = "unlock-recipe",
                            recipe = nuclearLandmine,
        })

        addEffectToTech("incendiary-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryLandmine,
        })

        addEffectToTech("he-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = heLandmine,
        })

        addEffectToTech("bio-landmine",
                        {
                            type = "unlock-recipe",
                            recipe = bioLandmine,
        })

    end

    landmine = table.deepcopy(data.raw["land-mine"]["land-mine"])
    -- local landmineRecipe = table.deepcopy(data.raw["recipe"]["land-mine"])
    local landmineItem = table.deepcopy(data.raw["item"]["land-mine"])

    landmineItem.hidden = true
    landmineItem.name = "landmine-ghostless-rampant-arsenal"
    landmineItem.place_result = "landmine-ghostless-rampant-arsenal"

    landmine.name = "landmine-ghostless-rampant-arsenal"
    landmine.create_ghost_on_death = false
    landmine.flags[#landmine.flags+1] = "hidden"

    data:extend({
            landmine,
            landmineItem
    })

end

return landmines
