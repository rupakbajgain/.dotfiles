#!/bin/sh
./update-system.sh
./cleanup-system.sh
#./cleanup-user.sh
./update-user.sh
./apply-user.sh
./apply-system.sh
