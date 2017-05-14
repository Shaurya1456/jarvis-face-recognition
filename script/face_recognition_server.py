#!/usr/bin/env python

import argparse # Manage program arguments
import json # Read json input
import os # Build path
import sys # Use exit calls
import signal # Catch kill
import logging # Add logging
import ast # Convert string to list
import picamera # Pi camera (take picture)
import numpy as np # Type specific definition
import face_recognition # Face recognition
import time # Sleep
from subprocess import call # Send request to Jarvis

if __name__ == "__main__":
  # Define lambda function to convert string to bool
  def __str2bool(value):
    if value.lower() in ('yes', 'true', 't', 'y', '1'):
      return True
    if value.lower() in ('no', 'false', 'f', 'n', '0'):
      return False
    else:
      raise argparse.ArgumentTypeError('Boolean value expected.')

  # Parse received parameters
  parser = argparse.ArgumentParser(description='Jarvis Face Recognition Server')
  parser.add_argument('-p', '--knownPeople', help='List of known people (format: "[{"name": "Person name", "image": "/path/to/img.jpg"},...]')
  parser.add_argument('-u', '--unknownPerson', default="Unknown", help='Name of unknown person (default: Unknown)')
  parser.add_argument('-v', '--verbose', type=__str2bool, nargs='?', default="True", help='Show debug information (default: True)')
  args = parser.parse_args()

  # Show more information if in debug mode
  if args.verbose:
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

  known_people = ast.literal_eval(args.knownPeople)

  # Get a reference to the Raspberry Pi camera.
  # If this fails, make sure you have a camera connected to the RPi and that you
  # enabled your camera in raspi-config and rebooted first.
  logging.debug("Enabling PiCamera")
  camera = picamera.PiCamera()
  camera.resolution = (320, 240)
  output = np.empty((240, 320, 3), dtype=np.uint8)

  # Load a sample picture and learn how to recognize it.
  logging.debug("Loading known face image(s)")
  people_face_encoding = []
  for known_person in known_people:
    logging.debug("Loading image of '{}' ('{}')".format(str(known_person['name']), str(known_person['image'])))
    person_image = face_recognition.load_image_file(str(known_person['image']))
    people_face_encoding.append(face_recognition.face_encodings(person_image)[0])

  # Initialize some variables
  face_locations = []
  face_encodings = []

  while True:
    logging.debug("Capturing image")
    # Grab a single frame of video from the RPi camera as a numpy array
    camera.capture(output, format="rgb")

    logging.debug("Trying to find faces")
    # Find all the faces and face encodings in the current frame of video
    face_locations = face_recognition.face_locations(output)
    logging.debug("Found {} faces in image".format(len(face_locations)))
    face_encodings = face_recognition.face_encodings(output, face_locations)

    # Loop over each face found in the frame to see if it's someone we know.
    for face_encoding in face_encodings:
      # See if the face is a match for the known face(s)
      logging.debug("Comparing found faces with registered faces")
      name = args.unknownPerson
      match = face_recognition.compare_faces(people_face_encoding, face_encoding)

      number_registered_people = 0
      for known_person in known_people:
        if match[number_registered_people]:
          name = known_person['name']
        number_registered_people = number_registered_people + 1

      logging.debug("I see someone named '{}'".format(name))

      # Send information to Jarvis (TODO: IMPROVE BY USING -x option)
      call([os.path.join(".", "jarvis.sh"), "-s", "J'ai détécté {}".format(name)])

    logging.debug("Waiting 2sec")
    time.sleep(2)
