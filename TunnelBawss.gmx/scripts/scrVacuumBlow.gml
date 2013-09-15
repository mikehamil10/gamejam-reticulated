//pops an item from the vacuum's stack
var lastIndex = ds_list_size(global.vacuumStack);
show_debug_message("popping from: " + string(lastIndex));
if(lastIndex > 0){
    global.vacuumContent = global.vacuumContent - 1;
    var item = ds_list_find_value(global.vacuumStack, lastIndex - 1);
    ds_list_delete(global.vacuumStack, lastIndex - 1);
    return item;
}
return "";
