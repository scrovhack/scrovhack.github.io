#!/usr/bin/env bash

echo "Content-Type: application/json"
echo ""

echo "{"
echo "  \"runtime\": \"Shell\","
echo "  \"message\": \"Hello from Bash\","
echo "  \"time\": \"$(date -Iseconds)\""
echo "}"
