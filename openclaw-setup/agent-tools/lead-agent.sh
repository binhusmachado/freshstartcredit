#!/bin/bash
#
# Lead Response Agent - Automation Script
# Watches for new leads and sends notifications
#

# Configuration
BUSINESS_EMAIL="fastbtimes@gmail.com"
BUSINESS_PHONE="(305) 747-3973"
NOTIFICATION_METHOD="whatsapp"  # whatsapp, email, or both

# Function to send WhatsApp notification to business owner
send_whatsapp_notification() {
    local name="$1"
    local phone="$2"
    local email="$3"
    local credit_score="$4"
    local goals="$5"
    
    echo "🚨 NEW LEAD ALERT 🚨

Name: $name
Phone: $phone
Email: $email
Credit Score: $credit_score

Goals:
$goals

⏰ Action: Call within 24 hours
📞 Business Line: $BUSINESS_PHONE
📧 Reply to: $email

---
Sent by FreshStartCredit Lead Agent"
}

# Function to send auto-reply email to lead
send_auto_reply() {
    local lead_email="$1"
    local lead_name="$2"
    local lead_phone="$3"
    
    echo "To: $lead_email
Subject: Fresh Start Credit - We Received Your Request

Hi $lead_name,

Thank you for reaching out to Fresh Start Credit!

We've received your request and will call you within 24 hours at $lead_phone.

IN THE MEANTIME, HERE'S WHAT TO EXPECT:
✅ Free 15-minute consultation
✅ Personalized credit analysis  
✅ Clear action plan with pricing
✅ No pressure, just real help

OUR SERVICES:
• $75 per deletion (pay after results)
• $599 full package deal
• Money-back guarantee

If you have any questions before we call, reply to this email or reach us at:
📞 (305) 747-3973
📧 fastbtimes@gmail.com

Talk soon!

Best regards,
Fresh Start Credit Team

---
This email was sent automatically. A real person will call you shortly."
}

# Function to add lead to tracking
track_lead() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local name="$1"
    local email="$2"
    local phone="$3"
    local status="NEW"
    
    # Append to CSV tracking file
    echo "$timestamp,$name,$email,$phone,$status" >> ~/.openclaw/workspace/LEAD_FORM_SOLUTION/leads.csv
    
    echo "✅ Lead tracked: $name at $timestamp"
}

# Main function - Process a new lead
process_new_lead() {
    local name="$1"
    local email="$2"
    local phone="$3"
    local credit_score="$4"
    local goals="$5"
    
    echo "═══════════════════════════════════════"
    echo "🤖 LEAD RESPONSE AGENT ACTIVATED"
    echo "═══════════════════════════════════════"
    echo "Time: $(date)"
    echo "Lead: $name"
    echo "───────────────────────────────────────"
    
    # Step 1: Track the lead
    track_lead "$name" "$email" "$phone"
    
    # Step 2: Send notification to business owner
    echo "📲 Sending WhatsApp notification to owner..."
    send_whatsapp_notification "$name" "$phone" "$email" "$credit_score" "$goals"
    
    # Step 3: Generate auto-reply email
    echo "📧 Generating auto-reply email..."
    send_auto_reply "$email" "$name" "$phone"
    
    echo "───────────────────────────────────────"
    echo "✅ Lead processed successfully!"
    echo "═══════════════════════════════════════"
}

# Demo/test function
demo() {
    echo "Running DEMO with test lead..."
    process_new_lead \
        "Test Customer" \
        "test@example.com" \
        "(555) 123-4567" \
        "500-599" \
        "I want to buy a house in 6 months and need to remove some late payments from my credit report."
}

# Show help
show_help() {
    cat << EOF
Lead Response Agent - Usage:

  ./lead-agent.sh demo              # Run demo with test lead
  ./lead-agent.sh process "Name" "Email" "Phone" "CreditScore" "Goals"
                                    # Process a real lead
  ./lead-agent.sh notify-owner      # Show notification template
  ./lead-agent.sh auto-reply        # Show auto-reply template

Examples:
  ./lead-agent.sh process "John Smith" "john@email.com" "(305) 555-1234" "500-599" "Want to buy a house"

EOF
}

# Main
if [ $# -eq 0 ]; then
    show_help
    exit 0
fi

COMMAND=$1

case $COMMAND in
    demo)
        demo
        ;;
    process)
        if [ $# -ne 6 ]; then
            echo "Error: process requires 5 arguments"
            echo "Usage: ./lead-agent.sh process \"Name\" \"Email\" \"Phone\" \"CreditScore\" \"Goals\""
            exit 1
        fi
        process_new_lead "$2" "$3" "$4" "$5" "$6"
        ;;
    notify-owner)
        echo "=== NOTIFICATION TEMPLATE (WhatsApp) ==="
        send_whatsapp_notification "John Doe" "(305) 555-1234" "john@example.com" "500-599" "Want to remove late payments"
        ;;
    auto-reply)
        echo "=== AUTO-REPLY EMAIL TEMPLATE ==="
        send_auto_reply "customer@email.com" "John Doe" "(305) 555-1234"
        ;;
    *)
        show_help
        ;;
esac
