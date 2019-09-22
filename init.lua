minetest.register_node("bouncing_ball:ball", {
        description = "the bouncing ball",
        tiles = {"bouncing.png"},
        is_ground_content = true,
        groups = {cracky=3, stone=1},
        on_punch = function (pos, node, puncher)
              minetest.chat_send_all('pos = {'..pos.x..', '..pos.y..', '..pos.z..' }') 
              minetest.set_node({ x = pos.x, y = pos.y + 1, z = pos.z }, {name ="bouncing_ball:ball"})
              minetest.set_node(pos, { name = "air" })
        end 
})
