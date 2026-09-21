#!/bin/bash
set -e

# PASS SOURCE DIRECTORY AS FIRST ARGUMENT
src_dir="$1"

if [[ -z "$src_dir" ]]; then
    echo "Usage: $0 <source_dir>"
    exit 1
fi

# directory where this .sh file lives, and its parent
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
parent_dir="$(dirname "$script_dir")"
out_dir="$parent_dir/motions_pkl_g1_to_kangaroo"

mkdir -p "$out_dir"

for path in "$src_dir"/*; do
    file=$(basename "$path")

    if [[ "$file" != "manifest.json" ]]; then
        uv run "$parent_dir/scripts/robot_to_robot.py" \
            --source_robot_file "$path" \
            --source-robot unitree_g1 \
            --target-robot pal_kangaroo \
            --save_path "$out_dir/$file"
    fi
done