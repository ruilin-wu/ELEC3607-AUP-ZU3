#!/bin/bash
# compare_projectspec_en_full.sh
# Usage: bash compare_projectspec_en_full.sh <path_A/project-spec> <path_B/project-spec>

A="$1"
B="$2"

if [ -z "$A" ] || [ -z "$B" ]; then
  echo "Usage: bash compare_projectspec_en_full.sh <path_A> <path_B>"
  exit 1
fi

if [ ! -d "$A" ] || [ ! -d "$B" ]; then
  echo "Error: Invalid directories. Please provide two valid project-spec folders."
  exit 1
fi

REPORT="project_spec_full_diff_$(date +%Y%m%d_%H%M%S).txt"

{
  echo "========================================"
  echo "Comparing directories:"
  echo "A: $A"
  echo "B: $B"
  echo "========================================"
  echo "[1] Counting total files..."
  echo "Files in A: $(find "$A" -type f | wc -l)"
  echo "Files in B: $(find "$B" -type f | wc -l)"
  echo ""

  echo "[2] Structure differences (missing, extra, or modified files):"
  diff -rq "$A" "$B" > /tmp/full_diff_list.txt

  # 分别提取各自独有的文件
  ONLY_IN_A=$(grep "^Only in $A" /tmp/full_diff_list.txt)
  ONLY_IN_B=$(grep "^Only in $B" /tmp/full_diff_list.txt)
  DIFF_LIST=$(grep " differ$" /tmp/full_diff_list.txt)

  if [ -n "$ONLY_IN_A" ]; then
    echo "Files/Folders only in A ($A):"
    echo "$ONLY_IN_A" | sed "s|^Only in $A||"
  else
    echo "No unique files in A."
  fi

  echo ""
  if [ -n "$ONLY_IN_B" ]; then
    echo "Files/Folders only in B ($B):"
    echo "$ONLY_IN_B" | sed "s|^Only in $B||"
  else
    echo "No unique files in B."
  fi

  echo ""
  if [ -n "$DIFF_LIST" ]; then
    echo "Files with content differences:"
    echo ""
    while IFS= read -r line; do
      FILE_A=$(echo "$line" | sed -n 's/^Files \(.*\) and \(.*\) differ$/\1/p')
      FILE_B=$(echo "$line" | sed -n 's/^Files \(.*\) and \(.*\) differ$/\2/p')
      if [ -n "$FILE_A" ] && [ -n "$FILE_B" ]; then
        echo "- A: $FILE_A"
        echo "  B: $FILE_B"
      fi
    done <<< "$DIFF_LIST"
  else
    echo "No content-different files."
  fi
  echo ""

  echo "[3] File content differences (details for files listed above):"
  if [ -n "$DIFF_LIST" ]; then
    echo "$DIFF_LIST" > /tmp/diff_files.txt
    while IFS= read -r line; do
      FILE_A=$(echo "$line" | sed -n 's/^Files \(.*\) and \(.*\) differ$/\1/p')
      FILE_B=$(echo "$line" | sed -n 's/^Files \(.*\) and \(.*\) differ$/\2/p')
      if [ -n "$FILE_A" ] && [ -n "$FILE_B" ]; then
        echo "----------------------------------------"
        echo "Differences in: ${FILE_A#$A/}"
        echo "File A: $FILE_A"
        echo "File B: $FILE_B"
        diff -u "$FILE_A" "$FILE_B"
        echo ""
      fi
    done < /tmp/diff_files.txt
    rm -f /tmp/diff_files.txt
  else
    echo "No file content differences found."
  fi

  rm -f /tmp/full_diff_list.txt

  echo "========================================"
  echo "Comparison completed. Report saved to: $REPORT"
} > "$REPORT"

exit 0
