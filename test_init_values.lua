function init()

    mavlink_msgs = require("modules/MAVLink/mavlink_msgs")
    COMMAND_ACK_ID = mavlink_msgs.get_msgid("COMMAND_ACK")
    COMMAND_LONG_ID = mavlink_msgs.get_msgid("COMMAND_LONG")

    if(arming:is_armed()) then
       arming:disarm() 
    end

    initial_position = ahrs:get_position()
    initial_home = ahrs:get_home()
    initial_alt = ahrs:get_hagl()

end