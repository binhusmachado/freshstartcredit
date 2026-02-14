# Setup Guide for Fresh Start Credit

## Step 1: Create Gmail App Password (2 minutes)

1. Go to https://myaccount.google.com
2. Click **Security** on the left
3. Under "2-Step Verification" - make sure it's ON (required for app passwords)
4. Search for "App passwords" at the top or go to: https://myaccount.google.com/apppasswords
5. Click **Select app** → Choose **Mail**
6. Click **Select device** → Choose **Other (Custom name)**
7. Type: `Fresh Start Credit Website`
8. Click **Generate**
9. **COPY THE 16-DIGIT PASSWORD** (it looks like: `abcd efgh ijkl mnop`)
10. Save this - you'll need it for Vercel

---

## Step 2: Create Airtable Account (2 minutes)

1. Go to https://airtable.com/signup
2. Sign up with **fastbtimes@gmail.com**
3. Verify your email (check inbox)
4. Once logged in, go to https://airtable.com/create/tokens
5. Click **Create new token**
6. Name: `Fresh Start Credit Website`
7. Scopes: Check **data.records:read** and **data.records:write**
8. Click **Create token**
9. **COPY THE TOKEN** (starts with `pat`)
10. Save this - you'll need it for Vercel

---

## Step 3: Create Airtable Base

1. In Airtable, click **Create a base** → **Start from scratch**
2. Name it: `Fresh Start Credit`
3. Rename "Table 1" to `Clients`
4. Add these fields (click "+" to add new fields):

| Field Name | Type | Options (if single select) |
|------------|------|---------------------------|
| Client ID | Single line text | |
| First Name | Single line text | |
| Last Name | Single line text | |
| Email | Email | |
| Phone | Single line text | |
| Date of Birth | Date | |
| SSN Last 4 | Single line text | |
| Primary Goal | Single select | mortgage, auto, refinance, credit-cards, general, other |
| Timeline | Single select | urgent, soon, planning, flexible |
| Current Score | Single line text | |
| Situation | Long text | |
| Selected Plan | Single select | per-deletion, package, consultation |
| Status | Single select | New Lead, Consultation Scheduled, Documents Pending, Analysis, Active - Round 1, Active - Round 2, Active - Round 3, Complete |
| Date Submitted | Date | |
| Notes | Long text | |
| Next Steps | Long text | |

5. Click **Share** button (top right)
6. Click **Create link** → **Copy link**
7. The Base ID is in the URL: `https://airtable.com/appXXXXXXXXXXXXXX/...`
   - Copy the part after `/app` and before the next `/`
   - It looks like: `appXXXXXXXXXXXXXX`
8. Save this - you'll need it for Vercel

---

## Step 4: Add Environment Variables to Vercel

1. Go to https://vercel.com/dashboard
2. Click your `freshstartcredit` project
3. Click **Settings** tab → **Environment Variables**
4. Add these 4 variables:

```
AIRTABLE_API_KEY=patXXXXXXXXXXXXXX (from Step 2)
AIRTABLE_BASE_ID=appXXXXXXXXXXXXXX (from Step 3)
GMAIL_USER=fastbtimes@gmail.com
GMAIL_APP_PASSWORD=abcd efgh ijkl mnop (from Step 1, no spaces)
ADMIN_KEY=choose-any-password-you-want-for-admin
```

5. Click **Save**
6. Go to **Deployments** tab
7. Click the three dots on the latest deployment → **Redeploy**

---

## Done! Test It:

1. Go to https://freshstartcredit.vercel.app/get-started.html
2. Fill out the form with test data
3. Submit
4. Check fastbtimes@gmail.com for the client confirmation email
5. Check Airtable - the data should appear in your Clients table
6. Go to https://freshstartcredit.vercel.app/admin.html
7. Login with your ADMIN_KEY
8. You should see the test client

## Troubleshooting:

**Emails not sending?**
- Make sure 2-Step Verification is ON in Gmail
- Make sure you copied the App Password correctly (16 digits, no spaces when entering in Vercel)

**Airtable not saving?**
- Check that you copied the token correctly (starts with `pat`)
- Check that the Base ID is correct (starts with `app`)
- Make sure all the field names match exactly

**Still stuck?**
Send me:
1. Your Airtable token (the `pat...` one)
2. Your Base ID (the `app...` one)
3. Your Gmail app password
4. Your chosen admin password

And I'll configure Vercel for you.
