-- Section 2: Characters
--   * Adventurer  - khaki safari outfit + 3D safari hat
--   * Professor   - lab coat, thick glasses, grey hair
--   * Researcher  - grey beard, plaid shirt, denim overalls
-- Use /ea_apply_skin to wear one, or meet them as peaceful NPCs
-- (Mobs Redo, mcl_mobs, or a built-in fallback NPC).
local ea = expedition_assets
local S = ea.S

local HAT = "expedition_assets:hat"
local META_SKIN = "expedition_assets:skin"
local META_ORIG = "expedition_assets:orig_skin"

local HAT_POS = {x = 0, y = tonumber(minetest.settings:get("expedition_assets_hat_offset_y")) or 3.7, z = 0}
local HAT_ROT = {x = 0, y = 0, z = 0}

ea.characters = {
	adventurer = {
		description = S("Adventurer"),
		hat = true,
		egg_color = "#C9B487", egg_spot = "#6B4A2E",
		lines = {
			S("Ready for the next expedition! Keep your hat on and your eyes open."),
			S("I've mapped every valley from here to the volcano. Well... most of them."),
			S("Hear that rumble? Either thunder, or something very, very big."),
		},
	},
	professor = {
		description = S("Professor"),
		egg_color = "#C4E0F0", egg_spot = "#3464AA",
		lines = {
			S("Fascinating! This fossil is at least 65 million years old."),
			S("Science is organised curiosity. Now - where did I put my notes?"),
			S("Please don't touch the specimens. Especially the ones that bite."),
		},
	},
	researcher = {
		description = S("Researcher"),
		egg_color = "#B8282C", egg_spot = "#4A6EA8",
		lines = {
			S("My compass says north... the footprints say T-Rex. Let's go south."),
			S("Thirty years in the field and I still get goosebumps."),
			S("Fresh tracks! Quiet now, and stay behind me."),
		},
	},
}
ea.character_order = {"adventurer", "professor", "researcher"}

function ea.skin_texture(id)
	return "expedition_assets_skin_" .. id .. (ea.is_mcl and "_64" or "") .. ".png"
end

local function say(player, id)
	local c = ea.characters[id]
	local line = c.lines[math.random(#c.lines)]
	minetest.chat_send_player(player:get_player_name(),
		minetest.colorize("#ffd36b", "<" .. c.description .. "> ") .. line)
end

---------------------------------------------------------------------------
-- Hat (a small mesh entity attached to the "Head" bone)
---------------------------------------------------------------------------
minetest.register_entity(HAT, {
	initial_properties = {
		physical = false,
		pointable = false,
		collide_with_objects = false,
		visual = "mesh",
		mesh = "expedition_assets_hat.obj",
		textures = {"expedition_assets_hat.png"},
		visual_size = {x = 10, y = 10, z = 10},
		backface_culling = false,
		collisionbox = {0, 0, 0, 0, 0, 0},
		selectionbox = {0, 0, 0, 0, 0, 0},
		static_save = false,
	},
	on_step = function(self, dtime)
		self._t = (self._t or 0) + dtime
		if self._t < 1 then return end
		self._t = 0
		if not self.object:get_attach() then
			self.object:remove() -- parent is gone
		end
	end,
})

function ea.remove_hat(obj)
	if not obj.get_children then return end
	for _, child in ipairs(obj:get_children()) do
		local ent = child:get_luaentity()
		if ent and ent.name == HAT then child:remove() end
	end
end

function ea.attach_hat(obj)
	ea.remove_hat(obj)
	local pos = obj:get_pos()
	if not pos then return end
	local hat = minetest.add_entity(pos, HAT)
	if hat then
		hat:set_attach(obj, "Head", HAT_POS, HAT_ROT)
	end
end

---------------------------------------------------------------------------
-- Player skins
---------------------------------------------------------------------------
local function set_player_texture(player, tex)
	if minetest.global_exists("mcl_player") and mcl_player.player_set_skin then
		mcl_player.player_set_skin(player, tex)
	elseif minetest.global_exists("player_api") and player_api.set_textures then
		player_api.set_textures(player, {tex})
	else
		player:set_properties({textures = {tex}})
	end
end

--- Apply character skin `id` (or "default") to `player`.
function ea.apply_skin(player, id)
	local meta = player:get_meta()
	if id == "default" then
		local orig = meta:get_string(META_ORIG)
		if orig == "" then orig = "character.png" end
		set_player_texture(player, orig)
		meta:set_string(META_SKIN, "")
		ea.remove_hat(player)
		return true
	end
	local c = ea.characters[id]
	if not c then return false end
	if meta:get_string(META_SKIN) == "" then
		local props = player:get_properties()
		local cur = props.textures and props.textures[1]
		if cur and cur ~= "" then meta:set_string(META_ORIG, cur) end
	end
	set_player_texture(player, ea.skin_texture(id))
	meta:set_string(META_SKIN, id)
	if c.hat then ea.attach_hat(player) else ea.remove_hat(player) end
	return true
end

local function resolve_skin_name(s)
	s = (s or ""):lower()
	local n = tonumber(s)
	if n then return ea.character_order[n] end
	if s == "default" or s == "reset" or s == "off" then return "default" end
	return ea.characters[s] and s or nil
end

minetest.register_chatcommand("ea_apply_skin", {
	params = "<adventurer|professor|researcher|1|2|3|default> [player]",
	description = S("Wear one of the Expedition character skins"),
	func = function(name, param)
		local skin_arg, target = param:match("^%s*(%S+)%s*(%S*)%s*$")
		local id = resolve_skin_name(skin_arg)
		if not id then
			return false, S("Usage: /ea_apply_skin <adventurer|professor|researcher|default> [player]")
		end
		if target == "" then target = name end
		if target ~= name and not minetest.check_player_privs(name, {ea_builder = true}) then
			return false, S("You need the 'ea_builder' privilege to change other players' skins.")
		end
		local player = minetest.get_player_by_name(target)
		if not player then return false, S("Player @1 is not online.", target) end
		ea.apply_skin(player, id)
		if id == "default" then
			return true, S("Skin reset for @1.", target)
		end
		say(player, id)
		return true, S("@1 is now the @2!", target, ea.characters[id].description)
	end,
})

-- Re-apply the chosen skin on join (after other skin mods had their turn).
minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	minetest.after(1.5, function()
		local p = minetest.get_player_by_name(name)
		if not p then return end
		local id = p:get_meta():get_string(META_SKIN)
		if id ~= "" and ea.characters[id] then ea.apply_skin(p, id) end
	end)
end)

---------------------------------------------------------------------------
-- NPCs
---------------------------------------------------------------------------
local MESH = "character.b3d"
local ANIM = {
	speed_normal = 30, speed_run = 30,
	stand_start = 0, stand_end = 79,
	walk_start = 168, walk_end = 187,
	run_start = 168, run_end = 187,
	punch_start = 189, punch_end = 198,
}
local COLLISION = {-0.3, 0.0, -0.3, 0.3, 1.77, 0.3}
local backend

local function npc_rightclick(self, clicker, id)
	if not clicker or not clicker:is_player() then return end
	-- turn towards the player
	local p, c = self.object:get_pos(), clicker:get_pos()
	if p and c then
		self.object:set_yaw(math.atan2(c.z - p.z, c.x - p.x) - math.pi / 2)
	end
	say(clicker, id)
end

local function register_mobs_redo(id, c, name)
	mobs:register_mob(name, {
		type = "npc",
		passive = true,
		attack_players = false, attack_npcs = false, attack_monsters = false,
		hp_min = 20, hp_max = 20, armor = 100,
		collisionbox = COLLISION,
		visual = "mesh", mesh = MESH,
		textures = {{ea.skin_texture(id)}},
		makes_footstep_sound = true,
		walk_velocity = 1, run_velocity = 2.5, walk_chance = 40,
		jump = true, fear_height = 3, floats = 1,
		runaway = true, runaway_from = {"mobs_monster:dirt_monster"},
		view_range = 10,
		water_damage = 0, lava_damage = 4, light_damage = 0,
		drops = {},
		animation = ANIM,
		on_rightclick = function(self, clicker) npc_rightclick(self, clicker, id) end,
		after_activate = function(self)
			if c.hat then ea.attach_hat(self.object) end
		end,
	})
	mobs:register_egg(name, S("@1 (spawn egg)", c.description),
		"expedition_assets_egg_" .. id .. ".png", 1)

	if minetest.settings:get_bool("expedition_assets_npc_natural_spawn", false) and mobs.spawn then
		mobs:spawn({
			name = name,
			nodes = {"group:soil", "default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
			neighbors = {"air"},
			min_light = 10, chance = 12000, active_object_count = 1,
			min_height = 1, max_height = 200, day_toggle = true,
		})
	end
end

local function register_mcl_mobs(id, c, name)
	mcl_mobs.register_mob(name, {
		description = c.description,
		type = "npc", spawn_class = "passive", passive = true,
		hp_min = 20, hp_max = 20,
		collisionbox = COLLISION,
		visual = "mesh", mesh = MESH,
		textures = {{ea.skin_texture(id)}},
		makes_footstep_sound = true,
		walk_velocity = 1, run_velocity = 2.4, walk_chance = 40,
		jump = true, fear_height = 4, floats = 1,
		runaway = true, view_range = 10,
		water_damage = 0, lava_damage = 4, light_damage = 0,
		drops = {},
		animation = ANIM,
		on_rightclick = function(self, clicker) npc_rightclick(self, clicker, id) end,
		after_activate = function(self)
			if c.hat then ea.attach_hat(self.object) end
		end,
	})
	if mcl_mobs.register_egg then
		mcl_mobs.register_egg(name, S("@1 (spawn egg)", c.description), c.egg_color, c.egg_spot, 0)
	end
end

-- Built-in fallback: a friendly NPC that stands still and looks at players.
local function register_fallback(id, c, name)
	minetest.register_entity(name, {
		initial_properties = {
			physical = true, collide_with_objects = true,
			collisionbox = COLLISION,
			selectionbox = COLLISION,
			visual = "mesh", mesh = MESH,
			textures = {ea.skin_texture(id)},
			makes_footstep_sound = true,
			hp_max = 20,
			stepheight = 0.6,
			infotext = c.description,
		},
		on_activate = function(self)
			self.object:set_armor_groups({immortal = 1})
			self.object:set_acceleration({x = 0, y = -9.81, z = 0})
			self.object:set_animation({x = ANIM.stand_start, y = ANIM.stand_end}, ANIM.speed_normal, 0, true)
			if c.hat then ea.attach_hat(self.object) end
		end,
		on_step = function(self, dtime)
			self._t = (self._t or 0) + dtime
			if self._t < 0.5 then return end
			self._t = 0
			local pos = self.object:get_pos()
			if not pos then return end
			for _, obj in ipairs(minetest.get_objects_inside_radius(pos, 6)) do
				if obj:is_player() then
					local o = obj:get_pos()
					self.object:set_yaw(math.atan2(o.z - pos.z, o.x - pos.x) - math.pi / 2)
					break
				end
			end
		end,
		on_rightclick = function(self, clicker) npc_rightclick(self, clicker, id) end,
		-- Sneak-punch with the ea_builder privilege removes the NPC
		on_punch = function(self, puncher)
			if puncher and puncher:is_player() and puncher:get_player_control().sneak
					and minetest.check_player_privs(puncher, {ea_builder = true}) then
				ea.remove_hat(self.object)
				self.object:remove()
			end
			return true
		end,
	})
end

if minetest.global_exists("mobs") and mobs.register_mob then
	backend = "mobs_redo"
elseif minetest.global_exists("mcl_mobs") and mcl_mobs.register_mob then
	backend = "mcl_mobs"
else
	backend = "builtin"
end
ea.npc_backend = backend

for _, id in ipairs(ea.character_order) do
	local c = ea.characters[id]
	local name = "expedition_assets:" .. id
	if backend == "mobs_redo" then
		register_mobs_redo(id, c, name)
	elseif backend == "mcl_mobs" then
		register_mcl_mobs(id, c, name)
	else
		register_fallback(id, c, name)
	end
end

--- Spawn character `id` at `pos`, facing `yaw` (optional).
function ea.spawn_character(id, pos, yaw)
	if not ea.characters[id] then return nil end
	local obj = minetest.add_entity(pos, "expedition_assets:" .. id)
	if obj and yaw then obj:set_yaw(yaw) end
	return obj
end

minetest.register_chatcommand("ea_spawn_npc", {
	params = "<adventurer|professor|researcher|all>",
	description = S("Spawn an Expedition character in front of you"),
	privs = {ea_builder = true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then return false end
		param = param:lower():gsub("%s+", "")
		local ids = param == "all" and ea.character_order or {resolve_skin_name(param)}
		if not ids[1] or ids[1] == "default" then
			return false, S("Usage: /ea_spawn_npc <adventurer|professor|researcher|all>")
		end
		local dir = ea.cardinal_dir(player)
		local right = {x = dir.z, y = 0, z = -dir.x}
		local base = vector.add(vector.round(player:get_pos()), vector.multiply(dir, 3))
		local yaw = player:get_look_horizontal() + math.pi
		for i, id in ipairs(ids) do
			local off = (i - (#ids + 1) / 2) * 2
			ea.spawn_character(id, vector.add(base, vector.multiply(right, off)), yaw)
		end
		return true, S("Spawned: @1", table.concat(ids, ", "))
	end,
})
