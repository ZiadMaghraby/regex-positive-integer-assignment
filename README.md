# RegEx assignment

A POSIX shell script that reads one number and reports whether it is a valid
positive integer. Numeric validation uses only `grep` and a regular expression.
Detailed comments before each step explain the commands and the regex.

## Run

Requires a POSIX shell and grep (Linux, macOS, WSL, or Git Bash).

```sh
sh check_positive_integer.sh
```

## Regular expression

```text
^0*[1-9][0-9]*$
```

`^` and `$` require the entire input line to match. `0*` allows leading zeros;
`[1-9]` requires a nonzero digit; `[0-9]*` allows any remaining digits.
Positive means strictly greater than zero. This solution accepts leading zeros
such as `007`, but rejects explicit signs such as `+7` and all whitespace.

| Input | Result |
| --- | --- |
| `1`, `42`, `007`, `00010` | Valid |
| `0`, `000`, `-5`, `+5` | Invalid |
| `1.5`, `1e3`, `abc`, `12abc` | Invalid |
| Empty input, spaces, ` 7`, `7 ` | Invalid |

No arithmetic conversion is used, so integer size is not limited by shell
arithmetic. Only the first input line is read.
