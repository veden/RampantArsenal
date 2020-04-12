-- imports

-- local aliens = require("prototypes/Aliens")
local turrets = require("prototypes/Turrets")

-- imported functions

local addTurrets = turrets.addTurrets
-- local addAlienResource = aliens.addAlienResource

-- module code

-- addAlienResource()
addTurrets()

for _, animation in ipairs(data.raw["character"]["character"]["animations"]) do
  if animation.armors then
    for _, armor in ipairs(animation.armors) do
      if armor == "power-armor-mk2" then
        animation.armors[#animation.armors + 1] = "power-armor-mk3-armor-rampant-arsenal"
        break
      end
    end
  end
end
