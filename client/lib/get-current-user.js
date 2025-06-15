// lib/get-current-user.ts
import api from '../services/apiService.js';

export const getCurrentUser = async (context) => {
    const client = api(context);
    const { data } = await client.get('/api/users/currentUser');
    return data.currentUser || null;
};
