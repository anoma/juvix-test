#!/bin/bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <command> <expect_success> <regex_list>"
    exit 1
fi

# The command under test
COMMAND="$1"

# Whether a success (0 exit code) is expected
EXPECT_SUCCESS="$2"

# Regular expressions passed as a single string, split by a delimiter (e.g., comma)
IFS=',' read -r -a regex_list <<< "$3"

# Execute the command and store both stdout and stderr in the output
output=$(stdbuf -oL $COMMAND 2>&1)
exit_code=$?

# Check the exit code
if [[ "$EXPECT_SUCCESS" == "expect_success" && $exit_code -ne 0 ]]; then
    echo "Expected $COMMAND to succeed but it failed with exit code $exit_code."
    exit 1
elif [[ ! "$EXPECT_SUCCESS" == "expect_success" && $exit_code -eq 0 ]]; then
    echo "Expected $COMMAND to fail but it succeeded."
    exit 1
fi


failed=0

for regex in "${regex_list[@]}"; do
    if [[ ! $output =~ $regex ]]; then
        echo "$COMMAND: No match found for regex: $regex"
        echo "output:"
        echo "$output"
        failed=1
    fi
done

if [ $failed -eq 1 ]; then
    exit 1
fi
