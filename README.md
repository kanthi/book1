# Quarto Book Template

A comprehensive template for creating books using Quarto with automatic deployment and multiple output formats. Features include automatic content indexing, dark/light themes, and GitHub Actions integration.

## Features

- Organized category-based content structure
- Automated content indexing based on directory structure
- Multiple output formats (HTML, PDF, EPUB)
- Dark and light theme support
- GitHub Actions for automated deployment
- No blank pages in PDF output

## Directory Structure

```
book/
├── content/          # Main content directory
│   ├── category1/    # Main categories
│   │   ├── _metadata.yml    # Category metadata
│   │   ├── subcategory1/    # Subcategories
│   │   └── subcategory2/
│   └── category2/
├── images/          # Image assets
├── styles/          # Theme customization
│   ├── light.scss   # Light theme styles
│   └── dark.scss    # Dark theme styles
├── scripts/         # Utility scripts
│   └── update-index.sh  # Auto-updates book structure
├── _quarto.yml     # Quarto configuration
└── index.qmd       # Book homepage
```

## Content Organization

### Using Metadata Files (Recommended)

Place a `_metadata.yml` file in each category directory to control its title and order:

```yaml
# content/category1/_metadata.yml
title: "Getting Started"
order: 1

# content/category2/_metadata.yml
title: "Advanced Topics"
order: 2
```

### Using Directory Names (Alternative)

Alternatively, use numbered prefixes in directory names:

```
content/
  01-getting-started/
  02-advanced-topics/
```

The script will:
1. First look for _metadata.yml
2. Fall back to parsing directory names
3. Extract order from numeric prefixes
4. Create titles from directory names (removing numbers, capitalizing words)

## Setup and Usage

1. Clone this repository
2. Install Quarto (https://quarto.org/docs/get-started/)
3. Install additional dependencies:
   ```bash
   quarto install tinytex  # For PDF rendering
   ```

### Adding Content

1. Create categories in the `content/` directory
2. Add `_metadata.yml` to each category (or use numbered directories)
3. Create subcategories as needed
4. Add `.qmd` files for your content

### Local Development

1. Update content in the `content/` directory
2. Run the index updater:
   ```bash
   ./scripts/update-index.sh
   ```
3. Preview the book:
   ```bash
   quarto preview
   ```

## Themes

### Light/Dark Theme Support

The template includes both light and dark themes with:
- Automatic system preference detection
- Manual theme switcher in the navbar
- Customizable styles in `styles/` directory

Customize themes by editing:
- `styles/light.scss` for light theme
- `styles/dark.scss` for dark theme

## Building the Book

```bash
quarto render
```

This will generate:
- HTML version with dark/light themes
- PDF version without blank pages
- EPUB version for e-readers

## Deployment

The repository includes GitHub Actions workflows for:

1. Automatic deployment to GitHub Pages
2. Creation of PDF/EPUB releases

To deploy:
1. Push changes to the `main` branch
2. GitHub Actions will:
   - Update the book structure
   - Build all formats
   - Deploy HTML to GitHub Pages
   - Create a release with PDF/EPUB assets

### Setting Up GitHub Pages

1. Go to repository Settings > Pages
2. Set source to GitHub Actions
3. First deployment will create gh-pages branch

## Configuration

### Quarto Settings

Edit `_quarto.yml` for:
- Book metadata
- Navigation options
- Output format settings
- Theme configuration

### GitHub Actions

The workflow in `.github/workflows/publish.yml`:
- Runs on pushes to main
- Updates book structure
- Builds all formats
- Deploys to GitHub Pages
- Creates releases

## License

MIT
