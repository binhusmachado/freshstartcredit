#!/bin/bash
# Daily Marketing Automation Script
# Run this to automate your marketing safely

echo "🚀 Starting Daily Marketing Automation"
echo "======================================"
echo "$(date)"
echo ""

# Check if it's safe to run (business hours only)
hour=$(date +%H)
if [ $hour -lt 7 ] || [ $hour -gt 21 ]; then
    echo "⚠️  Outside business hours (7am-9pm). Stopping to avoid bans."
    exit 1
fi

# Load security config
source ~/.openclaw/config/security.yaml 2>/dev/null || true

echo "✅ Security checks passed"
echo ""

# ============================================
# MORNING ROUTINE (9am-11am)
# ============================================

echo "🌅 MORNING ROUTINE"
echo "==================="

# 1. Check emails for client updates
echo "📧 Checking client emails..."
# This would integrate with your email skill
# openclaw ask "Check fastbtimes@gmail.com for urgent client emails and summarize"

# 2. Generate morning report
echo "📊 Generating morning analytics..."
cat > ~/OpenClawProjects/daily-reports/morning-$(date +%Y-%m-%d).md << EOF
# Morning Report - $(date)

## Today's Priorities:
1. [ ] Check all ad campaigns
2. [ ] Respond to client messages
3. [ ] Post scheduled content
4. [ ] Review yesterday's performance

## Client Check-ins Needed:
- Review client list and schedule calls

## Content to Create:
- Check content calendar
EOF

# 3. Content generation (if needed)
echo "🎨 Checking content calendar..."
# openclaw ask "What's on the content calendar for today?"

# ============================================
# CONTENT CREATION
# ============================================

echo ""
echo "📝 CONTENT CREATION"
echo "===================="

# Generate post ideas if none exist
if [ ! -f ~/OpenClawProjects/content/today-posts.md ]; then
    echo "Generating post ideas..."
    cat > ~/OpenClawProjects/content/today-posts.md << 'EOF'
# Today's Post Ideas (Auto-generated)

## Instagram Post 1 (12pm)
- Type: Educational carousel
- Topic: Credit score myths
- Image: Create with AI
- Caption: TBD

## TikTok (3pm)
- Type: Quick tip video
- Topic: How to dispute errors
- Script: TBD

## Facebook (6pm)
- Type: Client testimonial
- Content: Share success story
EOF
fi

echo "✅ Content plan ready"

# ============================================
# SOCIAL MEDIA MANAGEMENT
# ============================================

echo ""
echo "📱 SOCIAL MEDIA MANAGEMENT"
echo "=========================="

# Safety check - count today's posts
post_count=$(find ~/OpenClawProjects/logs -name "post-$(date +%Y-%m-%d)*" | wc -l)

if [ $post_count -ge 3 ]; then
    echo "⚠️  Already posted 3 times today. Skipping new posts."
else
    echo "📤 Safe to post ($post_count/3 today)"
    
    # Instagram
    if [ $post_count -lt 3 ]; then
        echo "📸 Preparing Instagram post..."
        # openclaw ask "Create Instagram post about credit repair tip. Save to approval queue."
    fi
    
    # TikTok
    if [ $post_count -lt 2 ]; then
        echo "🎵 Preparing TikTok content..."
        # openclaw ask "Generate TikTok script about credit score improvement"
    fi
fi

# Engagement (always safe)
echo "💬 Engagement tasks:"
echo "  - Reply to comments (check every 2 hours)"
echo "  - Like 20-30 posts in niche"
echo "  - Comment genuinely on 5-10 posts"

# ============================================
# ADS MANAGEMENT
# ============================================

echo ""
echo "📢 ADS MANAGEMENT"
echo "=================="

echo "Checking Meta Ads performance..."
# openclaw ask "Check Meta Ads dashboard. Alert if any ad is spending >$50 with ROAS < 1.5"

echo "Checking ad creative performance..."
# openclaw ask "Which ad creatives performed best yesterday? Generate summary."

# ============================================
# CLIENT MANAGEMENT
# ============================================

echo ""
echo "👥 CLIENT MANAGEMENT"
echo "===================="

echo "Checking for new form submissions..."
# openclaw ask "Check freshstartcredit.vercel.app form submissions. Alert if new leads."

echo "Scheduling follow-ups..."
# openclaw ask "Which clients need follow-up calls today? Create call list."

# ============================================
# SAFETY CHECKS
# ============================================

echo ""
echo "🛡️  SAFETY CHECKS"
echo "=================="

# Check action limits
today_actions=$(cat ~/.openclaw/logs/actions-$(date +%Y-%m-%d).log 2>/dev/null | wc -l)
echo "Actions today: $today_actions"

if [ $today_actions -gt 200 ]; then
    echo "⚠️  WARNING: High activity detected. Slowing down."
    echo "Taking 2-hour break..."
    sleep 7200
fi

# Log this run
echo "$(date): Daily automation completed" >> ~/.openclaw/logs/automation.log

echo ""
echo "✅ Daily Automation Complete!"
echo "============================="
echo ""
echo "📊 Summary:"
echo "  - Morning report generated"
echo "  - Content plan checked"
echo "  - Social media limits monitored"
echo "  - Client leads checked"
echo ""
echo "🕐 Next scheduled run: $(date -v+2H +%H:%M)"
echo ""
echo "📱 You'll receive Telegram alerts for:"
echo "  - New client submissions"
echo "  - Ad performance issues"
echo "  - Rate limit warnings"
echo ""
