class AuthenticationService {
    get token() {
        if (typeof window !== 'undefined') {
            return localStorage.getItem('token');
        }
        return null;
    }

    get isLoggedIn() {
        return this.token !== null;
    }
}

export default new AuthenticationService();
