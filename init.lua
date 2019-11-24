local timer = 0
minetest.register_tool("bouncing_ball:ball", {
        description = "the bouncing ball",
        inventory_image = "bouncing.png",
        on_use = function (itemstack, user, pointed_thing)
             local pos = user:getpos()
             local dir = user:get_look_dir()
             if pos and dir then
                 pos.y = pos.y + 1.6
                 minetest.add_entity(pos, "bouncing_ball:my_bouncing_ball")
             end
        end 
})

my_bouncing_ball = {
    initial_properties = {
        physical = false,
        timer = 0,
        textures = {"sphere.png"},
    },
    v0 = {x=10., y=20.5,z=0.},
    timer = 0,
    message = "This is entity to represent a bouncing ball",
}
my_bouncing_ball.on_step = function(self, dtime, node, pos)
    --self.timer = self.timer + dtime
    local pos = self.object:getpos()
    local prop = self.object:get_properties()
    local max_height =100 
    self.timer = self.timer + dtime
    -- currently y += v_y * dt with v_y = (-g * t + v_y0)
    local vel = {x = self.v0.x, y = -9.81 * self.timer + self.v0.y, z = self.v0.z}
    local pos_next = vector.add(pos, {x= vel.x * dtime, y= vel.y * dtime, z= vel.z * dtime})
    if minetest.get_node(pos_next).name == "air" then
            self.object:move_to(pos_next)
            --print('x = ' .. tostring(pos_next.x) .. ", y = " .. tostring(pos_next.y) .. ", z = " .. pos_next.z .. "t = " .. tostring(self.timer))
    else --next position is not empty -> destroy the object
        self.object:remove()
    end
end

minetest.register_entity("bouncing_ball:my_bouncing_ball", my_bouncing_ball)
