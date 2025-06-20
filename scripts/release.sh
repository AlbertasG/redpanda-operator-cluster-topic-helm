#!/bin/bash

# Install required tools if not present
if ! command -v helm-docs &> /dev/null; then
    echo "Installing helm-docs..."
    brew install norwoodj/tap/helm-docs
fi

if ! command -v cr &> /dev/null; then
    echo "Installing chart-releaser..."
    brew install chart-releaser
fi

# Generate documentation
echo "Generating documentation..."
helm-docs

# Package the chart
echo "Packaging chart..."
helm package .

# Update index
echo "Updating index..."
cr index

# Clean up
echo "Cleaning up..."
rm -rf .cr-release-packages
rm -rf .cr-index

echo "Done! You can now commit and push the changes to gh-pages branch." 