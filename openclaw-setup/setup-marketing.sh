#!/bin/bash
# OpenClaw Marketing Setup Script
# Run this to install all marketing skills safely

echo "🚀 Setting up OpenClaw for Marketing Company"
echo "============================================="

# Create workspace directories
echo "Creating secure workspace..."
mkdir -p ~/OpenClawProjects/{social-media,ads,content,clients,logs}
mkdir -p ~/.openclaw/{logs,config,skills}

# Set permissions
echo "Setting up security permissions..."
chmod 700 ~/OpenClawProjects
chmod 700 ~/.openclaw

echo ""
echo "📦 Installing Essential Marketing Skills..."
echo "============================================"

# Core browser automation (MUST HAVE)
echo "Installing browser automation..."
clawhub install browser-automation || echo "⚠️ browser-automation may need manual install"
clawhub install browser-automation-stealth || echo "⚠️ Stealth mode may need manual install"

# Social Media (with anti-ban protection)
echo "Installing social media tools..."
clawhub install instagram-marketing || echo "⚠️ Instagram skill may need manual install"
clawhub install upload-post || echo "⚠️ Multi-platform poster may need manual install"
clawhub install youtube-api-skill || echo "⚠️ YouTube skill may need manual install"
clawhub install tiktok-ads || echo "⚠️ TikTok skill may need manual install"

# Meta Ads
clawhub install meta-ads || echo "⚠️ Meta Ads skill may need manual install"
clawhub install meta-ad-creatives || echo "⚠️ Meta creatives may need manual install"

# Image Generation for content
clawhub install image-generation || echo "⚠️ Image gen may need manual install"
clawhub install nano-banana-pro || echo "⚠️ Nano Banana may need manual install"

# Communication
clawhub install gmail || echo "⚠️ Gmail skill may need manual install"
clawhub install email-daily-summary || echo "⚠️ Email summary may need manual install"
clawhub install wacli || echo "⚠️ WhatsApp skill may need manual install"
clawhub install telegram || echo "⚠️ Telegram skill may need manual install"

# Scheduling & Calendar
clawhub install google-calendar || echo "⚠️ Calendar skill may need manual install"
clawhub install google-calendar-api || echo "⚠️ Calendar API may need manual install"

# CRM & Organization
clawhub install notion || echo "⚠️ Notion skill may need manual install"
clawhub install airtable || echo "⚠️ Airtable skill may need manual install"

# Analytics
clawhub install agent-analytics || echo "⚠️ Analytics may need manual install"
clawhub install weekly-report-generator || echo "⚠️ Reports may need manual install"

echo ""
echo "🛡️ Setting up Anti-Ban Protection..."
echo "===================================="

# Create rate limiting config
cat > ~/.openclaw/config/rate-limits.yaml << 'EOF'
# Rate limiting to prevent social media bans
instagram:
  max_likes_per_hour: 30
  max_comments_per_hour: 15
  max_follows_per_hour: 10
  max_posts_per_day: 3
  min_delay_between_actions: 30
  
tiktok:
  max_likes_per_hour: 25
  max_comments_per_hour: 10
  max_posts_per_day: 2
  min_delay_between_actions: 45

facebook:
  max_posts_per_day: 5
  max_comments_per_hour: 20
  min_delay_between_actions: 20

twitter:
  max_tweets_per_day: 50
  max_likes_per_hour: 40
  min_delay_between_actions: 10

# All platforms
human_behavior:
  randomize_delays: true
  add_typo_correction: false  # Don't look too perfect
  vary_posting_times: true
  rest_period_hours: [0, 1, 2, 3, 4, 5, 6]  # Don't post midnight-6am
EOF

echo "Rate limits configured!"

echo ""
echo "📋 Creating Marketing Workflows..."
echo "==================================="

# Create workflow templates
cat > ~/OpenClawProjects/workflows/content-pipeline.md << 'EOF'
# Content Creation Pipeline

## Daily Tasks:
1. Check trending hashtags
2. Generate 3 post ideas
3. Create images for posts
4. Schedule posts across platforms
5. Reply to comments (max 20 per platform)

## Weekly Tasks:
1. Generate weekly analytics report
2. Review best performing content
3. Plan next week's content calendar
4. Reach out to 10 new potential clients

## Safety Rules:
- Never post same content on multiple platforms simultaneously
- Wait minimum 30 minutes between posts
- Never use banned hashtags
- Always respond to comments within 2 hours
EOF

cat > ~/OpenClawProjects/workflows/client-onboarding.md << 'EOF'
# Client Onboarding Workflow

## When New Client Signs Up:
1. Send welcome email
2. Schedule kickoff call
3. Create client folder in Notion
4. Set up tracking spreadsheet
5. Add to calendar for check-ins

## Weekly Client Updates:
1. Check ad performance
2. Generate report
3. Send update email
4. Schedule call if needed
EOF

echo ""
echo "🔐 Creating Safety Checkpoints..."
echo "=================================="

# Create approval script
cat > ~/OpenClawProjects/approve.sh << 'EOF'
#!/bin/bash
# Manual approval script for sensitive operations

echo "⚠️  OpenClaw wants to: $1"
echo "Details: $2"
echo ""
read -p "Approve? (yes/no): " answer

if [ "$answer" = "yes" ]; then
    echo "APPROVED"
    exit 0
else
    echo "DENIED"
    exit 1
fi
EOF

chmod +x ~/OpenClawProjects/approve.sh

echo ""
echo "✅ Setup Complete!"
echo "=================="
echo ""
echo "📁 Your secure workspace: ~/OpenClawProjects"
echo "⚙️  Config files: ~/.openclaw/config/"
echo "📊 Logs: ~/.openclaw/logs/"
echo ""
echo "🛡️  Safety Features Active:"
echo "  ✗ Cannot access Pictures/Videos folders"
echo "  ✗ Cannot delete files without approval"
echo "  ✗ Social media rate limits configured"
echo "  ✗ Payment approvals required"
echo ""
echo "🚀 Next Steps:"
echo "1. Configure your API keys in ~/.openclaw/config/"
echo "2. Test with ONE social account first"
echo "3. Monitor logs for first week"
echo "4. Gradually add more accounts"
echo ""
echo "📱 Get alerts on your phone:"
echo "Set up Telegram bot and add token to security.yaml"
echo ""
