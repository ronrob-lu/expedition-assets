-- Section 3: Buildings
--   /spawn_research_station  - two-storey jungle research outpost (9x9 + annex)
--   /spawn_park_entry [LINE 1|LINE 2] - giant wooden dino-park entrance gate
-- Structures are built right in front of you, facing you.
local ea = expedition_assets
local S = ea.S

---------------------------------------------------------------------------
-- Letter blocks for the park sign
---------------------------------------------------------------------------
local SYMBOLS = {["-"] = "dash", ["!"] = "excl", ["."] = "dot", ["?"] = "qmark"}
local LETTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-!.?"

function ea.letter_node(ch)
	ch = ch:upper()
	if not LETTERS:find(ch, 1, true) then return nil end
	return "expedition_assets:letter_" .. (SYMBOLS[ch] or ch:lower())
end

for i = 1, #LETTERS do
	local ch = LETTERS:sub(i, i)
	local key = SYMBOLS[ch] or ch:lower()
	local bg = "expedition_assets_letter_bg.png"
	minetest.register_node("expedition_assets:letter_" .. key, {
		description = S("Park Sign Letter '@1'", ch),
		tiles = {bg, bg, bg, bg, bg, "expedition_assets_letter_" .. key .. ".png"},
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = ea.wood_groups({letter_block = 1}),
		_mcl_hardness = 2, _mcl_blast_resistance = 3,
		sounds = ea.sound_wood(),
		on_place = minetest.rotate_node,
	})
end

---------------------------------------------------------------------------
-- Material palette (Minetest Game first, then VoxeLibre / Mineclonia)
---------------------------------------------------------------------------
local PALETTE = {
	cobble          = {"default:cobble", "mcl_core:cobble"},
	dark_bricks     = {"default:stonebrick", "mcl_deepslate:deepslate_bricks", "mcl_core:stonebrick"},
	planks          = {"default:wood", "mcl_core:wood"},
	dark_planks     = {"default:junglewood", "mcl_core:darkwood"},
	dark_log        = {"default:jungletree", "mcl_core:darktree"},
	slab_cobble     = {"stairs:slab_cobble", "mcl_stairs:slab_cobble"},
	slab_dark_wood  = {"stairs:slab_junglewood", "mcl_stairs:slab_darkwood"},
	stair_wood      = {"stairs:stair_wood", "mcl_stairs:stair_wood"},
	glass           = {"default:glass", "mcl_core:glass"},
	fence           = {"default:fence_wood", "mcl_fences:fence"},
	torch_wall      = {"default:torch_wall", "mcl_torches:torch_wall"},
	ladder          = {"default:ladder_wood", "mcl_core:ladder"},
	path            = {"default:dry_dirt", "mcl_core:grass_path", "default:dirt"},
	dirt            = {"default:dirt", "mcl_core:dirt"},
	furnace         = {"default:furnace", "mcl_furnaces:furnace"},
	metal           = {"default:steelblock", "mcl_core:ironblock"},
	bookshelf       = {"default:bookshelf", "mcl_books:bookshelf"},
}
-- If a material is missing, use this one instead
local FALLBACK = {
	dark_bricks = "cobble", slab_cobble = "cobble", slab_dark_wood = "dark_planks",
	stair_wood = "planks", dark_planks = "planks", dark_log = "dark_planks",
	path = "dirt", metal = "cobble", bookshelf = "planks", fence = "planks",
}
local resolved = {}

local function resolve(key)
	if key == "air" then return "air" end
	if key:find(":", 1, true) then
		return minetest.registered_nodes[key] and key or nil
	end
	if resolved[key] == nil then
		resolved[key] = ea.first_registered(PALETTE[key] or {}) or false
		if not resolved[key] and FALLBACK[key] then
			resolved[key] = resolve(FALLBACK[key]) or false
		end
	end
	return resolved[key] or nil
end

---------------------------------------------------------------------------
-- Builder: local coordinates (x = right, y = up, z = away from the player)
---------------------------------------------------------------------------
local Builder = {}
Builder.__index = Builder

local function new_builder(origin, forward)
	return setmetatable({
		o = origin, f = forward,
		r = {x = forward.z, y = 0, z = -forward.x},
	}, Builder)
end

function Builder:pos(x, y, z)
	return {
		x = self.o.x + self.r.x * x + self.f.x * z,
		y = self.o.y + y,
		z = self.o.z + self.r.z * x + self.f.z * z,
	}
end

function Builder:dir(v)
	return {
		x = self.r.x * v.x + self.f.x * v.z,
		y = v.y or 0,
		z = self.r.z * v.x + self.f.z * v.z,
	}
end

function Builder:facedir(v) return minetest.dir_to_facedir(self:dir(v)) end

function Builder:yaw(v)
	local d = self:dir(v)
	return math.atan2(-d.x, d.z)
end

-- opt.face = local direction for facedir nodes (stairs, furnaces, letters)
-- opt.wall = local direction pointing at the supporting wall (torches, ladders)
function Builder:set(x, y, z, key, opt)
	local name = resolve(key)
	if not name then return end
	local node = {name = name}
	if opt and opt.face then
		node.param2 = self:facedir(opt.face)
	elseif opt and opt.wall then
		node.param2 = minetest.dir_to_wallmounted(self:dir(opt.wall))
	end
	minetest.set_node(self:pos(x, y, z), node)
end

function Builder:fill(x0, x1, y0, y1, z0, z1, key, opt)
	for x = x0, x1 do
		for y = y0, y1 do
			for z = z0, z1 do
				self:set(x, y, z, key, opt)
			end
		end
	end
end

-- Fill air / water / plants below a column with dirt so nothing floats.
function Builder:support(x, z, top, depth)
	local dirt = resolve("dirt")
	if not dirt then return end
	for y = top, top - (depth or 12), -1 do
		local p = self:pos(x, y, z)
		local def = minetest.registered_nodes[minetest.get_node(p).name]
		if def and not def.buildable_to and def.walkable ~= false then return end
		minetest.set_node(p, {name = dirt})
	end
end

-- Two-node wooden door; `face` = local direction you walk through it.
function Builder:door(x, y, z, face)
	local p2 = self:facedir(face)
	local pos, above = self:pos(x, y, z), self:pos(x, y + 1, z)
	if minetest.registered_nodes["doors:door_wood_a"] then
		minetest.set_node(pos, {name = "doors:door_wood_a", param2 = p2})
		minetest.set_node(above, {name = "doors:hidden", param2 = p2})
		minetest.get_meta(pos):set_int("state", 0)
	elseif minetest.registered_nodes["mcl_doors:wooden_door_b_1"] then
		minetest.set_node(pos, {name = "mcl_doors:wooden_door_b_1", param2 = p2})
		minetest.set_node(above, {name = "mcl_doors:wooden_door_t_1", param2 = p2})
	else
		minetest.set_node(pos, {name = "air"})
		minetest.set_node(above, {name = "air"})
	end
end

local function spawn_npcs_enabled()
	return minetest.settings:get_bool("expedition_assets_spawn_npcs_with_buildings", false)
end

---------------------------------------------------------------------------
-- Research Station  (see reference_images/research_station.jpg)
---------------------------------------------------------------------------
-- Main house 9x9 (x 0..8, z 0..8): cobblestone ground floor, wooden upper
-- floor, dark stone-brick corners and roof trim, flat stone roof.
-- Annex 4x5 on the right with a fenced balcony on top and machinery outside.
local STATION = {
	anchor_x = 4, dist = 5,
	min = {x = -2, y = -12, z = -8}, max = {x = 14, y = 11, z = 9},
}

function STATION.build(b)
	b:fill(-1, 14, 1, 11, -1, 9, "air")

	-- ground work
	for x = 0, 12 do
		for z = 0, 8 do b:support(x, z, -1) end
	end
	b:fill(0, 8, 0, 0, 0, 8, "cobble")
	b:fill(9, 12, 0, 0, 1, 6, "cobble")

	-- walls
	for y = 1, 8 do
		for x = 0, 8 do
			for z = 0, 8 do
				local ex, ez = (x == 0 or x == 8), (z == 0 or z == 8)
				if ex or ez then
					local key
					if (ex and ez) or y == 8 then
						key = "dark_bricks"
					elseif y <= 3 then
						key = "cobble"
					else
						key = "planks"
					end
					b:set(x, y, z, key)
				end
			end
		end
	end

	-- upper floor (with ladder hole) and roof
	b:fill(1, 7, 4, 4, 1, 7, "planks")
	b:fill(1, 7, 8, 8, 1, 7, "slab_cobble")

	-- windows
	for _, w in ipairs({
		{2, 2, 0}, {6, 2, 0}, {2, 6, 0}, {6, 6, 0},   -- front
		{0, 2, 2}, {0, 2, 6}, {0, 6, 2}, {0, 6, 6},   -- left
		{3, 2, 8}, {5, 2, 8}, {3, 6, 8}, {5, 6, 8},   -- back
		{8, 2, 7}, {8, 6, 6}, {8, 6, 7},              -- right
	}) do
		b:set(w[1], w[2], w[3], "glass")
	end

	-- doors: front entrance, passage to the annex, balcony door upstairs
	b:door(4, 1, 0, {x = 0, z = 1})
	b:fill(8, 8, 1, 2, 4, 4, "air")
	b:door(8, 5, 4, {x = 1, z = 0})

	-- ladder to the upper floor
	for y = 1, 5 do b:set(2, y, 7, "ladder", {wall = {x = 0, z = 1}}) end

	-- torches (outside next to the door, and inside)
	b:set(3, 2, -1, "torch_wall", {wall = {x = 0, z = 1}})
	b:set(5, 2, -1, "torch_wall", {wall = {x = 0, z = 1}})
	b:set(1, 3, 4, "torch_wall", {wall = {x = -1, z = 0}})
	b:set(7, 3, 2, "torch_wall", {wall = {x = 1, z = 0}})
	b:set(1, 6, 4, "torch_wall", {wall = {x = -1, z = 0}})
	b:set(7, 6, 2, "torch_wall", {wall = {x = 1, z = 0}})

	-- annex (cobblestone, roof = balcony)
	for y = 1, 3 do
		for x = 9, 12 do
			for z = 2, 6 do
				if x == 12 or z == 2 or z == 6 then b:set(x, y, z, "cobble") end
			end
		end
		b:set(12, y, 2, "dark_bricks")
		b:set(12, y, 6, "dark_bricks")
	end
	b:set(12, 2, 4, "glass")
	b:fill(9, 12, 4, 4, 2, 6, "cobble")
	for x = 9, 12 do
		b:set(x, 5, 2, "fence")
		b:set(x, 5, 6, "fence")
	end
	for z = 3, 5 do b:set(12, 5, z, "fence") end

	-- machinery outside the annex
	b:set(10, 1, 1, "furnace", {face = {x = 0, z = 1}})
	b:set(11, 1, 1, "metal")
	b:set(11, 2, 1, "furnace", {face = {x = 0, z = 1}})
	b:set(12, 1, 1, "furnace", {face = {x = 0, z = 1}})

	-- interior: bookshelves + the expedition supply box
	b:fill(4, 6, 1, 2, 7, 7, "bookshelf")
	b:fill(1, 1, 5, 5, 5, 6, "bookshelf")
	ea.place_box(b:pos(6, 1, 5), b:facedir({x = 0, z = 1}))

	-- dirt path to the door + signpost
	for z = -1, -7, -1 do
		local x = z <= -5 and 3 or 4
		b:support(x, z, -1)
		b:set(x, 0, z, "path")
		b:fill(x, x, 1, 2, z, z, "air")
	end
	b:support(6, -3, 0)
	local sp = b:pos(6, 1, -3)
	minetest.set_node(sp, {name = "expedition_assets:signpost_single", param2 = b:facedir({x = 0, z = 1})})
	ea.set_sign_text(sp, S("Research Station"))

	if spawn_npcs_enabled() then
		local yaw = b:yaw({x = 0, z = -1})
		ea.spawn_character("professor", b:pos(3, 1, 3), yaw)
		ea.spawn_character("researcher", b:pos(10, 1, -1), yaw)
		ea.spawn_character("adventurer", b:pos(5, 1, -3), yaw)
	end
end

---------------------------------------------------------------------------
-- Park Entry  (see reference_images/entry-and-three-characters.png)
---------------------------------------------------------------------------
-- Two 3x3 dark-log pillars on tiered plank bases with decorative stairs,
-- open gate leaves, torches, and a 17 block wide signboard made of letter
-- blocks, topped with caps above each pillar. Opening: 11 blocks wide.
local GATE = {
	anchor_x = 8, dist = 6,
	min = {x = -5, y = -12, z = -9}, max = {x = 21, y = 16, z = 8},
	width = 17,
}

local function gate_pillar(b, mirror)
	local function X(x) return mirror and (GATE.width - 1 - x) or x end
	local function put(x, y, z, key, face)
		local opt
		if face then opt = {face = {x = mirror and -face.x or face.x, z = face.z}} end
		b:set(X(x), y, z, key, opt)
	end

	-- tier 1 base
	for x = -3, 2 do
		for z = -1, 3 do
			b:support(X(x), z, 0)
			for y = 1, 2 do put(x, y, z, "planks") end
		end
	end
	-- stair ring on tier 1, rising towards the pillar
	for z = -1, 3 do put(-3, 3, z, "stair_wood", {x = 1, z = 0}) end
	for x = -2, 2 do
		put(x, 3, -1, "stair_wood", {x = 0, z = 1})
		put(x, 3, 3, "stair_wood", {x = 0, z = -1})
	end
	-- tier 2 with decorative stairs climbing up the pillar side
	for z = 0, 2 do
		for y = 3, 5 do
			put(-2, y, z, "planks")
			put(-1, y, z, "planks")
		end
		put(-2, 6, z, "stair_wood", {x = 1, z = 0})
		put(-1, 6, z, "planks")
		put(-1, 7, z, "stair_wood", {x = 1, z = 0})
	end
	-- the trunk
	for x = 0, 2 do
		for z = 0, 2 do
			for y = 1, 9 do put(x, y, z, "dark_log") end
			put(x, 14, z, "dark_log")
			put(x, 15, z, "slab_dark_wood")
		end
		for y = 10, 13 do put(x, y, 2, "dark_log") end
	end
	-- torch on the front of the pillar
	b:set(X(1), 5, -1, "torch_wall", {wall = {x = 0, z = 1}})
	-- open gate leaf (swung inwards)
	for z = 3, 6 do
		b:support(X(3), z, 0)
		for y = 1, 6 do put(3, y, z, "dark_planks") end
	end
	-- slim post at the end of the signboard
	put(-1, 9, 0, "planks")
	for y = 10, 13 do put(-1, y, 0, "fence") end
	put(-1, 14, 0, "planks")
end

local function gate_line(b, y, text)
	text = text:upper():sub(1, GATE.width - 2)
	local start = 1 + math.floor((GATE.width - 2 - #text) / 2)
	local face = {face = {x = 0, z = 1}} -- letter face looks at the player
	for i = 1, #text do
		local node = ea.letter_node(text:sub(i, i))
		b:set(start + i - 1, y, 0, node or "dark_planks", node and face or nil)
	end
end

function GATE.build(b, opts)
	local w = GATE.width - 1
	b:fill(-5, w + 5, 1, 16, -8, 8, "air")

	gate_pillar(b, false)
	gate_pillar(b, true)

	-- signboard: dark backing + light frame + letters
	b:fill(0, w, 10, 13, 1, 1, "dark_planks")
	b:fill(0, w, 11, 12, 0, 0, "dark_planks")
	b:fill(0, w, 10, 10, 0, 0, "planks")
	b:fill(0, w, 13, 13, 0, 0, "planks")
	b:fill(0, 0, 11, 12, 0, 0, "planks")
	b:fill(w, w, 11, 12, 0, 0, "planks")
	gate_line(b, 12, opts.line1)
	gate_line(b, 11, opts.line2)

	-- dirt path through the gate
	for x = 6, 10 do
		for z = -8, 8 do
			b:support(x, z, -1)
			b:set(x, 0, z, "path")
		end
	end

	if spawn_npcs_enabled() then
		local yaw = b:yaw({x = 0, z = -1})
		ea.spawn_character("professor", b:pos(6, 1, -3), yaw)
		ea.spawn_character("adventurer", b:pos(8, 1, -3), yaw)
		ea.spawn_character("researcher", b:pos(10, 1, -3), yaw)
	end
end

---------------------------------------------------------------------------
-- Commands
---------------------------------------------------------------------------
local function start_build(name, spec, label, opts)
	local player = minetest.get_player_by_name(name)
	if not player then return false, S("You must be online.") end

	local f = ea.cardinal_dir(player)
	local r = {x = f.z, y = 0, z = -f.x}
	local pp = player:get_pos()
	local ground = {x = math.floor(pp.x + 0.5), y = math.floor(pp.y + 0.5) - 1, z = math.floor(pp.z + 0.5)}
	local origin = {
		x = ground.x + f.x * spec.dist - r.x * spec.anchor_x,
		y = ground.y,
		z = ground.z + f.z * spec.dist - r.z * spec.anchor_x,
	}
	local b = new_builder(origin, f)

	local c1, c2 = b:pos(spec.min.x, spec.min.y, spec.min.z), b:pos(spec.max.x, spec.max.y, spec.max.z)
	local minp = {x = math.min(c1.x, c2.x), y = math.min(c1.y, c2.y), z = math.min(c1.z, c2.z)}
	local maxp = {x = math.max(c1.x, c2.x), y = math.max(c1.y, c2.y), z = math.max(c1.z, c2.z)}

	if minetest.is_area_protected and minetest.is_area_protected(minp, maxp, name, 4) then
		return false, S("Part of that area is protected - try somewhere else.")
	end

	minetest.emerge_area(minp, maxp, function(_, _, remaining)
		if remaining > 0 then return end
		local t0 = minetest.get_us_time()
		spec.build(b, opts or {})
		minetest.log("action", ("[expedition_assets] %s spawned %s at %s"):format(
			name, label, minetest.pos_to_string(origin)))
		minetest.chat_send_player(name, minetest.colorize("#9be36b",
			S("@1 is ready! (@2 ms)", label, math.floor((minetest.get_us_time() - t0) / 1000))))
	end)
	return true, S("Building @1 in front of you...", label)
end

minetest.register_chatcommand("spawn_research_station", {
	description = S("Build the Expedition Research Station in front of you"),
	privs = {ea_builder = true},
	func = function(name)
		return start_build(name, STATION, S("Research Station"))
	end,
})

minetest.register_chatcommand("spawn_park_entry", {
	params = S("[LINE 1|LINE 2]"),
	description = S("Build the dino park entrance gate in front of you"),
	privs = {ea_builder = true},
	func = function(name, param)
		local l1, l2 = "PARQUE DE", "DINOSAURIOS"
		param = param or ""
		if param:find("%S") then
			l1, l2 = param:match("^%s*([^|]*)|?(.*)$")
			l1, l2 = (l1 or ""):gsub("^%s+", ""):gsub("%s+$", ""), (l2 or ""):gsub("^%s+", ""):gsub("%s+$", "")
		end
		return start_build(name, GATE, S("Park Entry"), {line1 = l1, line2 = l2})
	end,
})
