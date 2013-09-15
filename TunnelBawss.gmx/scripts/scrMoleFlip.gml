if(argument0.timer > 20){
    argument0.direction = 1 - argument0.direction
    if(argument0.direction > 0){
        argument0.image_xscale = 1
        //argument0.x -= argument0.flipOffset
    } else {
        //argument0.x += argument0.flipOffset
        argument0.image_xscale = -1
    }
    argument0.timer = 0
}
