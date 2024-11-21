-- Copyright (C) 2022  veden

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.


local artillery = {}

local sounds = require("__base__.prototypes.entity.sounds")

local scaleUtils = require("utils/ScaleUtils")
local recipeUtils = require("utils/RecipeUtils")
local technologyUtils = require("utils/TechnologyUtils")
local projectileUtils = require("utils/ProjectileUtils")
local ammoUtils = require("utils/AmmoUtils")

local makeAmmo = ammoUtils.makeAmmo
local addEffectToTech = technologyUtils.addEffectToTech
local makeArtilleryShell = projectileUtils.makeArtilleryShell
local makeRecipe = recipeUtils.makeRecipe
local scaleBoundingBox = scaleUtils.scaleBoundingBox
local scalePicture = scaleUtils.scalePicture
local makeInvisibleProjectile = projectileUtils.makeInvisibleProjectile

function artillery.enable()

    local liteArtillery = table.deepcopy(data.raw["artillery-turret"]["artillery-turret"])
    liteArtillery.name = "lite-artillery-turret-rampant-arsenal"
    liteArtillery.max_health = 1000
    liteArtillery.minable.result = "lite-artillery-turret-rampant-arsenal"
    liteArtillery.rotating_sound.sound.volume = 0.4
    liteArtillery.collision_box = scaleBoundingBox(0.65, liteArtillery.collision_box)
    liteArtillery.selection_box = scaleBoundingBox(0.65, liteArtillery.selection_box)
    liteArtillery.drawing_box_vertical_extension = 0.65 * liteArtillery.drawing_box_vertical_extension
    liteArtillery.cannon_base_shift[1] = 0
    liteArtillery.cannon_base_shift[2] = 0
    liteArtillery.manual_range_modifier = 1.25
    liteArtillery.gun = "lite-artillery-turret-gun-rampant-arsenal"
    scalePicture(0.35, liteArtillery.base_picture, 0.35)
    scalePicture(0.35, liteArtillery.cannon_barrel_pictures, 0.74)
    scalePicture(0.35, liteArtillery.cannon_base_pictures, 0.75)


    local liteArtilleryItem = table.deepcopy(data.raw["item"]["artillery-turret"])
    liteArtilleryItem.name = "lite-artillery-turret-rampant-arsenal"
    liteArtilleryItem.place_result = "lite-artillery-turret-rampant-arsenal"
    liteArtilleryItem.icons = {
        {icon = "__base__/graphics/icons/artillery-turret.png", icon_size = 64, icon_mipmaps = 4, tint = { 0.5, 0.9, 0.5, 1 }}
    }

    local liteArtilleryRecipe = table.deepcopy(data.raw["recipe"]["artillery-turret"])
    liteArtilleryRecipe.name = "lite-artillery-turret-rampant-arsenal"
    liteArtilleryRecipe.results = {{type="item", name="lite-artillery-turret-rampant-arsenal", amount=1}}
    liteArtilleryRecipe.enabled = false
    liteArtilleryRecipe.energy_required = 30
    liteArtilleryRecipe.order = "b[turret]-d[aremote]"
    liteArtilleryRecipe.ingredients = {
        {type="item", name="steel-plate", amount=30},
        {type="item", name="concrete", amount=30},
        {type="item", name="iron-gear-wheel", amount=20},
        {type="item", name="advanced-circuit", amount=10},
    }

    local liteArtilleryGun = table.deepcopy(data.raw["gun"]["artillery-wagon-cannon"])
    liteArtilleryGun.name = "lite-artillery-turret-gun-rampant-arsenal"
    liteArtilleryGun.attack_parameters.ammoCategory = "artillery-shell"
    liteArtilleryGun.attack_parameters.range = 90
    liteArtilleryGun.attack_parameters.cooldown = 350
    liteArtilleryGun.attack_parameters.damage_modifier = 0.75
    if liteArtilleryGun.attack_parameters.sound[1] then
        liteArtilleryGun.attack_parameters.sound[1].volume = 0.5
    end
    liteArtilleryGun.attack_parameters.shell_particle.scale = 0.75

    data:extend({liteArtilleryGun, liteArtillery, liteArtilleryItem, liteArtilleryRecipe})

    addEffectToTech("lite-artillery",
                    {
                        type = "unlock-recipe",
                        recipe = liteArtillery.name,
    })

    data.raw["shortcut"]["give-artillery-targeting-remote"].technology_to_unlock = "rampant-arsenal-technology-lite-artillery"

    local incendiaryArtilleryShellAmmo = makeAmmo({
            name = "incendiary-artillery",
            icon = "__RampantArsenal__/graphics/icons/incendiary-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[incendiary]",
            magSize = 1,
            stackSize = 1,
            ammoCategory = "artillery-shell",
            ammoType = {
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "incendiary"
                                    },
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                repeat_count = 100,
                                                                type = "create-trivial-smoke",
                                                                smoke_name = "nuclear-smoke",
                                                                offset_deviation = {{-1, -1}, {1, 1}},
                                                                slow_down_factor = 1,
                                                                starting_frame = 3,
                                                                starting_frame_deviation = 5,
                                                                starting_frame_speed = 0,
                                                                starting_frame_speed_deviation = 5,
                                                                speed_from_center = 0.5,
                                                                speed_deviation = 0.2
                                                            },
                                                            {
                                                                type = "show-explosion-on-chart",
                                                                scale = 8/32,
                                                            },
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "big-artillery-explosion"
                                                            },
                                                            {
                                                                type = "damage",
                                                                damage = {amount = 600, type = "fire"}
                                                            },
                                                            {
                                                                type = "create-entity",
                                                                entity_name = "big-scorchmark",
                                                                check_buildability = true
                                                            },
                                                            {
                                                                type = "create-smoke",
                                                                entity_name = "massive-fire-cloud-rampant-arsenal"
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 28,
                                            distance = 12,
                                            distance_deviation = 3,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "massive-fire-rampant-arsenal",
                                                                initial_ground_flame_count = 4,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 20,
                                            distance = 6,
                                            distance_deviation = 3,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "massive-fire-rampant-arsenal",
                                                                initial_ground_flame_count = 6,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 10,
                                            distance = 3,
                                            distance_deviation = 2,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "massive-fire-rampant-arsenal",
                                                                initial_ground_flame_count = 6,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 6,
                                            distance = 1,
                                            distance_deviation = 0.5,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "massive-fire-rampant-arsenal",
                                                                initial_ground_flame_count = 8,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                        },
                                        {
                                            type = "cluster",
                                            cluster_count = 36,
                                            distance = 16,
                                            distance_deviation = 6,
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "create-fire",
                                                                entity_name = "massive-fire-rampant-arsenal",
                                                                initial_ground_flame_count = 2,
                                                                check_buildability = true,
                                                                show_in_tooltip = true
                                                            }
                                                        }
                                                }
                                        }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }
    })

    makeRecipe({
            name = incendiaryArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/incendiary-artillery-shell.png",
            enabled = false,
            category = "crafting-with-fluid",
            ingredients = {
                {type="item", name="artillery-shell", amount=1},
                {type="fluid", name="napalm-fluid-rampant-arsenal", amount=400}
            },
            results = {{type = "item", name = incendiaryArtilleryShellAmmo, amount = 1}},
    })

    addEffectToTech("incendiary-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = incendiaryArtilleryShellAmmo,
    })

    local heArtilleryShellAmmo = makeAmmo({
            name = "he-artillery",
            icon = "__RampantArsenal__/graphics/icons/he-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[he]",
            magSize = 1,
            stackSize = 1,
            ammoCategory = "artillery-shell",
            ammoType = {
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "he"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    radius = 10,
                                                                    action_delivery =
                                                                        {
                                                                            type = "instant",
                                                                            target_effects =
                                                                                {
                                                                                    {
                                                                                        type = "damage",
                                                                                        damage = {amount = 500 , type = "physical"}
                                                                                    },
                                                                                    {
                                                                                        type = "damage",
                                                                                        damage = {amount = 3250 , type = "explosion"}
                                                                                    },
                                                                                    {
                                                                                        type = "create-entity",
                                                                                        entity_name = "big-artillery-explosion"
                                                                                    }
                                                                                }
                                                                        }
                                                                }
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
                                                            radius = 6
                                                        },
                                                        {
                                                            type = "create-trivial-smoke",
                                                            smoke_name = "artillery-smoke",
                                                            initial_height = 0,
                                                            speed_from_center = 0.05,
                                                            speed_from_center_deviation = 0.005,
                                                            offset_deviation = {{-4, -4}, {4, 4}},
                                                            max_radius = 3.5,
                                                            repeat_count = 4 * 4 * 15
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-artillery-explosion"
                                                        },
                                                        {
                                                            type = "show-explosion-on-chart",
                                                            scale = 8/32,
                                                        }
                                                    }
                                            }
                                    }
                                ),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    }
                            }
                    },
            }
    })

    makeRecipe({
            name = heArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/he-artillery-shell.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="artillery-shell", amount=1},
                {type="item", name="cluster-grenade", amount=3}
            },
            results = {{type = "item", name = heArtilleryShellAmmo, amount = 1}},
    })

    addEffectToTech("he-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = heArtilleryShellAmmo,
    })

    local bioArtilleryShellAmmo = makeAmmo({
            name = "bio-artillery",
            icon = "__RampantArsenal__/graphics/icons/bio-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[bio]",
            magSize = 1,
            stackSize = 1,

            ammoCategory = "artillery-shell",
            ammoType = {
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "bio"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            repeat_count = 100,
                                                            type = "create-trivial-smoke",
                                                            smoke_name = "nuclear-smoke",
                                                            offset_deviation = {{-1, -1}, {1, 1}},
                                                            slow_down_factor = 1,
                                                            starting_frame = 3,
                                                            starting_frame_deviation = 5,
                                                            starting_frame_speed = 0,
                                                            starting_frame_speed_deviation = 5,
                                                            speed_from_center = 0.5,
                                                            speed_deviation = 0.2
                                                        },
                                                        {
                                                            type = "show-explosion-on-chart",
                                                            scale = 8/32,
                                                        },
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "big-artillery-explosion"
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 300,
                                                                    radius = 12,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = makeInvisibleProjectile({
                                                                                    name = "bio",
                                                                                    action = {
                                                                                        {
                                                                                            type = "area",
                                                                                            radius = 3,
                                                                                            entity_flags = { "breaths-air" },
                                                                                            ignore_collision_condition = true,
                                                                                            action_delivery =
                                                                                                {
                                                                                                    type = "instant",
                                                                                                    target_effects = {
                                                                                                        {
                                                                                                            type = "damage",
                                                                                                            lower_distance_threshold = 0,
                                                                                                            upper_distance_threshold = 12,
                                                                                                            lower_damage_modifier = 1,
                                                                                                            upper_damage_modifier = 0.1,
                                                                                                            damage = {amount = 400, type = "poison"}
                                                                                                        },
                                                                                                        {
                                                                                                            type = "create-sticker",
                                                                                                            sticker = "big-toxic-sticker-rampant-arsenal",
                                                                                                            show_in_tooltip = true
                                                                                                        }
                                                                                                    }
                                                                                                }
                                                                                        }
                                                                                    }
                                                                            }),
                                                                            show_in_tooltip = true,
                                                                            starting_speed = 0.15,
                                                                            starting_speed_deviation = 0.02
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "create-smoke",
                                                            entity_name = "big-toxic-cloud-rampant-arsenal",
                                                            show_in_tooltip = false
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
                                                    }
                                            }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }
    })

    makeRecipe({
            name = bioArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/bio-artillery-shell.png",
            enabled = false,
            category = "crafting",
            magSize = 1,
            stackSize = 1,
            ingredients = {
                {type="item", name="artillery-shell", amount=1},
                {type="item", name="toxic-capsule-rampant-arsenal", amount=5}
            },
            results = {{type = "item", name = bioArtilleryShellAmmo, amount = 1}},
    })

    addEffectToTech("bio-artillery-shells",
                    {
                        type = "unlock-recipe",
                        recipe = bioArtilleryShellAmmo,
    })


    local nuclearArtilleryShellAmmo = makeAmmo({
            name = "nuclear-artillery",
            icon = "__RampantArsenal__/graphics/icons/nuclear-artillery-shell.png",
            order = "d[explosive-cannon-shell]-d[nuclear]",
            magSize = 1,
            stackSize = 1,
            ammoCategory = "artillery-shell",
            ammoType = {
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "artillery",
                                projectile = makeArtilleryShell(
                                    {
                                        name = "nuclear"
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "set-tile",
                                                            tile_name = "nuclear-ground",
                                                            radius = 12,
                                                            apply_projection = true,
                                                            tile_collision_mask = { layers={water_tile=true} },
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
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 7,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-ground-zero-projectile",
                                                                            starting_speed = 0.6 * 0.8,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 35,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave",
                                                                            starting_speed = 0.5 * 0.7,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 26,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                                                                            starting_speed = 0.5 * 0.7,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 700,
                                                                    radius = 4,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 1000,
                                                                    radius = 8,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 300,
                                                                    radius = 26,
                                                                    action_delivery =
                                                                        {
                                                                            type = "projectile",
                                                                            projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                                                                            starting_speed = 0.5 * 0.65,
                                                                            starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                                                        }
                                                                }
                                                        },
                                                        {
                                                            type = "nested-result",
                                                            action =
                                                                {
                                                                    type = "area",
                                                                    show_in_tooltip = false,
                                                                    target_entities = false,
                                                                    trigger_from_target = true,
                                                                    repeat_count = 10,
                                                                    radius = 8,
                                                                    action_delivery =
                                                                        {
                                                                            type = "instant",
                                                                            target_effects =
                                                                                {
                                                                                    {
                                                                                        type = "create-entity",
                                                                                        entity_name = "nuclear-smouldering-smoke-source",
                                                                                        tile_collision_mask = { layers={water_tile=true} }
                                                                                    }
                                                                                }
                                                                        }
                                                                }
                                                        }
                                                    }
                                            }
                                }),
                                starting_speed = 1,
                                direction_deviation = 0,
                                range_deviation = 0,
                                source_effects =
                                    {
                                        type = "create-explosion",
                                        entity_name = "artillery-cannon-muzzle-flash"
                                    },
                            }
                    },
            }
    })

    makeRecipe({
            name = nuclearArtilleryShellAmmo,
            icon = "__RampantArsenal__/graphics/icons/nuclear-artillery-shell.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="artillery-shell", amount=1},
                {type="item", name="atomic-bomb", amount=1}
            },
            results = {{type = "item", name = nuclearArtilleryShellAmmo, amount = 1}},
    })

    addEffectToTech("atomic-bomb",
                    {
                        type = "unlock-recipe",
                        recipe = nuclearArtilleryShellAmmo,
    })
end

return artillery
