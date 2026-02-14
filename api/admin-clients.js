// Admin API endpoint to get all clients
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, OPTIONS');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { adminKey } = req.query;

  // Simple admin key check (in production, use proper auth)
  if (adminKey !== process.env.ADMIN_KEY) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  try {
    const response = await fetch(
      `https://api.airtable.com/v0/${process.env.AIRTABLE_BASE_ID}/Clients?sort%5B0%5D%5Bfield%5D=Date+Submitted&sort%5B0%5D%5Bdirection%5D=desc`,
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

    const clients = data.records.map(record => ({
      id: record.id,
      clientId: record.fields['Client ID'],
      name: `${record.fields['First Name']} ${record.fields['Last Name']}`,
      email: record.fields['Email'],
      phone: record.fields['Phone'],
      status: record.fields['Status'],
      plan: record.fields['Selected Plan'],
      goal: record.fields['Primary Goal'],
      dateSubmitted: record.fields['Date Submitted'],
      notes: record.fields['Notes'] || '',
      nextSteps: record.fields['Next Steps'] || ''
    }));

    return res.status(200).json({ clients });

  } catch (error) {
    console.error('Admin API error:', error);
    return res.status(500).json({ error: 'Failed to fetch clients' });
  }
}
