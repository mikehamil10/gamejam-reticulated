
var returnString = "";
if(ds_list_size(global.vacuumStack) >= global.vacuumSize){
    return "";
}

var suckTarget  = instance_nearest(argument0, argument1, objDirtBlock);
var suckTarget2 = instance_nearest(argument0, argument1, objBomb);

var dirtDistance = point_distance(argument0, argument1, suckTarget.x, suckTarget.y);
var bombDistance = point_distance(argument0, argument1, suckTarget2.x, suckTarget2.y);

show_debug_message(string(self.suckDirection));

var selectedDistance = 100;
var selectedItem;

//if(suckTarget != noone){
    if (dirtDistance < bombDistance){
        returnString = "dirt";
        selectedDistance = dirtDistance;
        selectedItem = suckTarget;
    } else if (bombDistance < dirtDistance){
        returnString = "bomb";
        selectedDistance = bombDistance;
        selectedItem = suckTarget2;
    }
//}
//TODO: check for other suckable stuff and get the closest

//if (self.suckDirection == "side") {
//    
//}
if(selectedDistance < 100){
    with(selectedItem){
        instance_destroy();
    }
} else {
    return "";
}

return returnString;
