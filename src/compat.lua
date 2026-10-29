-- Game compatibility helpers (Minetest Game, VoxeLibre/MineClone2, Mineclonia)
local ea = expedition_assets

ea.is_mcl = minetest.get_modpath("mcl_core") ~= nil

--- Return the first name in `list` that is a registered item, or nil.
function ea.first_registered(list)
	for _, name in ipairs(list) do
		if minetest.registered_items[name] then
			return name
		end
	end
end

-- Crafting materials (resolved at load time; mods are in optional_depends so
-- they are already registered when this file runs).
ea.craft = {
	stick = "group:stick",
	planks = "group:wood",
	tin = ea.first_registered({
		"default:tin_ingot", "mcl_copper:copper_ingot",
		"default:steel_ingot", "mcl_core:iron_ingot",
	}),
	yellow_wool = ea.first_registered({"wool:yellow", "mcl_wool:yellow"}),
	planks_item = ea.first_registered({"default:wood", "mcl_core:wood"}),
}

-- Node sounds
function ea.sound_wood()
	if minetest.global_exists("default") and default.node_sound_wood_defaults then
		return default.node_sound_wood_defaults()
	elseif minetest.global_exists("mcl_sounds") and mcl_sounds.node_sound_wood_defaults then
		return mcl_sounds.node_sound_wood_defaults()
	end
	return {}
end

--- Dig groups for wooden things in both game families.
function ea.wood_groups(extra)
	local g = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2,
		handy = 1, axey = 1, deco_block = 1}
	for k, v in pairs(extra or {}) do g[k] = v end
	return g
end

function ea.is_creative(name)
	if minetest.is_creative_enabled then
		return minetest.is_creative_enabled(name or "")
	end
	return minetest.settings:get_bool("creative_mode", false)
end

--- Give `stack` to `player`, or drop it at `pos` if the inventory is full.
function ea.give_or_drop(player, stack, pos)
	if player and player:is_player() then
		local left = player:get_inventory():add_item("main", stack)
		if left:is_empty() then return end
		stack = left
	end
	minetest.add_item(pos, stack)
end

--- Snap a player's look direction to one of the four horizontal axes.
function ea.cardinal_dir(player)
	local d = player:get_look_dir()
	if math.abs(d.x) > math.abs(d.z) then
		return {x = d.x > 0 and 1 or -1, y = 0, z = 0}
	end
	return {x = 0, y = 0, z = d.z >= 0 and 1 or -1}
end

--- Respect the on_rightclick of the pointed node (chests, doors, ...).
-- Returns the result of on_rightclick (or true) if it handled the click.
function ea.call_rightclick(itemstack, placer, pointed)
	if pointed.type ~= "node" or not placer or not placer:is_player() then
		return nil
	end
	if placer:get_player_control().sneak then return nil end
	local node = minetest.get_node(pointed.under)
	local def = minetest.registered_nodes[node.name]
	if def and def.on_rightclick then
		return def.on_rightclick(pointed.under, node, placer, itemstack, pointed) or itemstack
	end
end

ea.mcl_hardness = {_mcl_hardness = 1.5, _mcl_blast_resistance = 2}
