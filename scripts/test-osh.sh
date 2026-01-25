#!/usr/bin/env osh
# OSH (Bash-compatible) test script

echo "=== OSH Test Script ==="
echo ""

# 1. Basic echo
echo "1. Basic output: Hello from OSH!"

# 2. Variables
name="OSH"
version=$(osh --version 2>&1 | head -1)
echo "2. Variables: name=$name"
echo "   Version: $version"

# 3. Arithmetic
a=10
b=3
echo "3. Arithmetic: $a + $b = $((a + b))"
echo "   $a * $b = $((a * b))"

# 4. Array (Bash-style)
fruits=(apple banana cherry)
echo "4. Array: ${fruits[@]}"
echo "   Length: ${#fruits[@]}"
echo "   Second element: ${fruits[1]}"

# 5. Conditional
num=42
if [[ $num -gt 40 ]]; then
    echo "5. Conditional: $num is greater than 40"
else
    echo "5. Conditional: $num is not greater than 40"
fi

# 6. Loop
echo "6. Loop (1-5):"
for i in {1..5}; do
    echo "   - Item $i"
done

# 7. Function
greet() {
    local target="$1"
    echo "   Hello, $target!"
}
echo "7. Function:"
greet "World"
greet "OSH User"

# 8. Command substitution
echo "8. Command substitution:"
echo "   Current directory: $(pwd)"
echo "   Date: $(date +%Y-%m-%d 2>/dev/null || echo 'date command not available')"

# 9. Here document
echo "9. Here document:"
cat <<EOF
   This is a here document.
   It preserves formatting.
EOF

echo ""
echo "=== OSH Test Complete ==="
