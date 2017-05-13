#!/usr/bin/env bash

# Find someone with the camera (silently)
#
jv_pg_fr_find_someone_with_the_camera()
{
  # TODO python3 script
}

# Say the name of the last detected person
jv_pg_fr_say_detected_person()
{
  say "$(jv_pg_fr_lang detected_person "$jv_pg_fr_detected_person")"
}
