-- Section 1: Tents (tent.obj / tent-canvas.obj)
-- 5 blocks wide, 4 blocks deep. The frame is crafted from 7 sticks in an
-- upside-down U; add 3 yellow wool to stretch the canvas over it.
local ea = expedition_assets
local S = ea.S

-- Footprint relative to the node the tent is placed in (before rotation).
-- Width x = -2..2, depth z = -1..2, height y = 0..3  (matches the mesh)
local FOOT = {x0 = -2, x1 = 2, z0 = -1, z1 = 2, y0 = 0, y1 = 3}

minetest.register_node("expedition_assets:tent_barrier_1", {
	description = "Tent Barrier 1",
	drawtype = "glasslike",
	tiles = {"tent_barrier_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_2", {
	description = "Tent Barrier 2",
	drawtype = "glasslike",
	tiles = {"tent_barrier_2.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_3", {
	description = "Tent Barrier 3",
	drawtype = "glasslike",
	tiles = {"tent_barrier_3.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_4", {
	description = "Tent Barrier 4",
	drawtype = "glasslike",
	tiles = {"tent_barrier_4.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_5", {
	description = "Tent Barrier 5",
	drawtype = "glasslike",
	tiles = {"tent_barrier_5.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_6", {
	description = "Tent Barrier 6",
	drawtype = "glasslike",
	tiles = {"tent_barrier_6.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_7", {
	description = "Tent Barrier 7",
	drawtype = "glasslike",
	tiles = {"tent_barrier_7.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_8", {
	description = "Tent Barrier 8",
	drawtype = "glasslike",
	tiles = {"tent_barrier_8.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_9", {
	description = "Tent Barrier 9",
	drawtype = "glasslike",
	tiles = {"tent_barrier_9.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_10", {
	description = "Tent Barrier 10",
	drawtype = "glasslike",
	tiles = {"tent_barrier_10.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_11", {
	description = "Tent Barrier 11",
	drawtype = "glasslike",
	tiles = {"tent_barrier_11.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_12", {
	description = "Tent Barrier 12",
	drawtype = "glasslike",
	tiles = {"tent_barrier_12.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_13", {
	description = "Tent Barrier 13",
	drawtype = "glasslike",
	tiles = {"tent_barrier_13.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_14", {
	description = "Tent Barrier 14",
	drawtype = "glasslike",
	tiles = {"tent_barrier_14.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_15", {
	description = "Tent Barrier 15",
	drawtype = "glasslike",
	tiles = {"tent_barrier_15.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_16", {
	description = "Tent Barrier 16",
	drawtype = "glasslike",
	tiles = {"tent_barrier_16.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_17", {
	description = "Tent Barrier 17",
	drawtype = "glasslike",
	tiles = {"tent_barrier_17.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_18", {
	description = "Tent Barrier 18",
	drawtype = "glasslike",
	tiles = {"tent_barrier_18.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_19", {
	description = "Tent Barrier 19",
	drawtype = "glasslike",
	tiles = {"tent_barrier_19.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_20", {
	description = "Tent Barrier 20",
	drawtype = "glasslike",
	tiles = {"tent_barrier_20.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_21", {
	description = "Tent Barrier 21",
	drawtype = "glasslike",
	tiles = {"tent_barrier_21.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_22", {
	description = "Tent Barrier 22",
	drawtype = "glasslike",
	tiles = {"tent_barrier_22.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_23", {
	description = "Tent Barrier 23",
	drawtype = "glasslike",
	tiles = {"tent_barrier_23.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_24", {
	description = "Tent Barrier 24",
	drawtype = "glasslike",
	tiles = {"tent_barrier_24.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_25", {
	description = "Tent Barrier 25",
	drawtype = "glasslike",
	tiles = {"tent_barrier_25.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_26", {
	description = "Tent Barrier 26",
	drawtype = "glasslike",
	tiles = {"tent_barrier_26.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_27", {
	description = "Tent Barrier 27",
	drawtype = "glasslike",
	tiles = {"tent_barrier_27.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_28", {
	description = "Tent Barrier 28",
	drawtype = "glasslike",
	tiles = {"tent_barrier_28.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_29", {
	description = "Tent Barrier 29",
	drawtype = "glasslike",
	tiles = {"tent_barrier_29.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_30", {
	description = "Tent Barrier 30",
	drawtype = "glasslike",
	tiles = {"tent_barrier_30.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_31", {
	description = "Tent Barrier 31",
	drawtype = "glasslike",
	tiles = {"tent_barrier_31.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_32", {
	description = "Tent Barrier 32",
	drawtype = "glasslike",
	tiles = {"tent_barrier_32.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_33", {
	description = "Tent Barrier 33",
	drawtype = "glasslike",
	tiles = {"tent_barrier_33.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_34", {
	description = "Tent Barrier 34",
	drawtype = "glasslike",
	tiles = {"tent_barrier_34.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_35", {
	description = "Tent Barrier 35",
	drawtype = "glasslike",
	tiles = {"tent_barrier_35.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_36", {
	description = "Tent Barrier 36",
	drawtype = "glasslike",
	tiles = {"tent_barrier_36.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_37", {
	description = "Tent Barrier 37",
	drawtype = "glasslike",
	tiles = {"tent_barrier_37.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_38", {
	description = "Tent Barrier 38",
	drawtype = "glasslike",
	tiles = {"tent_barrier_38.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_39", {
	description = "Tent Barrier 39",
	drawtype = "glasslike",
	tiles = {"tent_barrier_39.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_40", {
	description = "Tent Barrier 40",
	drawtype = "glasslike",
	tiles = {"tent_barrier_40.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_41", {
	description = "Tent Barrier 41",
	drawtype = "glasslike",
	tiles = {"tent_barrier_41.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_42", {
	description = "Tent Barrier 42",
	drawtype = "glasslike",
	tiles = {"tent_barrier_42.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_43", {
	description = "Tent Barrier 43",
	drawtype = "glasslike",
	tiles = {"tent_barrier_43.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_44", {
	description = "Tent Barrier 44",
	drawtype = "glasslike",
	tiles = {"tent_barrier_44.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_45", {
	description = "Tent Barrier 45",
	drawtype = "glasslike",
	tiles = {"tent_barrier_45.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_46", {
	description = "Tent Barrier 46",
	drawtype = "glasslike",
	tiles = {"tent_barrier_46.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_47", {
	description = "Tent Barrier 47",
	drawtype = "glasslike",
	tiles = {"tent_barrier_47.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_48", {
	description = "Tent Barrier 48",
	drawtype = "glasslike",
	tiles = {"tent_barrier_48.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_49", {
	description = "Tent Barrier 49",
	drawtype = "glasslike",
	tiles = {"tent_barrier_49.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_50", {
	description = "Tent Barrier 50",
	drawtype = "glasslike",
	tiles = {"tent_barrier_50.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_51", {
	description = "Tent Barrier 51",
	drawtype = "glasslike",
	tiles = {"tent_barrier_51.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_52", {
	description = "Tent Barrier 52",
	drawtype = "glasslike",
	tiles = {"tent_barrier_52.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_53", {
	description = "Tent Barrier 53",
	drawtype = "glasslike",
	tiles = {"tent_barrier_53.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_54", {
	description = "Tent Barrier 54",
	drawtype = "glasslike",
	tiles = {"tent_barrier_54.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_55", {
	description = "Tent Barrier 55",
	drawtype = "glasslike",
	tiles = {"tent_barrier_55.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_56", {
	description = "Tent Barrier 56",
	drawtype = "glasslike",
	tiles = {"tent_barrier_56.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_57", {
	description = "Tent Barrier 57",
	drawtype = "glasslike",
	tiles = {"tent_barrier_57.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_58", {
	description = "Tent Barrier 58",
	drawtype = "glasslike",
	tiles = {"tent_barrier_58.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_59", {
	description = "Tent Barrier 59",
	drawtype = "glasslike",
	tiles = {"tent_barrier_59.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_60", {
	description = "Tent Barrier 60",
	drawtype = "glasslike",
	tiles = {"tent_barrier_60.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_61", {
	description = "Tent Barrier 61",
	drawtype = "glasslike",
	tiles = {"tent_barrier_61.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_62", {
	description = "Tent Barrier 62",
	drawtype = "glasslike",
	tiles = {"tent_barrier_62.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_63", {
	description = "Tent Barrier 63",
	drawtype = "glasslike",
	tiles = {"tent_barrier_63.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_64", {
	description = "Tent Barrier 64",
	drawtype = "glasslike",
	tiles = {"tent_barrier_64.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_65", {
	description = "Tent Barrier 65",
	drawtype = "glasslike",
	tiles = {"tent_barrier_65.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_66", {
	description = "Tent Barrier 66",
	drawtype = "glasslike",
	tiles = {"tent_barrier_66.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_67", {
	description = "Tent Barrier 67",
	drawtype = "glasslike",
	tiles = {"tent_barrier_67.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_68", {
	description = "Tent Barrier 68",
	drawtype = "glasslike",
	tiles = {"tent_barrier_68.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_69", {
	description = "Tent Barrier 69",
	drawtype = "glasslike",
	tiles = {"tent_barrier_69.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_70", {
	description = "Tent Barrier 70",
	drawtype = "glasslike",
	tiles = {"tent_barrier_70.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_71", {
	description = "Tent Barrier 71",
	drawtype = "glasslike",
	tiles = {"tent_barrier_71.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_72", {
	description = "Tent Barrier 72",
	drawtype = "glasslike",
	tiles = {"tent_barrier_72.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_73", {
	description = "Tent Barrier 73",
	drawtype = "glasslike",
	tiles = {"tent_barrier_73.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_74", {
	description = "Tent Barrier 74",
	drawtype = "glasslike",
	tiles = {"tent_barrier_74.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_75", {
	description = "Tent Barrier 75",
	drawtype = "glasslike",
	tiles = {"tent_barrier_75.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_76", {
	description = "Tent Barrier 76",
	drawtype = "glasslike",
	tiles = {"tent_barrier_76.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_77", {
	description = "Tent Barrier 77",
	drawtype = "glasslike",
	tiles = {"tent_barrier_77.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_78", {
	description = "Tent Barrier 78",
	drawtype = "glasslike",
	tiles = {"tent_barrier_78.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_79", {
	description = "Tent Barrier 79",
	drawtype = "glasslike",
	tiles = {"tent_barrier_79.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})

minetest.register_node("expedition_assets:tent_barrier_80", {
	description = "Tent Barrier 80",
	drawtype = "glasslike",
	tiles = {"tent_barrier_80.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = true,
	pointable = true,
	diggable = true,
	buildable_to = false,
	drop = "",
	groups = {not_in_creative_inventory = 1},
})




local function is_boundary(x, y, z)
	if (z == FOOT.z0 or z == FOOT.z1) and x == 0 and y <= 1 then return false end
	if x == FOOT.x0 or x == FOOT.x1 then return true end
	if (z == FOOT.z0 or z == FOOT.z1) and x ~= 0 then return true end
	if y == FOOT.y1 then return true end
	return false
end

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
				if fn({x = pos.x + rx, y = pos.y + y, z = pos.z + rz}, x, y, z) == false then
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

	local placed_def = minetest.registered_nodes[itemstack:get_name()]
	if placed_def and placed_def._has_barriers then
        local i = 1
		each_footprint_pos(pos, param2, function(p, x, y, z)
			if is_boundary(x, y, z) then
				minetest.set_node(p, {name = "expedition_assets:tent_barrier_" .. i})
                i = i + 1
			end
		end)
	end

	minetest.sound_play("default_place_node", {pos = pos, gain = 0.6}, true)

	if not ea.is_creative(name) then
		itemstack:take_item()
	end
	return itemstack
end


local function tent_on_destruct(pos)
	local node = minetest.get_node(pos)
	local def = minetest.registered_nodes[node.name]
	if def and def._has_barriers then
		each_footprint_pos(pos, node.param2, function(p, x, y, z)
			local bnode = minetest.get_node(p)
			if string.match(bnode.name, "^expedition_assets:tent_barrier_") then
				minetest.set_node(p, {name = "air"})
			end
		end)
	end
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
		walkable = false,
		_has_barriers = walkable,
		is_ground_content = false,
		selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5}},
		groups = ea.wood_groups({flammable = 3}),
		_mcl_hardness = 1, _mcl_blast_resistance = 1,
		sounds = ea.sound_wood(),
		stack_max = 16,
		on_place = tent_on_place,
		on_destruct = tent_on_destruct,
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
