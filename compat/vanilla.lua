local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

--INTERMEDIATE PRODUCTS
rm.RemoveIngredient("iron-gear-wheel", "iron-plate", 1)
rm.AddIngredient("iron-gear-wheel", "brass-plate", 1)
data.raw.item["iron-gear-wheel"].icon = "__BrassTacks__/graphics/classic/icons/iron-gear-wheel.png"

tm.AddUnlock("lubricant", "brass-balls")
tm.AddUnlock("lubricant", "bearing")

if misc.difficulty > 1 then
    data.raw.recipe["iron-stick"].enabled = true

    tm.AddUnlock("steam-power", "pipe-flange", "-pipe")
    tm.AddUnlock("steam-power", "flywheel", "-steam-engine")

    if mods["BrimStuff"] then
        rm.ReplaceIngredientProportional("airtight-seal", "copper-plate", "pipe-flange", 0.5)
    end

    data.raw.technology["electric-engine"].icon = "__BrassTacks__/graphics/galdoc/technology/mechanical-engineering-2.png"
    data.raw.technology["electric-engine"].localised_name = {"technology-name.mechanical-engineering-2"}
    data.raw.technology["electric-engine"].localised_description = {"technology-description.mechanical-engineering-2"}
    data.raw.technology["electric-engine"].unit.count = 100
    tm.AddUnlock("electric-engine", "express-gearbox")
    if not data.raw.technology.gyro then
        tm.AddUnlock("electric-engine", "gyro")
    end
    if data.raw.item["nitinol-plate"] then
        tm.AddUnlock("nitinol-processing", "complex-joint")
        rm.ReplaceIngredientProportional("complex-joint", "galvanized-rod", "nitinol-plate", 0.125)
    else
        tm.AddUnlock("electric-engine", "complex-joint")
    end
end

if misc.difficulty > 1 then
    if rm.GetIngredientCount("flying-robot-frame", "gyro") == 0 then
        rm.AddIngredient("flying-robot-frame", "gyro", 1)
    end
    rm.RemoveIngredient("flying-robot-frame", "electronic-circuit", 99999)

    if data.raw.item["rocket-control-unit"] then
        if rm.GetIngredientCount("rocket-control-unit", "gyro") == 0 then
            rm.AddIngredient("rocket-control-unit", "gyro", 1)
        end
        rm.RemoveIngredient("rocket-control-unit", "electronic-circuit", 99999)
    else
        rm.AddIngredient("rocket-part", "gyro", 10)
    end

    if not mods["space-age"] then
        rm.AddIngredient("satellite", "gyro", 50)
    end

    if mods["IfNickel"] then
        rm.ReplaceIngredientProportional("gimbaled-rocket-engine", "iron-gear-wheel", "complex-joint", 0.2)
        rm.ReplaceIngredientProportional("motorized-arm", "iron-stick", "linkages", 0.33)
    end
end

if mods["IfNickel"] and misc.difficulty > 1 and not mods["BrimStuff"] then
    rm.ReplaceIngredientProportional("high-pressure-valve", "copper-plate", "brass-plate")
end

if misc.difficulty == 3 then
    if mods["IfNickel"] then
        if misc.starting_planet ~= "vulcanus" then
            tm.AddPrerequisite("high-pressure-valve", "electroplating")
        end
        rm.AddIngredient("grabber", "complex-joint", 1)
        rm.RemoveIngredient("grabber", "iron-gear-wheel", 3)
    else
        rm.ReplaceIngredientProportional("engine-unit", "pipe", "galvanized-tubing")
        tm.AddPrerequisite("engine", "electroplating")
    end
    rm.ReplaceIngredientProportional("barrel", "steel-plate", "galvanized-steel-plate")
end

if misc.difficulty < 3 then
    tm.AddUnlock("steel-processing", "galvanized-steel-plate", "steel-plate")
else
    tm.RemoveUnlock("steel-processing", "steel-chest")
    tm.AddUnlock("electroplating", "steel-chest")
end

if misc.difficulty > 1 then
    rm.AddIngredient("engine-unit", "linkages", 1) --close enough to con rods
end

rm.AddIngredient("electric-engine-unit", "bearing", 1)

rm.AddIngredient("battery", "zinc-plate", 1)
if misc.difficulty == 3 then
    --separate steps - the galvanized panel is the CASING.
    --bzlead replaces the iron with lead, which I support, but it represents part of the chemical cell.
    rm.AddIngredient("battery", "galvanized-panel", 1)
    rm.RemoveIngredient("battery", "iron-plate", 1)
end

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("flying-robot-frame", "steel-plate", "malleable-logarithmic-casing", 2)
    rm.ReplaceIngredientProportional("uranium-fuel-cell", "iron-plate", "malleable-logarithmic-casing", 0.5)
    if mods["ThemTharHills"] then
        rm.AddIngredient("stepper-motor", "malleable-logarithmic-casing")
    end
end

rm.ReplaceIngredientProportional("refined-concrete", "steel-plate", "galvanized-steel-plate")
if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("refined-concrete", "iron-stick", "galvanized-rod")

    if mods["IfNickel"] then
        rm.ReplaceIngredientProportional("ambifacient-lunar-waneshaft", "iron-stick", "galvanized-rod")
    end
end

if misc.difficulty == 3 then
    if not mods["BrimStuff"] then
        rm.AddIngredient("rocket-fuel", "pipe-flange", 1)
        rm.AddIngredient("rocket-fuel-from-jelly", "pipe-flange", 1)
        rm.AddIngredient("ammonia-rocket-fuel", "pipe-flange", 1)
        rm.AddIngredient("maraxsis-hydrolox-rocket-fuel", "pipe-flange", 1)
    end

    rm.AddIngredient("rocket-fuel", "galvanized-panel", 1)
    rm.AddIngredient("rocket-fuel-from-jelly", "galvanized-panel", 1)
    rm.AddIngredient("ammonia-rocket-fuel", "galvanized-panel", 1)
    rm.AddIngredient("maraxsis-hydrolox-rocket-fuel", "galvanized-panel", 1)

elseif misc.difficulty == 2 and not (mods["space-age"] or mods["BrimStuff"]) then
    rm.AddIngredient("rocket-fuel", "pipe-flange", 1)
end

if misc.difficulty > 1 then
    if data.raw.item["nitinol-plate"] then
        tm.AddPrerequisite("utility-science-pack", "nitinol-processing")
    else
        tm.AddPrerequisite("utility-science-pack", "electric-engine")
    end
    rm.AddIngredient("utility-science-pack", "complex-joint", 4)
    tm.AddPrerequisite("production-science-pack", "electric-engine")
    rm.ReplaceIngredientProportional("production-science-pack", "rail", "express-gearbox", 0.2)
    if mods["maraxsis"] then
        rm.AddIngredient("maraxsis-deepsea-research-utility-science-pack", "complex-joint", 4)
        rm.ReplaceIngredientProportional("maraxsis-deepsea-research-production-science-pack", "rail", "express-gearbox", 0.2)
    end
end

if data.raw.item["spring"] and not data.raw.item["bronze-plate"] then
    --brass is generally not used for springs. too stiff.
    --however it makes the recipes nicer so in it goes.
    rm.ReplaceIngredientProportional("spring", "copper-plate", "brass-plate")
end

if data.raw.item["differential-girdlespring"] then
    rm.ReplaceIngredientProportional("differential-girdlespring", "steel-plate", "galvanized-rod", 10)
end

--LOGISTICS

--STORAGE
rm.ReplaceIngredientProportional("steel-chest", "steel-plate", "galvanized-steel-plate")
if misc.difficulty > 1 then
    rm.AddIngredient("iron-chest", "linkages", 1) --those support things a lot of toolboxes have to keep them open. also ~hinges.
    rm.AddIngredient("steel-chest", "linkages", 1)
end

--PIPING
rm.MultiplyRecipe("pipe", 5)
if misc.difficulty == 1 then
    rm.AddIngredient("pipe", "brass-plate", 2)
    rm.RemoveIngredient("storage-tank", "iron-plate", 10)
    rm.AddIngredient("storage-tank", "brass-plate", 10)
    rm.AddIngredient("pump", "brass-plate", 3)
    rm.AddIngredient("boiler", "brass-plate", 5)
    rm.RemoveIngredient("offshore-pump", "pipe", 1)
    rm.AddIngredient("offshore-pump", "brass-plate", 2)
else
    rm.AddIngredient("pipe", "pipe-flange", 1)
    rm.AddIngredient("storage-tank", "pipe-flange", 4)
    rm.AddIngredient("boiler", "pipe-flange", 3)
    rm.AddIngredient("offshore-pump", "pipe-flange", 1)
    if not mods["BrimStuff"] then
        rm.AddIngredient("pump", "pipe-flange", 2)
        rm.AddIngredient("flamethrower-ammo", "pipe-flange", 1)
        if rm.GetIngredientCount("flamethrower-ammo", "steel-plate") >= 5 then
            rm.RemoveIngredient("flamethrower-ammo", "steel-plate", 4) --i still hold this stuff is too expensive.
        end
    end
end
data.raw.item["pipe"].weight = 5 * kg
data.raw.item["pipe-to-ground"].weight = 20 * kg

rm.ReplaceIngredientProportional("pump", "steel-plate", "galvanized-steel-plate")

if misc.difficulty == 1 then
    rm.ReplaceIngredientProportional("storage-tank", "steel-plate", "galvanized-steel-plate")
else
    rm.ReplaceIngredientProportional("storage-tank", "steel-plate", "hardened-hull")
    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("storage-tank", "iron-plate", "galvanized-panel")
    end
end

--INSERTERS
rm.ReplaceIngredientProportional("fast-inserter", "iron-plate", "iron-gear-wheel", 1, 2)

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("burner-inserter", "iron-plate", "linkages")
    rm.ReplaceIngredientProportional("inserter", "iron-plate", "linkages")
    if difficulty == 2 and mods["IfNickel"] then --gears quasi-represent motors when motors don't exist as an item
        rm.RemoveIngredient("inserter", "iron-gear-wheel", 1)
    end
    rm.ReplaceIngredientProportional("long-handed-inserter", "iron-plate", "linkages")

    rm.AddIngredient("stack-inserter", "complex-joint", 1)
end

--BELTS

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("splitter", "iron-plate", "flywheel", 1, 2)
    rm.ReplaceIngredientProportional("splitter", "iron-plate", "linkages", 1, 3)
else
    rm.ReplaceIngredientProportional("splitter", "iron-plate", "iron-gear-wheel", 1, 3)
end

--I'm not going to duplicate this logic into the space age file. The point of the separation is legibility, not pedantry.
if misc.difficulty == 1 then
    if mods["space-age"] then
        --blue belts already have lubricant as an extra ingredient.
        rm.AddIngredient("turbo-transport-belt", "bearing", 3)
        rm.AddIngredient("turbo-underground-belt", "bearing", 24)
        rm.AddIngredient("turbo-splitter", "bearing", 6)
    else
        rm.AddIngredient("express-transport-belt", "bearing", 2)
        rm.AddIngredient("express-underground-belt", "bearing", 16)
        rm.AddIngredient("express-splitter", "bearing", 4)
    end
else
    rm.ReplaceIngredientProportional("fast-transport-belt", "iron-gear-wheel", "fast-gearbox", 0.2)
    rm.ReplaceIngredientProportional("fast-underground-belt", "iron-gear-wheel", "fast-gearbox", 0.2)
    rm.ReplaceIngredientProportional("fast-splitter", "iron-gear-wheel", "fast-gearbox", 0.2)
    tm.AddPrerequisite("logistics-2", "mechanical-engineering")
    if misc.difficulty == 2 and mods["space-age"] then
        rm.ReplaceIngredientProportional("express-transport-belt", "iron-gear-wheel", "fast-gearbox", 0.2)
        rm.ReplaceIngredientProportional("express-underground-belt", "iron-gear-wheel", "fast-gearbox", 0.2)
        rm.ReplaceIngredientProportional("express-splitter", "iron-gear-wheel", "fast-gearbox", 0.2)
        rm.AddIngredient("turbo-transport-belt", "express-gearbox", 1)
        rm.AddIngredient("turbo-underground-belt", "express-gearbox", 8)
        rm.AddIngredient("turbo-splitter", "express-gearbox", 2)
        if not mods["BrimStuff"] then
            rm.AddIngredient("express-transport-belt", "bearing", 2)
            rm.AddIngredient("express-underground-belt", "bearing", 16)
            rm.AddIngredient("express-splitter", "bearing", 4)
        end
    else
        rm.ReplaceIngredientProportional("express-transport-belt", "iron-gear-wheel", "express-gearbox", 0.1)
        rm.ReplaceIngredientProportional("express-underground-belt", "iron-gear-wheel", "express-gearbox", 0.1)
        rm.ReplaceIngredientProportional("express-splitter", "iron-gear-wheel", "express-gearbox", 0.2)
        if difficulty == 3 then
            tm.AddUnlock("tungsten-steel", "spurving-bearing")
            tm.ReplaceIngredientProportional("turbo-transport-belt", "tungsten-plate", "spurving-bearing", 0.4)
            tm.ReplaceIngredientProportional("turbo-underground-belt", "tungsten-plate", "spurving-bearing", 0.4)
            tm.ReplaceIngredientProportional("turbo-splitter", "tungsten-plate", "spurving-bearing", 0.4)
        end
    end

    tm.RemovePrerequisite("logistics-3", "lubricant")
    if data.raw.item["nitinol-plate"] then
        tm.AddPrerequisite("logistics-3", "nitinol-processing")
    else
        tm.AddPrerequisite("logistics-3", "electric-engine")
    end
    rm.AddIngredient("express-splitter", "complex-joint", 2)
end

--ELECTRIC POLES

if misc.difficulty == 3 then
    tm.RemovePrerequisite("electric-energy-distribution-1", "steel-processing")
    tm.AddPrerequisite("electric-energy-distribution-1", "electroplating")
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("medium-electric-pole", "steel-plate", "loadbearing-lattice")
        rm.RemoveIngredient("medium-electric-pole", "iron-stick", 99999)
    end
    rm.ReplaceIngredientProportional("big-electric-pole", "steel-plate", "loadbearing-lattice")
    rm.RemoveIngredient("big-electric-pole", "iron-stick", 99999)
else
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("medium-electric-pole", "steel-plate", "galvanized-steel-plate")
    end
    rm.ReplaceIngredientProportional("big-electric-pole", "steel-plate", "galvanized-steel-plate")
end
rm.ReplaceIngredientProportional("substation", "steel-plate", "galvanized-steel-plate")

--RAILWAY
rm.AddIngredient("locomotive", "iron-gear-wheel", 10)
if misc.difficulty > 1 then
    rm.AddIngredient("locomotive", "flywheel", 2)
end

rm.ReplaceIngredientProportional("fluid-wagon", "steel-plate", "galvanized-steel-plate")

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("fluid-wagon", "pipe", "galvanized-tubing")

    rm.ReplaceIngredientProportional("rail-support", "steel-plate", "loadbearing-lattice")
    rm.ReplaceIngredientProportional("rail-ramp", "steel-plate", "loadbearing-lattice")

    rm.ReplaceIngredientProportional("train-stop", "steel-plate", "loadbearing-lattice")
    rm.ReplaceIngredientProportional("train-stop", "iron-plate", "galvanized-panel")
    rm.RemoveIngredient("train-stop", "iron-stick", 99999)

    rm.RemoveIngredient("rail-signal", "iron-plate", 99999)
    rm.RemoveIngredient("rail-chain-signal", "iron-plate", 99999)
    rm.AddIngredient("rail-signal", "malleable-logarithmic-casing", 1)
    rm.AddIngredient("rail-chain-signal", "malleable-logarithmic-casing", 1)
    rm.AddIngredient("rail-signal", "galvanized-panel", mods["ThemTharHills"] and 1 or 2)
    rm.AddIngredient("rail-chain-signal", "galvanized-panel", mods["ThemTharHills"] and 1 or 2)
else
    rm.ReplaceIngredientProportional("rail-support", "steel-plate", "galvanized-steel-plate")
    rm.ReplaceIngredientProportional("rail-ramp", "steel-plate", "galvanized-steel-plate")    
    rm.ReplaceIngredientProportional("train-stop", "steel-plate", "galvanized-steel-plate")
end

--ROBOTICS
if misc.difficulty == 3 then
    rm.AddIngredient("construction-robot", "bearing", 2)
    rm.AddIngredient("logistic-robot", "complex-joint", 2)
else
    rm.AddIngredient("construction-robot", "iron-gear-wheel", 2)
    rm.AddIngredient("logistic-robot", "bearing", 2)
end

rm.AddIngredient("passive-provider-chest", "iron-gear-wheel", 3)
rm.AddIngredient("storage-chest", "iron-gear-wheel", 3)
rm.AddIngredient("active-provider-chest", "iron-gear-wheel", 3)
rm.AddIngredient("buffer-chest", "iron-gear-wheel", 3)
rm.AddIngredient("requester-chest", "iron-gear-wheel", 3)

--COMBINATORS

if misc.difficulty == 3 then
    rm.AddIngredient("arithmetic-combinator", "malleable-logarithmic-casing", 2)
    rm.AddIngredient("decider-combinator", "malleable-logarithmic-casing", 2)
    rm.AddIngredient("constant-combinator", "malleable-logarithmic-casing", 1)
    rm.ReplaceIngredientProportional("power-switch", "iron-plate", "malleable-logarithmic-casing", 0.4)
    rm.ReplaceIngredientProportional("display-panel", "iron-plate", "galvanized-panel")
    rm.ReplaceIngredientProportional("programmable-speaker", "iron-plate", "galvanized-panel")
    rm.ReplaceIngredientProportional("programmable-speaker", "iron-stick", "galvanized-rod")
    tm.AddPrerequisite("circuit-network", "electroplating")
end

--PRODUCTION

--MINING
if misc.difficulty > 1 then
    if mods["IfNickel"] then --gears quasi-represent motors when motors don't exist as an item
        rm.ReplaceIngredientProportional("electric-mining-drill", "iron-gear-wheel", "linkages")
    end

    rm.AddIngredient("electric-mining-drill", "flywheel", 1)
    rm.ReplaceIngredientProportional("pumpjack", "iron-gear-wheel", "flywheel", 1, 5)
end

if misc.starting_planet ~= "vulcanus" then
    rm.ReplaceIngredientProportional("pumpjack", "steel-plate", "galvanized-steel-plate")
    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("pumpjack", "pipe", "galvanized-tubing")
    end
end

--CRAFTING MACHINES

if rm.GetIngredientCount("assembling-machine-3", "electric-engine-unit") == 0 then
    rm.AddIngredient("assembling-machine-3", "electric-engine-unit", 2)
end
if misc.difficulty == 1 then
    rm.AddIngredient("assembling-machine-3", "bearing", 5)
else
    rm.ReplaceIngredientProportional("assembling-machine-1", "iron-gear-wheel", "linkages")

    tm.AddPrerequisite("automation-2", "mechanical-engineering")
    rm.ReplaceIngredientProportional("assembling-machine-2", "iron-gear-wheel", "fast-gearbox", 0.2)
    rm.AddIngredient("assembling-machine-3", "express-gearbox", 2)
    if data.raw.item["nitinol-plate"] then
        tm.AddPrerequisite("automation-3", "nitinol-processing")
    end
    rm.AddIngredient("assembling-machine-3", "complex-joint", 5)
end

if misc.difficulty == 3 then
    if misc.starting_planet ~= "vulcanus" then
        rm.AddIngredient("chemical-plant", "galvanized-tubing", 5)
        if not mods["BrimStuff"] then
            rm.RemoveIngredient("chemical-plant", "pipe", 5)
        end
    end
    rm.AddIngredient("oil-refinery", "galvanized-tubing", 10)
    if not mods["BrimStuff"] then
        rm.RemoveIngredient("oil-refinery", "pipe", 10)
    end
end

tm.AddPrerequisite("uranium-mining", "electric-engine")
rm.AddIngredient("centrifuge", "electric-engine-unit", 10)

if misc.difficulty == 1 then
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("chemical-plant", "steel-plate", "galvanized-steel-plate")
    end
    rm.ReplaceIngredientProportional("oil-refinery", "steel-plate", "galvanized-steel-plate")
else
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("chemical-plant", "steel-plate", "hardened-hull")
    end
    rm.ReplaceIngredientProportional("oil-refinery", "steel-plate", "hardened-hull")
    rm.ReplaceIngredientProportional("electric-furnace", "steel-plate", "hardened-hull", 0.5)
    rm.ReplaceIngredientProportional("rocket-silo", "steel-plate", "hardened-hull", 0.5, 200)
    rm.AddIngredient("rocket-silo", "complex-joint", 100)
    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("rocket-silo", "pipe", "galvanized-tubing")
    end
end

--GENERATORS

rm.AddIngredient("steam-turbine", "bearing", 5)

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("accumulator", "iron-plate", "galvanized-panel", 2)
    rm.ReplaceIngredientProportional("heat-exchanger", "pipe", "galvanized-tubing")
    rm.ReplaceIngredientProportional("steam-turbine", "pipe", "galvanized-tubing")
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("solar-panel", "steel-plate", "loadbearing-lattice")
        tm.AddPrerequisite("solar-energy", "electroplating")
    end
else
    if misc.starting_planet ~= "vulcanus" then
        rm.ReplaceIngredientProportional("solar-panel", "steel-plate", "galvanized-steel-plate")
    end
end

if misc.difficulty > 1 then
    rm.AddIngredient("solar-panel", "linkages", 4) --coordinated sun tracking
    rm.AddIngredient("steam-engine", "flywheel", 2)

    rm.ReplaceIngredientProportional("nuclear-reactor", "steel-plate", "hardened-hull", 0.5)
    rm.ReplaceIngredientProportional("heat-exchanger", "steel-plate", "hardened-hull")
end

--MILITARY

--AMMUNITION

if mods["space-age"] and misc.difficulty < 3 then
    rm.RemoveIngredient("firearm-magazine", "iron-plate", 1) -- this is a boon in space platform energy (brass smelting is faster) at minor complexity cost
    rm.RemoveIngredient("firearm-magazine", "lead-plate", 1) -- this is a boon in space platform energy (brass smelting is faster) at minor complexity cost
end
rm.AddIngredient("firearm-magazine", "brass-plate", 1)
rm.AddIngredient("shotgun-shell", "brass-plate", 1)
rm.AddIngredient("cannon-shell", "brass-plate", 2)
rm.AddIngredient("explosive-cannon-shell", "brass-plate", 2)

if misc.difficulty > 1 and not data.raw.item["tracker"] then
    if rm.GetIngredientCount("artillery-shell", "gyro") == 0 then
        rm.AddIngredient("artillery-shell", "gyro", 1)
    end
    rm.RemoveIngredient("artillery-shell", "radar", 1)
end

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("poison-capsule", "steel-plate", "malleable-logarithmic-casing")
    rm.ReplaceIngredientProportional("slowdown-capsule", "steel-plate", "malleable-logarithmic-casing")
    --rm.ReplaceIngredientProportional("land-mine", "steel-plate", "malleable-logarithmic-casing")
    rm.AddIngredient("defender-capsule", "malleable-logarithmic-casing", 1)
end

if misc.difficulty > 1 then
    if rm.GetIngredientCount("distractor-capsule", "gyro") == 0 then
        rm.AddIngredient("distractor-capsule", "gyro", 1)
    else
        rm.RemoveIngredient("distractor-capsule", "gyro", 2)
    end
end

--EQUIPMENT

if misc.difficulty > 1 then
    rm.AddIngredient("exoskeleton-equipment", "complex-joint", 10)
else
    rm.AddIngredient("exoskeleton-equipment", "bearing", 20)
end

--TURRETS

if misc.difficulty > 1 then
    rm.AddIngredient("gun-turret", "flywheel", 1)
    rm.ReplaceIngredientProportional("flamethrower-turret", "iron-gear-wheel", "linkages")
end
rm.ReplaceIngredientProportional("gun-turret", "copper-plate", "brass-plate")

rm.ReplaceIngredientProportional("gate", "steel-plate", "galvanized-steel-plate")
rm.ReplaceIngredientProportional("laser-turret", "steel-plate", "galvanized-steel-plate")

if misc.difficulty == 3 and mods["space-age"] then
    rm.ReplaceIngredientProportional("artillery-turret", "iron-gear-wheel", "spurving-bearing", 0.25)
    rm.ReplaceIngredientProportional("artillery-wagon", "iron-gear-wheel", "spurving-bearing", 0.25)
else
    rm.ReplaceIngredientProportional("artillery-turret", "iron-gear-wheel", "complex-joint", 0.25)
    rm.ReplaceIngredientProportional("artillery-wagon", "iron-gear-wheel", "complex-joint", 0.25)
end

if misc.difficulty < 3 then
    if mods["IfNickel"] then
        if misc.difficulty == 1 then
            rm.AddIngredient("laser-turret", "iron-gear-wheel", 5)
        end
    else
        rm.AddIngredient("laser-turret", "iron-gear-wheel", 10)
    end
end
if misc.difficulty > 1 then
    tm.AddPrerequisite("laser-turret", "electric-engine")
    if rm.GetIngredientCount("laser-turret", "gyro") == 0 then
        rm.AddIngredient("laser-turret", "gyro", 1)
    end
    if misc.difficulty == 3 then
        if data.raw.item["nitinol-plate"] then
            tm.AddPrerequisite("laser-turret", "nitinol-processing")
        end
        rm.AddIngredient("laser-turret", "complex-joint", 1)
    end
end


-- ???

if misc.difficulty ~= 1 then
    if misc.difficulty == 2 then
        tm.AddPrerequisite("fluid-handling", "hardened-hull")
    else
        tm.AddUnlock("electroplating", "hardened-hull", "-loadbearing-lattice")
        tm.AddPrerequisite("fluid-handling", "invar-processing")
    end
    if misc.difficulty == 3 then
        
        if mods["IfNickel"] then
            if misc.starting_planet ~= "vulcanus" then
                rm.ReplaceIngredientProportional("high-pressure-valve", "pipe", "galvanized-tubing")
            end
            rm.ReplaceIngredientProportional("self-regulating-valve", "pipe", "galvanized-tubing")
        else
            rm.ReplaceIngredientProportional("pump", "pipe", "galvanized-tubing", 2)
        end

    else
    end

end