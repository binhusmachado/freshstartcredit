#!/bin/bash
# Interactive Skill Installation with Approval
# Asks for confirmation before installing each skill

echo "🔒 INTERACTIVE SKILL INSTALLATION"
echo "=================================="
echo ""
echo "This script will install essential marketing skills."
echo "You'll be asked to approve each one."
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track installation status
INSTALLED=()
FAILED=()
SKIPPED=()

# Function to ask for approval
ask_approval() {
    local skill_name=$1
    local description=$2
    
    echo ""
    echo "📦 Skill: ${YELLOW}$skill_name${NC}"
    echo "   Description: $description"
    echo ""
    
    # Check if already installed
    if clawhub list 2>/dev/null | grep -q "^$skill_name "; then
        echo "   ${GREEN}✓ Already installed${NC}"
        INSTALLED+=("$skill_name")
        return 0
    fi
    
    # Show skill info
    echo "   Fetching skill information..."
    clawhub info "$skill_name" 2>/dev/null | head -10 || echo "   (Info not available)"
    echo ""
    
    read -p "   Install this skill? (yes/no/skip): " answer
    
    case $answer in
        [Yy]es|[Yy])
            echo "   Installing $skill_name..."
            if clawhub install "$skill_name" --force 2>&1 | tee "/tmp/install-${skill_name}.log"; then
                echo "   ${GREEN}✓ Successfully installed${NC}"
                INSTALLED+=("$skill_name")
                return 0
            else
                echo "   ${RED}✗ Installation failed${NC}"
                FAILED+=("$skill_name")
                return 1
            fi
            ;;
        [Ss]kip|[Ss])
            echo "   Skipped."
            SKIPPED+=("$skill_name")
            return 0
            ;;
        *)
            echo "   Skipped (no approval)."
            SKIPPED+=("$skill_name")
            return 0
            ;;
    esac
}

# ============================================
# TIER 1: CRITICAL SKILLS
# ============================================

echo ""
echo "🥇 TIER 1: CRITICAL SKILLS"
echo "=========================="
echo ""

ask_approval "browser-automation" "Control web browsers programmatically - ESSENTIAL for all web tasks"
ask_approval "browser-automation-stealth" "Undetectable browser automation - hides bot detection"
ask_approval "google-calendar" "Manage Google Calendar - schedule posts and appointments"
ask_approval "gmail" "Email automation - send and receive emails"

# ============================================
# TIER 2: MARKETING ESSENTIALS
# ============================================

echo ""
echo "🥈 TIER 2: MARKETING ESSENTIALS"
echo "================================"
echo ""

ask_approval "meta-ads" "Facebook and Instagram advertising automation"
ask_approval "google-ads" "Google Ads campaign management"
ask_approval "instagram-marketing" "Instagram content and engagement automation"
ask_approval "image-generation" "AI image creation for content"
ask_approval "youtube-api-skill" "YouTube video management and analytics"
ask_approval "youtube-transcript" "Get YouTube video transcripts automatically"

# ============================================
# TIER 3: BUSINESS TOOLS
# ============================================

echo ""
echo "🥉 TIER 3: BUSINESS TOOLS"
echo "=========================="
echo ""

ask_approval "stripe-api" "Payment processing and billing automation"
ask_approval "notion" "Documentation and knowledge base management"
ask_approval "airtable" "Database and CRM functionality"
ask_approval "wacli" "WhatsApp messaging automation"
ask_approval "firecrawl-search" "Web scraping for research and leads"

# ============================================
# BONUS: SCREEN/BROWSER ACCESS TOOLS
# ============================================

echo ""
echo "🎁 BONUS: SCREEN & BROWSER ACCESS"
echo "==================================="
echo ""

ask_approval "peekaboo" "macOS UI automation - can see and control screen elements"
ask_approval "screenshot" "Capture screenshots automatically"
ask_approval "browser-use" "Advanced browser control and monitoring"
ask_approval "video-transcript-downloader" "Download transcripts from any video"

# ============================================
# SUMMARY
# ============================================

echo ""
echo "📊 INSTALLATION SUMMARY"
echo "======================="
echo ""

if [ ${#INSTALLED[@]} -gt 0 ]; then
    echo "${GREEN}✓ Successfully installed (${#INSTALLED[@]}):${NC}"
    for skill in "${INSTALLED[@]}"; do
        echo "  - $skill"
    done
    echo ""
fi

if [ ${#FAILED[@]} -gt 0 ]; then
    echo "${RED}✗ Failed to install (${#FAILED[@]}):${NC}"
    for skill in "${FAILED[@]}"; do
        echo "  - $skill"
        echo "    Log: /tmp/install-${skill}.log"
    done
    echo ""
fi

if [ ${#SKIPPED[@]} -gt 0 ]; then
    echo "${YELLOW}⚠ Skipped (${#SKIPPED[@]}):${NC}"
    for skill in "${SKIPPED[@]}"; do
        echo "  - $skill"
    done
    echo ""
fi

echo "Total: ${#INSTALLED[@]} installed, ${#FAILED[@]} failed, ${#SKIPPED[@]} skipped"
echo ""

# Show final list
echo "Currently installed skills:"
clawhub list 2>/dev/null || echo "  (No skills installed yet)"

echo ""
echo "✅ Installation complete!"
echo ""
echo "📁 Installation logs saved to: /tmp/install-*.log"
echo ""
