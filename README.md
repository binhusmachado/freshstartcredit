# Fresh Start Credit Solutions - Website

Credit repair business website with automated client intake, status tracking, and admin dashboard.

## Live Site
https://freshstartcredit.vercel.app

## Pages
- **Home** (`/`) - Landing page with services
- **Get Started** (`/get-started.html`) - Client intake form
- **Status** (`/status.html`) - Client status checker
- **Admin** (`/admin.html`) - Admin dashboard
- **About, Services, Pricing, FAQ, Contact** - Info pages

## Phase 2 Setup Required

### 1. Airtable Setup
1. Create free Airtable account: https://airtable.com
2. Create new base called "Fresh Start Credit"
3. Create table "Clients" with these fields:
   - Client ID (Single line text)
   - First Name (Single line text)
   - Last Name (Single line text)
   - Email (Email)
   - Phone (Single line text)
   - Date of Birth (Date)
   - SSN Last 4 (Single line text)
   - Primary Goal (Single select: mortgage, auto, refinance, credit-cards, general, other)
   - Timeline (Single select: urgent, soon, planning, flexible)
   - Current Score (Single line text)
   - Situation (Long text)
   - Selected Plan (Single select: per-deletion, package, consultation)
   - Status (Single select: New Lead, Consultation Scheduled, Documents Pending, Analysis, Active - Round 1, Active - Round 2, Active - Round 3, Complete)
   - Date Submitted (Date)
   - Notes (Long text)
   - Next Steps (Long text)

4. Get your API key from https://airtable.com/create/tokens
5. Get your Base ID from https://airtable.com/api (it's in the URL or docs)

### 2. Resend Setup (Email)
1. Create free Resend account: https://resend.com
2. Verify your domain OR use resend's test domain initially
3. Get API key from dashboard

### 3. Vercel Environment Variables
Add these in Vercel dashboard → Project Settings → Environment Variables:

```
AIRTABLE_API_KEY=your_airtable_api_key
AIRTABLE_BASE_ID=your_airtable_base_id
RESEND_API_KEY=your_resend_api_key
ADMIN_KEY=choose_a_secret_key_for_admin_dashboard
```

### 4. Deploy
Push to GitHub, Vercel will auto-deploy.

## Features

### Automated Workflow
1. Client fills intake form
2. Data saved to Airtable
3. Confirmation email sent to client
4. Notification email sent to admin
5. Client gets unique Client ID

### Client Portal
- Check case status with Client ID or email
- View updates and next steps

### Admin Dashboard
- View all clients
- Update status, notes, next steps
- Statistics overview

## Stripe Integration (Phase 3)
To add payment processing:
1. Create Stripe account
2. Add STRIPE_SECRET_KEY to environment variables
3. Update `/api/submit-intake.js` to create payment intent
4. Add Stripe.js to intake form

## Testing
Use test data:
- Name: Test Client
- Email: your email
- Phone: (305) 747-3973
- All other fields: test data
