#!/data/data/com.termux/files/usr/bin/bash

# ==============================
#        DEV-X TOOLKIT v2.0
# ==============================

clear

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
RESET='\033[0m'

banner() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════╗"
    echo "║              DEV-X                   ║"
    echo "║        DEVELOPER TOOLKIT v2.0        ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
}

pause() {
    echo
    read -p "Press ENTER to continue..."
}

create_html() {
    echo
    read -p "Project name: " project

    if [ -z "$project" ]; then
        echo -e "${RED}Project name cannot be empty.${RESET}"
        pause
        return
    fi

    mkdir -p "$project"

    cat > "$project/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$project</title>
    <style>
        body {
            margin: 0;
            min-height: 100vh;
            display: grid;
            place-items: center;
            background: #080808;
            color: white;
            font-family: Arial, sans-serif;
        }

        .box {
            text-align: center;
            padding: 40px;
        }

        h1 {
            color: #00e5ff;
        }
    </style>
</head>

<body>

<div class="box">
    <h1>$project</h1>
    <p>Created with DEV-X Toolkit 🚀</p>
</div>

</body>
</html>
EOF

    echo
    echo -e "${GREEN}✓ HTML project created successfully!${RESET}"
    echo "Location: ~/dev-x/$project"
    pause
}

create_node() {
    echo
    read -p "Project name: " project

    if [ -z "$project" ]; then
        echo -e "${RED}Project name cannot be empty.${RESET}"
        pause
        return
    fi

    mkdir -p "$project"
    cd "$project" || return

    npm init -y >/dev/null 2>&1

    cat > server.js <<'EOF'
const http = require("http");

const PORT = 3000;

const server = http.createServer((req, res) => {
    res.writeHead(200, {
        "Content-Type": "text/html"
    });

    res.end(`
        <h1>DEV-X Node.js Project</h1>
        <p>Server is running successfully 🚀</p>
    `);
});

server.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
EOF

    cd ..

    echo
    echo -e "${GREEN}✓ Node.js project created!${RESET}"
    echo "Location: ~/dev-x/$project"
    pause
}

create_python() {
    echo
    read -p "Project name: " project

    if [ -z "$project" ]; then
        echo -e "${RED}Project name cannot be empty.${RESET}"
        pause
        return
    fi

    mkdir -p "$project"

    cat > "$project/main.py" <<'EOF'
print("DEV-X Python Project")
print("Hello from Python! 🚀")
EOF

    echo
    echo -e "${GREEN}✓ Python project created!${RESET}"
    echo "Location: ~/dev-x/$project"
    pause
}

start_server() {
    echo
    echo "Starting local web server..."
    echo
    echo "Open your browser and visit:"
    echo -e "${CYAN}http://localhost:8080${RESET}"
    echo
    echo "Press CTRL+C to stop the server."
    echo

    python -m http.server 8080
}

file_manager() {
    while true; do
        banner

        echo -e "${YELLOW}FILE MANAGER${RESET}"
        echo
        echo "1. List files"
        echo "2. Create folder"
        echo "3. Create file"
        echo "4. Delete file/folder"
        echo "5. Back"
        echo

        read -p "Select: " option

        case $option in

        1)
            echo
            ls -lah
            pause
            ;;

        2)
            read -p "Folder name: " folder
            mkdir -p "$folder"
            echo -e "${GREEN}✓ Folder created.${RESET}"
            pause
            ;;

        3)
            read -p "File name: " file
            touch "$file"
            echo -e "${GREEN}✓ File created.${RESET}"
            pause
            ;;

        4)
            read -p "File/folder to delete: " target

            if [ -e "$target" ]; then
                rm -rf "$target"
                echo -e "${GREEN}✓ Deleted.${RESET}"
            else
                echo -e "${RED}Not found.${RESET}"
            fi

            pause
            ;;

        5)
            break
            ;;

        *)
            echo -e "${RED}Invalid option.${RESET}"
            pause
            ;;
        esac
    done
}
project_manager() {
    while true; do
        banner

        echo -e "${YELLOW}PROJECT MANAGER${RESET}"
        echo

        projects=()

        while IFS= read -r item; do
            [ -d "$item" ] && projects+=("$item")
        done < <(find . -maxdepth 1 -mindepth 1 -type d ! -name ".git" -printf "%f\n" | sort)

        if [ ${#projects[@]} -eq 0 ]; then
            echo "No projects found."
            pause
            return
        fi

        for i in "${!projects[@]}"; do
            echo "$((i+1)). ${projects[$i]}"
        done

        echo
        echo "O. Open project"
        echo "D. Delete project"
        echo "B. Back"
        echo

        read -p "Select: " option

        case "$option" in

        [0-9]*)
            index=$((option-1))

            if [ "$index" -ge 0 ] && [ "$index" -lt "${#projects[@]}" ]; then
                project="${projects[$index]}"

                echo
                echo "Project: $project"
                echo
                ls -lah "$project"
                pause
            else
                echo -e "${RED}Invalid project.${RESET}"
                pause
            fi
            ;;

        O|o)
            read -p "Project number: " number

            index=$((number-1))

            if [ "$index" -ge 0 ] && [ "$index" -lt "${#projects[@]}" ]; then
                cd "${projects[$index]}" || continue

                echo
                echo "Opened: ${projects[$index]}"
                echo "Current directory:"
                pwd
                echo

                ls -lah
                pause

                cd ..
            else
                echo -e "${RED}Invalid project.${RESET}"
                pause
            fi
            ;;

        D|d)
            read -p "Project number to delete: " number

            index=$((number-1))

            if [ "$index" -ge 0 ] && [ "$index" -lt "${#projects[@]}" ]; then

                project="${projects[$index]}"

                read -p "Delete '$project'? (yes/no): " confirm

                if [ "$confirm" = "yes" ]; then
                    rm -rf -- "$project"
                    echo -e "${GREEN}✓ Project deleted.${RESET}"
                else
                    echo "Cancelled."
                fi

                pause
            else
                echo -e "${RED}Invalid project.${RESET}"
                pause
            fi
            ;;

        B|b)
            return
            ;;

        *)
            echo -e "${RED}Invalid option.${RESET}"
            sleep 1
            ;;

        esac
    done
}
calculator() {
    echo
    echo "Calculator"
    echo "Example: 25+10"
    echo

    read -p "Enter calculation: " calculation

    python -c "print($calculation)" 2>/dev/null

    if [ $? -ne 0 ]; then
        echo -e "${RED}Invalid calculation.${RESET}"
    fi

    pause
}

git_tools() {
    while true; do
        banner

        echo -e "${YELLOW}GIT TOOLS${RESET}"
        echo
        echo "1. Git status"
        echo "2. Initialize repository"
        echo "3. Add all files"
        echo "4. Commit"
        echo "5. Back"
        echo

        read -p "Select: " option

        case $option in

        1)
            git status
            pause
            ;;

        2)
            git init
            echo -e "${GREEN}✓ Git repository initialized.${RESET}"
            pause
            ;;

        3)
            git add .
            echo -e "${GREEN}✓ Files added.${RESET}"
            pause
            ;;

        4)
            read -p "Commit message: " message
            git commit -m "$message"
            pause
            ;;

        5)
            break
            ;;

        *)
            echo -e "${RED}Invalid option.${RESET}"
            pause
            ;;
        esac
    done
}

while true; do

    banner

    echo -e "${WHITE}1.${RESET} 📄 Create HTML Project"
    echo -e "${WHITE}2.${RESET} 🟢 Create Node.js Project"
    echo -e "${WHITE}3.${RESET} 🐍 Create Python Project"
    echo -e "${WHITE}4.${RESET} 🌐 Start Local Web Server"  
echo -e "${WHITE}6.${RESET} 🚀 Project Manager"
 echo -e "${WHITE}5.${RESET} 📁 File Manager"
    echo -e "${WHITE}6.${RESET} 🧮 Calculator"
    echo -e "${WHITE}7.${RESET} 🔧 Git Tools"
    echo -e "${WHITE}0.${RESET} ❌ Exit"

    echo
    read -p "Select an option: " choice

    case $choice in

    1) create_html ;;
    2) create_node ;;
    3) create_python ;;
    4) start_server ;;
5) file_manager ;;
6) project_manager ;;
7) calculator ;;
8) git_tools ;;
    0) ❌️ Exit
        clear
        echo -e "${CYAN}Thanks for using DEV-X! 🚀${RESET}"
        exit
        ;;

    *)
        echo -e "${RED}Invalid option.${RESET}"
        sleep 1
        ;;

    esac

done
