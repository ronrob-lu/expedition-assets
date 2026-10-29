-- Section 1: Signposts (signpost.obj / signpost-single.obj)
-- Works like the classic Minetest sign: right-click to write a text. The text
-- appears as infotext and as a floating label above the post.
local ea = expedition_assets
local S = ea.S
local F = minetest.formspec_escape

local LABEL = "expedition_assets:sign_label"
local LABEL_OFFSET = {x = 0, y = 1.75, z = 0}
local MAX_LEN = 120

minetest.register_entity(LABEL, {
	initial_properties = {
		physical = false,
		pointable = false,
		collide_with_objects = false,
		visual = "sprite",
		textures = {"blank.png"},
		visual_size = {x = 0.01, y = 0.01},
		collisionbox = {0, 0, 0, 0, 0, 0},
		selectionbox = {0, 0, 0, 0, 0, 0},
		static_save = false, -- recreated by the LBM below
		nametag_color = "#FFF4C2",
		nametag_bgcolor = "#3A2414C0",
	},
})

local function remove_labels(pos)
	for _, obj in ipairs(minetest.get_objects_inside_radius(vector.add(pos, LABEL_OFFSET), 0.6)) do
		local ent = obj:get_luaentity()
		if ent and ent.name == LABEL then obj:remove() end
	end
end

local function update_label(pos)
	remove_labels(pos)
	local text = minetest.get_meta(pos):get_string("text")
	if text == "" then return end
	local obj = minetest.add_entity(vector.add(pos, LABEL_OFFSET), LABEL)
	if obj then
		obj:set_properties({nametag = text})
	end
end

--- Write `text` on the signpost at `pos` (also used by structure builders).
function ea.set_sign_text(pos, text)
	text = (text or ""):sub(1, MAX_LEN)
	local meta = minetest.get_meta(pos)
	meta:set_string("text", text)
	meta:set_string("infotext", text ~= "" and ('"' .. text .. '"') or S("Signpost (right-click to write)"))
	update_label(pos)
end

local function register_signpost(id, desc, recipe)
	local name = "expedition_assets:" .. id
	local inv = "expedition_assets_" .. id .. "_inv.png"
	minetest.register_node(name, {
		description = desc,
		_doc_items_longdesc = S("A wooden signpost. Right-click to write on it."),
		drawtype = "mesh",
		mesh = "expedition_assets_" .. id .. ".obj",
		tiles = {"expedition_assets_colormap.png"},
		inventory_image = inv,
		wield_image = inv,
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		is_ground_content = false,
		selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.12, 0.5, 1.5, 0.12}},
		collision_box = {type = "fixed", fixed = {-0.1, -0.5, -0.1, 0.1, 1.5, 0.1}},
		groups = ea.wood_groups({sign = 1}),
		_mcl_hardness = 1, _mcl_blast_resistance = 1,
		sounds = ea.sound_wood(),
		stack_max = 16,

		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec",
				"size[6,3]" ..
				"field[0.5,1;5.5,1;text;" .. F(S("Write on the signpost:")) .. ";${text}]" ..
				"button_exit[2,2;2,1;save;" .. F(S("Save")) .. "]")
			meta:set_string("infotext", S("Signpost (right-click to write)"))
		end,

		on_receive_fields = function(pos, _, fields, sender)
			if not fields.text or not (fields.save or fields.key_enter_field) then return end
			local pname = sender:get_player_name()
			if minetest.is_protected(pos, pname) then
				minetest.record_protection_violation(pos, pname)
				return
			end
			ea.set_sign_text(pos, fields.text)
			minetest.log("action", ("[expedition_assets] %s wrote %q on signpost at %s")
				:format(pname, fields.text:sub(1, MAX_LEN), minetest.pos_to_string(pos)))
		end,

		on_destruct = remove_labels,
	})

	minetest.register_craft({output = name, recipe = recipe})
	return name
end

local P, St = ea.craft.planks, ea.craft.stick

-- Two arms: a plank on each side of the post
local double = register_signpost("signpost", S("Signpost"), {
	{P, St, P},
	{"", St, ""},
	{"", St, ""},
})
-- One arm: a plank on the right of the post
local single = register_signpost("signpost_single", S("Signpost (single)"), {
	{St, P},
	{St, ""},
	{St, ""},
})

minetest.register_lbm({
	label = "Restore expedition signpost labels",
	name = "expedition_assets:sign_labels",
	nodenames = {double, single},
	run_at_every_load = true,
	action = function(pos) update_label(pos) end,
})
