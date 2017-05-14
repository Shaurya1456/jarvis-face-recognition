#!/usr/bin/env bash

# Start the face recognition server
jv_pg_fr_start()
{
  jv_debug "Starting Face Recognition server"

  # Start the server
  local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

  if [ "$verbose" = true ]; then
    python3 $dir/script/face_recognition_server.py --verbose="True" --knownPeople="$var_jv_pg_fr_people_to_find" --unknownPerson "$jv_pg_fr_unknown_person" &
  else
    nohup python3 $dir/script/face_recognition_server.py --verbose="True" --knownPeople="$var_jv_pg_fr_people_to_find" --unknownPerson "$jv_pg_fr_unknown_person" 2>&1 | jv_add_timestamps >>$jv_dir/jarvis.log &
  fi
}
