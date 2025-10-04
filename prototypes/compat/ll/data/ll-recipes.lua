optionals = require("optionals")
helper = require("prototypes.lib.prototype_helper")

if not mods["LunarLandings"] then
  return
end

data:extend({
  type = "recipe",
  name = "cheese-ore-processing",
  category = "ll-electric-smelting",
  subgroup = "ll-raw-material-moon",
  order = "a[moon-rock]-c",
  icon = "__BrassTacks-Updated__/graphics/icons/cheese-ore.png",
  icon_size = 64,
  energy_required = 10,
  ingredients = {helper.item("cheese-ore", 20)},
  results = {
    helper.item("zinc-ore", 10), 
    helper.item("ll-moon-rock", 3), 
    helper.fluid("light-oil", 10, {fluidbox_index = 1})},
  always_show_products = true,
  enabled = false
})

if settings.startup["brasstacks-experimental-intermediates"].value then
  if mods["IfNickel-Updated"] then
    data:extend({
      {
        type = "recipe",
        name = "hardened-hull-alumina",
        icons = {
          helper.graphic("icons/hardened-hull.png"),
          {
            icon = "__LunarLandings__/graphics/icons/alumina.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          },
         },
        category = "crafting",
        energy_required = 2,
        ingredients = {
          helper.item("galvanized-steel-plate"), 
          helper.item("ll-alumina"), 
          helper.preferred({
            helper.item("bronze-plate", 2),
            helper.item("brass-plate", 2)})},
        results = {helper.item("hardened-hull", 1)},
        enabled = false,
        lasermill = {helium=5, productivity=true, convert=true}
      }
    })
  end
  if optionals.withskyseeker then
    data:extend({
      {
        type = "recipe",
        name = "skyseeker-armature",
        category = "crafting",
        energy_required = 20,
        ingredients = {{type="item", name="complex-joint", amount=1}, {type="item", name="low-density-structure", amount=1}, {type="item", name="electric-engine-unit", amount=1}, 
                        parts.preferred({"kr-steel-gear-wheel", "iron-gear-wheel"}, {3, 6}), parts.preferred({"gyro", "gyroscope"}, {1, 1})},
        results = {{type="item", name="skyseeker-armature", amount=1}},
        enabled = false
      }
    })
  end
end