core.register_node("block_mod:wood", {
	description = "Wood from a Tree",
	tiles = { "block_mod_woodtop.png", "block_mod_woodtop.png", "block_mod_wood.png" },
	groups = { choppy = 3, oddly_breakable_by_hand = 2 },
	on_dig = function(pos, node, digger)
		local name = digger:get_player_name()
		if name == "Paul" then
			core.remove_node(pos)

			local inv = digger:get_inventory()
			if inv:room_for_item("main", "block_mod:wood") then
				inv:add_item("main", "block_mod:wood")
			else
				-- Drop as item if inventory is full
				core.add_item(pos, "block_mod:wood")
			end
			return true
		end

		return false
	end,
})

core.register_node("block_mod:carpet", {
    description = "Hello World Carpet",
    tiles = { "block_mod_carpet.png" },
    groups = { choppy = 3, oddly_breakable_by_hand = 2 },

    drawtype = "mesh",
    mesh = "carpet.obj",

    paramtype2 = "facedir",

    selection_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 1.5, -0.45, 0.5 }
    },

    collision_box = {
        type = "fixed",
        fixed = { -0.5, -0.5, -0.5, 1.5, -0.45, 0.5 }
    },
})
