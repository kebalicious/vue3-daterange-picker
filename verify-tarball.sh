#!/bin/bash

# Create and pack the tarball
PKG_TARBALL=$(npm pack --json | jq -r '.[0].filename')
echo "Generated tarball: $PKG_TARBALL"

# Verify tarball contents
echo "Tarball contents:"
tar -tf "$PKG_TARBALL"

echo ""
echo "Verifying required files..."

# Store tarball contents to avoid multiple tar calls and pipe issues
TARBALL_CONTENTS=$(tar -tf "$PKG_TARBALL" 2>/dev/null)

# Check each required file
check_file() {
    local file_pattern="$1"
    local display_name="$2"
    
    if echo "$TARBALL_CONTENTS" | grep -q "$file_pattern"; then
        echo "✓ Found $display_name"
        return 0
    else
        echo "✗ Missing $display_name"
        return 1
    fi
}

# Verify each required file
check_file "package/dist/vue3-daterange-picker.umd.js" "vue3-daterange-picker.umd.js" || exit 1
check_file "package/dist/vue3-daterange-picker.es.js" "vue3-daterange-picker.es.js" || exit 1
check_file "package/dist/style.css" "style.css" || exit 1
check_file "package/package.json" "package.json" || exit 1

echo "All required files verified in tarball."

# Set up temporary install directory
echo ""
echo "Setting up test installation..."
rm -rf tmp-install
mkdir -p tmp-install
cd tmp-install

# Initialize and install the tarball
npm init -y >/dev/null 2>&1
echo "Installing tarball..."
npm install "../$PKG_TARBALL" >/dev/null 2>&1

# Debug: List installed files and package.json
echo ""
echo "Installed files in node_modules/@kebalicious/vue3-daterange-picker:"
if [ -d "node_modules/@kebalicious/vue3-daterange-picker" ]; then
    ls -la node_modules/@kebalicious/vue3-daterange-picker
else
    echo "Directory not found"
    exit 1
fi

echo ""
echo "Checking dist directory:"
if [ -d "node_modules/@kebalicious/vue3-daterange-picker/dist" ]; then
    ls -la node_modules/@kebalicious/vue3-daterange-picker/dist/
else
    echo "Dist directory not found"
    exit 1
fi

echo ""
echo "Package.json content:"
if [ -f "node_modules/@kebalicious/vue3-daterange-picker/package.json" ]; then
    head -10 node_modules/@kebalicious/vue3-daterange-picker/package.json
else
    echo "package.json not found"
    exit 1
fi

# Test import (using scoped package name)
echo ""
echo "Testing import..."
if node -e "const pkg = require('@kebalicious/vue3-daterange-picker'); console.log('Import successful! Type:', typeof pkg);"; then
    echo "✓ Package import test passed"
else
    echo "✗ Package import test failed"
    exit 1
fi

# Clean up
cd ..
rm -rf tmp-install

echo ""
echo "🎉 All verification tests passed!"