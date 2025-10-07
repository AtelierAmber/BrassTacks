local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

--mods that just use vanilla-like ore generation will not get special design effort
if mods["tenebris"] then
    data.raw.planet["tenebris"].map_gen_settings.autoplace_controls["zinc-ore"] = {}
    data.raw.planet["tenebris"].map_gen_settings.autoplace_settings.entity.settings["zinc-ore"] = {}    
end

if mods["terrapalus"] then
    data.raw.planet["terrapalus"].map_gen_settings.autoplace_controls["zinc-ore"] = {}
    data.raw.planet["terrapalus"].map_gen_settings.autoplace_settings.entity.settings["zinc-ore"] = {}    
end

if mods["maraxsis"] then
    rm.AddProduct("maraxsis-geothermal-sulfur", "sphalerite", 8)

    if misc.difficulty == 3 then
        if not mods["IfNickel"] then
            rm.ReplaceIngredientProportional("maraxsis-hydro-plant", "pipe", "galvanized-tubing")
        end
    end

    rm.ReplaceIngredientProportional("maraxsis-pressure-dome", "pipe", "pump", 0.2)
    if misc.difficulty > 1 and not mods["BrimStuff"] then
        rm.AddIngredient("maraxsis-wyrm-confinement-cell", "pipe-flange", 1)
    end
end

--cerys: I'm really not sure if you can obtain all ores in decent ratios from recycling stuff.
--as I understand it cerys is a meticulously designed puzzle, adding explicit compat would almost be like adding compat with ultracube

--arrakis, shattered planet: incomplete