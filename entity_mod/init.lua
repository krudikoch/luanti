local entity = {
    initial_properties = {
        hp_max = 20,
        physical = true,
        collide_with_objects = true,
        collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
        visual = "mesh",
        visual_size = {x = 1, y = 1, z = 1},
        mesh = "Steve.obj",
        textures = {"steve.png"},
        spritediv = {x = 1, y = 1},
        initial_sprite_basepos = {x = 0, y = 0},
    },

    -- in blocks
    aggro_range = 30,

    fov = 60,
    raycasts = 15,
    y_offset = 0.3,

    speed = 1
}

local function yaw_to_dir(yaw)
    return {
        x = -math.sin(yaw),
        y = 0,
        z = math.cos(yaw)
    }
end

local function find_player_by_raycast(pos, direction, range)
    local ray = minetest.raycast(pos, vector.add(pos, vector.multiply(direction, range)), true, false)
    for pointed_thing in ray do
        if pointed_thing.type == "object" then
            local obj = pointed_thing.ref
            if obj:is_player() then
                return obj, pointed_thing.intersection_point
            end
        end
    end
    return nil, nil
end

local function find_player_around_entity(pos, rotation, fov, raycasts, y_offset, aggro_range)
    local half_fov = fov / 2
    local yaw_start = rotation.y - half_fov
    local yaw_end = rotation.y + half_fov + 0.1
    local raycast_steps = fov / raycasts

    for yaw = yaw_start, yaw_end, raycast_steps do
        for current_y_offset = -y_offset, y_offset + 0.1, y_offset do
            local cast_direction = yaw_to_dir(yaw) + vector.new(0, current_y_offset, 0)

            local player, intersection = find_player_by_raycast(pos, cast_direction, aggro_range)
            if player then
                return player, vector.distance(pos, intersection)
            end
        end
    end
end

function entity:on_step(dtime)
    local pos      = self.object:get_pos()
    local rotation = self.object:get_rotation()

    local player, distance = find_player_around_entity(pos, rotation, self.fov, self.raycasts, self.y_offset, self.aggro_range)

    if player == nil then
        return;
    end

    local player_pos = player:get_pos()
    local direction = vector.direction(pos, player_pos)

    self.object:set_rotation(vector.dir_to_rotation(direction))

    local delta = vector.normalize(direction) * dtime * self.speed

    self.object:move_to(pos + delta)
end

core.register_entity("entity_mod:entity", entity)
