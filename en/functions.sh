#!/usr/bin/env bash

jv_pg_fr_lang()
{
  case "$1" in
    detected_person) echo "Detected person: $2";;

    *) jv_error "Error: Translation key '$1' not recognized. Please contact the designer of this plugin.";;
  esac
}
