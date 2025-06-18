import Link from 'next/link';
import {useEffect, useState} from "react";
import {gql, useQuery} from "@apollo/client";
import apolloClient from "../../lib/apolloClient.js";
import Pagination from "../../components/jobs/pagination.js";
import {getJobApplications} from "../../services/graphql/jobsService.js";

const JobApplications = ({currentUser, page, pageSize}) => {
    const [currentPage, setCurrentPage] = useState(page);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(false);
    const [jsonData, setJsonData] = useState([]);
    const [total, setTotal] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const [searchQuery, setSearchQuery] = useState("");

    useEffect(() => {
        const fetchJobs = async () => {
            const {data, loading, error} = await getJobApplications(page, pageSize);
            setJsonData(data.jobApplications.data);
            setCurrentPage(data.jobApplications.page);
            setTotal(data.jobApplications.total)
        }
        fetchJobs()
    }, [page]);

    useEffect(() => {
        setTotalPages(Math.ceil(total / pageSize))
    }, [total, jsonData])

    const onSearch = async (value) => {
        page = 1
        pageSize = 25
        setSearchQuery(value)
        const {data, loading, error} = await getJobApplications(page, pageSize, value);
        setJsonData(data.jobApplications.data);
        setCurrentPage(data.jobApplications.page);
        setTotal(data.jobApplications.total)
    }

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (

        <div className="max-w-7xl mx-auto p-6 rounded-lg m-5" >

            <h3 className="text-xl font-bold mb-2 text-gray-800">🛍️ JobApplications</h3>
            <div className="w-full max-w-md mx-auto mt-10">
                <input
                    onKeyDown={(e) => {
                        if (e.key === 'Enter') {
                            onSearch(e.target.value);
                        }
                    }}
                    type="text"
                    placeholder="Search..."
                    className="w-full px-4 py-2 border-b border-b-blue-500 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                />
            </div>
            <h4 className="text-sm text-gray-600 mb-6 text-center">
                <small>Total: {total}</small>
            </h4>

            <Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize} route="job_applications"></Pagination>
            <div className="overflow-x-auto mt-6">
                <table className="min-w-full divide-y divide-gray-200 bg-white shadow-md rounded-lg overflow-hidden">
                    <thead className="bg-gray-50">
                    <tr>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Job Title
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Email
                        </th>
                        <th scope="col" className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Full Name
                        </th>
                        <th scope="col" className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-200">
                    {jsonData?.map((job_application) => (
                        <tr key={job_application.id}>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                {job_application.job.title}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                {job_application.email}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                {job_application.fullname}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-right text-sm">
                                <Link
                                    href={`/job_applications/${job_application.id}`}
                                    className="text-blue-600 hover:underline font-medium"
                                >
                                    View →
                                </Link>
                            </td>
                        </tr>
                    ))}
                    </tbody>
                </table>
            </div>

            <Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize} route="job_applications"></Pagination>
        </div>
    );
};

JobApplications.getInitialProps = async (context) => {
    const {page = 1, pageSize = 25} = context.query;
    return {page, pageSize};
};

export default JobApplications;
