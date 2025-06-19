import axios from 'axios'

function isClientSide() {
    return typeof window !== 'undefined';
}

const apiService = () => {
    let baseUrl;
    if (typeof window === 'undefined') {
        baseUrl = 'https://glassdoor.dev'
    } else {
        baseUrl = 'https://glassdoor.dev'
    }
    console.log(baseUrl);
    const axiosClient = axios.create({
        baseURL: baseUrl,
        timeout: 10000,
        headers: {
            "Content-Type": "application/json",
        },
    })

    axiosClient.interceptors.request.use(config => {
        if (isClientSide()) {
            const token = localStorage.getItem("jwt");
            if (token) {
                config.headers.Authorization = `Bearer ${token}`;
            }
        }
        return config;
    });

    return axiosClient;
}

export default apiService();
