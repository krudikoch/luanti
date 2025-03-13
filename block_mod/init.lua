core.register_node("block_mod:wood", {
	description = "Wood from a Tree",
	tiles = { "block_mod_woodtop.png", "block_mod_woodtop.png", "block_mod_wood.png" },
	groups = { choppy = 3, oddly_breakable_by_hand = 2 },
	on_dig = function(pos, node, digger)
		local name = digger:get_player_name()
		if name == "Paul" then
			minetest.remove_node(pos)

			local inv = digger:get_inventory()
			if inv:room_for_item("main", "block_mod:wood") then
				inv:add_item("main", "block_mod:wood")
			else
				-- Drop as item if inventory is full
				minetest.add_item(pos, "block_mod:wood")
			end
			return true
		end

		return false
	end,
})
