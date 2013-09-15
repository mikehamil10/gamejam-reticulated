
var returnString = "";
var suckTarget = instance_nearest(argument0, argument1, objDirtBlock);
if(suckTarget != noone){
    returnString = "dirt";
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
