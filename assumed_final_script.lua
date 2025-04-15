function init()
    
    mavlink_msgs = require("modules/MAVLink/mavlink_msgs")
    COMMAND_ACK_ID = mavlink_msgs.get_msgid("COMMAND_ACK")
    COMMAND_LONG_ID = mavlink_msgs.get_msgid("COMMAND_LONG")

    if(arming:is_armed()) then
       arming:disarm() 
    end
    
    -- get ground data
    initial_position = ahrs:get_position()
    initial_home = ahrs:get_home()
    initial_alt = ahrs:get_hagl()
    jerk = 0 --important
    
    deploy_flag_not_raised = true
    jerk_threshold = -0.5 --test val TODO change with test
    
    -- reading acceleration
    
    -- jerk SHOULD BE CALLED EVERY <PERIOD> seconds, where this behavior is defined as a conditional block
    -- within read loop to check time_delta < <PERIOD>
    old_accel, old_time = 0, 0
    while deploy_flag_not_raised do
        
        new_accel = ahrs:get_accel()
        new_time = os.clock()
        
        -- When jerk is negative past threshold, exit loop and begin the subsequent steps
        jerk = (new_accel - old_accel) / (new_time / old_time)
        
        if jerk < jerk_threshold then
            deploy_flag_not_raised = false
        if end

        old_accel = new_accel
        old_time = new_time

    end
    
    vehicle:set_mode(18) --throw mode
    
    while !ahrs:prearm_healthy() do
        print("Prearm checks not yet ready.")
    end
    
    arming:arm()
    send_gpio() 

    -- TODO make guided mode
    -- 1) put into guided mode AFTER throw mode stabilizes (if there is no attribute or function to confirm this, make a comment and skip)
    -- 2) guide it to the home position (on the ground! not the new home if one is recreated!), both altitude and GPS location
    vehicle:set_mode(4) --needs to be set to guided mode before we set its destination


end

function send_gpio()
    -- https://github.com/ArduPilot/ardupilot/blob/master/libraries/AP_Scripting/docs/docs.lua

    pin_number = -- TODO FIND PIN NUMBER FOR THE GPIO SECTION
    gpio:pinMode(pin_number, 1) -- set pin to output mode
    gpio:write(pin_number, 1) -- turn pin on 
end