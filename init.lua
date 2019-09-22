local timer = 0
minetest.register_tool("bouncing_ball:ball", {
        description = "the bouncing ball",
        inventory_image = "bouncing.png",
        on_use = function (itemstack, user, pointed_thing)
             local pos = user:getpos()
             local dir = user:get_look_dir()
             if pos and dir then
                 pos.y = pos.y + 1.6
                 local obj = minetest.add_entity(pos, "bouncing_ball:my_bouncing_ball")
                 if obj then
                    obj.direction = {x=dir.x, y=dir.y , z=dir.z }
                 end
             end
        end 
})

local my_bouncing_ball = {
    initial_properties = {
        physical = false,
        timer = 0,
        textures = {"sphere.png"},
        direction = {x=0., y=0.,z=0.},
    },

    message = "This is entity to represent a bouncing ball",
}

my_bouncing_ball.on_step = function(self, dtime, node, pos)
    --self.timer = self.timer + dtime
    local pos = self.object:getpos()
    local vel = self.object.direction
    -- currently x  += v  * dt (rectiline movement)
    local pos_next = vector.add(pos, {x=vel.x * dtime, y=vel.y * dtime, z= vel.z *dtime})
    if minetest.get_node(pos_next).name == "air" then
        self.object:move_to(pos_next)
    end
end
minetest.register_entity("bouncing_ball:my_bouncing_ball", my_bouncing_ball)
