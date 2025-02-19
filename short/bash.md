# Bash Script to get last 10 lines of a files

```bash
#!/bin/bash

# Define the file
FILE="your_file.txt"

# Check if the file exists
if [[ -f "$FILE" ]]; then
    tail -n 10 "$FILE"
else
    echo "File not found: $FILE"
fi
```

# Bash Script to get no of words in a file
```bash
#!/bin/bash

# Define the file
FILE="your_file.txt"

# Check if the file exists
if [[ -f "$FILE" ]]; then
    WORD_COUNT=$(wc -w < "$FILE")
    echo "Number of words in $FILE: $WORD_COUNT"
else
    echo "File not found: $FILE"
fi
```

# Bash script to get no of duplicatons words in a file

```bash
#!/bin/bash

# Define the file
FILE="your_file.txt"

# Check if the file exists
if [[ -f "$FILE" ]]; then
    tr -s '[:space:][:punct:]' '\n' < "$FILE" | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -nr | awk '$1 > 1 {print $2, $1}'
else
    echo "File not found: $FILE"
fi
```