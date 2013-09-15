// always keep our dude upright
phy_rotation = 0;

// ___________________________________________________________________ Movement

/*
XBox 360 Controls
=================
A: button1
B: button2
X: button3
Y: button4
*/

/*
Because sucking and blowing use the same animation, we can't use the sprite to identify
which mode the dwarf is in, so I made a spriteMode variable with the following meanings:
0: idle
1: walk right
2: walk left
3: jumping (falling?)
4: sucking
5: blowing
*/

//move to the next room on esc
if (keyboard_check_pressed(vk_escape)){
    if(room_next(room) != -1)
    {
        room_goto(room_next(room));
    }
}

// are we currently in the middle of the 'suck' animation?
if (self.spriteMode == 4) {
    // Yes. Don't allow movement, and wait until the animation is done
    if (image_index > 11) {
        sprite_index = sprAvatarIdle;
        image_index = 1;
        //reset sucking counter so we can suck another object
        self.suck = 0;
        self.spriteMode = 0;
    } else if (image_index > 6 && self.suck == 0){
        //don't suck up more than one object
        self.suck = 1;
        //suck up the object in the middle of the animation
        var targetX = self.x;
        var targetY = self.y;
        //update the suck coordinates based on the direction we're facing
        if(self.suckDirection == "side"){
            targetX -= (image_xscale * 48);
        } else if(self.suckDirection == "up"){
            targetY -= 96;
        } else if(self.suckDirection == "down"){
            targetY += 96;
        }
        targetY += 48;
        //check if the nearest object is within range and suckable
        var suckTarget = scrSuckObject(targetX, targetY);
        scrVacuumSuck(suckTarget);
    }
} else if (self.spriteMode == 5) {
    // Yes. Don't allow movement, and wait until the animation is done
    if (image_index > 11) {
        sprite_index = sprAvatarIdle;
        image_index = 1;
        //reset sucking counter so we can spit out another object
        self.suck = 0;
        self.spriteMode = 0;
    } else if (image_index > 6 && self.suck == 0){
        //don't spit out more than one object
        self.suck = 1;
        //spit shit out
        var item = scrVacuumBlow();
        //find the location we want to start the object to appear around
        if(item != ""){
            var targetX = self.x;
            var targetY = self.y;
            targetX -= (image_xscale * 96);
            targetY += 48
            if(item == "dirt"){
                targetX = targetX - (targetX % 96)
                targetY = targetY - (targetY % 96)
                with(objDirtBlock){
                    if(place_free(targetX, targetY)){
                        instance_create(targetX, targetY, objDirtBlock);
                    } else {
                        scrVacuumSuck("dirt");
                    }
                }
            }
        }
    }
} else {
    // No. Handle movement
    if (keyboard_check(vk_left) || (joystick_exists(1) && joystick_direction(1) == vk_numpad4)) {
        phy_position_x -= self.speedX;
        if(self.isJumping){
            sprite_index = sprAvatarIdle;
        } else {
            sprite_index = sprAvatarWalk;
        }
        image_xscale = 1;
        self.spriteMode = 2;
    } else if (keyboard_check(vk_right) || (joystick_exists(1) && joystick_direction(1) == vk_numpad6)) {
        phy_position_x += self.speedX;
        if(self.isJumping){
            sprite_index = sprAvatarIdle;
        } else {
            sprite_index = sprAvatarWalk;
        }
        image_xscale = -1;
        self.spriteMode = 1;
    } else {
        sprite_index = sprAvatarIdle;
        image_index = 1;
        self.spriteMode = 0;
    }
    
    // ________________________________________________________________ Jumping
    if (!self.isJumping && (keyboard_check_pressed(vk_space) || (joystick_exists(1) && joystick_check_button(1, 1)))) {
        self.isJumping = true;
        self.canResetJump = false;
        alarm[0] = 10;
        physics_apply_impulse(phy_position_x, phy_position_y, 0, -self.jumpForce);
        self.spriteMode = 3;
    } 
    
    // ________________________________________________________________ Sucking
    if ((keyboard_check_pressed(vk_lcontrol) && keyboard_check(vk_down)) || (joystick_exists(1) && joystick_check_button(1, 3) && joystick_direction(1) == vk_numpad2)){
        self.suckDirection = "down";
        isSucking = true;
        sprite_index = sprAvatarSuck;
        self.spriteMode = 4;
    } else if ((keyboard_check_pressed(vk_lcontrol) && keyboard_check(vk_up)) || (joystick_exists(1) && joystick_check_button(1, 3) && joystick_direction(1) == vk_numpad8)){
        self.suckDirection = "up";
        isSucking = true;
        sprite_index = sprAvatarSuck;
        self.spriteMode = 4;
    } else if (keyboard_check_pressed(vk_lcontrol) || (joystick_exists(1) && joystick_check_button(1, 3))) {
        self.suckDirection = "side";
        isSucking = true;
        sprite_index = sprAvatarSuck;
        self.spriteMode = 4;
    } else if (keyboard_check_pressed(vk_lshift) || (joystick_exists(1) && joystick_check_button(1, 2))) { //TODO: controller equivalent
        isSucking = true;
        sprite_index = sprAvatarSuck;
        self.spriteMode = 5;
    }
}
