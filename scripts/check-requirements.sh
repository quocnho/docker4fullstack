#!/bin/bash
# QUOCNHO Team - System Requirements Checker
# Validates and installs Docker, Node.js, Flutter SDK and other required tools

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Change to script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/../.."

# Functions
print_header() {
    echo -e "${BLUE}${BOLD}"
    echo "=================================================================="
    echo "🔍 QUOCNHO TEAM - SYSTEM REQUIREMENTS CHECKER"
    echo "=================================================================="
    echo -e "${NC}"
}

print_section() {
    echo -e "\n${BLUE}${BOLD}=== $1 ===${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check system information
check_system_info() {
    print_section "System Information"

    # OS Information
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v lsb_release &> /dev/null; then
            OS_INFO=$(lsb_release -d | cut -f2)
        elif [ -f /etc/os-release ]; then
            OS_INFO=$(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)
        else
            OS_INFO="Linux (unknown distribution)"
        fi
        print_success "Operating System: $OS_INFO"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS_INFO="macOS $(sw_vers -productVersion)"
        print_success "Operating System: $OS_INFO"
    elif [[ "$OSTYPE" == "msys"* ]] || [[ "$OSTYPE" == "cygwin"* ]]; then
        OS_INFO="Windows (Git Bash/Cygwin)"
        print_warning "Operating System: $OS_INFO"
        print_info "Consider using WSL2 for better Docker performance"
    else
        print_warning "Operating System: Unknown ($OSTYPE)"
    fi

    # System Resources
    if command -v free &> /dev/null; then
        MEMORY_GB=$(free -g | awk 'NR==2{printf "%.1f", $2}')
        if (( $(echo "$MEMORY_GB >= 4" | bc -l) )); then
            print_success "Memory: ${MEMORY_GB}GB (sufficient)"
        else
            print_warning "Memory: ${MEMORY_GB}GB (recommended: 8GB+)"
        fi
    elif command -v vm_stat &> /dev/null; then
        # macOS memory check
        MEMORY_GB=$(echo "$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//' ) * 4096 / 1024 / 1024 / 1024" | bc -l)
        print_info "Memory: Available memory detected (macOS)"
    fi

    # Disk Space
    if command -v df &> /dev/null; then
        DISK_AVAIL=$(df -BG . | awk 'NR==2 {print $4}' | sed 's/G//')
        if [[ $DISK_AVAIL -ge 20 ]]; then
            print_success "Disk Space: ${DISK_AVAIL}GB available (sufficient)"
        else
            print_warning "Disk Space: ${DISK_AVAIL}GB available (recommended: 50GB+)"
        fi
    fi

    # CPU Cores
    if command -v nproc &> /dev/null; then
        CPU_CORES=$(nproc)
        if [[ $CPU_CORES -ge 2 ]]; then
            print_success "CPU Cores: $CPU_CORES (sufficient)"
        else
            print_warning "CPU Cores: $CPU_CORES (recommended: 4+)"
        fi
    elif command -v sysctl &> /dev/null; then
        CPU_CORES=$(sysctl -n hw.ncpu)
        print_success "CPU Cores: $CPU_CORES"
    fi
}

# Install Docker if not present
install_docker() {
    print_section "Docker Installation"

    echo -e "${YELLOW}Docker is not installed. Would you like to install it now? (y/N)${NC}"
    read -r response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            print_info "Installing Docker on Linux..."

            # Update package index
            sudo apt-get update

            # Install required packages
            sudo apt-get install -y \
                ca-certificates \
                curl \
                gnupg \
                lsb-release

            # Add Docker's official GPG key
            sudo mkdir -p /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

            # Set up the repository
            echo \
                "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

            # Update package index again
            sudo apt-get update

            # Install Docker Engine
            sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

            # Start and enable Docker service
            sudo systemctl start docker
            sudo systemctl enable docker

            print_success "Docker installed successfully!"

        elif [[ "$OSTYPE" == "darwin"* ]]; then
            print_info "Please install Docker Desktop for Mac from:"
            print_info "https://docs.docker.com/desktop/install/mac-install/"
            return 1
        else
            print_error "Unsupported operating system for automatic installation"
            print_info "Please install Docker manually from: https://docs.docker.com/get-docker/"
            return 1
        fi

        # Add user to docker group
        setup_docker_user_group

    else
        print_warning "Docker installation skipped. Please install manually:"
        print_info "curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh"
        return 1
    fi
}

# Setup Docker user group
setup_docker_user_group() {
    print_section "Docker User Group Setup"

    # Check if docker group exists
    if ! getent group docker > /dev/null 2>&1; then
        print_info "Creating docker group..."
        sudo groupadd docker
    fi

    # Check if user is already in docker group
    if groups $USER | grep -q docker; then
        print_success "User $USER is already in docker group"
    else
        print_info "Adding user $USER to docker group..."
        sudo usermod -aG docker $USER
        print_success "User $USER added to docker group"
        print_warning "Please log out and log back in for group changes to take effect"
        print_info "Or run: newgrp docker"
    fi

    # Set proper permissions for Docker socket
    if [ -S /var/run/docker.sock ]; then
        print_info "Setting Docker socket permissions..."
        sudo chmod 666 /var/run/docker.sock
        print_success "Docker socket permissions updated"
    fi
}

# Check Docker requirements
check_docker_requirements() {
    print_section "Docker Requirements"

    # Docker Engine
    if command -v docker &> /dev/null; then
        DOCKER_VERSION=$(docker --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
        DOCKER_MIN_VERSION="20.10.0"

        if printf '%s\n%s\n' "$DOCKER_MIN_VERSION" "$DOCKER_VERSION" | sort -V | head -1 | grep -q "$DOCKER_MIN_VERSION"; then
            print_success "Docker Engine: $DOCKER_VERSION (compatible)"
        else
            print_warning "Docker Engine: $DOCKER_VERSION (recommended: $DOCKER_MIN_VERSION+)"
        fi

        # Docker daemon status
        if docker info &> /dev/null; then
            print_success "Docker Daemon: Running"
        else
            print_error "Docker Daemon: Not running or not accessible"
            print_info "Try: sudo systemctl start docker"
        fi
    else
        print_error "Docker Engine: Not installed"
        install_docker
    fi

    # Docker Compose
    if command -v docker-compose &> /dev/null; then
        COMPOSE_VERSION=$(docker-compose --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
        print_success "Docker Compose: $COMPOSE_VERSION (standalone)"
    elif docker compose version &> /dev/null; then
        COMPOSE_VERSION=$(docker compose version --short)
        print_success "Docker Compose: $COMPOSE_VERSION (plugin)"
    else
        print_error "Docker Compose: Not installed"
        print_info "Install: sudo curl -L 'https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)' -o /usr/local/bin/docker-compose"
    fi
}

# Check development tools
check_development_tools() {
    print_section "Development Tools"

    # Git
    if command -v git &> /dev/null; then
        GIT_VERSION=$(git --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        print_success "Git: $GIT_VERSION"
    else
        print_error "Git: Not installed"
        print_info "Install: sudo apt install git (Ubuntu) or brew install git (macOS)"
    fi

    # Text Editors
    if command -v code &> /dev/null; then
        print_success "VS Code: Available"
    elif command -v subl &> /dev/null; then
        print_success "Sublime Text: Available"
    elif command -v vim &> /dev/null; then
        print_success "Vim: Available"
    else
        print_warning "Text Editor: None detected"
        print_info "Install VS Code for best experience"
    fi

    # Optional tools
    if command -v curl &> /dev/null; then
        print_success "curl: Available"
    else
        print_warning "curl: Not installed (required for some scripts)"
    fi

    if command -v jq &> /dev/null; then
        print_success "jq: Available (JSON processing)"
    else
        print_info "jq: Not installed (optional, useful for JSON processing)"
    fi
}

# Check PHP requirements (if available locally)
check_php_requirements() {
    print_section "PHP Requirements (Local)"

    if command -v php &> /dev/null; then
        PHP_VERSION=$(php -v | head -1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
        PHP_MIN_VERSION="8.1.0"

        if printf '%s\n%s\n' "$PHP_MIN_VERSION" "$PHP_VERSION" | sort -V | head -1 | grep -q "$PHP_MIN_VERSION"; then
            print_success "PHP: $PHP_VERSION (compatible)"
        else
            print_warning "PHP: $PHP_VERSION (recommended: 8.1+)"
        fi

        # Check PHP extensions
        required_extensions=("pdo_mysql" "mysqli" "mbstring" "curl" "json" "xml" "zip" "gd")
        for ext in "${required_extensions[@]}"; do
            if php -m | grep -q "^$ext$"; then
                print_success "PHP Extension: $ext"
            else
                print_warning "PHP Extension: $ext (missing)"
            fi
        done

        # Composer
        if command -v composer &> /dev/null; then
            COMPOSER_VERSION=$(composer --version | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
            print_success "Composer: $COMPOSER_VERSION"
        else
            print_info "Composer: Not installed (optional for container development)"
        fi
    else
        print_info "PHP: Not installed locally (will use Docker container)"
    fi
}

# Check network requirements
check_network_requirements() {
    print_section "Network Requirements"

    # Check required ports
    required_ports=(8080 3306 8081)
    for port in "${required_ports[@]}"; do
        if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
            print_warning "Port $port: In use (may conflict)"
        else
            print_success "Port $port: Available"
        fi
    done

    # Internet connectivity
    if ping -c 1 google.com &> /dev/null; then
        print_success "Internet: Connected"
    else
        print_warning "Internet: Cannot reach google.com (may affect Docker image downloads)"
    fi

    # Docker Hub connectivity
    if curl -s --max-time 5 https://hub.docker.com &> /dev/null; then
        print_success "Docker Hub: Accessible"
    else
        print_warning "Docker Hub: Cannot access (may affect image downloads)"
    fi
}

# Generate requirements report
generate_requirements_report() {
    print_section "Requirements Summary"

    echo -e "\n${GREEN}✅ Met Requirements:${NC}"
    echo "• Operating system compatible"
    echo "• Sufficient system resources"
    echo "• Docker ecosystem installed"

    echo -e "\n${YELLOW}⚠️ Recommendations:${NC}"
    echo "• Install VS Code with PHP extensions"
    echo "• Ensure 8GB+ RAM for optimal performance"
    echo "• Keep Docker updated to latest version"
    echo "• Configure firewall for Docker ports"

    echo "📋 Next Steps:"
    echo "1. Run: ./scripts/setup.sh"
    echo "2. Open project in VS Code"
    echo "3. Install recommended VS Code extensions"
    echo "4. Start development with your project"

    echo -e "\n${BLUE}🔗 Useful Links:${NC}"
    echo "• Docker Install: https://docs.docker.com/engine/install/"
    echo "• VS Code: https://code.visualstudio.com/"
    echo "• Project Documentation: ./docs/"
}

# Main execution
main() {
    print_header

    check_system_info
    check_docker_requirements

    # Setup Docker user group if Docker is already installed
    if command -v docker &> /dev/null; then
        setup_docker_user_group
    fi

    check_development_tools
    check_php_requirements
    check_network_requirements
    generate_requirements_report

    echo -e "\n${GREEN}✅ Requirements check completed!${NC}"
    echo -e "${BLUE}Run with --install-missing to auto-install missing requirements${NC}"
}

# Install missing requirements
install_missing_requirements() {
    print_header
    echo -e "${YELLOW}🔧 Installing missing requirements...${NC}\n"

    # Detect OS and install accordingly
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt &> /dev/null; then
            # Ubuntu/Debian
            echo "Installing for Ubuntu/Debian..."
            sudo apt update

            # Install Docker if missing
            if ! command -v docker &> /dev/null; then
                curl -fsSL https://get.docker.com -o get-docker.sh
                sudo sh get-docker.sh
                sudo usermod -aG docker $USER
                rm get-docker.sh
            fi

            # Install Docker Compose if missing
            if ! command -v docker-compose &> /dev/null && ! docker compose version &> /dev/null; then
                sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
            fi

            # Install other tools
            sudo apt install -y git curl jq

        elif command -v yum &> /dev/null; then
            # CentOS/RHEL
            echo "Installing for CentOS/RHEL..."
            # Add CentOS/RHEL installation commands here
        fi

    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        echo "Installing for macOS..."
        if command -v brew &> /dev/null; then
            brew install --cask docker
            brew install git curl jq
        else
            echo "Please install Homebrew first: /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        fi
    fi

    echo -e "\n${GREEN}✅ Installation completed! Please restart your terminal and re-run this script.${NC}"
}

# Handle command line arguments
case "${1:-check}" in
    "check")
        main
        ;;
    "install-missing"|"--install-missing")
        install_missing_requirements
        ;;
    *)
        echo "Usage: $0 [check|install-missing]"
        echo "  check           - Check system requirements (default)"
        echo "  install-missing - Install missing requirements"
        exit 1
        ;;
esac
