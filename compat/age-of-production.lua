local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("aop-greenhouse", "iron-gear-wheel", "fast-gearbox", 0.2, (mods["IfNickel" or mods["BrimStuff"]]) and 25 or 50)
    rm.ReplaceIngredientProportional("aop-smeltery", "iron-gear-wheel", "complex-joint", 0.33, (mods["IfNickel" or mods["BrimStuff"]]) and 75 or 150)
end

if not mods["IfNickel"] then
    rm.AddIngredient("aop-lumber-mill", "electric-engine-unit", 5)
end

tm.AddUnlock("aop-mineral-synthesis", "ammoniacal-zinc-synthesis")

rm.AddProduct("aop-nauvitian-crushing", {type="item", name="zinc-ore", amount=1, probability=0.4})
rm.AddProduct("aop-vulcanusian-crushing", {type="item", name="sphalerite", amount=2, probability=0.5})
rm.AddProduct("aop-fulgoran-crushing", {type="item", name="zinc-ore", amount=1, probability=0.2})
rm.AddProduct("aop-gleban-crushing", {type="item", name="zinc-bacteria", amount=1, probability=0.5})

rm.AddRecipeCategory("zinc-bacteria", "biochemistry")