#!/bin/bash

commandToRun="helm $@"

# If collector env var not set
# default to localhost:4318
if [ -z $HT_OTELCOL_ENDPOINT ]
then
  HT_OTELCOL_ENDPOINT=http://localhost:4318
fi

# If service name not set
# default to helm
if [ -z $HT_SERVICE_NAME ]
then
  HT_SERVICE_NAME=helm
fi

time_start=0
$commandToRun
time_end=$SECONDS

duration=$(( $time_end - $time_start ))
echo "Duration: $duration"

tracepusher -e $HT_OTELCOL_ENDPOINT -sen $HT_SERVICE_NAME -spn "$commandToRun" -dur $duration