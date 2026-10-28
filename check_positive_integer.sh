#!/bin/sh

# Step 1: Ask the user to enter one value. printf prints a fixed prompt without
# adding a newline, so the user can type their answer on the same line.
printf 'Enter a number: '

# Step 2: Read one complete line into number. IFS= preserves leading/trailing
# whitespace, and -r preserves backslashes. This matters because we must reject
# invalid input rather than silently remove characters before checking it.
# Initialize the variable so empty input or end-of-file has a predictable value.
number=''
IFS= read -r number

# Step 3: Use grep and a regular expression as the ONLY numeric validation.
# printf safely passes the input as data, even if it contains % or starts with -.
# -E enables extended regular expressions; -q suppresses matching output.
# grep succeeds (exit status 0) when the entire input matches this expression:
#   ^       : the start of the line; prevents accepting a valid substring.
#   0*      : zero or more leading zeros (for example, 007 represents seven).
#   [1-9]   : one nonzero digit, ensuring the value is strictly greater than 0.
#   [0-9]*  : zero or more additional decimal digits.
#   $       : the end of the line; prevents extra characters after the number.
# Together, ^0*[1-9][0-9]*$ accepts positive integers written using ASCII digits.
# It rejects zero (including 000), negatives, signs, decimals, letters, whitespace,
# and empty input. There is no arithmetic conversion, so very large values work.
# LC_ALL=C makes the character ranges behave consistently across locales.
if printf '%s\n' "$number" | LC_ALL=C grep -Eq '^0*[1-9][0-9]*$'; then
    # Step 4a: A successful grep match means the input is a valid positive integer.
    printf 'Valid positive integer.\n'
else
    # Step 4b: A failed grep match means the input does not meet the required format.
    printf 'Not a valid positive integer.\n'
fi
