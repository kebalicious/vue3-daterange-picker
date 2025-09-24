# Create and pack the tarball
PKG_TARBALL=$(npm pack --json | jq -r '.[0].filename')
echo "Generated tarball: $PKG_TARBALL"

# Verify tarball contents
echo "Tarball contents:"
tar -tf "$PKG_TARBALL"

echo ""
echo "Verifying required files..."

# Store tarball contents to avoid broken pipe issues with -o pipefail
TARBALL_CONTENTS=$(tar -tf "$PKG_TARBALL" 2>/dev/null)

# Check each required file safely
if echo "$TARBALL_CONTENTS" | grep -q "package/dist/vue3-daterange-picker.umd.js"; then
    echo "✓ Found vue3-daterange-picker.umd.js"
else
    echo "✗ Missing vue3-daterange-picker.umd.js"
    exit 1
fi

if echo "$TARBALL_CONTENTS" | grep -q "package/dist/vue3-daterange-picker.es.js"; then
    echo "✓ Found vue3-daterange-picker.es.js"
else
    echo "✗ Missing vue3-daterange-picker.es.js"
    exit 1
fi

if echo "$TARBALL_CONTENTS" | grep -q "package/dist/style.css"; then
    echo "✓ Found style.css"
else
    echo "✗ Missing style.css"
    exit 1
fi

if echo "$TARBALL_CONTENTS" | grep -q "package/package.json"; then
    echo "✓ Found package.json"
else
    echo "✗ Missing package.json"
    exit 1
fi

echo "Tarball contents verified."

# Set up temporary install directory
mkdir -p tmp-install
cd tmp-install

# Initialize and install the tarball
npm init -y >/dev/null 2>&1
npm install "../$PKG_TARBALL" >/dev/null 2>&1

# Debug: List installed files and package.json
echo "Installed files in node_modules/@kebalicious/vue3-daterange-picker:"
if [ -d "node_modules/@kebalicious/vue3-daterange-picker" ]; then
    ls -la node_modules/@kebalicious/vue3-daterange-picker
    echo ""
    echo "Dist directory contents:"
    ls -la node_modules/@kebalicious/vue3-daterange-picker/dist/
else
    echo "Directory not found"
    exit 1
fi

echo ""
echo "Package.json verification:"
if [ -f "node_modules/@kebalicious/vue3-daterange-picker/package.json" ]; then
    echo "✓ package.json exists"
    # Show just the important parts
    node -e "
        const pkg = require('./node_modules/@kebalicious/vue3-daterange-picker/package.json');
        console.log('Name:', pkg.name);
        console.log('Version:', pkg.version);
        console.log('Main:', pkg.main);
        console.log('Module:', pkg.module);
    "
else
    echo "✗ package.json not found"
    exit 1
fi

# Test import (using scoped package name)
echo ""
echo "Testing package import..."
if node -e "const pkg = require('@kebalicious/vue3-daterange-picker'); console.log('✓ Import successful! Package type:', typeof pkg);"; then
    echo "✓ Package import test passed"
else
    echo "✗ Package import test failed"
    exit 1
fi

# Clean up
cd ..
rm -rf tmp-install

echo ""
echo "🎉 All package verification tests passed!"