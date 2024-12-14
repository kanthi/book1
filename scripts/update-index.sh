#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BOOK_DIR="$(dirname "$SCRIPT_DIR")"
CONTENT_DIR="$BOOK_DIR/content"
QUARTO_YML="$BOOK_DIR/_quarto.yml"

# Function to read metadata from _metadata.yml file
get_metadata() {
    local dir="$1"
    local metadata_file="$dir/_metadata.yml"
    if [ -f "$metadata_file" ]; then
        # Read title
        local title=$(grep "^title:" "$metadata_file" | cut -d'"' -f2)
        # Read order
        local order=$(grep "^order:" "$metadata_file" | cut -d':' -f2 | tr -d ' ')
        echo "$order|$title"
    else
        # Extract order from directory name if it starts with a number
        local dirname=$(basename "$dir")
        local order=$(echo "$dirname" | grep -o '^[0-9]\+' || echo "999")
        # Create title from directory name
        local title=$(echo "$dirname" | sed -E 's/^[0-9]+-?//' | sed 's/\b\(.\)/\u\1/g')
        echo "$order|$title"
    fi
}

# Create a temporary file
TMP_FILE=$(mktemp)

# Write the header
cat > "$TMP_FILE" << EOL
project:
  type: book
  output-dir: _book

book:
  title: "Book Title"
  author: "Author Name"
  date: last-modified
  navbar: 
    pinned: true
    right:
      - icon: sun
        href: "#"
        id: quarto-light
      - icon: moon
        href: "#"
        id: quarto-dark
      - icon: circle-half
        href: "#"
        id: quarto-auto
  sidebar:
    style: docked
    collapse-level: 1
  chapters:
    - index.qmd
EOL

# Function to process directories
process_directory() {
    local dir="$1"
    local metadata=$(get_metadata "$dir")
    local order=$(echo "$metadata" | cut -d'|' -f1)
    local title=$(echo "$metadata" | cut -d'|' -f2)
    
    # Add the category as a part
    echo "    - part: \"$title\"" >> "$TMP_FILE"
    echo "      chapters:" >> "$TMP_FILE"
    
    # Get all subdirectories and sort them
    local subdirs=()
    while IFS= read -r subdir; do
        if [ -d "$subdir" ] && [[ ! $(basename "$subdir") == _* ]]; then
            subdirs+=("$subdir")
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d | sort)
    
    # Process each subdirectory
    for subdir in "${subdirs[@]}"; do
        if [ -d "$subdir" ]; then
            local subdir_name=$(basename "$subdir")
            local relative_path="content/$(basename "$dir")/${subdir_name}"
            local subdir_metadata=$(get_metadata "$subdir")
            local subdir_title=$(echo "$subdir_metadata" | cut -d'|' -f2)
            
            # Check if index.qmd exists
            if [ -f "${subdir}/index.qmd" ]; then
                echo "        - ${relative_path}/index.qmd" >> "$TMP_FILE"
            fi
            
            # Process individual .qmd files (excluding index.qmd)
            for qmd in "$subdir"/*.qmd; do
                if [ -f "$qmd" ] && [ "$(basename "$qmd")" != "index.qmd" ]; then
                    local qmd_name=$(basename "$qmd")
                    echo "        - ${relative_path}/${qmd_name}" >> "$TMP_FILE"
                fi
            done
        fi
    done

    # If no subdirectories found with index.qmd, add the category index
    if [ -f "$dir/index.qmd" ]; then
        echo "        - content/$(basename "$dir")/index.qmd" >> "$TMP_FILE"
    fi
}

# Get all main categories and sort them by order
categories=()
while IFS= read -r category; do
    if [ -d "$category" ] && [[ ! $(basename "$category") == _* ]]; then
        metadata=$(get_metadata "$category")
        order=$(echo "$metadata" | cut -d'|' -f1)
        categories+=("$order|$category")
    fi
done < <(find "$CONTENT_DIR" -maxdepth 1 -mindepth 1 -type d)

# Sort categories by order and process them
while IFS= read -r category_info; do
    category_path=$(echo "$category_info" | cut -d'|' -f2)
    process_directory "$category_path"
done < <(printf "%s\n" "${categories[@]}" | sort -n)

# Add the format section
cat >> "$TMP_FILE" << EOL

format:
  html:
    theme:
      light: [cosmo, styles/light.scss]
      dark: [darkly, styles/dark.scss]
    code-fold: true
    toc: true
    number-sections: false
    page-navigation: true
    
  pdf:
    documentclass: scrreprt
    classoption: ["oneside"]
    number-sections: false
    colorlinks: true
    geometry:
      - top=25mm
      - left=25mm
      - right=25mm
      - bottom=25mm
    
  epub:
    toc: true
    number-sections: false
EOL

# Replace the original file with the new content
mv "$TMP_FILE" "$QUARTO_YML"

echo "Updated _quarto.yml with current directory structure"
