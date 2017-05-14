#!/usr/bin/env bash

# Start the face recognition server
# return (int): 0 if success, 1 if failed
jv_pg_fr_start()
{
  # TODO python3 script
}

# Say the name of the last detected person
jv_pg_fr_say_detected_person()
{
  say "$(jv_pg_fr_lang detected_person "$jv_pg_fr_detected_person")"
}
