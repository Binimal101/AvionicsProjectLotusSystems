function init():
    if(arming:is_armed()) then
       arming:disarm() 
    end
    -- get ground data
    initial_position = ahrs:get_position()
    initial_home = ahrs:get_home()
    initial_alt = ahrs:get_hagl()
    -- reading acceleration
    while ahrs:get_accel():z() > 0 do
        print("(still accelerating upwards)")
    end
    vehicle:set_mode(18) --throw mode
    
    while !ahrs:prearm_healthy() do
        print("Prearm checks not yet ready.")
    end
    arming:arm()
    send_gpio() 
end