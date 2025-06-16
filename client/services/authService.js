import api from "./apiService.js";

class AuthenticationService {

    constructor(context) {
        this.context = context;
    }

    get token() {
        if (typeof window !== 'undefined') {
            return localStorage.getItem('token');
        }
        return null;
    }

    get isLoggedIn() {
        return this.token !== null;
    }

    // async get currentUser() {
    //     const client = api(this.context);
    //     const {data} = await client.get('/api/v1/users/currentUser');
    //     return data.currentUser || null;
    // };
}

export default new AuthenticationService();
