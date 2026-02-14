// API endpoint to check client status
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { clientId, email } = req.query;

  if (!clientId && !email) {
    return res.status(400).json({ error: 'Client ID or email required' });
  }

  try {
    // Build filter formula
    let filterFormula;
    if (clientId) {
      filterFormula = `{Client ID} = '${clientId}'`;
    } else {
      filterFormula = `{Email} = '${email}'`;
    }

    // Query Airtable
    const response = await fetch(
      `https://api.airtable.com/v0/${process.env.AIRTABLE_BASE_ID}/Clients?filterByFormula=${encodeURIComponent(filterFormula)}`,
      {
        headers: {
          'Authorization': `Bearer ${process.env.AIRTABLE_API_KEY}`
        }
      }
    );

    if (!response.ok) {
      throw new Error('Failed to fetch from Airtable');
    }

    const data = await response.json();

    if (data.records.length === 0) {
      return res.status(404).json({ error: 'Client not found' });
    }

    const client = data.records[0];
    
    // Return limited info for security
    return res.status(200).json({
      clientId: client.fields['Client ID'],
      name: `${client.fields['First Name']} ${client.fields['Last Name']}`,
      status: client.fields['Status'],
      plan: client.fields['Selected Plan'],
      dateSubmitted: client.fields['Date Submitted'],
      notes: client.fields['Notes'] || 'No updates yet.',
      nextSteps: client.fields['Next Steps'] || 'Awaiting consultation scheduling.'
    });

  } catch (error) {
    console.error('Status check error:', error);
    return res.status(500).json({ error: 'Failed to retrieve status' });
  }
}
