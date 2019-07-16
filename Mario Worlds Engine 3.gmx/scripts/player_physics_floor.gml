///player_physics_floor()

/*
**  Name:
**      player_physics();
**
**  Function:
**      Manages the physics of the player when in contact with the floor
*/

//If moving down
if (vspeed > 0) {

    //Check for a semisolid ground
    var semisolid = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom+vspeed, obj_semisolid, 1, 0);
    
    //If that ground exists and the player is above it...
    if (semisolid) 
    && (y < semisolid.y-11) 
    && (!collision_rectangle(bbox_left, bbox_top+4, bbox_right, semisolid.y-1, obj_solid, 1, 0)) {
    
        //Snap above the platform
        y = semisolid.y-16;
        
        //Stop vertical movement
        vspeed = 0;
        gravity = 0;
        
        //Reset values
        event_user(15);
    }
}

//Embed the player into the slope if he is walking or sliding down to ensure correct slope physics
if (collision_rectangle(x, bbox_bottom+1, x, bbox_bottom+4, obj_slopeparent, 1, 0))
&& (!collision_rectangle(x, bbox_bottom-4, x, bbox_bottom-4, obj_slopeparent, 1, 0))
&& (state == statetype.walk)
    y += 4;

//Handle collision with slopes
if (collision_rectangle(x, bbox_bottom-4, x, bbox_bottom, obj_slopeparent, 1, 0))
&& (!collision_rectangle(x, bbox_bottom-8, x, bbox_bottom-8, obj_slopeparent, 1, 0)) {

    //If moving down
    if (vspeed > 0) {
    
        //Stop vertical movement
        vspeed = 0;
        gravity = 0;
        
        //Reset values
        event_user(15);
    }
    
    //Prevent the player from getting embed inside a slope
    if (vspeed > -0.85)
        while (collision_rectangle(x, bbox_bottom-4, x, bbox_bottom, obj_slopeparent, 1, 0))
            y--;
}
