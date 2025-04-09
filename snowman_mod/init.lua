local snowman = {
    initial_properties = {
        hp_max = 20,
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.5, -0.5, -0.5, 0.5, 2, 0.5},
        visual = "mesh",
        visual_size = {x = 1, y = 1, z = 1},
        mesh = "snowman.obj",
        textures = {"snowman.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
    },
}

core.register_entity("snowman_mod:snowman", snowman)
local function create_snowman(pos, blocks_to_destroy)
    core.remove_node(pos)

    for _, block_pos in ipairs(blocks_to_destroy) do
        core.remove_node(block_pos)
    end

    core.add_entity(pos, "snowman_mod:snowman", nil)
end

local snowblock_def = core.registered_nodes["default:snowblock"]

if snowblock_def then
    local old_on_place = snowblock_def.on_place

    core.override_item("default:snowblock", {
        on_place = function (itemstack, placer, pointed_thing)
            local result = old_on_place(itemstack, placer, pointed_thing)

            local block_placement_position = pointed_thing.above
            local directly_above = vector.add(block_placement_position, vector.new(0, 1, 0))
            local two_above = vector.add(block_placement_position, vector.new(0, 2, 0))
            local below = vector.subtract(block_placement_position, vector.new(0, 1, 0))

            local block_directly_above = core.get_node(directly_above)
            local block_two_above = core.get_node(two_above)
            local block_below = core.get_node(below)

            if block_directly_above.name == "default:snowblock" and block_two_above.name == "default:coalblock" then
                create_snowman(block_placement_position, {directly_above, two_above})
            elseif block_below.name == "default:snowblock" and block_directly_above.name == "default:coalblock" then
                create_snowman(below, {block_placement_position, directly_above})
            end

            return result
        end
    }, {})
end

local coalblock_def = core.registered_nodes["default:coalblock"]
if coalblock_def then
    local old_on_place = coalblock_def.on_place

    core.override_item("default:coalblock", {
        on_place = function (itemstack, placer, pointed_thing)
            local result = old_on_place(itemstack, placer, pointed_thing)

            local block_placement_position = pointed_thing.above
            local below = vector.subtract(block_placement_position, vector.new(0, 1, 0))
            local two_below = vector.subtract(block_placement_position, vector.new(0, 2, 0))

            local block_below = core.get_node(below)
            local block_two_below = core.get_node(two_below)

            if block_below.name == "default:snowblock" and block_two_below.name == "default:snowblock" then
                create_snowman(two_below, {below, block_placement_position})
            end

            return result
        end
    }, {})
end
