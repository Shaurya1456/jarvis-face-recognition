# Camera configuration (for now: Only PiCamera available)
#var_jv_pg_fr_use_pi_camera="True" # Use Pi camera: True / Use USB camera: False
#var_jv_pg_fr_usb_camera_id=0 # USB camera number (0 by default)

# Face recognition configuration
jv_pg_fr_unknown_person="Unknown user" # Name of people found with camera but not reconized

var_jv_pg_fr_people_to_find='[
    {"name": "Barack Obama", "image": "../examples/barack_obama.jpg"},
    {"name": "Hillary Clinton", "image": "../examples/hillary_clinton.jpg"}
]' # List of people to find in pictures
