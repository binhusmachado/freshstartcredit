# Fresh Start Credit Solutions - Website

A professional credit repair business website with client intake form, status tracking, and admin dashboard.

## Live Site
https://freshstartcredit.vercel.app

## Pages
- **Home** (`/`) - Landing page with services and features
- **Get Started** (`/get-started.html`) - Client intake form with Formspree
- **Status** (`/status.html`) - Client status checker (manual lookup)
- **Admin** (`/admin.html`) - Admin dashboard (manual data entry)
- **About, Services, Pricing, FAQ, Contact** - Information pages

## How It Works

### Client Flow:
1. Client visits `/get-started.html`
2. Fills out the intake form
3. Form submits directly to Formspree
4. You receive an email with all client details
5. Follow up within 24 hours

### Admin Flow:
1. Check fastbtimes@gmail.com for new submissions
2. Call client to schedule consultation
3. Track clients manually in Airtable (or any spreadsheet)
4. Update client via email/phone on progress

## Setup

### 1. Formspree (Already Configured)
The form submits to Formspree endpoint: `https://formspree.io/f/mwvnovoz`

If you need to change it:
1. Go to https://formspree.io
2. Create a new form
3. Copy the endpoint URL
4. Update `action="YOUR_NEW_ENDPOINT"` in `get-started.html`

### 2. Deploy to Vercel
1. Push code to GitHub
2. Go to https://vercel.com/new
3. Import your GitHub repo
4. Deploy (no environment variables needed!)

### 3. Custom Domain (Optional)
1. In Vercel dashboard, go to Settings → Domains
2. Add your custom domain
3. Follow DNS instructions

## Features

### Intake Form Captures:
- Personal info (name, email, phone, DOB, SSN last 4)
- Credit goals (mortgage, auto, etc.)
- Timeline (urgent, soon, planning, flexible)
- Current credit score range
- Detailed situation description
- Selected plan (per-deletion, package, consultation)

### Admin Dashboard:
- View all clients (manual data entry)
- Update status, notes, next steps
- Statistics overview
- Login protected with password

### Client Status Page:
- Clients can check their case status
- View updates and next steps
- No login required

## Customization

### Change Colors:
Edit `css/style.css` - look for CSS variables at the top:
```css
:root {
  --primary-dark: #0f172a;
  --accent: #f59e0b;
  ...
}
```

### Change Contact Info:
Edit these files and search/replace:
- Phone: `(305) 747-3973`
- Email: `fastbtimes@gmail.com`

### Change Pricing:
Edit `pricing.html` and `get-started.html`

## Testing

Test the form:
1. Go to `/get-started.html`
2. Fill out with test data
3. Submit
4. Check fastbtimes@gmail.com for the email

## Support

Questions? The site is now fully functional and ready for customers!
