local helper = require("prototypes.lib.prototype_helper")
local config = require("prototypes.lib.prototype_config")

---MARK: Aluminum
if mods["bzaluminum"] then
  if not mods["galdocs-manufacturing"] and not mods["Krastorio2"] then
    local precursor = data.raw.recipe["brass-precursor"]
    precursor.ingredients = {
      helper.item("copper-ore", 2),
      helper.item("zinc-ore", 2)
    }
    if not config.foundryEnabled then
      data:extend({
        {
          type = "recipe",
          name = "brass-precursor-foundry",
          category = "crafting",
          energy_required = 0.5,
          ingredients = {
            helper.item("copper-plate"), 
            helper.item("zinc-plate")},
          results = {helper.item("brass-precursor", 2)},
          enabled = false,
        }
      })
    end
  end
end
