#!/bin/bash
#
# Credit Report Dispute Manager
# Track and manage client disputes
#

DATA_DIR="~/.openclaw/workspace/DISPUTE_MANAGER"
CLIENTS_FILE="$DATA_DIR/clients.csv"
DISPUTES_FILE="$DATA_DIR/disputes.csv"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

init() {
    mkdir -p "$DATA_DIR"
    [ ! -f "$CLIENTS_FILE" ] && echo "id,name,email,phone,ssn_last4,date_added" > "$CLIENTS_FILE"
    [ ! -f "$DISPUTES_FILE" ] && echo "id,client_id,creditor,account_number,error_type,bureaus,status,date_filed,date_resolved,notes" > "$DISPUTES_FILE"
    echo -e "${GREEN}✓ Dispute Manager initialized${NC}"
}

add_client() {
    echo -e "${BLUE}➕ Add New Client${NC}"
    read -p "Name: " name
    read -p "Email: " email
    read -p "Phone: " phone
    read -p "SSN Last 4: " ssn
    
    local id="C$(date +%s)"
    echo "$id,$name,$email,$phone,$ssn,$(date +%Y-%m-%d)" >> "$CLIENTS_FILE"
    
    echo -e "${GREEN}✓ Client added: $name (ID: $id)${NC}"
}

add_dispute() {
    echo -e "${BLUE}➕ Add New Dispute${NC}"
    
    # Show clients
    echo -e "\n${YELLOW}Existing Clients:${NC}"
    tail -n +2 "$CLIENTS_FILE" | while IFS=, read -r id name email phone ssn date; do
        echo "  $id - $name"
    done
    
    read -p "\nClient ID: " client_id
    read -p "Creditor Name: " creditor
    read -p "Account Number: " account
    
    echo -e "\n${YELLOW}Error Types:${NC}"
    echo "  1. Not mine (identity theft)"
    echo "  2. Date inaccurate"
    echo "  3. Paid but still reporting"
    echo "  4. Duplicate entry"
    echo "  5. Account older than 7 years"
    echo "  6. Other"
    read -p "Select error type (1-6): " error_num
    
    case $error_num in
        1) error_type="Not mine"; ;;
        2) error_type="Date inaccurate"; ;;
        3) error_type="Paid still reporting"; ;;
        4) error_type="Duplicate entry"; ;;
        5) error_type="Older than 7 years"; ;;
        *) error_type="Other"; ;;
    esac
    
    read -p "Bureaus (Experian,Equifax,TransUnion): " bureaus
    
    local id="D$(date +%s)"
    echo "$id,$client_id,$creditor,$account,$error_type,$bureaus,PENDING,$(date +%Y-%m-%d),," >> "$DISPUTES_FILE"
    
    echo -e "${GREEN}✓ Dispute added for $creditor${NC}"
}

list_disputes() {
    echo -e "${BLUE}📋 All Disputes${NC}\n"
    
    printf "%-12s %-15s %-20s %-20s %-15s %-20s\n" "ID" "CLIENT" "CREDITOR" "ERROR TYPE" "STATUS" "DATE FILED"
    echo "-------------------------------------------------------------------------------------------------------------------"
    
    tail -n +2 "$DISPUTES_FILE" | while IFS=, read -r id client_id creditor account error bureaus status date_filed date_resolved notes; do
        # Get client name
        local client_name=$(grep "^$client_id," "$CLIENTS_FILE" | cut -d',' -f2)
        printf "%-12s %-15s %-20s %-20s %-15s %-20s\n" "$id" "$client_name" "$creditor" "$error" "$status" "$date_filed"
    done
}

update_status() {
    echo -e "${BLUE}🔄 Update Dispute Status${NC}\n"
    
    list_disputes
    
    read -p "\nEnter Dispute ID: " dispute_id
    
    echo -e "\n${YELLOW}New Status:${NC}"
    echo "  1. PENDING"
    echo "  2. INVESTIGATING"
    echo "  3. DELETED (Success)"
    echo "  4. VERIFIED (Failed)"
    echo "  5. CLOSED"
    read -p "Select status (1-5): " status_num
    
    case $status_num in
        1) new_status="PENDING"; ;;
        2) new_status="INVESTIGATING"; ;;
        3) new_status="DELETED"; ;;
        4) new_status="VERIFIED"; ;;
        5) new_status="CLOSED"; ;;
        *) new_status="PENDING"; ;;
    esac
    
    # Update the CSV
    local temp_file=$(mktemp)
    head -1 "$DISPUTES_FILE" > "$temp_file"
    
    tail -n +2 "$DISPUTES_FILE" | while IFS=, read -r id client_id creditor account error bureaus status date_filed date_resolved notes; do
        if [ "$id" = "$dispute_id" ]; then
            local resolved_date=""
            [ "$new_status" = "DELETED" ] || [ "$new_status" = "VERIFIED" ] || [ "$new_status" = "CLOSED" ] && resolved_date=$(date +%Y-%m-%d)
            echo "$id,$client_id,$creditor,$account,$error,$bureaus,$new_status,$date_filed,$resolved_date,$notes" >> "$temp_file"
        else
            echo "$id,$client_id,$creditor,$account,$error,$bureaus,$status,$date_filed,$date_resolved,$notes" >> "$temp_file"
        fi
    done
    
    mv "$temp_file" "$DISPUTES_FILE"
    echo -e "${GREEN}✓ Status updated to $new_status${NC}"
}

stats() {
    echo -e "${BLUE}📊 Dispute Statistics${NC}\n"
    
    local total=$(tail -n +2 "$DISPUTES_FILE" | wc -l)
    local pending=$(grep -c ",PENDING," "$DISPUTES_FILE" || echo "0")
    local deleted=$(grep -c ",DELETED," "$DISPUTES_FILE" || echo "0")
    local verified=$(grep -c ",VERIFIED," "$DISPUTES_FILE" || echo "0")
    
    echo "Total Disputes:     $total"
    echo "Pending:            $pending"
    echo "Successful (Deleted): $deleted"
    echo "Verified (Failed):  $verified"
    
    if [ "$total" -gt 0 ]; then
        local success_rate=$((deleted * 100 / total))
        echo -e "\n${GREEN}Success Rate: ${success_rate}%${NC}"
    fi
}

search() {
    read -p "Search term (name, creditor, or ID): " term
    
    echo -e "${BLUE}🔍 Search Results for '$term'${NC}\n"
    
    # Search in disputes
    grep -i "$term" "$DISPUTES_FILE" | while IFS=, read -r id client_id creditor account error bureaus status date_filed date_resolved notes; do
        local client_name=$(grep "^$client_id," "$CLIENTS_FILE" | cut -d',' -f2)
        echo -e "${YELLOW}Dispute:${NC} $id - $creditor ($status)"
        echo "  Client: $client_name"
        echo "  Error: $error"
        echo "  Bureaus: $bureaus"
        echo ""
    done
}

show_menu() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  🤖 CREDIT REPORT DISPUTE MANAGER${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo ""
    echo "  1. ➕ Add New Client"
    echo "  2. ➕ Add New Dispute"
    echo "  3. 📋 List All Disputes"
    echo "  4. 🔄 Update Dispute Status"
    echo "  5. 📊 View Statistics"
    echo "  6. 🔍 Search"
    echo "  0. 🚪 Exit"
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

main() {
    init
    
    while true; do
        show_menu
        read -p "Select option: " choice
        
        case $choice in
            1) add_client ;;
            2) add_dispute ;;
            3) list_disputes ;;
            4) update_status ;;
            5) stats ;;
            6) search ;;
            0) echo -e "${GREEN}Goodbye!${NC}"; exit 0 ;;
            *) echo -e "${RED}Invalid option${NC}" ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
    done
}

# Run if called directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main
fi
