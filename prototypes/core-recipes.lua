local optionals = require("optionals")
local helper = require("prototypes.lib.prototype_helper")
local config = require("prototypes.lib.prototype_config")

if not mods["galdocs-manufacturing"] then
  data:extend({
    {
      type = "recipe",
      name = "brass-plate",
      category = "smelting",
      energy_required = 1.6,
      ingredients = {helper.item("brass-precursor")},
      results = {helper.item("brass-plate")},
    },
    {
      type = "recipe",
      name = "brass-precursor",
      category = "crafting",
      energy_required = 0.5,
      ingredients = {
        helper.item("copper-plate"), 
        helper.item("zinc-plate")},
      results = {helper.item("brass-precursor", 2)}
    }
  })
  if optionals.foundryEnabled then
    data:extend({
      {
        type = "recipe",
        name = "brass-plate-foundry",
        category = "founding",
        energy_required = 3.2,
        ingredients = {
          helper.item("copper-plate"), 
          helper.item("zinc-plate")},
        results = {helper.item("brass-plate", 2)},
        enabled = false
      }
    })
  end
  if not mods["exotic-industries"] then
    data:extend({
      {
        type = "recipe",
        name = "zinc-plate",
        category = "smelting",
        energy_required = 3.2 * config.yield,
        ingredients = {helper.item("zinc-ore", config.cost)},
        results = {helper.item("zinc-plate", config.yield)}
      }
    })
  end
end

data:extend({
  {
    type = "recipe",
    name = "bolted-flange",
    category = "crafting",
    energy_required = 2.5,
    ingredients = {helper.item("brass-plate", 2)},
    results = {helper.item("bolted-flange")},
    lasermill = {helium=1, productivity=true}
  },
  {
    type = "recipe",
    name = "brass-balls",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 0.5,
    ingredients = {helper.item("brass-plate")},
    results = {helper.item("brass-balls", 2)},
    lasermill = {helium=1, productivity=true, type="gubbins", multiply=2}
  },
---TODO: Probably rename this
  { 
    type = "recipe",
    name = "bearing",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 4,
    ingredients = {
      helper.item("brass-plate", 2), 
      helper.item("brass-balls", 4), 
      helper.fluid("lubricant", 5)},
    results = {helper.item("bearing")},
  }
})