#!/bin/bash

# Default number of parallel jobs
parallel_jobs=3

# Function to run commands in parallel
run_parallel() {
    local i=0
    local running=0
    local total=$#

    while (( i < total || running > 0 )); do
        # Start jobs if there are available slots and commands remaining
        while (( running < parallel_jobs && i < total )); do
            eval "${!i}" &   # Start command in background
            running=$((running + 1)) # Increment running count
            i=$((i + 1))             # Move to next command
        done

        # Wait for any background process to finish
        wait -n
        running=$((running - 1))     # Decrement running count
    done
}

# Parse arguments
for arg in "$@"; do
    case $arg in
        --parallel-jobs=*)
        parallel_jobs="${arg#*=}"
        shift # Remove --parallel-jobs from arguments
        ;;
    esac
done

# Remaining arguments should be the commands
commands=("$@")

# Ensure at least one command is passed as an argument
if [ ${#commands[@]} -eq 0 ]; then
    echo "Usage: $0 [--parallel-jobs=X] \"command1\" \"command2\" ... \"commandN\""
    exit 1
fi

# Call the function to run commands in parallel
run_parallel "${commands[@]}"
