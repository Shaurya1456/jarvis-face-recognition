#!/usr/bin/env bash

# Start the face recognition server
# return (int): 0 if success, 1 if failed
jv_pg_fr_start()
{
  jv_debug "Starting Face Recognition server"

  # Start the server
  local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  if [ "$verbose" = true ]; then
    python3 $dir/script/face_recognition_server.py --verbose="True" --knownPeople="$var_jv_pg_fr_people_to_find" &
  else
    nohup python3 $dir/script/face_recognition_server.py --verbose="True" --knownPeople="$var_jv_pg_fr_people_to_find" --unknownPerson "$jv_pg_fr_unknown_person" 2>&1 | jv_add_timestamps >>$jv_dir/jarvis.log &
  fi
}

# Say the name of the last detected person
jv_pg_fr_say_detected_person()
{
  say "$(jv_pg_fr_lang detected_person "$jv_pg_fr_detected_person")"
}
