#!/bin/sh
fvm flutter packages pub run build_runner build --delete-conflicting-outputs
#flutter packages pub run build_runner build -d