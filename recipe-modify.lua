local recipemod = {}

local function AddToIngList(ingredients, toadd, count)
  local done = false
  for k, v in pairs(ingredients) do
    if v[1] == toadd then
      v[2] = v[2] + count
      done = true
      break
    end
    if v["name"] == toadd then
      v["amount"] = v["amount"] + count
      done = true
      break
    end
  end
  if not done then
    if data.raw.fluid[toadd] then
      table.insert(ingredients, {type="fluid", name=toadd, amount=count})
    else
      table.insert(ingredients, {toadd, count})
    end
  end
end

function recipemod.AddIngredient(recipename, ingredient, normalamt, expensiveamt)
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and normalamt and normalamt > 0 then
      AddToIngList(rec.ingredients, ingredient, normalamt)
    end
    if rec.normal and normalamt and normalamt > 0 then
      AddToIngList(rec.normal.ingredients, ingredient, normalamt)
    end
    if rec.expensive and expensiveamt and expensiveamt > 0 then
      AddToIngList(rec.expensive.ingredients, ingredient, expensiveamt)
    end
  end
end

local function RemoveFromIngList(ingredients, toremove, count)
  local done = false
  for k, v in pairs(ingredients) do
    if v[1] == toremove then
      if v[2] > count then
        v[2] = v[2] - count
      else
        ingredients[k] = nil
      end
      return true
    end
    if v["name"] == toremove then
      if v["amount"] > count then
        v["amount"] = v["amount"] - count
      else
        ingredients[k] = nil
      end
      return true
    end
  end
  return false
end

--no checks for >0. remove 0 is effectively a test if ingredient is present.
function recipemod.RemoveIngredient(recipename, ingredient, normalamt, expensiveamt)
  local removed = false;
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and normalamt then
      removed = RemoveFromIngList(rec.ingredients, ingredient, normalamt) or removed
    end
    if rec.normal and normalamt then
      removed = RemoveFromIngList(rec.normal.ingredients, ingredient, normalamt) or removed
    end
    if rec.expensive and expensiveamt then
      removed = RemoveFromIngList(rec.expensive.ingredients, ingredient, expensiveamt) or removed
    end
  end
  return removed
end

--ONLY INTENDED FOR MULTI PRODUCT RECIPES
function recipemod.RemoveProduct(recipename, product, normalamt, expensiveamt)
  local removed = false;
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.results and normalamt then
      removed = RemoveFromIngList(rec.results, product, normalamt) or removed
    end
    if rec.normal and rec.normal.results and normalamt then
      removed = RemoveFromIngList(rec.normal.results, product, normalamt) or removed
    end
    if rec.expensive and rec.expensive.results and expensiveamt then
      removed = RemoveFromIngList(rec.expensive.results, product, expensiveamt) or removed
    end
  end
  return removed
end

function recipemod.AddProductRaw(recipename, product, expensiveproduct)
  if not expensiveproduct then
    expensiveproduct = product
  end
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.results and product then
      table.insert(rec.results, product)
    else
      if rec.result then
        rec.results = {{rec.result, rec.result_count or 1}, product}
        rec.result = nil
        rec.result_count = nil
      else
        rec.results = {product}
      end
    end
    if rec.normal then
      if rec.normal.results and product then
        table.insert(rec.results, product)
      else
        if rec.normal.result then
          rec.normal.results = {{rec.normal.result, rec.normal.result_count or 1}, product}
          rec.normal.result = nil
          rec.normal.result_count = nil
        else
          rec.normal.results = {product}
        end
      end
    end
    if rec.expensive then
      if rec.expensive.results and expensiveproduct then
        table.insert(rec.results, expensiveproduct)
      else
        if rec.expensive.result then
          rec.expensive.results = {{rec.expensive.result, rec.expensive.result_count or 1}, expensiveproduct}
          rec.expensive.result = nil
          rec.expensive.result_count = nil
        else
          rec.expensive.results = {expensiveproduct}
        end
      end
    end
  end
end

--faster than one then the other
local function ReplaceInIngList(ingredients, toadd, toremove, count)
  local done = false
  local delete_index = -1
  for k, v in pairs(ingredients) do
    if v[1] == toadd then
      v[2] = v[2] + count
      done = true
    end
    if v["name"] == toadd then
      v["amount"] = v["amount"] + count
      done = true
    end
    if v[1] == toremove then
      if v[2] > count then
        v[2] = v[2] - count
      else
        delete_index = k
      end
    end
    if v["name"] == toremove then
      if v["amount"] > count then
        v["amount"] = v["amount"] - count
      else
        delete_index = k
      end
    end
  end
  if delete_index ~= -1 then
    ingredients[delete_index] = nil
  end
  if not done then
    if data.raw.fluid[toadd] then
      table.insert(ingredients, {type="fluid", name=toadd, amount=count})
    else
      table.insert(ingredients, {toadd, count})
    end
  end
end

function recipemod.ReplaceIngredient(recipename, toreplace, ingredient, normalamt, expensiveamt)
  local rec = data.raw.recipe[recipename]
  if rec then
    if rec.ingredients and normalamt and normalamt > 0 then
      ReplaceInIngList(rec.ingredients, ingredient, toreplace, normalamt)
    end
    if rec.normal and normalamt and normalamt > 0 then
      ReplaceInIngList(rec.normal.ingredients, ingredient, toreplace, normalamt)
    end
    if rec.expensive and expensiveamt and expensiveamt > 0 then
      ReplaceInIngList(rec.expensive.ingredients, ingredient, toreplace, expensiveamt)
    end
  end
end

local function migrateVar(from, to, varname)
  if from[varname] ~= nil then --we want to copy an explicit false
    to[varname] = from[varname]
    from[varname] = nil
  end
end

--convert a recipe to have normal and expensive variants
function recipemod.Expensify(recipename)
  if data.raw.recipe[recipename] then
    local rec = data.raw.recipe[recipename]
    if rec.normal then
      if rec.expensive then return end
      rec.expensive = table.deepcopy(rec.normal)
      return
    end
    if rec.expensive then
      rec.normal = table.deepcopy(rec.expensive)
      return
    end
    rec.normal = {}
    migrateVar(rec, rec.normal, "ingredients")
    migrateVar(rec, rec.normal, "result")
    migrateVar(rec, rec.normal, "result_count")
    migrateVar(rec, rec.normal, "results")
    migrateVar(rec, rec.normal, "energy_required")
    migrateVar(rec, rec.normal, "emissions_multiplier")
    migrateVar(rec, rec.normal, "requester_paste_multiplier")
    migrateVar(rec, rec.normal, "overload_multiplier")
    migrateVar(rec, rec.normal, "allow_inserter_overload")
    migrateVar(rec, rec.normal, "enabled")
    migrateVar(rec, rec.normal, "hidden")
    migrateVar(rec, rec.normal, "hide_from_stats")
    migrateVar(rec, rec.normal, "hide_from_player_crafting")
    migrateVar(rec, rec.normal, "allow_decomposition")
    migrateVar(rec, rec.normal, "allow_as_intermediate")
    migrateVar(rec, rec.normal, "allow_intermediates")
    migrateVar(rec, rec.normal, "always_show_made_in")
    migrateVar(rec, rec.normal, "show_amount_in_title")
    migrateVar(rec, rec.normal, "always_show_products")
    migrateVar(rec, rec.normal, "unlock_results")
    migrateVar(rec, rec.normal, "main_product")
    rec.expensive = table.deepcopy(rec.normal)
  end
end

function recipemod.CheckIngredient(recipename, ingredient, mode) -- omit mode to search all
  local rec = data.raw.recipe[recipename]
  if not rec then return false end
  if mode ~= "expensive" then
    if rec.ingredients then
      for k, v in pairs(rec.ingredients) do
        if v[1] == ingredient then return true end
        if v["name"] == ingredient then return true end
      end
    end
    if rec.normal and rec.normal.ingredients then
      for k, v in pairs(rec.normal.ingredients) do
        if v[1] == ingredient then return true end
        if v["name"] == ingredient then return true end
      end
    end
  end
  if mode ~= "normal" then
    if rec.expensive and rec.expensive.ingredients then
      for k, v in pairs(rec.expensive.ingredients) do
        if v[1] == ingredient then return true end
        if v["name"] == ingredient then return true end
      end
    end
  end
  return false
end

function recipemod.ReplaceProportional(recipename, ingredient, replacement, factor, mode) -- omit mode to search all
  local rec = data.raw.recipe[recipename]
  if not rec then return false end
  local cheapamt = 0
  local expensiveamt = 0
  if mode ~= "expensive" then
    if rec.ingredients then
      for k, v in pairs(rec.ingredients) do
        if v["name"] == ingredient or v[1] == ingredient then
          if v["amount"] then
            cheapamt = v["amount"]
          else if v[2] then
            cheapamt = v[2]
          end end
        end
      end
    end
    if rec.normal and rec.normal.ingredients then
      for k, v in pairs(rec.normal.ingredients) do
        if v["name"] == ingredient or v[1] == ingredient then
          if v["amount"] then
            cheapamt = v["amount"]
          else if v[2] then
            cheapamt = v[2]
          end end
        end
      end
    end
  end
  if mode ~= "normal" then
    if rec.expensive and rec.expensive.ingredients then
      for k, v in pairs(rec.expensive.ingredients) do
        if v["name"] == ingredient or v[1] == ingredient then
          if v["amount"] then
            expensiveamt = v["amount"]
          else if v[2] then
            expensiveamt = v[2]
          end end
        end
      end
    end
  end
  local function final_amount(num)
    if num <= 0 then return 0 end
    return math.max(1, math.floor(num))
  end
  if factor >= 1 then
    recipemod.ReplaceIngredient(recipename, ingredient, replacement, final_amount(cheapamt * factor), final_amount(expensiveamt * factor))
  else
    recipemod.RemoveIngredient(recipename, ingredient, cheapamt, expensiveamt)
    recipemod.AddIngredient(recipename, replacement, final_amount(cheapamt * factor), final_amount(expensiveamt * factor))
  end
end

function recipemod.multiply(recipe, factor, cost, output, time)
  if type(recipe) == "string" then
    if data.raw.recipe[recipe] then
      recipemod.multiply(data.raw.recipe[recipe], factor, cost, output, time)
    end
    return
  end
  if recipe.ingredients and cost then
    for k, v in pairs(recipe.ingredients) do
      if v[2] then v[2] = v[2] * factor end
      if v["amount"] then v["amount"] = v["amount"] * factor end
    end
  end
  if output then
    if recipe.results then
      for k, v in pairs(recipe.results) do
        if v[2] then v[2] = v[2] * factor end
        if v["amount"] then v["amount"] = v["amount"] * factor end
        if v["amount_min"] then v["amount_min"] = v["amount_min"] * factor end
        if v["amount_max"] then v["amount_max"] = v["amount_max"] * factor end
      end
    else
      if recipe.result_count then
        recipe.result_count = recipe.result_count * factor
      else
        recipe.result_count = factor
      end
    end
  end
  if time then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * factor
    else
      recipe.energy_required = factor / 2
    end
  end
  if recipe.normal then
    recipemod.multiply(recipe.normal, factor, cost, output, time)
  end
  if recipe.expensive then
    recipemod.multiply(recipe.expensive, factor, cost, output, time)
  end
end

return recipemod
