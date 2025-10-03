local helper = require("prototypes.lib.prototype_helper")

---MARK: Matter Recipes
local matterutil = require("__Krastorio2__/prototypes/libraries/matter")
matterutil.make_recipes({
  material = helper.item("zinc-ore", 10),
  matter_count = 8,
  energy_required = 1,
  need_stabilizer = false,
  unlocked_by_technology = "kr-matter-zinc-processing"
})
matterutil.make_deconversion_recipe({
  material = helper.item("zinc-plate", 10),
  matter_count = mods["space-exploration"] and 7.5 or 10,
  energy_required = 3,
  only_deconversion = true,
  need_stabilizer = true,
  unlocked_by_technology = "kr-matter-zinc-processing"
})