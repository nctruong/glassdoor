import {gql} from "@apollo/client";
import apolloClient from "../../lib/apolloClient.js";

const getJobs = async (pageIndex, pageSize, params = null) => {
    const GET_JOBS = gql`
        query GetJobs($pageIndex: Int!, $pageSize: Int!, $params: JobFilterParams  ) {
            jobCollection(pageIndex: $pageIndex, pageSize: $pageSize, params: $params) {
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
    console.log(params)
    let variables = {
        pageIndex: parseInt(pageIndex),
        pageSize: parseInt(pageSize),
    }
    console.log(variables)
    if (params && params['title'] !== '') variables['params'] = params
    const { data, loading, error } = await apolloClient.query({
        query: GET_JOBS,
        variables: variables,
    });

    return { data, loading, error };
}

const getJobApplications = async (pageIndex, pageSize, candidateName, scope = "all") => {
    const GET_JOBS = gql`
        query GetJobs($pageIndex: Int!, $pageSize: Int!, $scope: String, $candidateName: String  ) {
            jobApplications(params:{ pageIndex: $pageIndex, pageSize: $pageSize, scope: $scope, candidateName: $candidateName }) {
                data {
                    id
                    job {
                        title
                    }
                    email
                    fullname
                    employer {
                        name
                        email
                    }
                },
                scopes {
                    all,
                    approved,
                    pending
                    rejected120,
                    rejected360,
                    spamRejected
                }
                total,
                page,
                pageSize
            }
        }
    `
    let variables = {
        pageIndex: parseInt(pageIndex),
        pageSize: parseInt(pageSize),
        scope: scope,
    }
    if (candidateName !== undefined && candidateName !== "") { variables['candidateName'] = candidateName }

    const { data, loading, error } = await apolloClient.query({
        query: GET_JOBS,
        variables: variables,
    });

    return { data, loading, error };
}
export { getJobs, getJobApplications };
