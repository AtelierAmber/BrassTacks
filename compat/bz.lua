local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["bzlead"] then
    if data.raw.item["lead-expansion-bolt"] and misc.difficulty > 1 then
        --add bolts to loadbearing lattices

        rm.AddIngredient("loadbearing-lattice", "lead-expansion-bolt", 2)
        if mods["BrimStuff"] and misc.difficulty < 3 then
            --not an overloaded recipe by any means, but one you want to be simpler
            rm.RemoveIngredient("big-electric-pole", "lead-expansion-bolt", 99999)
        end

        --the following is not super consistent with what expansion bolts actually are
        --i thought they were just a generic sort of fastener but they have a specific purpose
        --they are not used for metal-metal connections. i left them in the loadbearing lattice bc
        --it might plausibly connect to a concrete foundation

        --add bolts to hardened hulls
        --if misc.difficulty == 3 then
            --rm.AddIngredient("hardened-hull", "lead-expansion-bolt", 3)
        --elseif mods["IfNickel"] then
            --invar is a bit expensive
            --rm.AddIngredient("hardened-hull", "lead-expansion-bolt", 1)
        --else
            --rm.ReplaceIngredientProportional("hardened-hull", "iron-plate", "lead-expansion-bolt", 2)
        --end
    end

    if misc.difficulty > 1 then
        --excess ingredients in solar panel
        rm.RemoveIngredient("solar-panel", "copper-plate", 5)
    end
end

if mods["bztitanium"] then
    if misc.difficulty == 3 and mods["space-age"] then
        rm.ReplaceIngredientProportional("express-gearbox", "iron-gear-wheel", "titanium-plate", 0.4)
        rm.ReplaceIngredientProportional("express-transport-belt", "titanium-plate", "express-gearbox", 0.5)
    end
    if misc.difficulty > 1 then
        --consolidate turbine ingredients
        if misc.difficulty == 3 and mods["space-age"] then
            rm.ReplaceIngredientProportional("steam-turbine", "iron-gear-wheel", "express-gearbox", 0.2)
            rm.RemoveIngredient("steam-turbine", "bearing", 99999)
            rm.RemoveIngredient("steam-turbine", "titanium-plate", 99999)
        else
            rm.ReplaceIngredientProportional("steam-turbine", "iron-gear-wheel", "express-gearbox", 0.1)
            rm.RemoveIngredient("steam-turbine", "bearing", 99999)
        end
    end
end

if mods["bztin"] then
    if data.raw.item["bronze-plate"] then
        rm.RemoveIngredient("electric-engine-unit", "bronze-plate", 1)
        rm.AddIngredient("bearing", "bronze-plate", 1)
        if misc.difficulty < 3 then
            rm.RemoveIngredient("bearing", "brass-plate", 1)
            if misc.difficulty == 2 then --don't necessarily want to exceed 4 ingredients
                rm.AddIngredient("complex-joint", "bronze-plate", 3)
            end
        end

        if misc.difficulty > 1 then
            if not mods["IfNickel"] then
                rm.ReplaceIngredientProportional("hardened-hull", "iron-plate", "bronze-plate", 2)
            else
                rm.AddIngredient("hardened-hull", "bronze-plate", 2)
            end
            rm.RemoveIngredient("hardened-hull", "brass-plate", 1)
            rm.ReplaceIngredientProportional("storage-tank", "bronze-plate", "hardened-hull", 0.5)
        end
    end

    if misc.difficulty == 3 then
        rm.AddIngredient("malleable-logarithmic-casing", "tin-plate", 2)

        if data.raw.item["tinned-cable"] then
            data.raw.technology["tinned-cable"].hidden = true
            data.raw.technology["tinned-cable"].hidden_in_factoriopedia = true

            tm.AddUnlock("electroplating", "tinned-cable", "-depleted-zinc-salt-reprocessing")

            rm.AddIngredient("tinned-cable", "water", 100)
            rm.AddProduct("tinned-cable", "organotins", 1)
            --not realistic, but i don't want to add a tin salt waste product for this one process.
            --this makes the gameplay a bit more interesting anyway.
            
            tm.RemovePrerequisite("circuit-network", "tinned-cable")
            tm.RemovePrerequisite("oil-gathering", "tinned-cable")

            --Also you know what? My intermediate now
            if not mods["ThemTharHills"] then
                rm.ReplaceIngredientProportional("advanced-circuit", "copper-cable", "tinned-cable")
            end
        end
    end
end

if mods["bzzirconium"] then
    if misc.difficulty > 1 then
        if data.raw.item["cermet"] then
            rm.RemoveIngredient("assembling-machine-3", "cermet", 99999)
            rm.ReplaceIngredientProportional("complex-joint", "plastic-bar", "cermet", 0.5)
            rm.AddIngredient("spurving-bearing", "cermet", 1)
        else
            rm.ReplaceIngredientProportional("complex-joint", "plastic-bar", "zirconia", 1)
            rm.AddIngredient("spurving-bearing", "zirconia", 3)
        end
    end
end

if mods["bzcarbon"] then
    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("electroplating-machine", "copper-plate", "graphite", 1, 10)
        --electroplating machine is also an electrolysis machine. because of reasons.
        if data.raw.recipe["fullerenes"] then
            data.raw.recipe["fullerenes"].category = "electroplating"
        end
    end
end