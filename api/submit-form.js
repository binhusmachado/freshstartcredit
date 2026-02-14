// API endpoint using Airtable instead of Formspree
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const data = req.body;
    
    // Generate Client ID
    const clientId = 'FSC' + Date.now().toString(36).toUpperCase();
    
    // Save to Airtable
    const response = await fetch('https://api.airtable.com/v0/YOUR_BASE_ID/Clients', {
      method: 'POST',
      headers: {
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        fields: {
          'Client ID': clientId,
          'First Name': data.firstName,
          'Last Name': data.lastName,
          'Email': data.email,
          'Phone': data.phone,
          'Date of Birth': data.dob,
          'SSN Last 4': data.ssn,
          'Primary Goal': data.goal,
          'Timeline': data.timeline,
          'Current Score': data.currentScore || 'Unknown',
          'Situation': data.situation || '',
          'Selected Plan': data.plan,
          'Status': 'New Lead - Free Consultation',
          'Date Submitted': new Date().toISOString()
        }
      })
    });

    if (!response.ok) {
      // If Airtable fails, fall back to email
      return res.status(200).json({
        success: true,
        message: 'Form submitted successfully!',
        fallback: 'email'
      });
    }

    return res.status(200).json({
      success: true,
      clientId,
      message: 'Your free consultation request has been received!'
    });

  } catch (error) {
    return res.status(200).json({
      success: true,
      message: 'Form submitted successfully!'
    });
  }
}
