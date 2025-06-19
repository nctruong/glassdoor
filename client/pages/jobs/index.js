import Link from 'next/link';
import {useEffect, useState} from "react";
import Pagination from "../../components/jobs/pagination.js";
import {getJobs} from "../../services/graphql/jobsService.js";
import Search from "../../components/search.js";

const Jobs = ({currentUser, page, pageSize}) => {
    const [currentPage, setCurrentPage] = useState(page);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(false);
    const [jsonData, setJsonData] = useState([]);
    const [total, setTotal] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const [searchQuery, setSearchQuery] = useState("");

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
    }, [total, jsonData])

    const onSearch = async (value) => {
        page = 1
        pageSize = 25
        setSearchQuery(value)
        const {data, loading, error} = await getJobs(page, pageSize, { title: value });
        setJsonData(data.jobCollection.jobs);
        setCurrentPage(data.jobCollection.page);
        setTotal(data.jobCollection.total)
    }

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (

        <div className="max-w-7xl mx-auto rounded-lg" >

            <h3 className="text-xl font-bold mb-2 text-gray-800">💼 Jobs</h3>
            <Search onSearch={onSearch}></Search>
            <h4 className="text-sm text-gray-600 mb-6 text-center">
                <small>Total: {total}</small>
            </h4>

            {/*<Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize}></Pagination>*/}
            <div className="overflow-x-auto mt-6">
                <table className="min-w-full table-auto bg-white shadow-md rounded-lg">
                    <thead className="bg-gray-50">
                    <tr>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Title
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Description
                        </th>
                        <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Salary
                        </th>
                        <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">
                            Actions
                        </th>
                    </tr>
                    </thead>
                    <tbody className="divide-y divide-gray-200">
                    {jsonData?.map((job) => (
                        <tr key={job.id}>
                            <td className="px-6 py-4 text-sm font-medium text-gray-800 whitespace-normal break-words max-w-xs">
                                {job.title}
                            </td>
                            <td className="px-6 py-4 text-sm text-gray-600 whitespace-normal break-words max-w-md">
                                {job.description}
                            </td>
                            <td className="px-6 py-4 text-sm text-gray-600 whitespace-nowrap">
                                {job.salary}
                            </td>
                            <td className="px-6 py-4 text-sm text-right">
                                <Link
                                    href={`/jobs/${job.id}`}
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

            <Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize}></Pagination>
        </div>
    );
};

Jobs.getInitialProps = async (context) => {
    const {page = 1, pageSize = 25} = context.query;
    return {page, pageSize};
};

export default Jobs;
