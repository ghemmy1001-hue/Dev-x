#!/data/data/com.termux/files/usr/bin/bash

ai_assistant() {

    clear

    echo "╔══════════════════════════════════════╗"
    echo "║          DEV-X AI ASSISTANT          ║"
    echo "║            OpenRouter                ║"
    echo "╚══════════════════════════════════════╝"
    echo
    echo "Type 'exit' to return."
    echo

    if [ -z "$OPENROUTER_API_KEY" ]; then
        echo "ERROR: OPENROUTER_API_KEY is not set."
        echo
        echo "Load your API key first."
        echo
        return 1
    fi

    while true; do

        read -r -p "DEV-X AI > " prompt

        if [ -z "$prompt" ]; then
            continue
        fi

        if [ "$prompt" = "exit" ] || [ "$prompt" = "quit" ]; then
            echo
            echo "Returning to DEV-X..."
            sleep 1
            break
        fi

        echo
        echo "Thinking..."
        echo

        payload=$(python -c '
import json
import sys

prompt = sys.argv[1]

data = {
    "model": "openrouter/free",
    "messages": [
        {
            "role": "system",
            "content": "You are DEV-X AI, a helpful coding assistant. Give clear, practical programming answers."
        },
        {
            "role": "user",
            "content": prompt
        }
    ]
}

print(json.dumps(data))
' "$prompt")

        response=$(curl -s \
            https://openrouter.ai/api/v1/chat/completions \
            -H "Authorization: Bearer $OPENROUTER_API_KEY" \
            -H "Content-Type: application/json" \
            -d "$payload")

        answer=$(python -c '
import json
import sys

try:
    data = json.load(sys.stdin)

    if "choices" in data:
        print(data["choices"][0]["message"]["content"])
    elif "error" in data:
        print("API ERROR:")
        print(data["error"].get("message", data["error"]))
    else:
        print("Unexpected API response.")

except Exception as e:
    print("Could not read API response.")
' <<< "$response")

        echo "$answer"
        echo
        echo "──────────────────────────────────────"
        echo

    done
}
