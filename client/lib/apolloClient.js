import { ApolloClient, InMemoryCache, createHttpLink } from '@apollo/client';
import { setContext } from '@apollo/client/link/context';

const httpLink = createHttpLink({
    uri: 'https://glassdoor.dev/api/v1/graphql', // Change to your GraphQL endpoint
});

const authLink = setContext((_, { headers }) => {
    const token = typeof window !== 'undefined' ? localStorage.getItem('token') : null;

    return {
        headers: {
            ...headers,
            authorization: token ? `Bearer ${token}` : '',
        },
    };
});

const client = new ApolloClient({
    link: authLink.concat(httpLink),
    cache: new InMemoryCache(),
});

export default client;
