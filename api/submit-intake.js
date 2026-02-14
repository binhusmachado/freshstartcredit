// API endpoint using Formspree for form submission
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  try {
    const data = req.body;
    
    // Generate Client ID
    const clientId = `FSC${Date.now().toString(36).toUpperCase()}`;
    
    // Add client ID to data
    data.clientId = clientId;
    
    // Send to Formspree
    const response = await fetch('https://formspree.io/f/mwvnovoz', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
      body: JSON.stringify(data)
    });

    if (response.ok) {
      return res.status(200).json({
        success: true,
        clientId,
        message: 'Submission received! Check your email for confirmation.'
      });
    } else {
      throw new Error('Formspree error');
    }

  } catch (error) {
    console.error('API Error:', error);
    return res.status(500).json({
      error: 'Failed to submit form',
      message: error.message
    });
  }
}
