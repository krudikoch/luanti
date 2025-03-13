core.register_node("tree_mod:wood", {
	description = "Wood from a Tree",
	tiles = { "testmod_woodtop.png", "testmod_woodtop.png", "testmod_wood.png" },
	groups = { choppy = 3, oddly_breakable_by_hand = 2 },
})

core.register_node("tree_mod:leave", {
	description = "Leaves from a tree",
	tiles = { "testmod_leaves.png" },
	groups = { shears = 3, leafdecay = 3, flammable = 2, oddly_breakable_by_hand = 3 },
	drop = {
		max_items = 1,
		items = { {
			items = { "default:sapling" },
			rarity = 5,
		} },
	},
	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if digger and digger:is_player() then
			local wielded = digger:get_wielded_item()
			local name = wielded:get_name()
			local tool_capabilities = wielded:get_tool_capabilities()

			if tool_capabilities.groupcaps and tool_capabilities.groupcaps.shears then
				minetest.add_item(pos, "tree_mod:leave")
			end
		end
	end,
})

core.register_tool("tree_mod:shear", {
	description = "Shear to cut leaves",
	inventory_image = "tree_mod.png",
	tool_capabilities = {
		max_drop_level = 1,
		groupcaps = {
			shears = {
				maxlevel = 3,
				uses = 100,
				times = { [1] = 1.6, [2] = 1.2, [3] = 0.25 },
			},
		},
	},
})

core.register_craft({
	output = "tree_mod:shear",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot", "", "" },
		{ "", "", "" },
	},
})
