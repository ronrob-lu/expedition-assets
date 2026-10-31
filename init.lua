--[[
	Expedition Assets
	Copyright (c) 2026 ronrob-lu - MIT Licence (see LICENSE.md)

	Section 1 - models     : expedition box, tents, tin tools, signposts
	Section 2 - characters : adventurer, professor, researcher (skins + NPCs)
	Section 3 - buildings  : /spawn_research_station, /spawn_park_entry, /spawn_observation_tower
]]

expedition_assets = {}
local ea = expedition_assets

ea.modname = minetest.get_current_modname()
ea.modpath = minetest.get_modpath(ea.modname)
ea.S = minetest.get_translator(ea.modname)

minetest.register_privilege("ea_builder", {
	description = ea.S("Can spawn Expedition structures/NPCs and change other players' skins"),
	give_to_singleplayer = true,
	give_to_admin = true,
})

for _, file in ipairs({
	"compat",     -- game detection (Minetest Game / VoxeLibre / Mineclonia)
	"box",        -- section 1: expedition box
	"tents",      -- section 1: tent + tent with canvas
	"tools",      -- section 1: tin tools (+ put-down 3D display)
	"signs",      -- section 1: writable signposts
	"characters", -- section 2: skins, hat, NPCs
	"buildings",  -- section 3: structures
}) do
	dofile(ea.modpath .. "/src/" .. file .. ".lua")
end

minetest.log("action", "[expedition_assets] loaded - happy exploring!")
