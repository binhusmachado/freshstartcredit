// API endpoint for client intake form submission
// Saves to Airtable and sends confirmation emails

export default async function handler(req, res) {
  // Enable CORS
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const {
      firstName,
      lastName,
      email,
      phone,
      dob,
      ssn,
      goal,
      timeline,
      currentScore,
      situation,
      plan
    } = req.body;

    // Validate required fields
    if (!firstName || !lastName || !email || !phone || !dob || !ssn || !goal || !timeline) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Generate unique client ID
    const clientId = `FSC${Date.now().toString(36).toUpperCase()}`;

    // Save to Airtable
    const airtableResponse = await fetch(
      `https://api.airtable.com/v0/${process.env.AIRTABLE_BASE_ID}/Clients`,
      {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${process.env.AIRTABLE_API_KEY}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          fields: {
            'Client ID': clientId,
            'First Name': firstName,
            'Last Name': lastName,
            'Email': email,
            'Phone': phone,
            'Date of Birth': dob,
            'SSN Last 4': ssn,
            'Primary Goal': goal,
            'Timeline': timeline,
            'Current Score': currentScore || 'Unknown',
            'Situation': situation || '',
            'Selected Plan': plan,
            'Status': 'New Lead',
            'Date Submitted': new Date().toISOString()
          }
        })
      }
    );

    if (!airtableResponse.ok) {
      const error = await airtableResponse.text();
      console.error('Airtable error:', error);
      // Continue even if Airtable fails - we have the data
    }

    // Send confirmation email to client
    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'Fresh Start Credit <hello@freshstartcredit.vercel.app>',
        to: email,
        subject: 'Your Fresh Start Credit Consultation is Confirmed',
        html: `
          <h2>Thank you, ${firstName}!</h2>
          <p>We've received your consultation request. Here's what happens next:</p>
          <ol>
            <li>We'll review your information within 24 hours</li>
            <li>You'll receive a call from us at ${phone} to schedule your consultation</li>
            <li>We'll analyze your credit reports together</li>
            <li>You'll get a customized action plan</li>
          </ol>
          <p><strong>Your Client ID:</strong> ${clientId}</p>
          <p>Save this ID - you'll need it to check your status.</p>
          <p>Questions? Reply to this email or call us at (305) 747-3973</p>
          <br>
          <p>- Fresh Start Credit Solutions Team</p>
        `
      })
    });

    // Send notification to admin
    await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.RESEND_API_KEY}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        from: 'Fresh Start Credit System <system@freshstartcredit.vercel.app>',
        to: 'fastbtimes@gmail.com',
        subject: `New Client Lead: ${firstName} ${lastName}`,
        html: `
          <h2>New Client Submission</h2>
          <p><strong>Client ID:</strong> ${clientId}</p>
          <p><strong>Name:</strong> ${firstName} ${lastName}</p>
          <p><strong>Email:</strong> ${email}</p>
          <p><strong>Phone:</strong> ${phone}</p>
          <p><strong>Goal:</strong> ${goal}</p>
          <p><strong>Timeline:</strong> ${timeline}</p>
          <p><strong>Selected Plan:</strong> ${plan}</p>
          <p><strong>Situation:</strong> ${situation || 'N/A'}</p>
          <br>
          <p><a href="https://freshstartcredit.vercel.app/admin.html">View in Admin Dashboard</a></p>
        `
      })
    });

    return res.status(200).json({
      success: true,
      clientId,
      message: 'Submission received. Check your email for confirmation.'
    });

  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({
      error: 'Internal server error',
      message: error.message
    });
  }
}
