-- Section 1: Tents (tent.obj / tent-canvas.obj)
-- 5 blocks wide, 4 blocks deep. The frame is crafted from 7 sticks in an
-- upside-down U; add 3 yellow wool to stretch the canvas over it.
local ea = expedition_assets
local S = ea.S

-- Footprint relative to the node the tent is placed in (before rotation).
-- Width x = -2..2, depth z = -1..2, height y = 0..3  (matches the mesh)
local FOOT = {x0 = -2, x1 = 2, z0 = -1, z1 = 2, y0 = 0, y1 = 3}

local function rotate(x, z, rot)
	for _ = 1, rot do
		x, z = z, -x
	end
	return x, z
end

local function each_footprint_pos(pos, param2, fn)
	local rot = param2 % 4
	for x = FOOT.x0, FOOT.x1 do
		for z = FOOT.z0, FOOT.z1 do
			local rx, rz = rotate(x, z, rot)
			for y = FOOT.y0, FOOT.y1 do
				if fn({x = pos.x + rx, y = pos.y + y, z = pos.z + rz}) == false then
					return false
				end
			end
		end
	end
	return true
end

local function tent_on_place(itemstack, placer, pointed)
	local handled = ea.call_rightclick(itemstack, placer, pointed)
	if handled then return handled end
	if pointed.type ~= "node" or not placer then return itemstack end

	local name = placer:get_player_name()
	local under = minetest.get_node(pointed.under)
	local udef = minetest.registered_nodes[under.name]
	local pos = (udef and udef.buildable_to) and pointed.under or pointed.above
	local param2 = minetest.dir_to_facedir(placer:get_look_dir())

	local blocked
	local ok = each_footprint_pos(pos, param2, function(p)
		if minetest.is_protected(p, name) then
			blocked = S("That area is protected.")
			return false
		end
		local def = minetest.registered_nodes[minetest.get_node(p).name]
		if not def or not def.buildable_to then
			blocked = S("Not enough room - a tent needs a free area of 5 x 4 blocks (4 high).")
			return false
		end
	end)
	if not ok then
		minetest.chat_send_player(name, minetest.colorize("#ffbb55", blocked))
		return itemstack
	end

	minetest.set_node(pos, {name = itemstack:get_name(), param2 = param2})
	minetest.sound_play("default_place_node", {pos = pos, gain = 0.6}, true)
	if not ea.is_creative(name) then
		itemstack:take_item()
	end
	return itemstack
end

local function register_tent(id, desc, mesh, inv, walkable)
	minetest.register_node("expedition_assets:" .. id, {
		description = desc,
		_doc_items_longdesc = S("A 5 x 4 block expedition tent."),
		drawtype = "mesh",
		mesh = mesh,
		tiles = {"expedition_assets_colormap.png"},
		inventory_image = inv,
		wield_image = inv,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = walkable, -- walk right in
		is_ground_content = false,
		selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}},
		groups = ea.wood_groups({flammable = 3}),
		_mcl_hardness = 1, _mcl_blast_resistance = 1,
		sounds = ea.sound_wood(),
		stack_max = 16,
		on_place = tent_on_place,
	})
end

register_tent("tent", S("Tent Frame (5x4)"), "expedition_assets_tent.obj",
	"expedition_assets_tent_inv.png", false)
register_tent("tent_canvas", S("Expedition Tent (5x4)"), "expedition_assets_tent_canvas.obj",
	"expedition_assets_tent_canvas_inv.png", true)

-- 7 sticks in an upside-down U
minetest.register_craft({
	output = "expedition_assets:tent",
	recipe = {
		{ea.craft.stick, ea.craft.stick, ea.craft.stick},
		{ea.craft.stick, "", ea.craft.stick},
		{ea.craft.stick, "", ea.craft.stick},
	},
})

if ea.craft.yellow_wool then
	local w = ea.craft.yellow_wool
	minetest.register_craft({
		type = "shapeless",
		output = "expedition_assets:tent_canvas",
		recipe = {"expedition_assets:tent", w, w, w},
	})
else
	minetest.log("warning", "[expedition_assets] no yellow wool found - tent canvas recipe skipped")
end
