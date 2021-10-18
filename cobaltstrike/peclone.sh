#!/bin/bash
#
# Check a Malleable C&C Profile
#
java -XX:ParallelGCThreads=4 -XX:+UseParallelGC -Xms512M -Xmx1024M -classpath ./cobaltstrike.jar pe.PEParser $*
