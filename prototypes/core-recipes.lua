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

if optionals.useadvfitting then
  data:extend({
    {
      type = "recipe",
      name = "airtight-seal",
      category = "advanced-crafting",
      enabled = false,
      energy_required = 2.5,
      ingredients = {
        helper.item("bolted-flange"), 
        helper.preferred({
          helper.item("graphite", 2), --- BZCarbon
          helper.item("rubber", 2) --- BrimStuff
        })},
      results = {helper.item("airtight-seal")},
      lasermill = {helium=data.raw.item["silver-brazing-alloy"] and 4 or 2, productivity=true}
    }
  })
end

if optionals.experimental then
  data:extend({
    {
      type = "recipe",
      name = "flywheel",
      category = "crafting",
      energy_required = 2,
      ingredients = {
        helper.item("iron-gear-wheel"), 
        helper.item("zinc-plate",3)},
      results = {helper.item("flywheel")},
      lasermill = {helium = 2, productivity = true}
    },
    {
      type = "recipe",
      name = "articulated-mechanism",
      category = "crafting",
      energy_required = 1,
      ingredients = {
        helper.item("brass-plate"), 
        helper.preferred({
          helper.item("aluminum-plate"),
          helper.item("iron-plate")}), 
        helper.item("iron-stick", 3)},
      results = {helper.item("articulated-mechanism", 2)},
    },
    {
      type = "recipe",
      name = "hardened-hull",
      category = "crafting",
      energy_required = 2,
      ingredients = {
        helper.item("galvanized-steel-plate"),
        helper.item("iron-plate", 2), 
        helper.preferred({
          helper.item("bronze-plate", 2),
          helper.item("brass-plate", 2)})},
      results = {helper.item("hardened-hull")},
      enabled = false,
      lasermill = {helium=5, productivity=true}
    },
    {
      type = "recipe",
      name = "complex-joint",
      category = "crafting-with-fluid",
      energy_required = 8,
      ingredients = {
        helper.item("bearing"), 
        helper.item("galvanized-steel-plate"), 
        helper.preferred({
          helper.item("cermet"),
          helper.item("zirconia", 4),
          helper.item("plastic-bar", 2)}), 
        helper.item("articulated-mechanism", 8), 
        helper.fluid("lubricant", 5)},
      results = {helper.item("complex-joint")},
      enabled = false,
    },
    {
      type = "recipe",
      name = "gearbox",
      category = "crafting",
      energy_required = 3,
      ingredients = {
        helper.item("galvanized-steel-plate", 1), 
        helper.item("iron-gear-wheel", (mods["Krastorio2"] and 8 or 10))},
      results = {helper.item("gearbox", 2)},
      enabled = false
    },
    {
      type = "recipe",
      name = "advanced-gearbox",
      category = "crafting-with-fluid",
      energy_required = 3,
      ingredients = {
        helper.item("gearbox"), 
        helper.item("iron-gear-wheel", (mods["Krastorio2"] and 4 or 5)), 
        helper.item("bearing", 2), 
        helper.item("flywheel"), 
        helper.fluid("lubricant", 20)},
      results = {helper.item("advanced-gearbox")},
      enabled = false
    }
  })
  
  if not mods["galdocs-manufacturing"] then
    data:extend({
      {
        type = "recipe",
        name = "galvanized-steel-plate",
        category = optionals.foundryEnabled and "founding" or "advanced-crafting",
        energy_required = optionals.foundryEnabled and 6.4 or 3,
        ingredients = {{type="item", name="steel-plate", amount=1}, {type="item", name="zinc-plate", amount=1}},
        results = {{type="item", name="galvanized-steel-plate", amount=1}},
        enabled = false,
      }
    })
  end

  if optionals.gyroscope then
    data:extend({
      {
        type = "recipe",
        name = optionals.gyroscope,
        category = "crafting",
        energy_required = 5,
        --preferred can't be used - ifnickel loads after this. Then modify it in update??
        ingredients = {
          helper.item("flywheel"), 
          helper.item("bearing", 2), 
          helper.item("advanced-circuit"), 
          (mods["aai-industry"] and helper.item("electric-motor")) or 
            (mods["IfNickel-Updated"] and helper.item("motor")) or 
            (mods["Krastorio2"] and helper.item("kr-steel-gear-wheel")) or 
            helper.item("iron-gear-wheel", 2)},
        results = {helper.item(optionals.gyroscope)},
        enabled = false
      }
    })
  end
end

if optionals.drill then
  data:extend({
    {
      type = "recipe",
      name = "industrial-drill-head",
      category = "advanced-crafting",
      energy_required = 5,
      ingredients = {
        helper.item("complex-joint"), 
        helper.item("electric-engine-unit"), 
        helper.item("tungsten-carbide", 2), 
        helper.item("diamond", 2)},
      results = {helper.item("industrial-drill-head")},
      enabled = false
    },
  })
end