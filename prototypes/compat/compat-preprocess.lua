local optionals = require("optionals")
local helper = require("prototypes.lib.prototype_helper")

if optionals.experimental then
  if optionals.withskyseeker then
    data:extend({
      {
        type = "recipe",
        name = "skyseeker-armature",
        category = "crafting",
        energy_required = 20,
        ingredients = {
          helper.item("complex-joint"), 
          helper.item("low-density-structure"), 
          helper.item("electric-engine-unit"), 
          helper.preferred({
            helper.item("kr-steel-gear-wheel", 3),
            helper.item("iron-gear-wheel", 6)}), 
          helper.preferred({
            helper.item("gyro"), 
            helper.item("gyroscope")})},
        results = {helper.item("skyseeker-armature")},
        enabled = false
      }
    })
  end
end