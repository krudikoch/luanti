local entity = {
    initial_properties = {
        hp_max = 20,
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
        visual = "mesh",
        visual_size = {x = 1, y = 2, z = 1},
        mesh = "Steve.obj",
        textures = {"steve.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
    },

    message = "I got hit",
}

function entity:on_step(dtime)
    local pos      = self.object:get_pos()
    local pos_down = vector.subtract(pos, vector.new(0, 1, 0))

    local delta
    if core.get_node(pos_down).name == "air" then
        delta = vector.new(0, -1, 0)
    elseif core.get_node(pos).name == "air" then
        delta = vector.new(0, 0, 1)
    else
        delta = vector.new(0, 1, 0)
    end

    delta = vector.multiply(delta, dtime)

    self.object:move_to(vector.add(pos, delta))
end

function entity:on_punch(hitter)
    core.chat_send_player(hitter:get_player_name(), self.message)
end

core.register_entity("entity_mod:entity", entity)
core.add_entity({x = 1, y = 2, z = 3}, "entity_mod:entity", nil)
