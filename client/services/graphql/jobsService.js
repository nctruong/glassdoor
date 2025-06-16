import {gql} from "@apollo/client";
import apolloClient from "../../lib/apolloClient.js";

const getJobs = async (pageIndex, pageSize) => {
    const GET_JOBS = gql`
        query GetJobs($pageIndex: Int!, $pageSize: Int!) {
            jobCollection(pageIndex: $pageIndex, pageSize: $pageSize) {
                jobs {
                    id
                    title
                    description
                    salary
                    employer {
                        name
                        email
                    }
                },
                total,
                page,
                pageSize
            }
        }
    `

    const { data, loading, error } = await apolloClient.query({
        query: GET_JOBS,
        variables: {
            pageIndex: parseInt(pageIndex),
            pageSize: parseInt(pageSize),
        },
    });

    return { data, loading, error };
}
export { getJobs };
