#!/bin/bash


# CS:GO Legacy - Complete fix for Linux
# Fixes library loading, tcmalloc compatibility, and Panorama crash


GAMEROOT="/home/laptop/.local/share/Steam/steamapps/common/csgo legacy/"


echo "=========================================="
echo "CS:GO Legacy Linux Fix"
echo "=========================================="
echo ""


# Check if game directory exists
if [ ! -d "$GAMEROOT" ]; then
    echo "ERROR: Game directory not found!"
    echo "Expected: $GAMEROOT"
    exit 1
fi


# Step 1: Fix library loading (32-bit -> 64-bit)
echo "[1/3] Fixing library loading..."
cd "$GAMEROOT"


if [ -d "bin" ] && [ ! -d "bin.32bit.backup" ]; then
    mkdir -p bin.32bit.backup
    for file in bin/*.so; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            if [ -f "bin/linux64/$filename" ]; then
                mv "$file" "bin.32bit.backup/"
            fi
        fi
    done
fi


if [ -d "csgo/bin" ] && [ ! -d "csgo/bin.32bit.backup" ]; then
    mkdir -p csgo/bin.32bit.backup
    for file in csgo/bin/*.so; do
        if [ -f "$file" ]; then
            filename=$(basename "$file")
            if [ -f "csgo/bin/linux64/$filename" ]; then
                mv "$file" "csgo/bin.32bit.backup/"
            fi
        fi
    done
fi


cd "$GAMEROOT/bin"
for file in linux64/*.so; do
    filename=$(basename "$file")
    if [ ! -e "$filename" ]; then
        ln -s "linux64/$filename" "$filename"
    fi
done


cd "$GAMEROOT/csgo/bin"
for file in linux64/*.so; do
    filename=$(basename "$file")
    if [ ! -e "$filename" ]; then
        ln -s "linux64/$filename" "$filename"
    fi
done


echo "✓ Libraries fixed"


# Step 2: Fix tcmalloc compatibility
echo "[2/3] Fixing tcmalloc compatibility..."
cd "$GAMEROOT/bin/linux64"


if [ -f "libtcmalloc_minimal.so.0" ] && [ ! -f "libtcmalloc_minimal.so.0.original" ]; then
    mv libtcmalloc_minimal.so.0 libtcmalloc_minimal.so.0.original
fi


if [ -f "/usr/lib/libtcmalloc_minimal.so.4" ]; then
    cp /usr/lib/libtcmalloc_minimal.so.4 libtcmalloc_minimal.so.0
    echo "✓ System tcmalloc installed"
else
    echo "⚠ WARNING: System tcmalloc not found!"
    echo "  Install it: sudo pacman -S gperftools"
fi


# Step 3: Fix Panorama crash
echo "[3/3] Fixing Panorama UI crash..."
cd "$GAMEROOT/csgo/panorama"


if [ -d "videos" ] && [ ! -d "videos.disabled" ]; then
    mv videos videos.disabled
    echo "✓ Panorama videos disabled"
elif [ -d "videos.disabled" ]; then
    echo "✓ Videos already disabled"
fi


echo ""
echo "=========================================="
echo "✓ CS:GO Legacy is ready to play!"
echo "=========================================="
echo ""
echo "Launch options to add in Steam:"
echo "  -nojoy -novid"
echo ""
echo "To add launch options:"
echo "  1. Library → CS:GO Legacy → Right Click → Properties"
echo "  2. Launch Options → add: -nojoy -novid"
echo ""
echo "Enjoy the game! 🎮"
