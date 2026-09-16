#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
#              DEV-X TOOLKIT
#                 v3.0
# ==========================================

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
WHITE='\033[1;37m'
RESET='\033[0m'

BASE="$HOME/dev-x"
update_devx() {

    banner

    echo -e "${CYAN}DEV-X UPDATER${RESET}"
    echo
    echo "Checking GitHub for updates..."
    echo

    cd "$BASE" || return

    if ! git remote get-url origin >/dev/null 2>&1; then
        echo -e "${RED}GitHub remote is not configured.${RESET}"
        pause
        return
    fi

    git fetch origin main

    LOCAL=$(git rev-parse HEAD)
    REMOTE=$(git rev-parse origin/main)

    if [ "$LOCAL" = "$REMOTE" ]; then

        echo -e "${GREEN}✓ DEV-X is already up to date.${RESET}"

    else

        echo
        echo -e "${YELLOW}A new version is available.${RESET}"
        echo

        read -p "Update DEV-X now? (y/n): " answer

        if [[ "$answer" =~ ^[Yy]$ ]]; then

            git pull --ff-only origin main

            if [ $? -eq 0 ]; then
                echo
                echo -e "${GREEN}✓ DEV-X updated successfully!${RESET}"
            else
                echo
                echo -e "${RED}Update failed. Your files were not overwritten.${RESET}"
            fi

        else

            echo "Update cancelled."

        fi

    fi

    pause
}

pause() {
    echo
    read -p "Press ENTER to continue..."
}

banner() {
    clear
    echo -e "${CYAN}"
    echo "╔══════════════════════════════════════╗"
    echo "║              DEV-X                   ║"
    echo "║        DEVELOPER TOOLKIT v3.0        ║"
    echo "╚══════════════════════════════════════╝"
    echo -e "${RESET}"
    echo
}

# ==========================================
# CREATE HTML PROJECT
# ==========================================

create_html() {

    echo
    read -p "Project name: " project

    if [ -z "$project" ]; then
        echo -e "${RED}Project name cannot be empty.${RESET}"
        pause
        return
    fi

    folder="$BASE/$project"

    mkdir -p "$folder"

    cat > "$folder/index.html" <<EOF
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>$project</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<div class="container">

<h1>$project</h1>

<p>Your website was created with DEV-X 🚀</p>

<button onclick="hello()">Click Me</button>

</div>

<script src="script.js"></script>

</body>

</html>
EOF

    cat > "$folder/style.css" <<'EOF'
* {
    box-sizing: border-box;
}

body {

    margin: 0;

    min-height: 100vh;

    display: grid;

    place-items: center;

    background: #080808;

    color: white;

    font-family: Arial, sans-serif;

}

.container {

    text-align: center;

    padding: 40px;

}

h1 {

    font-size: 50px;

    color: #00e5ff;

}

button {

    padding: 14px 30px;

    border: none;

    border-radius: 30px;

    cursor: pointer;

    font-weight: bold;

}
EOF

    cat > "$folder/script.js" <<'EOF'
function hello() {

    alert("DEV-X says hello! 🚀");

}
EOF

    echo
    echo -e "${GREEN}✓ HTML project created!${RESET}"
    echo
    echo "Location:"
    echo "$folder"

    pause
}

# ==========================================
# WEBSITE BUILDER
# ==========================================

website_builder() {

    banner

    echo -e "${YELLOW}WEBSITE BUILDER${RESET}"
    echo
    echo "1. Landing Page"
    echo "2. Portfolio"
    echo "3. Gaming Website"
    echo "4. Blank Website"
    echo "0. Back"
    echo

    read -p "Choose template: " template

    if [ "$template" = "0" ]; then
        return
    fi

    read -p "Website name: " site

    if [ -z "$site" ]; then
        echo -e "${RED}Website name cannot be empty.${RESET}"
        pause
        return
    fi

    folder_name=$(echo "$site" | tr ' ' '-' | tr '[:upper:]' '[:lower:]')

    folder="$BASE/$folder_name"

    mkdir -p "$folder"

    # --------------------------
    # LANDING PAGE
    # --------------------------

    if [ "$template" = "1" ]; then

cat > "$folder/index.html" <<EOF
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>$site</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<header>

<h2>$site</h2>

<nav>

<a href="#home">Home</a>

<a href="#about">About</a>

<a href="#contact">Contact</a>

</nav>

</header>

<section class="hero" id="home">

<div>

<h1>Welcome to $site</h1>

<p>Built with DEV-X.</p>

<button onclick="start()">Get Started</button>

</div>

</section>

<section id="about">

<h2>About</h2>

<p>This is your new website.</p>

</section>

<section id="contact">

<h2>Contact</h2>

<p>Contact us today.</p>

</section>

<script src="script.js"></script>

</body>

</html>
EOF

    # --------------------------
    # PORTFOLIO
    # --------------------------

    elif [ "$template" = "2" ]; then

cat > "$folder/index.html" <<EOF
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>$site</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<main class="portfolio">

<div class="avatar">

DEV

</div>

<h1>$site</h1>

<p>Developer • Designer • Creator</p>

<button onclick="contact()">Contact Me</button>

<section>

<h2>Projects</h2>

<div class="projects">

<div>Project One</div>

<div>Project Two</div>

<div>Project Three</div>

</div>

</section>

</main>

<script src="script.js"></script>

</body>

</html>
EOF

    # --------------------------
    # GAMING WEBSITE
    # --------------------------

    elif [ "$template" = "3" ]; then

cat > "$folder/index.html" <<EOF
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>$site</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<header>

<h1>$site</h1>

<p>GAMING ZONE</p>

</header>

<section class="hero">

<h2>LEVEL UP</h2>

<p>Enter the battlefield.</p>

<button onclick="play()">START</button>

</section>

<section class="features">

<div>

<h3>⚡ SPEED</h3>

<p>Fast gameplay.</p>

</div>

<div>

<h3>🎮 GAMING</h3>

<p>Built for gamers.</p>

</div>

<div>

<h3>🏆 VICTORY</h3>

<p>Reach the top.</p>

</div>

</section>

<script src="script.js"></script>

</body>

</html>
EOF

    # --------------------------
    # BLANK WEBSITE
    # --------------------------

    elif [ "$template" = "4" ]; then

cat > "$folder/index.html" <<EOF
<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>$site</title>

<link rel="stylesheet" href="style.css">

</head>

<body>

<h1>$site</h1>

<p>Start building here.</p>

<script src="script.js"></script>

</body>

</html>
EOF

    else

        echo -e "${RED}Invalid template.${RESET}"

        rm -rf "$folder"

        pause

        return

    fi

    # =================================
    # COMMON CSS
    # =================================

cat > "$folder/style.css" <<'EOF'

* {

    box-sizing: border-box;

}

body {

    margin: 0;

    min-height: 100vh;

    background: #080808;

    color: white;

    font-family: Arial, sans-serif;

}

header {

    padding: 20px;

    display: flex;

    justify-content: space-between;

    align-items: center;

}

nav a {

    color: white;

    text-decoration: none;

    margin: 10px;

}

.hero {

    min-height: 70vh;

    display: grid;

    place-items: center;

    text-align: center;

    padding: 30px;

}

.hero h1 {

    font-size: clamp(2.5rem, 8vw, 6rem);

}

button {

    padding: 14px 30px;

    border: none;

    border-radius: 30px;

    cursor: pointer;

    font-weight: bold;

}

section {

    padding: 60px 10%;

}

.portfolio {

    text-align: center;

    padding: 60px 10%;

}

.avatar {

    width: 100px;

    height: 100px;

    margin: auto;

    display: grid;

    place-items: center;

    border-radius: 50%;

    background: #222;

}

.projects,

.features {

    display: grid;

    grid-template-columns:

    repeat(auto-fit, minmax(200px, 1fr));

    gap: 20px;

}

.projects div,

.features div {

    padding: 30px;

    background: #151515;

    border-radius: 15px;

}

@media(max-width:700px) {

    header {

        flex-direction: column;

        gap: 15px;

    }

}

EOF

    # =================================
    # JAVASCRIPT
    # =================================

cat > "$folder/script.js" <<'EOF'

function start() {

    alert("Welcome! 🚀");

}

function contact() {

    alert("Contact section opened.");

}

function play() {

    alert("Game loading... 🎮");

}

EOF

    echo
    echo -e "${GREEN}✓ Website created successfully!${RESET}"
    echo
    echo "Project:"
    echo "$folder"
    echo
    echo "Files:"
    echo " ├── index.html"
    echo " ├── style.css"
    echo " └── script.js"

    pause
}

# ==========================================
# PROJECT MANAGER
# ==========================================

project_manager() {

    while true; do

        banner

        echo -e "${YELLOW}PROJECT MANAGER${RESET}"
        echo

        mapfile -t projects < <(
            find "$BASE" \
            -mindepth 1 \
            -maxdepth 1 \
            -type d \
            -printf "%f\n" 2>/dev/null |
            sort
        )

        if [ "${#projects[@]}" -eq 0 ]; then

            echo "No projects found."

            pause

            return

        fi

        for i in "${!projects[@]}"; do

            echo "$((i + 1)). ${projects[$i]}"

        done

        echo
        echo "O. Open project"
        echo "D. Delete project"
        echo "B. Back"
        echo

        read -p "Select: " option

        if [[ "$option" =~ ^[0-9]+$ ]]; then

            index=$((option - 1))

            if [ "$index" -ge 0 ] &&
               [ "$index" -lt "${#projects[@]}" ]; then

                project="${projects[$index]}"

                echo
                echo "Project: $project"
                echo

                ls -lah "$BASE/$project"

                pause

            else

                echo -e "${RED}Invalid project.${RESET}"

                pause

            fi

        elif [ "$option" = "O" ] ||
             [ "$option" = "o" ]; then

            read -p "Project number: " number

            if [[ "$number" =~ ^[0-9]+$ ]]; then

                index=$((number - 1))

                if [ "$index" -ge 0 ] &&
                   [ "$index" -lt "${#projects[@]}" ]; then

                    cd "$BASE/${projects[$index]}" || return

                    echo
                    echo "Opened project:"
                    pwd

                    echo

                    ls -lah

                    pause

                    cd "$BASE" || return

                else

                    echo -e "${RED}Invalid project.${RESET}"

                    pause

                fi

            fi

        elif [ "$option" = "D" ] ||
             [ "$option" = "d" ]; then

            read -p "Project number: " number

            if [[ "$number" =~ ^[0-9]+$ ]]; then

                index=$((number - 1))

                if [ "$index" -ge 0 ] &&
                   [ "$index" -lt "${#projects[@]}" ]; then

                    project="${projects[$index]}"

                    read -p "Type DELETE to confirm: " confirm

                    if [ "$confirm" = "DELETE" ]; then

                        rm -rf "$BASE/$project"

                        echo -e "${GREEN}✓ Project deleted.${RESET}"

                    else

                        echo "Cancelled."

                    fi

                    pause

                fi

            fi

        elif [ "$option" = "B" ] ||
             [ "$option" = "b" ]; then

            return

        else

            echo -e "${RED}Invalid option.${RESET}"

            pause

        fi

    done
}

# ==========================================
# LOCAL SERVER
# ==========================================

start_server() {

    banner

    echo "Available projects:"
    echo

    ls -1 "$BASE" 2>/dev/null

    echo

    read -p "Project folder: " project

    if [ ! -d "$BASE/$project" ]; then

        echo -e "${RED}Project not found.${RESET}"

        pause

        return

    fi

    cd "$BASE/$project" || return

    echo
    echo -e "${GREEN}Starting server...${RESET}"
    echo
    echo "Open:"
    echo -e "${CYAN}http://localhost:8080${RESET}"
    echo
    echo "Press CTRL+C to stop."

    python -m http.server 8080

    cd "$BASE" || return
}

# ==========================================
# FILE MANAGER
# ==========================================

file_manager() {

    while true; do

        banner

        echo -e "${YELLOW}FILE MANAGER${RESET}"
        echo

        echo "1. List files"
        echo "2. Create folder"
        echo "3. Create file"
        echo "4. Delete"
        echo "0. Back"
        echo

        read -p "Choose: " option

        case "$option" in

            1)

                ls -lah "$BASE"

                pause

                ;;

            2)

                read -p "Folder name: " folder

                mkdir -p "$BASE/$folder"

                echo -e "${GREEN}✓ Folder created.${RESET}"

                pause

                ;;

            3)

                read -p "File name: " file

                touch "$BASE/$file"

                echo -e "${GREEN}✓ File created.${RESET}"

                pause

                ;;

            4)

                read -p "Name to delete: " target

                if [ -e "$BASE/$target" ]; then

                    rm -rf "$BASE/$target"

                    echo -e "${GREEN}✓ Deleted.${RESET}"

                else

                    echo -e "${RED}Not found.${RESET}"

                fi

                pause

                ;;

            0)

                return

                ;;

            *)

                echo -e "${RED}Invalid option.${RESET}"

                pause

                ;;

        esac

    done
}

# ==========================================
# CALCULATOR
# ==========================================

calculator() {

    banner

    echo "Calculator"
    echo
    echo "Example: 25 * 4"
    echo

    read -p "Calculation: " calculation

    python -c "print($calculation)" 2>/dev/null

    if [ $? -ne 0 ]; then

        echo -e "${RED}Invalid calculation.${RESET}"

    fi

    pause
}

# ==========================================
# GIT TOOLS
# ==========================================

git_tools() {

    banner

    echo -e "${YELLOW}GIT TOOLS${RESET}"
    echo

    echo "1. Git status"
    echo "2. Initialize Git"
    echo "3. Add files"
    echo "4. Commit"
    echo "0. Back"
    echo

    read -p "Choose: " option

    case "$option" in

        1)

            git status

            pause

            ;;

        2)

            git init

            pause

            ;;

        3)

            git add .

            echo "Files added."

            pause

            ;;

        4)

            read -p "Commit message: " message

            git add .

            git commit -m "$message"

            pause

            ;;

        0)

            return

            ;;

        *)

            echo -e "${RED}Invalid option.${RESET}"

            pause

            ;;

    esac
}

# ==========================================
# MAIN MENU
# ==========================================

mkdir -p "$BASE"

while true; do

    banner

    echo -e "${WHITE}1.${RESET} 📄 HTML Project"
    echo -e "${WHITE}2.${RESET} 🌐 Website Builder"
    echo -e "${WHITE}3.${RESET} 🟢 Node.js Project"
    echo -e "${WHITE}4.${RESET} 🐍 Python Project"
    echo -e "${WHITE}5.${RESET} 🚀 Local Web Server"
    echo -e "${WHITE}6.${RESET} 📁 Project Manager"
    echo -e "${WHITE}7.${RESET} 🧮 Calculator"
    echo -e "${WHITE}8.${RESET} 🔧 Git Tools"
    echo -e "${WHITE}9.${RESET} 📂 File Manager"
    echo -e "${WHITE}10.${RESET} 🔄 Update DEV-X"
    echo -e "${WHITE}0.${RESET} ❌ Exit"
    echo

    read -p "Select an option: " choice

    case "$choice" in

        1)
            create_html
            ;;

        2)
            website_builder
            ;;

        3)
            echo
            echo "Node.js project creator coming next."
            pause
            ;;

        4)
            echo
            echo "Python project creator coming next."
            pause
            ;;

        5)
            start_server
            ;;

        6)
            project_manager
            ;;

        7)
            calculator
            ;;

        8)
            git_tools
            ;;

        9)
            file_manager
            ;;
        10)
            update_devx
            ;;
        0)
            clear
            echo -e "${CYAN}DEV-X closed. Keep building! 🚀${RESET}"
            exit
            ;;

        *)
            echo -e "${RED}Invalid option.${RESET}"
            sleep 1
            ;;

    esac

done
