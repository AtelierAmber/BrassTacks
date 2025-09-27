script.on_init(
  function()
    if remote.interfaces["freeplay"] then
      local care_package = remote.call("freeplay", "get_created_items")
      if settings.global["brasstacks-starting-items"].value then
        care_package["brass-plate"] = 100
      end
      remote.call("freeplay", "set_created_items", care_package)
    end
  end
)

script.on_init(
  function()
    local luna = game.surfaces["luna"]
    if game.active_mods["LunarLandings"] and luna then
      local cheese_settings = game.surfaces.nauvis.map_gen_settings.autoplace_controls["cheese-ore"]
      local mgs = luna.map_gen_settings
      mgs.autoplace_controls["cheese-ore"] = cheese_settings
      mgs.autoplace_settings.entity.settings["cheese-ore"] = cheese_settings
      luna.map_gen_settings = mgs
      luna.regenerate_entity("cheese-ore")
    end
  end
)

script.on_configuration_changed(
  function()
    for redacted, theForce in pairs(game.forces) do
      for k, v in pairs(theForce.technologies) do
        if v.researched then
          for k2, v2 in pairs(v.effects) do
            if v2.recipe then
              theForce.recipes[v2.recipe].enabled = true
            end
          end
        end
      end
    end
  end
)
