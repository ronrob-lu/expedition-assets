-- Section 1: Tin tools (tool-*.obj)
-- Crafted like the classic tools, but with tin + sticks.
-- Sneak + right-click on the ground to put a tool down as a 3D model;
-- dig the model to pick the tool up again (wear is preserved).
local ea = expedition_assets
local S = ea.S

local T, St = ea.craft.tin, ea.craft.stick

local TOOLS = {
	shovel = {
		description = S("Tin Shovel"),
		recipe = {{T}, {St}, {St}},
		groups = {shovel = 1},
		caps = {
			full_punch_interval = 1.1, max_drop_level = 1,
			groupcaps = {crumbly = {times = {[1] = 1.50, [2] = 0.90, [3] = 0.40}, uses = 25, maxlevel = 2}},
			damage_groups = {fleshy = 3},
		},
		mcl = {shovely = {speed = 4, level = 3, uses = 180}},
	},
	axe = {
		description = S("Tin Axe"),
		recipe = {{T, T}, {T, St}, {"", St}},
		groups = {axe = 1},
		caps = {
			full_punch_interval = 1.0, max_drop_level = 1,
			groupcaps = {choppy = {times = {[1] = 2.50, [2] = 1.40, [3] = 1.00}, uses = 25, maxlevel = 2}},
			damage_groups = {fleshy = 5},
		},
		mcl = {axey = {speed = 4, level = 3, uses = 180}},
	},
	pickaxe = {
		description = S("Tin Pickaxe"),
		recipe = {{T, T, T}, {"", St, ""}, {"", St, ""}},
		groups = {pickaxe = 1},
		caps = {
			full_punch_interval = 1.0, max_drop_level = 1,
			groupcaps = {cracky = {times = {[1] = 4.00, [2] = 1.60, [3] = 0.80}, uses = 25, maxlevel = 2}},
			damage_groups = {fleshy = 4},
		},
		mcl = {pickaxey = {speed = 4, level = 3, uses = 180}},
	},
	-- Like a pickaxe, but with one stick less: shorter handle, quicker on soft
	-- stone, wears out faster - perfect for cracking open fossils.
	hammer = {
		description = S("Tin Rock Hammer"),
		recipe = {{T, T, T}, {"", St, ""}},
		groups = {pickaxe = 1},
		caps = {
			full_punch_interval = 0.9, max_drop_level = 1,
			groupcaps = {cracky = {times = {[1] = 4.20, [2] = 1.40, [3] = 0.60}, uses = 15, maxlevel = 2}},
			damage_groups = {fleshy = 5},
		},
		mcl = {pickaxey = {speed = 5, level = 3, uses = 110}},
	},
	hoe = {
		description = S("Tin Hoe"),
		recipe = {{T, T}, {"", St}, {"", St}},
		groups = {hoe = 1},
		caps = {full_punch_interval = 1.0, damage_groups = {fleshy = 2}},
		mcl = {hoey = {speed = 4, level = 3, uses = 180}},
	},
}
local ORDER = {"shovel", "axe", "pickaxe", "hammer", "hoe"}

local HOE_USES = 200

-- VoxeLibre / Mineclonia: simple soil tilling for the hoe
local function mcl_till(itemstack, user, pointed)
	if pointed.type ~= "node" or not minetest.registered_nodes["mcl_farming:soil"] then
		return nil
	end
	local node = minetest.get_node(pointed.under)
	local above = minetest.get_node(pointed.above)
	if (node.name == "mcl_core:dirt" or node.name == "mcl_core:dirt_with_grass")
			and above.name == "air" and pointed.above.y > pointed.under.y then
		local name = user:get_player_name()
		if minetest.is_protected(pointed.under, name) then
			minetest.record_protection_violation(pointed.under, name)
			return itemstack
		end
		minetest.set_node(pointed.under, {name = "mcl_farming:soil"})
		if not ea.is_creative(name) then
			itemstack:add_wear(math.ceil(65535 / HOE_USES))
		end
		return itemstack
	end
end

local function put_down(itemstack, placer, pointed, display_name)
	if pointed.type ~= "node" then return itemstack end
	local name = placer:get_player_name()
	local pos = pointed.above
	local under = minetest.get_node(pointed.under)
	local udef = minetest.registered_nodes[under.name]
	if udef and udef.buildable_to then pos = pointed.under end
	local def = minetest.registered_nodes[minetest.get_node(pos).name]
	if not def or not def.buildable_to then return itemstack end
	if minetest.is_protected(pos, name) then
		minetest.record_protection_violation(pos, name)
		return itemstack
	end
	minetest.set_node(pos, {name = display_name,
		param2 = minetest.dir_to_facedir(placer:get_look_dir())})
	local meta = minetest.get_meta(pos)
	meta:set_int("wear", itemstack:get_wear())
	meta:set_string("infotext", itemstack:get_short_description() or "")
	itemstack:take_item()
	return itemstack
end

for _, id in ipairs(ORDER) do
	local t = TOOLS[id]
	local name = "expedition_assets:tool_" .. id
	local display = "expedition_assets:display_" .. id
	local inv = "expedition_assets_tool_" .. id .. "_inv.png"

	local groups = {tool = 1}
	for k, v in pairs(t.groups) do groups[k] = v end
	if ea.is_mcl then
		groups.dig_speed_class = 3
		groups.enchantability = 14
	end

	local def = {
		description = t.description,
		_doc_items_longdesc = S("A tin tool for expeditions. Sneak + place to put it down."),
		inventory_image = inv,
		wield_image = inv,
		wield_scale = {x = 1.2, y = 1.2, z = 1},
		groups = groups,
		tool_capabilities = t.caps,
		_mcl_diggroups = t.mcl,
		_mcl_toollike_wield = true,
		_repair_material = T,
		sound = {breaks = "default_tool_breaks"},

		on_place = function(itemstack, placer, pointed)
			if not placer or not placer:is_player() then return itemstack end
			if placer:get_player_control().sneak then
				return put_down(itemstack, placer, pointed, display)
			end
			local handled = ea.call_rightclick(itemstack, placer, pointed)
			if handled then return handled end
			if id == "hoe" and ea.is_mcl then
				return mcl_till(itemstack, placer, pointed) or itemstack
			end
			return itemstack
		end,
	}

	if id == "hoe" and minetest.global_exists("farming") and farming.hoe_on_use then
		def.on_use = function(itemstack, user, pointed)
			return farming.hoe_on_use(itemstack, user, pointed, HOE_USES)
		end
	end

	minetest.register_tool(name, def)

	if T then
		minetest.register_craft({output = name, recipe = t.recipe})
	end

	-- The 3D model lying/standing on the ground
	minetest.register_node(display, {
		description = t.description,
		drawtype = "mesh",
		mesh = "expedition_assets_tool_" .. id .. ".obj",
		tiles = {"expedition_assets_colormap.png"},
		inventory_image = inv,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = false,
		is_ground_content = false,
		selection_box = {type = "fixed", fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}},
		groups = {dig_immediate = 3, attached_node = 1, not_in_creative_inventory = 1,
			handy = 1, deco_block = 1},
		_mcl_hardness = 0,
		sounds = ea.sound_wood(),
		drop = name,
		on_dig = function(pos, node, digger)
			if not digger or not digger:is_player() then return false end
			local pname = digger:get_player_name()
			if minetest.is_protected(pos, pname) then
				minetest.record_protection_violation(pos, pname)
				return false
			end
			local stack = ItemStack(name)
			stack:set_wear(minetest.get_meta(pos):get_int("wear"))
			minetest.remove_node(pos)
			ea.give_or_drop(digger, stack, pos)
			return true
		end,
	})
end

if not T then
	minetest.log("warning", "[expedition_assets] no tin/copper/iron ingot found - tool recipes skipped")
end
