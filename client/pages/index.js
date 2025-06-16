import Link from 'next/link';
import {useEffect, useState} from "react";
import {gql, useQuery} from "@apollo/client";
import apolloClient from "../lib/apolloClient.js";
import Pagination from "../components/jobs/pagination.js";
import {getJobs} from "../services/jobsService.js";

const LandingPage = ({currentUser, page, pageSize}) => {
    console.log(`------------------------------------------------page: ${page}, pageSize: ${pageSize}`)
    const [currentPage, setCurrentPage] = useState(page);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(false);
    const [jsonData, setJsonData] = useState([]);
    const [total, setTotal] = useState(0);
    const [totalPages, setTotalPages] = useState(0);

    useEffect(() => {
        const fetchJobs = async () => {
            const {data, loading, error} = await getJobs(page, pageSize);
            setJsonData(data.jobCollection.jobs);
            setCurrentPage(data.jobCollection.page);
            setTotal(data.jobCollection.total)
        }
        fetchJobs()
    }, [page]);

    useEffect(() => {
        setTotalPages(Math.ceil(total / pageSize))
    }, [total])

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (
        <div className="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow m-5">
            <h3 className="text-2xl font-bold mb-2 text-gray-800">🛍️ jobs</h3>
            <h4 className="text-sm text-gray-600 mb-6">
                Total: {total}
            </h4>
            <div className="w-full max-w-md mx-auto mt-10">
                <input
                    type="text"
                    placeholder="Search..."
                    className="w-full px-4 py-2 border rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
            </div>
            <Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize}></Pagination>
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 mt-5">
                {jsonData?.map((job) => (
                    <div
                        key={job.id}
                        className="p-4 border rounded-lg shadow-sm hover:shadow-md transition"
                    >
                        <h5 className="text-lg font-semibold text-gray-700">{job.title}</h5>
                        {/*<p className="text-sm text-gray-500">ID: {job.id}</p>*/}
                        <p className="text-sm text-gray-500">${job.description}</p>
                        <p className="text-sm text-gray-500">Salary: {job.salary}</p>
                        <Link
                            href={`/jobs/${job.id}`}
                            className="inline-block mt-3 text-blue-600 hover:underline"
                        >
                            View Details →
                        </Link>
                    </div>
                ))}
            </div>

            <Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize}></Pagination>
        </div>
    );
};

LandingPage.getInitialProps = async (context) => {
    const {page = 1, pageSize = 25} = context.query;
    return {page, pageSize};
};

export default LandingPage;
