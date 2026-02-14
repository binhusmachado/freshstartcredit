# Social Media Automation - Anti-Ban Guide
# Follow these rules to keep your accounts safe

## 🛡️ The Golden Rules

### 1. **Never Act Like a Robot**
- Real humans: Inconsistent timing, typos, breaks
- Your AI: Add random delays (15-120 seconds between actions)
- Real humans: Don't post at 3am
- Your AI: Schedule posts during business hours only

### 2. **Warm Up New Accounts**
- Week 1: 1 post per day, 10 likes
- Week 2: 2 posts per day, 20 likes
- Week 3: 3 posts per day, 30 likes
- Week 4+: Normal activity
- Sudden high activity = instant ban

### 3. **Never Spam**
- Same comment on 100 posts = BAN
- Same hashtag on every post = BAN  
- Following 1000 people in one day = BAN
- Posting every 5 minutes = BAN

---

## 📱 Platform-Specific Limits

### INSTAGRAM (Most Strict)
```yaml
Daily Limits:
  Posts: 1-3 per day
  Stories: 5-10 per day
  Likes: 300-500 per day (space them out!)
  Comments: 50-80 per day
  Follows: 50-100 per day
  Unfollows: 50-100 per day
  
Timing:
  Min delay between posts: 2 hours
  Min delay between likes: 15 seconds
  Min delay between comments: 60 seconds
  
Content:
  Never use banned hashtags
  Vary your captions (don't copy-paste)
  Mix photo types (don't post same style)
  Respond to comments within 2 hours
```

### TIKTOK
```yaml
Daily Limits:
  Posts: 1-4 per day (quality over quantity!)
  Likes: 500-1000 per day
  Comments: 100-200 per day
  Follows: 100-200 per day
  
Timing:
  Post between 7am-9pm (your audience timezone)
  Peak times: 12pm-1pm, 7pm-9pm
  
Content:
  Original videos perform better than reposts
  Use trending sounds (but change them up)
  Don't use same hashtag set every time
```

### FACEBOOK/META ADS
```yaml
Ad Account Limits:
  New accounts: Start with $5-10/day budget
  Gradually increase by 20% every 3 days
  Never jump from $10 to $500 instantly
  
Posting:
  1-2 posts per day max
  Space posts 6+ hours apart
  
Groups:
  Max 10 groups per day
  Vary your comments
  Don't post same content to 50 groups
```

---

## 🤖 OpenClaw Configuration for Safety

### Add This To Your OpenClaw Prompts:

```
CRITICAL SAFETY RULES - NEVER VIOLATE:

1. RATE LIMITING:
   - Wait random time between 15-120 seconds between actions
   - Never do more than Instagram: 30 actions/hour, TikTok: 20/hour
   - If you hit a rate limit, STOP for 2 hours

2. CONTENT SAFETY:
   - Check every post for banned hashtags
   - Never post identical content twice
   - Always vary captions and hashtags
   - Add human touch (emojis, slight typos if natural)

3. TIMING:
   - Only post between 7am-9pm EST
   - Space posts minimum 2 hours apart
   - Never post midnight-6am
   - Take "breaks" - don't post every single day

4. ENGAGEMENT:
   - Reply to comments within 2 hours
   - Like 10-20 posts before/after posting
   - Comment genuinely on 5-10 posts daily
   - Follow 10-20 relevant accounts daily

5. IF YOU GET WARNED:
   - Stop all automation immediately
   - Wait 24-48 hours
   - Reduce activity by 50%
   - Report to me via Telegram

YOU MUST FOLLOW THESE RULES OR ACCOUNTS WILL BE BANNED.
```

---

## 🚨 Warning Signs (Stop Immediately If You See These)

1. **"Action Blocked"** - Instagram is warning you
2. **"Please Wait"** with countdown - Slow down NOW
3. **CAPTCHA appearing** - You're acting too robotic
4. **Shadowban** - Posts get 0 engagement
5. **Account Verification Required** - Red flag!

**If you see any of these:**
- Stop all automation for 24-48 hours
- Log in manually and act like normal user
- Post 1-2 things manually
- Like/comment manually
- Then resume with 50% less activity

---

## 📊 Weekly Monitoring Checklist

Check these every Sunday:
- [ ] No warning emails from platforms
- [ ] Follower count growing (not stuck)
- [ ] Posts getting normal engagement
- [ ] No "suspicious activity" alerts
- [ ] Account status shows "Good Standing"

---

## 🔄 Safe Automation Schedule

```
MORNING (9am-11am):
  - Check notifications
  - Reply to 10-20 comments
  - Like 20-30 posts in your niche
  - Post content (if scheduled for morning)

MIDDAY (12pm-2pm):
  - Post main content
  - Engage with comments for 30 min
  - Follow 10-20 accounts

EVENING (6pm-8pm):
  - Reply to all comments
  - Like 20-30 posts
  - Comment on 5-10 posts genuinely
  - Post Stories (if applicable)

NIGHT (9pm-11pm):
  - Check messages/DMs
  - Schedule next day's content
  - Generate report
```

---

## 🎯 Content Strategy That Won't Get Banned

### DO:
✅ Original content
✅ Mix of photos, videos, carousels
✅ Engage with community genuinely
✅ Use 10-20 varied hashtags
✅ Post consistently (not constantly)
✅ Respond to every comment

### DON'T:
❌ Copy-paste same caption
❌ Use same 30 hashtags every post
❌ Post stock photos only
❌ Buy followers/likes
❌ Use "follow for follow" hashtags
❌ Post more than 3x per day
❌ Automate DMs with spam

---

## 🛠️ Technical Safeguards

### Browser Fingerprint Randomization:
```yaml
# In your OpenClaw config:
browser:
  randomize_fingerprint: true
  rotate_user_agents: true
  clear_cookies_daily: false  # Keep login sessions
  use_residential_proxy: true  # If you have one
```

### IP Address Safety:
- Use same IP for each account
- Don't log in from 5 different countries in one day
- If using VPN, keep it consistent per account
- Mobile IPs are safer than data center IPs

---

## 📞 Emergency Contacts

If account gets banned:
1. **Instagram:** Help Center → Report a Problem
2. **TikTok:** feedback@tiktok.com
3. **Facebook:** Business Help Center
4. **Appeal Template:** 
   "Hi, I believe my account was incorrectly flagged. 
   I follow all community guidelines and would like 
   to request a review. Thank you."

---

## ✅ Pre-Flight Checklist

Before running ANY automation:
- [ ] Account is 30+ days old
- [ ] Profile picture uploaded
- [ ] Bio completed
- [ ] 5-10 manual posts made
- [ ] Following 50-100 accounts manually
- [ ] Rate limits configured
- [ ] Delay timers set (15-120 seconds)
- [ ] Telegram alerts configured
- [ ] Daily action limits set
- [ ] Approval required for posts

---

**REMEMBER:** 
Slow and steady = Account lives forever
Fast and aggressive = Account dies in 1 week

**When in doubt: SLOW DOWN**
