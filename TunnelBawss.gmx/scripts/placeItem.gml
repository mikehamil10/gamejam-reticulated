 if(item == argument0){ //string "dirt"
                show_debug_message("Pre blow: x: " + string(targetX) + "   y: " + string(targetY));
                targetX = self.x - (self.x % 96)
                targetY = self.y - (self.y % 96)
                show_debug_message("Post blow: x: " + string(targetX) + "   y: " + string(targetY));
                var i = 0;
                with(argument1){ //objectBlocktype "objDirtBlock"
                    if(i == 0){
                        show_debug_message("blowing " + argument0);
                        if(place_free(targetX, targetY))
                        {
                         if(longPress){
                          //shoot stuff
                         } else{
                                instance_create(targetX, targetY, objDirtBlock);
                        }
                        }else 
                        {
                            scrVacuumSuck("dirt");
                        }
                        i = 1;
                    }
                }
            }
