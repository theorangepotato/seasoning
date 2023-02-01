#!/bin/bash

SEASON=1
EPISODE=1
# SERIES_NAME="Series Name"

while [[ $# -gt 0 ]]; do
    case $1 in
        -x|--extension)
            EXTENSION="$2"
	    shift # argument
	    shift # value
	    ;;
	-s|--season)
	    SEASON="$2"
	    shift # argument
	    shift # value
	    ;;
	-e|--episode-start)
	    EPISODE="$2"
	    shift # argument
	    shift # value
	    ;;
	-n|--name)
	    SERIES_NAME="$2"
	    shift # argument
	    shift # value
	    ;;
	-d|--dryrun)
	    DRYRUN="TRUE"
	    shift # argument
	    ;;
	-q|--quiet)
	    QUIET="TRUE"
	    shift # argument
	    ;;
	*)
	    echo "ERROR: Unknown option $1"
	    exit 1
	    ;;
    esac
done

if [ -z ${SERIES_NAME+x} ]; then
    echo "ERROR: Name must be set"
    exit 1
fi

INTEGER='^[0-9]+$'
if ! [[ $SEASON =~ $INTEGER ]] ; then
   echo "ERROR: Season must be an integer number"
   exit 1
fi

if ! [[ $EPISODE =~ $INTEGER ]] ; then
   echo "ERROR: Episode must be an integer number"
   exit 1
fi

if ! [ -z "$EXTENSION" ]; then
    EXTENSION=".$EXTENSION"
fi

for file in *"$EXTENSION"; do
    name="$SERIES_NAME S$(printf %02d "$SEASON")E$(printf %02d "$EPISODE")$EXTENSION"
    if [ "$QUIET" != "TRUE" ]; then
	echo "$file --> $name"
    fi
    if [ "$DRYRUN" != "TRUE" ]; then
      mv "$file" "$name"
    fi
    EPISODE=$((EPISODE + 1))
done
