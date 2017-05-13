#!/usr/bin/env bash

jv_pg_fr_lang()
{
  case "$1" in
    detected_person) echo "Personne détéctée: $2";;

    *) jv_error "Erreur: Clef de traduction '$1' non reconnue. Merci de contacter le concepteur de ce plugin.";;
  esac
}
