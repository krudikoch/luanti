core.register_node("block_mod:wood", {
	description = "Wood from a Tree",
	tiles = { "block_mod_woodtop.png", "block_mod_woodtop.png", "block_mod_wood.png" },
	groups = { choppy = 3, oddly_breakable_by_hand = 2 },

    on_dig = function (pos, node, digger)
        local name = digger:get_player_name()
        if name == "Paul" then
            minetest.remove_node(pos)
            return true
        end

        return false
    end,

    drops = { items = { items = "block_mod:wood" }},
})
