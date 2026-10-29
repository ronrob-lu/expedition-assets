-- Section 1: Expedition Box (box.obj / box-open.obj)
-- A one-node supply chest, pre-stocked with expedition gear. Not craftable.
local ea = expedition_assets
local S = ea.S
local F = minetest.formspec_escape

local BOX = "expedition_assets:box"
local BOX_OPEN = "expedition_assets:box_open"
local SLOTS = 32

ea.tool_names = {
	"expedition_assets:tool_shovel", "expedition_assets:tool_axe",
	"expedition_assets:tool_pickaxe", "expedition_assets:tool_hammer",
	"expedition_assets:tool_hoe",
}
ea.sign_names = {"expedition_assets:signpost", "expedition_assets:signpost_single"}

--- The starter kit: 10 yellow wool, 20 planks, 2 of each tool, 4 of each signpost.
function ea.box_contents()
	local list = {}
	if ea.craft.yellow_wool then list[#list + 1] = ea.craft.yellow_wool .. " 10" end
	if ea.craft.planks_item then list[#list + 1] = ea.craft.planks_item .. " 20" end
	for _, tool in ipairs(ea.tool_names) do
		list[#list + 1] = tool
		list[#list + 1] = tool
	end
	for _, sign in ipairs(ea.sign_names) do
		list[#list + 1] = sign .. " 4"
	end
	return list
end

function ea.fill_box(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	inv:set_size("main", SLOTS)
	for _, item in ipairs(ea.box_contents()) do
		inv:add_item("main", item)
	end
end

--- Place a fully stocked box (used by the structure builders).
function ea.place_box(pos, param2)
	minetest.set_node(pos, {name = BOX, param2 = param2 or 0})
	ea.fill_box(pos)
end

-- Who has which box open: open_boxes[player_name] = pos
local open_boxes = {}

local function box_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local cols = ea.is_mcl and 9 or 8
	return "size[" .. cols .. ",9]" ..
		"label[0,0;" .. F(S("Expedition Box")) .. "]" ..
		"list[nodemeta:" .. spos .. ";main;0,0.5;8,4;]" ..
		"list[current_player;main;0,5;" .. cols .. ",4;]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]"
end

local function play(pos, sound)
	if minetest.get_modpath("default") then
		minetest.sound_play(sound, {pos = pos, gain = 0.3, max_hear_distance = 10}, true)
	end
end

local function still_open(pos)
	for _, p in pairs(open_boxes) do
		if vector.equals(p, pos) then return true end
	end
	return false
end

local function close_box(name)
	local pos = open_boxes[name]
	if not pos then return end
	open_boxes[name] = nil
	if still_open(pos) then return end
	local node = minetest.get_node(pos)
	if node.name == BOX_OPEN then
		minetest.swap_node(pos, {name = BOX, param2 = node.param2})
		play(pos, "default_chest_close")
	end
end

local function can_access(pos, player)
	local name = player:get_player_name()
	if minetest.is_protected(pos, name) then
		minetest.record_protection_violation(pos, name)
		return false
	end
	return true
end

local function box_def(mesh, open)
	return {
		description = open and S("Expedition Box (open)") or S("Expedition Box"),
		_doc_items_longdesc = S("A sturdy supply box packed with expedition gear."),
		drawtype = "mesh",
		mesh = mesh,
		tiles = {"expedition_assets_colormap.png"},
		inventory_image = "expedition_assets_box_inv.png",
		wield_image = "expedition_assets_box_inv.png",
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}},
		collision_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}},
		groups = ea.wood_groups({container = 2, not_in_creative_inventory = open and 1 or nil}),
		_mcl_hardness = 2.5, _mcl_blast_resistance = 2.5,
		sounds = ea.sound_wood(),
		drop = BOX,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", S("Expedition Box"))
			meta:get_inventory():set_size("main", SLOTS)
		end,

		-- New boxes come stocked; boxes that were dug come back empty.
		after_place_node = function(pos, placer, itemstack)
			if itemstack:get_meta():get_string("empty") ~= "1" then
				ea.fill_box(pos)
			end
		end,

		preserve_metadata = function(pos, oldnode, oldmeta, drops)
			for _, stack in ipairs(drops) do
				if stack:get_name() == BOX then
					local m = stack:get_meta()
					m:set_string("empty", "1")
					m:set_string("description", S("Expedition Box (empty)"))
				end
			end
		end,

		can_dig = function(pos)
			return minetest.get_meta(pos):get_inventory():is_empty("main")
		end,

		on_rightclick = function(pos, node, clicker, itemstack)
			if not clicker or not clicker:is_player() then return itemstack end
			if not can_access(pos, clicker) then return itemstack end
			local name = clicker:get_player_name()
			if node.name == BOX then
				minetest.swap_node(pos, {name = BOX_OPEN, param2 = node.param2})
				play(pos, "default_chest_open")
			end
			open_boxes[name] = vector.new(pos)
			minetest.show_formspec(name, "expedition_assets:box", box_formspec(pos))
			return itemstack
		end,

		allow_metadata_inventory_move = function(pos, _, _, _, _, count, player)
			return can_access(pos, player) and count or 0
		end,
		allow_metadata_inventory_put = function(pos, _, _, stack, player)
			return can_access(pos, player) and stack:get_count() or 0
		end,
		allow_metadata_inventory_take = function(pos, _, _, stack, player)
			return can_access(pos, player) and stack:get_count() or 0
		end,

		on_blast = function() end, -- explosion proof, like a safe
	}
end

minetest.register_node(BOX, box_def("expedition_assets_box.obj", false))
minetest.register_node(BOX_OPEN, box_def("expedition_assets_box_open.obj", true))

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "expedition_assets:box" and fields.quit then
		close_box(player:get_player_name())
	end
end)

minetest.register_on_leaveplayer(function(player)
	close_box(player:get_player_name())
end)

-- Boxes left open when the server stopped get closed again.
minetest.register_lbm({
	label = "Close open expedition boxes",
	name = "expedition_assets:close_boxes",
	nodenames = {BOX_OPEN},
	run_at_every_load = true,
	action = function(pos, node)
		if not still_open(pos) then
			minetest.swap_node(pos, {name = BOX, param2 = node.param2})
		end
	end,
})
