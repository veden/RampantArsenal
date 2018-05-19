local constants = {}

-- versions

constants.VERSION_1 = 1

-- misc

constants.DEFAULT_SPOUT_SIZE = 1000

constants.INTERVAL_LOGIC = 38

-- spawners

constants.BITER_SPAWNER = "biter-spawner"
constants.SPITTER_SPAWNER = "spitter-spawner"
-- constants.SMALL_WORM = "small-worm-turret"
-- constants.MEDIUM_WORM = "medium-worm-turret"
-- constants.BIG_WORM = "big-worm-turret"

constants.BOB_BITER_SPAWNER = "bob-biter-spawner"
constants.BOB_SPITTER_SPAWNER = "bob-spitter-spawner"

-- constants.BOB_BIG_EXPLOSIVE_WORM = "bob-big-explosive-worm-turret"
-- constants.BOB_BIG_FIRE_WORM = "bob-big-fire-worm-turret"
-- constants.BOB_BIG_POISON_WORM = "bob-big-poison-worm-turret"
-- constants.BOB_BIG_PIERCING_WORM = "bob-big-piercing-worm-turret"
-- constants.BOB_BIG_ELECTRIC_WORM = "bob-big-electric-worm-turret"
-- constants.BOB_GIANT_WORM = "bob-giant-worm-turret"
-- constants.BOB_BEHEMOTH_WORM = "bob-behemoth-worm-turret"

constants.RAMPANT_NEUTRAL_BITER_SPAWNER = "neutral-biter-nest"
constants.RAMPANT_NEUTRAL_SPITTER_SPAWNER = "neutral-spitter-nest"
-- constants.RAMPANT_NEUTRAL_WORM = "neutral-worm"

constants.RAMPANT_ACID_BITER_SPAWNER = "acid-biter-nest"
constants.RAMPANT_ACID_SPITTER_SPAWNER = "acid-spitter-nest"
-- constants.RAMPANT_ACID_WORM = "acid-worm"

constants.RAMPANT_PHYSICAL_BITER_SPAWNER = "physical-biter-nest"
constants.RAMPANT_PHYSICAL_SPITTER_SPAWNER = "physical-spitter-nest"
-- constants.RAMPANT_PHYSICAL_WORM = "physical-worm"

constants.RAMPANT_ELECTRIC_BITER_SPAWNER = "electric-biter-nest"
constants.RAMPANT_ELECTRIC_SPITTER_SPAWNER = "electric-spitter-nest"
-- constants.RAMPANT_ELECTRIC_WORM = "electric-worm"

constants.RAMPANT_SUICIDE_BITER_SPAWNER = "suicide-biter-nest"
constants.RAMPANT_SUICIDE_SPITTER_SPAWNER = "suicide-spitter-nest"
-- constants.RAMPANT_SUICIDE_WORM = "suicide-worm"

constants.RAMPANT_NUCLEAR_BITER_SPAWNER = "nuclear-biter-nest"
constants.RAMPANT_NUCLEAR_SPITTER_SPAWNER = "nuclear-spitter-nest"
-- constants.RAMPANT_NUCLEAR_WORM = "nuclear-worm"

constants.RAMPANT_FIRE_BITER_SPAWNER = "fire-biter-nest"
constants.RAMPANT_FIRE_SPITTER_SPAWNER = "fire-spitter-nest"
-- constants.RAMPANT_FIRE_WORM = "fire-worm"

constants.RAMPANT_INFERNO_BITER_SPAWNER = "inferno-biter-nest"
constants.RAMPANT_INFERNO_SPITTER_SPAWNER = "inferno-spitter-nest"
-- constants.RAMPANT_INFERNO_WORM = "inferno-worm"

constants.RAMPANT_TROLL_BITER_SPAWNER = "troll-biter-nest"
constants.RAMPANT_TROLL_SPITTER_SPAWNER = "troll-spitter-nest"
-- constants.RAMPANT_TROLL_WORM = "troll-worm"

constants.RAMPANT_FAST_BITER_SPAWNER = "fast-biter-nest"
constants.RAMPANT_FAST_SPITTER_SPAWNER = "fast-spitter-nest"
-- constants.RAMPANT_FAST_WORM = "fast-worm"

constants.RAMPANT_LASER_BITER_SPAWNER = "laser-biter-nest"
constants.RAMPANT_LASER_SPITTER_SPAWNER = "laser-spitter-nest"
-- constants.RAMPANT_LASER_WORM = "laser-worm"

constants.RAMPANT_WASP_BITER_SPAWNER = "wasp-biter-nest"
constants.RAMPANT_WASP_SPITTER_SPAWNER = "wasp-spitter-nest"
-- constants.RAMPANT_WASP_WORM = "wasp-worm"

constants.RAMPANT_SPAWNER_BITER_SPAWNER = "spawner-biter-nest"
constants.RAMPANT_SPAWNER_SPITTER_SPAWNER = "spawner-spitter-nest"
-- constants.RAMPANT_SPAWNER_WORM = "spawner-worm"

constants.RAMPANT_PREFIX_TABLE = {
    ["spawner"] = {},
    ["wasp"] = {},
    ["laser"] = {},
    ["fast"] = {},
    ["troll"] = {},
    ["inferno"] = {},
    ["fire"] = {},
    ["nuclear"] = {},
    ["suicide"] = {},
    ["electric"] = {},
    ["physical"] = {},
    ["acid"] = {},
    ["neutral"] = {"dirty-alien-goo-resource-rampant-arsenal"}
}

constants.DEFAULT_GOO_TYPE = "dirty-alien-goo-resource-rampant-arsenal"

constants.RAW_GOO_TYPES = {
    "dirty-alien-goo-resource-rampant-arsenal",
    "dirty-alien-goo-blue-resource-rampant-arsenal",
    "dirty-alien-goo-red-resource-rampant-arsenal",
    "dirty-alien-goo-green-resource-rampant-arsenal",
    "dirty-alien-goo-orange-resource-rampant-arsenal",
    "dirty-alien-goo-purple-resource-rampant-arsenal",
    "dirty-alien-goo-yellow-resource-rampant-arsenal"       
}

local function checkStartupSetting(setting)
    local a = settings.startup[setting]
    return a and a.value
end

local function validateStartupSetting(setting)
    local a = settings.startup[setting]
    return a ~= nil
end

constants.ENABLE_NORMAL_GOO = checkStartupSetting("bobmods-enemies-enableartifacts") or checkStartupSetting("NE_Alien_Artifacts") or validateStartupSetting("rampant-disableVanillaAI")

constants.ENABLE_ALL_GOO = checkStartupSetting("bobmods-enemies-enablenewartifacts") or validateStartupSetting("rampant-disableVanillaAI")

return constants
