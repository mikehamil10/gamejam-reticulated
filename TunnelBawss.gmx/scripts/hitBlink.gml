    //are we in hitFrame state?
    if (self.hitFrame =true){
    hitBlinkCounter ++;
    
    if((hitBlinkCounter div round(room_speed/6) )mod 2) ==1  { //changes 3 times a second
 
    
     draw_sprite(sprite_index, 0, x, y);
    
    
    }else {
    hitBlinkCounter=1;
     sprite_index = sprAvatarWalk;
     draw_sprite(sprite_index, 0, x, y);
    }}
