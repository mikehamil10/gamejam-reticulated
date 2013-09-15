
var returnString = "";
if(ds_list_size(global.vacuumStack) > global.vacuumSize){
    return "";
}
var suckTarget = instance_nearest(argument0, argument1, objDirtBlock);
var suckTarget2 = instance_nearest(argument0, argument1, objBomb);
if(suckTarget != noone){
if (suckTarget2<suckTarget){
    returnString = "dirt";
    }
    if(suckTarget<suckTarget2){
    returnString = "bomb";
    }
}
//TODO: check for other suckable stuff and get the closest

if(abs(suckTarget.x - argument0 < 80) && abs(suckTarget.y - argument1) < 80){
    with(suckTarget){
        instance_destroy();
    }
} else {
    return "";
}
return returnString;
