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
        helper.item("lubricant", 5)},
      results = {helper.item("complex-joint")},
      enabled = false,
    },
    {
      type = "recipe",
      name = "gearbox",
      category = "crafting",
      energy_required = 3,
      ingredients = {{type="item", name="galvanized-steel-plate", amount=1}, {type="item", name="iron-gear-wheel", amount=(mods["Krastorio2"] and 8 or 10)}},
      results = {{type="item", name="gearbox",amount=2}},
      enabled = false
    },
    {
      type = "recipe",
      name = "advanced-gearbox",
      category = "crafting-with-fluid",
      energy_required = 3,
      ingredients = {{type="item", name="gearbox", amount=1}, {type="item", name="iron-gear-wheel", amount=(mods["Krastorio2"] and 4 or 5)}, 
                     {type="item", name="bearing", amount=2}, {type="item", name="flywheel", amount=1}, {type="fluid", name="lubricant", amount=20}},
      results = {{type="item", name="advanced-gearbox", amount=1}},
      enabled = false
    }
  })

  if optionals.gyroscope then
    data:extend({
      {
        type = "recipe",
        name = parts.gyroscope,
        category = "crafting",
        energy_required = 5,
        --preferred can't be used - ifnickel loads after this.
        ingredients = {{type="item", name="flywheel", amount=1}, {type="item", name="bearing", amount=2}, {type="item", name="advanced-circuit", amount=1}, 
                       (mods["aai-industry"] and {type="item",name="electric-motor", amount=1}) or (mods["IfNickel-Updated"] and {type="item",name="motor", amount=1}) or (mods["Krastorio2"] and {type="item",name="kr-steel-gear-wheel", amount=1}) or {type="item",name="iron-gear-wheel", amount=2}},
        results = {{type="item", name=parts.gyroscope, amount=1}},
        enabled = false
      }
    })
  end
end

if parts.drill then
  data:extend({
    {
      type = "recipe",
      name = "industrial-drill-head",
      category = "advanced-crafting",
      energy_required = 5,
      ingredients = {{type="item", name="complex-joint", amount=1}, {type="item", name="electric-engine-unit", amount=1}, {type="item", name="tungsten-carbide", amount=2}, {type="item", name="diamond", amount=2}},
      results = {{type="item", name="industrial-drill-head", amount=1}},
      enabled = false
    },
  })
end