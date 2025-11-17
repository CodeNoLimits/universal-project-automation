#!/bin/bash
# 🖼️ IMAGE OPTIMIZATION AUTOMATION
# Optimizes all images in a project (convert to WebP, resize, compress)
# Called by: n8n workflow, manual, or git pre-commit hook

PROJECT_ID=$1
REGISTRY_FILE="$HOME/.claude/templates/universal-project-automation/PROJECT_REGISTRY.json"
REPORTS_DIR="$HOME/.claude/templates/universal-project-automation/reports"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

if [ -z "$PROJECT_ID" ]; then
  echo "❌ Usage: $0 <project-id>"
  exit 1
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🖼️  IMAGE OPTIMIZATION AUTOMATION"
echo "Project: $PROJECT_ID"
echo "Timestamp: $TIMESTAMP"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if sharp-cli installed
if ! command -v sharp &> /dev/null; then
  echo "📦 Installing sharp-cli for image processing..."
  npm install -g sharp-cli
fi

# Check if imagemin installed
if ! command -v imagemin &> /dev/null; then
  echo "📦 Installing imagemin for compression..."
  npm install -g imagemin-cli imagemin-webp imagemin-mozjpeg imagemin-pngquant
fi

# Extract project path
PROJECT_PATH=$(cat "$REGISTRY_FILE" | jq -r ".projects[] | select(.id == \"$PROJECT_ID\") | .path")

if [ -z "$PROJECT_PATH" ] || [ "$PROJECT_PATH" == "null" ]; then
  echo "❌ Project path not found in registry for: $PROJECT_ID"
  exit 1
fi

if [ ! -d "$PROJECT_PATH" ]; then
  echo "❌ Project directory does not exist: $PROJECT_PATH"
  exit 1
fi

cd "$PROJECT_PATH" || exit 1

echo "📂 Working directory: $PROJECT_PATH"
echo ""

mkdir -p "$REPORTS_DIR/$PROJECT_ID/image-optimization"
REPORT_FILE="$REPORTS_DIR/$PROJECT_ID/image-optimization/report-$TIMESTAMP.md"

cat > "$REPORT_FILE" << EOF
# Image Optimization Report
**Project:** $PROJECT_ID
**Date:** $(date '+%Y-%m-%d %H:%M:%S')
**Path:** $PROJECT_PATH

---

## Images Optimized

EOF

# Find all images
IMAGES=$(find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -not -path "*/node_modules/*" -not -path "*/.git/*" -not -path "*/dist/*" -not -path "*/build/*")

if [ -z "$IMAGES" ]; then
  echo "ℹ️  No images found to optimize"
  exit 0
fi

IMAGE_COUNT=$(echo "$IMAGES" | wc -l | tr -d ' ')
echo "🖼️  Found $IMAGE_COUNT images to optimize"
echo ""

OPTIMIZED_COUNT=0
TOTAL_SAVED=0

echo "$IMAGES" | while read -r img; do
  if [ ! -f "$img" ]; then
    continue
  fi

  BASENAME=$(basename "$img")
  DIR=$(dirname "$img")
  EXT="${BASENAME##*.}"
  FILENAME="${BASENAME%.*}"

  ORIGINAL_SIZE=$(stat -f%z "$img" 2>/dev/null || stat -c%s "$img" 2>/dev/null)

  echo "  Processing: $img"

  # Create WebP version
  WEBP_OUTPUT="$DIR/$FILENAME.webp"
  if [ ! -f "$WEBP_OUTPUT" ]; then
    sharp -i "$img" -o "$WEBP_OUTPUT" --webp 2>/dev/null

    if [ -f "$WEBP_OUTPUT" ]; then
      WEBP_SIZE=$(stat -f%z "$WEBP_OUTPUT" 2>/dev/null || stat -c%s "$WEBP_OUTPUT" 2>/dev/null)
      SAVED=$((ORIGINAL_SIZE - WEBP_SIZE))
      SAVED_PCT=$((SAVED * 100 / ORIGINAL_SIZE))

      echo "    ✅ WebP created: $FILENAME.webp (saved ${SAVED_PCT}%)"
      ((OPTIMIZED_COUNT++))
      TOTAL_SAVED=$((TOTAL_SAVED + SAVED))

      # Add to report
      echo "- \`$img\` → \`$WEBP_OUTPUT\` (saved ${SAVED_PCT}%)" >> "$REPORT_FILE"
    fi
  fi

  # Optimize original (lossless for PNG, lossy for JPEG)
  if [ "$EXT" == "png" ] || [ "$EXT" == "PNG" ]; then
    imagemin "$img" --plugin=pngquant > "/tmp/$BASENAME" 2>/dev/null
    if [ -f "/tmp/$BASENAME" ]; then
      OPTIMIZED_SIZE=$(stat -f%z "/tmp/$BASENAME" 2>/dev/null || stat -c%s "/tmp/$BASENAME" 2>/dev/null)
      if [ "$OPTIMIZED_SIZE" -lt "$ORIGINAL_SIZE" ]; then
        mv "/tmp/$BASENAME" "$img"
        SAVED=$((ORIGINAL_SIZE - OPTIMIZED_SIZE))
        SAVED_PCT=$((SAVED * 100 / ORIGINAL_SIZE))
        echo "    🔧 PNG optimized (saved ${SAVED_PCT}%)"
        TOTAL_SAVED=$((TOTAL_SAVED + SAVED))
      fi
    fi
  elif [ "$EXT" == "jpg" ] || [ "$EXT" == "jpeg" ] || [ "$EXT" == "JPG" ] || [ "$EXT" == "JPEG" ]; then
    imagemin "$img" --plugin=mozjpeg > "/tmp/$BASENAME" 2>/dev/null
    if [ -f "/tmp/$BASENAME" ]; then
      OPTIMIZED_SIZE=$(stat -f%z "/tmp/$BASENAME" 2>/dev/null || stat -c%s "/tmp/$BASENAME" 2>/dev/null)
      if [ "$OPTIMIZED_SIZE" -lt "$ORIGINAL_SIZE" ]; then
        mv "/tmp/$BASENAME" "$img"
        SAVED=$((ORIGINAL_SIZE - OPTIMIZED_SIZE))
        SAVED_PCT=$((SAVED * 100 / ORIGINAL_SIZE))
        echo "    🔧 JPEG optimized (saved ${SAVED_PCT}%)"
        TOTAL_SAVED=$((TOTAL_SAVED + SAVED))
      fi
    fi
  fi

  # Generate responsive variants (if image is large)
  WIDTH=$(identify -format "%w" "$img" 2>/dev/null)
  if [ -n "$WIDTH" ] && [ "$WIDTH" -gt 1920 ]; then
    echo "    📐 Generating responsive variants..."

    # 1920px variant
    sharp -i "$img" -o "$DIR/$FILENAME-1920.$EXT" resize 1920 2>/dev/null

    # 1280px variant
    sharp -i "$img" -o "$DIR/$FILENAME-1280.$EXT" resize 1280 2>/dev/null

    # 640px variant
    sharp -i "$img" -o "$DIR/$FILENAME-640.$EXT" resize 640 2>/dev/null

    echo "    ✅ Responsive variants: 1920px, 1280px, 640px"
  fi

  echo ""
done

# Final statistics
TOTAL_SAVED_MB=$(awk "BEGIN {print $TOTAL_SAVED/1024/1024}")

cat >> "$REPORT_FILE" << EOF

---

## Summary

- **Images processed:** $IMAGE_COUNT
- **WebP variants created:** $OPTIMIZED_COUNT
- **Total space saved:** ${TOTAL_SAVED_MB} MB
- **Timestamp:** $TIMESTAMP

---

## Next Steps

1. Update HTML/JSX to use WebP with fallback:
   \`\`\`html
   <picture>
     <source srcset="image.webp" type="image/webp">
     <img src="image.jpg" alt="Description">
   </picture>
   \`\`\`

2. For Next.js, use \`next/image\` component:
   \`\`\`jsx
   <Image src="/image.jpg" alt="Description" width={800} height={600} />
   \`\`\`

3. Add responsive srcset for different screen sizes

---

*Report generated by: Image Optimization Automation*
EOF

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ IMAGE OPTIMIZATION COMPLETE"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Images processed: $IMAGE_COUNT"
echo "💾 Space saved: ${TOTAL_SAVED_MB} MB"
echo "📄 Report: $REPORT_FILE"
echo ""

# Git commit optimized images
if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "📝 Committing optimized images to git..."
  git add .
  git commit -m "🖼️ Optimize images - saved ${TOTAL_SAVED_MB}MB

- Processed $IMAGE_COUNT images
- Created WebP variants
- Optimized PNG/JPEG compression
- Generated responsive variants

🤖 Generated with Image Optimization Automation
" || echo "ℹ️  No changes to commit"
  echo ""
fi

echo "✅ Done!"
echo ""
