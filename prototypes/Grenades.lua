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


local grenades = {}

local technologyUtils = require("utils/TechnologyUtils")
local recipeUtils = require("utils/RecipeUtils")
local capsuleUtils = require("utils/CapsuleUtils")
local projectileUtils = require("utils/ProjectileUtils")

local makeRecipe = recipeUtils.makeRecipe
local addEffectToTech = technologyUtils.addEffectToTech
local makeGrenadeProjectile = projectileUtils.makeGrenadeProjectile
local makeCapsuleProjectile = projectileUtils.makeCapsuleProjectile
local makeCapsule = capsuleUtils.makeCapsule

local sounds = require ("__base__.prototypes.entity.sounds")

function grenades.enable()

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        local incendiaryGrenade = makeCapsule(
            {
                name = "incendiary-grenade",
                icon = "__RampantArsenal__/graphics/icons/incendiary-grenade.png",
                order = "a[grenade]-a[nzincendiary]"
            },
            {
                type = "throw",
                attack_parameters =
                    {
                        type = "projectile",
                        activation_type = "throw",
                        ammo_category = "grenade",
                        cooldown = 30,
                        projectile_creation_distance = 0.6,
                        range = 20,
                        ammo_type =
                            {
                                category = "grenade",
                                target_type = "position",
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "projectile",
                                                    projectile = makeGrenadeProjectile(
                                                        {
                                                            name = "incendiary",
                                                            tint = {r=0.5,g=0.3,b=0,a=0.8}
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
                                                                                }
                                                                            }
                                                                    }
                                                            },
                                                            {
                                                                type = "cluster",
                                                                cluster_count = 7,
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
                                                                                    initial_ground_flame_count = 4,
                                                                                    check_buildability = true,
                                                                                    show_in_tooltip = true
                                                                                }
                                                                            }
                                                                    }
                                                            },
                                                            {
                                                                type = "area",
                                                                radius = 6.5,
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
                                                                                    damage = {amount = 150, type = "fire"}
                                                                                },
                                                                                {
                                                                                    type = "create-fire",
                                                                                    entity_name = "fire-flame",
                                                                                    initial_ground_flame_count = 4
                                                                                },
                                                                                {
                                                                                    type = "create-sticker",
                                                                                    sticker = "small-fire-sticker-rampant-arsenal"
                                                                                }
                                                                            }
                                                                    }
                                                            }
                                                    }),
                                                    starting_speed = 0.3
                                                }
                                        },
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "play-sound",
                                                                sound = sounds.throw_projectile
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                    }
        })

        makeRecipe({
                name = incendiaryGrenade,
                icon = "__RampantArsenal__/graphics/icons/incendiary-grenade.png",
                enabled = false,
                category = "crafting-with-fluid",
                ingredients = {
                    {type="item", name="grenade", amount=1},
                    {type="item", name="copper-plate", amount=1},
                    {type="fluid", name="light-oil", amount=40}
                },
                results = {{type="item", name=incendiaryGrenade, amount=1}}
        })

        addEffectToTech("incendiary-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = incendiaryGrenade,
        })


        local heGrenade = makeCapsule(
            {
                name = "he-grenade",
                icon = "__RampantArsenal__/graphics/icons/he-grenade.png",
                order = "a[grenade]-a[nzhe]"
            },
            {
                type = "throw",
                attack_parameters =
                    {
                        type = "projectile",
                        activation_type = "throw",
                        ammo_category = "grenade",
                        cooldown = 30,
                        projectile_creation_distance = 0.6,
                        range = 20,
                        ammo_type =
                            {
                                category = "grenade",
                                target_type = "position",
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "projectile",
                                                    projectile = makeGrenadeProjectile(
                                                        {
                                                            name = "he",
                                                            tint = {r=0,g=0,b=0.8,a=0.8}
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
                                                                                    type = "create-entity",
                                                                                    entity_name = "big-explosion"
                                                                                },
                                                                                {
                                                                                    type = "create-entity",
                                                                                    entity_name = "small-scorchmark",
                                                                                    check_buildability = true
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
                                                                                    radius = 4
                                                                                }
                                                                            }
                                                                    }
                                                            },
                                                            {
                                                                type = "area",
                                                                radius = 6.5,
                                                                action_delivery =
                                                                    {
                                                                        type = "instant",
                                                                        target_effects =
                                                                            {
                                                                                {
                                                                                    type = "damage",
                                                                                    damage = {amount = 550, type = "explosion"}
                                                                                },
                                                                                {
                                                                                    type = "push-back",
                                                                                    distance = 1
                                                                                },
                                                                                {
                                                                                    type = "create-entity",
                                                                                    entity_name = "medium-explosion"
                                                                                }
                                                                            }
                                                                    }
                                                            }
                                                    }),
                                                    starting_speed = 0.3
                                                }
                                        },
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "play-sound",
                                                                sound = sounds.throw_projectile
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                    }
        })

        makeRecipe({
                name = heGrenade,
                icon = "__RampantArsenal__/graphics/icons/he-grenade.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="grenade", amount=1},
                    {type="item", name="copper-plate", amount=1},
                    {type="item", name="explosives", amount=4}
                },
                results = {{type="item", name=heGrenade, amount=1}}
        })

        addEffectToTech("he-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = heGrenade,
        })

        local bioGrenade = makeCapsule(
            {
                name = "bio-grenade",
                icon = "__RampantArsenal__/graphics/icons/bio-grenade.png",
                order = "a[grenade]-a[nzfbio]"
            },
            {
                type = "throw",
                attack_parameters =
                    {
                        type = "projectile",
                        activation_type = "throw",
                        ammo_category = "grenade",
                        cooldown = 30,
                        projectile_creation_distance = 0.6,
                        range = 20,
                        ammo_type =
                            {
                                category = "grenade",
                                target_type = "position",
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "projectile",
                                                    projectile = makeGrenadeProjectile(
                                                        {
                                                            name = "bio",
                                                            tint = {r=0.5,g=0,b=0.5,a=0.8}
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
                                                                                    type = "create-entity",
                                                                                    entity_name = "medium-explosion"
                                                                                },
                                                                                {
                                                                                    type = "create-entity",
                                                                                    entity_name = "small-scorchmark",
                                                                                    check_buildability = true
                                                                                },
                                                                                {
                                                                                    type = "create-entity",
                                                                                    entity_name = "small-toxic-cloud-rampant-arsenal",
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
                                                                                    radius = 3
                                                                                }
                                                                            }
                                                                    }
                                                            },
                                                            {
                                                                type = "area",
                                                                radius = 6.5,
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
                                                                                    damage = {amount = 175, type = "poison"}
                                                                                }
                                                                            }
                                                                    }
                                                            }
                                                    }),
                                                    starting_speed = 0.3
                                                }
                                        },
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "play-sound",
                                                                sound = sounds.throw_projectile
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                    }
        })

        makeRecipe({
                name = bioGrenade,
                icon = "__RampantArsenal__/graphics/icons/bio-grenade.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="grenade", amount=1},
                    {type="item", name="copper-plate", amount=1},
                    {type="item", name="poison-capsule", amount=1}
                },
                results = {{type="item", name=bioGrenade, amount=1}}
        })

        addEffectToTech("bio-grenades",
                        {
                            type = "unlock-recipe",
                            recipe = bioGrenade,
        })

        local toxicCapsule = makeCapsule(
            {
                name = "toxic",
                icon = "__RampantArsenal__/graphics/icons/toxic-capsule.png",
                order = "b[poison-capsule]-a[toxic]"
            },
            {
                type = "throw",
                attack_parameters =
                    {
                        type = "projectile",
                        activation_type = "throw",
                        ammo_category = "capsule",
                        cooldown = 30,
                        projectile_creation_distance = 0.6,
                        range = 25,
                        ammo_type =
                            {
                                category = "capsule",
                                target_type = "position",
                                action =
                                    {
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "projectile",
                                                    projectile = makeCapsuleProjectile(
                                                        {
                                                            name = "toxic",
                                                            tint = {r=0.5,g=0,b=0.5,a=0.8}
                                                        },
                                                        {
                                                            type = "direct",
                                                            action_delivery =
                                                                {
                                                                    type = "instant",
                                                                    target_effects =
                                                                        {
                                                                            type = "create-entity",
                                                                            show_in_tooltip = true,
                                                                            entity_name = "toxic-cloud-rampant-arsenal"
                                                                        }
                                                                }
                                                        }
                                                    ),
                                                    starting_speed = 0.3
                                                }
                                        },
                                        {
                                            type = "direct",
                                            action_delivery =
                                                {
                                                    type = "instant",
                                                    target_effects =
                                                        {
                                                            {
                                                                type = "play-sound",
                                                                sound = sounds.throw_projectile
                                                            }
                                                        }
                                                }
                                        }
                                    }
                            }
                    }
        })

        makeRecipe({
                name = toxicCapsule,
                icon = "__RampantArsenal__/graphics/icons/toxic-capsule.png",
                enabled = false,
                category = "crafting",
                ingredients = {
                    {type="item", name="poison-capsule", amount=3},
                    {type="item", name="iron-plate", amount=3},
                    {type="item", name="plastic-bar", amount=3}
                },
                results = {{type="item", name=toxicCapsule, amount=1}}
        })

        addEffectToTech("bio-capsules",
                        {
                            type = "unlock-recipe",
                            recipe = toxicCapsule,
        })
    end

    local repairCapsule = makeCapsule(
        {
            name = "repair",
            icon = "__RampantArsenal__/graphics/icons/repair-capsule.png",
            order = "c[slowdown-capsule]-b[repair]"
        },
        {
            type = "throw",
            attack_parameters =
                {
                    type = "projectile",
                    ammo_category = "capsule",
                    activation_type = "throw",
                    cooldown = 30,
                    projectile_creation_distance = 0.6,
                    range = 25,
                    ammo_type =
                        {
                            category = "capsule",
                            target_type = "position",
                            action =
                                {
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = makeCapsuleProjectile(
                                                    {
                                                        name = "repair",
                                                        tint = {r=0.5,g=0.3,b=0,a=0.8},
                                                    },
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        type = "create-entity",
                                                                        show_in_tooltip = true,
                                                                        entity_name = "repair-cloud-rampant-arsenal"
                                                                    }
                                                            }
                                                    }
                                                ),
                                                starting_speed = 0.3
                                            }
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "play-sound",
                                                            sound = sounds.throw_projectile
                                                        }
                                                    }
                                            }
                                    }
                                }
                        }
                }
    })

    makeRecipe({
            name = repairCapsule,
            icon = "__RampantArsenal__/graphics/icons/repair-capsule.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="repair-pack", amount=2},
                {type="item", name="steel-plate", amount=1},
                {type="item", name="plastic-bar", amount=1}
            },
            results = {{type="item", name=repairCapsule, amount=1}}
    })

    addEffectToTech("regeneration",
                    {
                        type = "unlock-recipe",
                        recipe = repairCapsule,
    })

    local paralysisCapsule = makeCapsule(
        {
            name = "paralysis",
            icon = "__RampantArsenal__/graphics/icons/paralysis-capsule.png",
            order = "c[slowdown-capsule]-a[paralysis]"
        },
        {
            type = "throw",
            attack_parameters =
                {
                    type = "projectile",
                    ammo_category = "capsule",
                    activation_type = "throw",
                    cooldown = 30,
                    projectile_creation_distance = 0.6,
                    range = 25,
                    ammo_type =
                        {
                            category = "capsule",
                            target_type = "position",
                            action =
                                {
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = makeCapsuleProjectile(
                                                    {
                                                        name = "paralysis",
                                                        tint = {r=0,g=0,b=0.8,a=0.8}
                                                    },
                                                    {
                                                        type = "direct",
                                                        action_delivery =
                                                            {
                                                                type = "instant",
                                                                target_effects =
                                                                    {
                                                                        type = "create-entity",
                                                                        show_in_tooltip = true,
                                                                        entity_name = "paralysis-cloud-rampant-arsenal"
                                                                    }
                                                            }
                                                    }
                                                ),
                                                starting_speed = 0.3
                                            }
                                    },
                                    {
                                        type = "direct",
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "play-sound",
                                                            sound = sounds.throw_projectile
                                                        }
                                                    }
                                            }
                                    }
                                }
                        }
                }
    })

    makeRecipe({
            name = paralysisCapsule,
            icon = "__RampantArsenal__/graphics/icons/paralysis-capsule.png",
            enabled = false,
            category = "crafting",
            ingredients = {
                {type="item", name="slowdown-capsule", amount=3},
                {type="item", name="iron-plate", amount=3},
                {type="item", name="plastic-bar", amount=3}
            },
            results = {{type="item", name=paralysisCapsule, amount=1}}
    })

    addEffectToTech("paralysis",
                    {
                        type = "unlock-recipe",
                        recipe = paralysisCapsule,
    })

    local healingCapsule = makeCapsule(
        {
            name = "healing",
            icon = "__RampantArsenal__/graphics/icons/healing-capsule.png",
            order = "c[slowdown-capsule]-c[healing]"
        },
        {
            type = "use-on-self",
            attack_parameters =
                {
                    type = "projectile",
                    activation_type = "consume",
                    ammo_category = "grenade",
                    cooldown = 30,
                    range = 0,
                    ammo_type =
                        {
                            category = "capsule",
                            target_type = "position",
                            action =
                                {
                                    type = "direct",
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "damage",
                                                    damage = {type = "healing", amount = -300}
                                                }
                                        }
                                }
                        }
                }
    })

    makeRecipe({
            name = healingCapsule,
            icon = "__RampantArsenal__/graphics/icons/healing-capsule.png",
            enabled = false,
            category = "crafting-with-fluid",
            ingredients = {
                {type="item", name="stone", amount=5},
                {type="item", name="coal", amount=2},
                {type="item", name="wood", amount=1}
            },
            results = {{type="item", name=healingCapsule, amount=1}}
    })

    addEffectToTech("boosters",
                    {
                        type = "unlock-recipe",
                        recipe = healingCapsule,
    })


    local speedCapsule = makeCapsule(
        {
            name = "speed",
            icon = "__RampantArsenal__/graphics/icons/speed-capsule.png",
            order = "c[slowdown-capsule]-d[speed]"
        },
        {
            type = "use-on-self",
            attack_parameters =
                {
                    type = "projectile",
                    activation_type = "consume",
                    ammo_category = "grenade",
                    cooldown = 30,
                    range = 0,
                    ammo_type =
                        {
                            category = "capsule",
                            target_type = "position",
                            action =
                                {
                                    type = "direct",
                                    action_delivery =
                                        {
                                            type = "instant",
                                            target_effects =
                                                {
                                                    type = "create-sticker",
                                                    sticker = "speed-boost-sticker-rampant-arsenal",
                                                    show_in_tooltip = true
                                                }
                                        }
                                }
                        }
                }
    })

    makeRecipe({
            name = speedCapsule,
            icon = "__RampantArsenal__/graphics/icons/speed-capsule.png",
            enabled = false,
            category = "crafting-with-fluid",
            ingredients = {
                {type="item", name="steel-plate", amount=2},
                {type="item", name="electronic-circuit", amount=2}
            },
            results = {{type="item", name=speedCapsule, amount=1}}
    })

    addEffectToTech("boosters",
                    {
                        type = "unlock-recipe",
                        recipe = speedCapsule,
    })

    if settings.startup["rampant-arsenal-enableAmmoTypes"].value then
        data.raw["projectile"]["cluster-grenade"].action[2].action_delivery.projectile = makeGrenadeProjectile(
            {
                name = "cluster"
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
                    radius = 7,
                    action_delivery =
                        {
                            type = "instant",
                            target_effects =
                                {
                                    {
                                        type = "damage",
                                        damage = {amount = 50, type = "physical"}
                                    },
                                    {
                                        type = "damage",
                                        damage = {amount = 175, type = "explosion"}
                                    }
                                }
                        }
                }
        })
    end
end

return grenades
