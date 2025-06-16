import {ApolloProvider} from "@apollo/client";
import client from "../lib/apolloClient";
import '../styles/globals.css';
import Header from "../components/header";
import api from "../services/apiService.js";
import Router from "next/router";
import auth from "../services/authService.js";
import {useEffect} from "react";

const AppComponent = ({Component, pageProps, currentUser}) => {
    useEffect(() => {
        if (!auth.isLoggedIn) {
            Router.push("/auth/signin");
        }
    }, []);

    return (
        <ApolloProvider client={client}>
            <Header currentUser={currentUser}/>
            <div className="container mx-auto mt-15">
                <Component currentUser={currentUser} {...pageProps} />
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

