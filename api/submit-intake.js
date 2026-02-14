// API endpoint for client intake form submission
// Saves to Airtable only - Airtable automation handles emails

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
            'Date Submitted': new Date().toISOString(),
            'Notes': `New client submission from website. Goal: ${goal}, Timeline: ${timeline}`,
            'Next Steps': 'Schedule free consultation within 24 hours'
          }
        })
      }
    );

    if (!airtableResponse.ok) {
      const error = await airtableResponse.text();
      console.error('Airtable error:', error);
      return res.status(500).json({ error: 'Failed to save to database', details: error });
    }

    const data = await airtableResponse.json();

    return res.status(200).json({
      success: true,
      clientId,
      message: 'Submission received! You will receive an email confirmation shortly.'
    });

  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({
      error: 'Internal server error',
      message: error.message
    });
  }
}
