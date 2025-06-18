import {gql} from "@apollo/client";
import apolloClient from "../../lib/apolloClient.js";

const getUsers = async (pageIndex, pageSize, email = "") => {
    const GET_JOBS = gql`
        query GetUsers($pageIndex: Int!, $pageSize: Int!, $email: String  ) {
            users(pageIndex: $pageIndex, pageSize: $pageSize, email: $email) {
                data {
                    email
                    fullname
                    phone
                    title
                    role
                }
                total
                page
            }
        }
    `
    let variables = {
        pageIndex: parseInt(pageIndex),
        pageSize: parseInt(pageSize),
    }
    console.log(variables)
    if (email !== "") variables['email'] = email
    const { data, loading, error } = await apolloClient.query({
        query: GET_JOBS,
        variables: variables,
    });

    return { data, loading, error };
}

export { getUsers }
