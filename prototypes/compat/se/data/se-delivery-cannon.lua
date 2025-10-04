local optionals = require("optionals")

se_delivery_cannon_recipes["zinc-ore"] = {name= "zinc-ore"}
se_delivery_cannon_recipes["zinc-plate"] = {name= "zinc-plate"}
se_delivery_cannon_recipes["zinc-ingot"] = {name= "zinc-ingot"}
se_delivery_cannon_recipes["brass-plate"] = {name= "brass-plate"}
se_delivery_cannon_recipes["brass-ingot"] = {name= "brass-ingot"}

if optionals.experimental then
  se_delivery_cannon_recipes["hardened-hull"] = {name= "hardened-hull"}
end

if mods["Krastorio2"] then
  se_delivery_cannon_recipes["enriched-zinc"] = {name= "enriched-zinc"}
end