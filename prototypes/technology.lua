local misc = require("__pf-functions__/misc")
local tm = require("__pf-functions__/technology-manipulation")

if misc.difficulty > 1 then
    data:extend({
        {
            type = "technology",
            name = "mechanical-engineering",
            icon = "__BrassTacks__/graphics/classic/technology/mechanical-engineering.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "fast-gearbox"
                }
            },
            prerequisites = difficulty == 3 and {"electroplating"} or {"steel-processing", "logistic-science-pack"},
            unit = {
                count = 50,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                }
            }
        }
    })
end

if misc.difficulty == 3 then
    data:extend({
        {
            type = "technology",
            name = "electroplating",
            icon = "__BrassTacks__/graphics/technology/electroplating.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "electroplating-machine"
                },
                {
                    type = "unlock-recipe",
                    recipe = "depleted-zinc-salt-reprocessing"
                },
                {
                    type = "unlock-recipe",
                    recipe = "galvanized-panel"
                },
                {
                    type = "unlock-recipe",
                    recipe = "galvanized-rod"
                },
                {
                    type = "unlock-recipe",
                    recipe = "galvanized-tubing"
                },
                {
                    type = "unlock-recipe",
                    recipe = "galvanized-steel-plate"
                },
                {
                    type = "unlock-recipe",
                    recipe = "malleable-logarithmic-casing"
                },
                {
                    type = "unlock-recipe",
                    recipe = "loadbearing-lattice"
                }
            },
            prerequisites = {"steel-processing", "logistic-science-pack"},
            unit = {
                count = 50,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "advanced-electroplating-machine",
            icon = "__BrassTacks__/graphics/technology/advanced-electroplating-machine.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "advanced-electroplating-machine"
                }
            },
            prerequisites = {mods["space-age"] and "electromagnetic-science-pack" or "production-science-pack"},
            unit = {
                count = mods["space-age"] and 500 or 50,
                time = 30,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    mods["space-age"] and {"space-science-pack", 1} or nil,
                    mods["space-age"] and {"electromagnetic-science-pack", 1} or nil,
                }
            }
        }
    })

    tm.AddPrerequisite("mechanical-engineering", "electroplating")
elseif misc.difficulty == 2 then
    data:extend({
        {
            type = "technology",
            name = "hardened-hull",
            icon = "__BrassTacks__/graphics/classic/technology/hardened-hull.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "hardened-hull"
                }
            },
            prerequisites = {"steel-processing", "logistic-science-pack"},
            unit = {
                count = 50,
                time = 30,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1}
                }
            }
        }
    })
end