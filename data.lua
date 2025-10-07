if mods["space-age"] and not mods["pf-sa-compat"] then
    error("Brass Tacks requires PF Space Age compatibility (pf-sa-compat) to work with Space Age. Please download and enable that mod to continue.")
end

require("prototypes/ore")
require("prototypes/particle")
require("prototypes/items-fluids")
require("prototypes/electroplating-machine")
require("prototypes/recipes")
require("prototypes/technology")