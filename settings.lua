data:extend({

        {
            type = "int-setting",
            name = "rampant-arsenal-airFilterCooldown",
            description = "rampant-arsenal-airFilterCooldown",
            setting_type = 'runtime-global',
            default_value = 30 * 60,
            min_value = 1,
            max_value = 1000000,
            order = "a[modifer]-a[resource]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableAirFiltering",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableOilBurner",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableAdvancedLab",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableLargeStorageTank",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableAdvancedSolarPanel",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableNuclearGeneratorEquipmentConsuming",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-enableAdvancedAccumulator",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-unhideVanillaDamageTechnologies",
            setting_type = 'startup',
            default_value = false,
            order = "a[projectile]-a[collide]",
            per_user = false
        },

        {
            type = "bool-setting",
            name = "rampant-arsenal-useInfiniteTechnologies",
            setting_type = 'startup',
            default_value = true,
            order = "a[projectile]-a[collide]",
            per_user = false
        }

        -- {
        --     type = "bool-setting",
        --     name = "rampant-arsenal-enableGunTurretDamageResearch",
        --     setting_type = 'startup',
        --     default_value = true,
        --     order = "a[projectile]-a[collide]",
        --     per_user = false
        -- },

        -- {
        --     type = "bool-setting",
        --     name = "rampant-arsenal-enableDamageResearch",
        --     setting_type = 'startup',
        --     default_value = true,
        --     order = "a[projectile]-a[collide]",
        --     per_user = false
        -- }


        -- {
        --     type = "bool-setting",
        --     name = "rampant-arsenal-infiniteSpouts",
        --     description = "rampant-arsenal-infiniteSpouts",
        --     setting_type = 'startup',
        --     default_value = true,
        --     order = "a[modifer]-a[resource]",
        --     per_user = false
        -- },

        -- {
        --     type = "double-setting",
        --     name = "rampant-arsenal-spoutThreshold",
        --     description = "rampant-arsenal-spoutThreshold",
        --     setting_type = 'runtime-global',
        --     default_value = 0.1,
        --     min_value = 0.0,
        --     max_value = 1.0,
        --     order = "a[modifer]-a[resource]",
        --     per_user = false
        -- },

        -- {
        --     type = "double-setting",
        --     name = "rampant-arsenal-spoutScaler",
        --     description = "rampant-arsenal-spoutThreshold",
        --     setting_type = 'runtime-global',
        --     default_value = 1.0,
        --     min_value = 0.0,
        --     max_value = 1000000.0,
        --     order = "a[modifer]-a[resource]",
        --     per_user = false
        -- }

})
