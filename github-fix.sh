#!/bin/bash

# One-liner that works with GitHub Actions pipefail
PKG_TARBALL=$(npm pack --json | jq -r '.[0].filename')
echo "Generated: $PKG_TARBALL"

# Store contents to avoid broken pipe
CONTENTS=$(tar -tf "$PKG_TARBALL")

# Check files one by one
echo "$CONTENTS" | grep -q "vue3-daterange-picker.umd.js" && echo "✓ UMD found" || { echo "✗ UMD missing"; exit 1; }
echo "$CONTENTS" | grep -q "vue3-daterange-picker.es.js" && echo "✓ ES found" || { echo "✗ ES missing"; exit 1; }
echo "$CONTENTS" | grep -q "style.css" && echo "✓ CSS found" || { echo "✗ CSS missing"; exit 1; }

echo "All files verified!"

# Quick install test
rm -rf tmp-test && mkdir tmp-test && cd tmp-test
npm init -y >/dev/null 2>&1
npm install "../$PKG_TARBALL" >/dev/null 2>&1
node -e "console.log('Import test:', typeof require('@kebalicious/vue3-daterange-picker'))"
cd .. && rm -rf tmp-test

echo "🎉 SUCCESS!"