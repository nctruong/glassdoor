import {ApolloProvider} from "@apollo/client";
import client from "../lib/apolloClient";
import '../styles/globals.css';
import Header from "../components/header";
import api from "../services/apiService.js";
import Router, {useRouter} from "next/router";
import auth from "../services/authService.js";
import {useEffect} from "react";
import Sidebar from "../components/sidebar.js";
const AppComponent = ({Component, pageProps, currentUser}) => {
    const router = useRouter()
    useEffect(() => {

        const currentPath = router.pathname
        if (currentPath !== '/auth/signup' && !auth.isLoggedIn) {
            Router.push("/auth/signin");
        }
    }, []);

    return (
        <ApolloProvider client={client}>
            <Header currentUser={currentUser}/>
            <div className="container mx-auto">
                <div className="flex min-h-screen bg-gray-100">
                    <Sidebar />

                    {/* Main content */}
                    <main className="flex-1 p-6">
                        <Component currentUser={currentUser} {...pageProps} />
                    </main>
                </div>
            </div>
        </ApolloProvider>
    )
}

AppComponent.getInitialProps = async (appContext) => {
    const client = api(appContext.ctx);
    // const { data } = await client.get('/api/users/currentuser');
    const data = {currentUser: {name: "WILL"}}
    let pageProps = {};
    if (appContext.Component.getInitialProps) {
        pageProps = await appContext.Component.getInitialProps(
            appContext.ctx,
            client,
            data.currentUser
        );
    }

    return {
        pageProps,
        ...data,
    };
};

export default AppComponent;

