function init()
    if(arming:is_armed()) then
       arming:disarm() 
    end
    -- get ground data
    initial_position = ahrs:get_position()
    initial_home = ahrs:get_home()
    initial_alt = ahrs:get_hagl()
    jork = 0

    accel_list = {}
    time_list = {}
    
    deploy_flag_not_raised = true
    jerk_threshold = -0.5 --test val
     -- reading acceleration

    -- JERK SHOULD BE CALLED EVERY <PERIOD> seconds, where this behavior is defined as a conditional block
    -- within read loop to check time_delta < <PERIOD>
    

    while deploy_flag_not_raised do
        table.insert(accel_list, ahrs:get_accel())
        table.insert(time_list, os.clock())
        --print("(still accelerating upwards)")
        if end
    end
    vehicle:set_mode(18) --throw mode
    while !ahrs:prearm_healthy() do
        print("Prearm checks not yet ready.")
    end
    arming:arm()
    send_gpio() 
end


-- Abiguous(?) of the direction of the axes for get_accel()
-- jerk = (a1-a2)/(t1-t2), t is os.clock()
function jerk(accels, times)
    local cals = {}
    
    -- take running rate of change measurement
    for i = 0, accels.length - 1, 1 do
        cals[i] = (accels[i + 1] - accels[i]) / (times[i + 1] - times[i])
    end
    


    
end