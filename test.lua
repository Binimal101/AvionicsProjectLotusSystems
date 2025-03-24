function init()
    if(arming:is_armed()) then
       arming:disarm() 
    end
    -- get ground data
    initial_position = ahrs:get_position()
    initial_home = ahrs:get_home()
    initial_alt = ahrs:get_hagl()
    jork = 0 --important
    
    deploy_flag_not_raised = true
    jork_threshold = -0.5 --test val TODO change with test
    
    -- reading acceleration
    
    -- jork SHOULD BE CALLED EVERY <PERIOD> seconds, where this behavior is defined as a conditional block
    -- within read loop to check time_delta < <PERIOD>
    old_accel, old_time = 0, 0
    while deploy_flag_not_raised do
        
        new_accel = ahrs:get_accel()
        new_time = os.clock()
        
        -- When jork is negative past threshold, exit loop and begin the subsequent steps
        jork = (new_accel - old_accel) / (new_time / old_time)
        
        if jork < jork_threshold then
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
end

function send_gpio()
    -- https://github.com/ArduPilot/ardupilot/blob/master/libraries/AP_Scripting/docs/docs.lua

    pin_number = -- TODO FIND PIN NUMBER FOR THE GPIO SECTION
    gpio:pinMode(pin_number, 1) -- set pin to output mode
    gpio:write(pin_number, 1) -- turn pin on 

end