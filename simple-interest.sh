#!/usr/bin/env bash

set -euo pipefail

read -r -p "Enter the principal amount: " principal
read -r -p "Enter the annual rate of interest (%): " rate
read -r -p "Enter the time period (years): " time

if ! [[ "$principal" =~ ^[0-9]+([.][0-9]+)?$ &&
        "$rate" =~ ^[0-9]+([.][0-9]+)?$ &&
        "$time" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    printf 'Error: principal, rate, and time must be non-negative numbers.\n' >&2
    exit 1
fi

simple_interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" \
    'BEGIN { printf "%.2f", principal * rate * time / 100 }')
total_amount=$(awk -v principal="$principal" -v interest="$simple_interest" \
    'BEGIN { printf "%.2f", principal + interest }')

printf 'Simple interest: %s\n' "$simple_interest"
printf 'Total amount: %s\n' "$total_amount"
