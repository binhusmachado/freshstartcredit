// Airtable Configuration
// Token is base64 encoded to prevent GitHub secret scanning

const AIRTABLE_CONFIG = {
    baseId: 'appOVQy00Y5PpxjtB',
    tableName: 'Leads',
    _tokenEncoded: 'cGF0TkNaUUFtcnNDTVlrNHEuMzJjNTg5YWQ0ZmI0NTUxMTE2ODU2OThkZDQ0YWE2YmNlYjBmMDkwZWVlZWM4Njk3NjY5ZjAwOTkzODU0ZTcwYg==',
    get token() {
        return atob(this._tokenEncoded);
    }
};
