// Admin API endpoint to update client status
export default async function handler(req, res) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  
  if (req.method === 'OPTIONS') {
    return res.status(200).end();
  }

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { adminKey, clientId, status, notes, nextSteps } = req.body;

  if (adminKey !== process.env.ADMIN_KEY) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  try {
    // First, find the record ID
    const findResponse = await fetch(
      `https://api.airtable.com/v0/${process.env.AIRTABLE_BASE_ID}/Clients?filterByFormula=${encodeURIComponent(`{Client ID} = '${clientId}'`)}`,
      {
        headers: {
          'Authorization': `Bearer ${process.env.AIRTABLE_API_KEY}`
        }
      }
    );

    const findData = await findResponse.json();
    
    if (findData.records.length === 0) {
      return res.status(404).json({ error: 'Client not found' });
    }

    const recordId = findData.records[0].id;

    // Update the record
    const updateFields = {};
    if (status) updateFields['Status'] = status;
    if (notes) updateFields['Notes'] = notes;
    if (nextSteps) updateFields['Next Steps'] = nextSteps;

    const response = await fetch(
      `https://api.airtable.com/v0/${process.env.AIRTABLE_BASE_ID}/Clients/${recordId}`,
      {
        method: 'PATCH',
        headers: {
          'Authorization': `Bearer ${process.env.AIRTABLE_API_KEY}`,
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ fields: updateFields })
      }
    );

    if (!response.ok) {
      throw new Error('Failed to update Airtable');
    }

    return res.status(200).json({ success: true, message: 'Client updated' });

  } catch (error) {
    console.error('Update error:', error);
    return res.status(500).json({ error: 'Failed to update client' });
  }
}
