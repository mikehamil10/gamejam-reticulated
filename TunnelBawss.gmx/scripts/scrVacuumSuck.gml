//Adds a item to the vacuum's stack
if(argument0 != ""){
    global.vacuumContent += 1;
    ds_list_add(global.vacuumStack, argument0);
}
