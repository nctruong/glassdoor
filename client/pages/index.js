import Link from 'next/link';
import { useEffect, useState } from "react";
import { gql, useQuery } from "@apollo/client";
import apolloClient from "../lib/apolloClient.js";

const LandingPage = ( { currentUser, page, pageSize } ) => {
    console.log(`------------------------------------------------page: ${page}, pageSize: ${pageSize}`)
    const [currentPage, setCurrentPage] = useState(page);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(false);
    const [jsonData, setJsonData] = useState([]);
    const [total, setTotal] = useState(0);
    const [totalPages, setTotalPages] = useState(0);

    useEffect(() => {
        const fetchJobs = async () => {
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

            console.log(`page: ${page}, pageSize: ${pageSize}`);
            const { data, loading, error } = await apolloClient.query({
                query: GET_JOBS,
                variables: {
                    pageIndex: parseInt(page),
                    pageSize: parseInt(pageSize),
                },
            });
            console.log(`data: ${JSON.stringify(data)}`);
            setJsonData(data.jobCollection.jobs);
            setCurrentPage(data.jobCollection.page);
            setTotal(data.jobCollection.total)

            setTotalPages(Math.ceil(total / pageSize))
        }
        fetchJobs()
    }, []);

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (
        <div className="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow m-5">
            <h3 className="text-2xl font-bold mb-2 text-gray-800">🛍️ jobs</h3>
            <h4 className="text-sm text-gray-600 mb-6">
                Total: {total}, Page: {page}, Page Size: {pageSize}
            </h4>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                {jsonData?.map((job) => (
                    <div
                        key={job.id}
                        className="p-4 border rounded-lg shadow-sm hover:shadow-md transition"
                    >
                        <h5 className="text-lg font-semibold text-gray-700">{job.title}</h5>
                        <p className="text-sm text-gray-500">ID: {job.id}</p>
                        <p className="text-sm text-gray-500">Price: ${job.description}</p>
                        <p className="text-sm text-gray-500">Quantity: {job.salary}</p>
                        <Link
                            href={`/jobs/${job.id}`}
                            className="inline-block mt-3 text-blue-600 hover:underline"
                        >
                            View Details →
                        </Link>
                    </div>
                ))}
            </div>

            <div className="flex justify-center mt-8 space-x-2">
                {Array.from({ length: totalPages }, (_, i) => (
                    <Link
                        key={i}
                        href={`/?page=${i + 1}&pageSize=${pageSize}`}
                        className={`px-4 py-2 text-sm rounded border ${
                            currentPage === i + 1
                                ? 'bg-blue-600 text-white border-blue-600'
                                : 'text-blue-600 border-blue-300 hover:bg-blue-100'
                        } transition`}
                    >
                        {i + 1}
                    </Link>
                ))}
            </div>
        </div>
    );
};

LandingPage.getInitialProps = async (context) => {
    const { page = 1, pageSize = 20 } = context.query;
    return { page, pageSize };
};

export default LandingPage;
