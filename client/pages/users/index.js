import Link from 'next/link';
import {useEffect, useState} from "react";
import {gql, useQuery} from "@apollo/client";
import apolloClient from "../../lib/apolloClient.js";
import Pagination from "../../components/jobs/pagination.js";
import {getUsers} from "../../services/graphql/usersService.js";
import Search from "../../components/search.js";

const Users = ({currentUser, page, pageSize}) => {
    const [currentPage, setCurrentPage] = useState(page);
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(false);
    const [jsonData, setJsonData] = useState([]);
    const [total, setTotal] = useState(0);
    const [totalPages, setTotalPages] = useState(0);
    const [searchQuery, setSearchQuery] = useState("");

    useEffect(() => {
        const fetchJobs = async () => {
            const {data, loading, error} = await getUsers(page, pageSize);
            setJsonData(data.users.data);
            setCurrentPage(data.users.page);
            setTotal(data.users.total)
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
        const {data, loading, error} = await getUsers(page, pageSize, value);
        setJsonData(data.users.data);
        setCurrentPage(data.users.page);
        setTotal(data.users.total)
    }

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error: {error.message}</p>;

    return (

        <div className="max-w-7xl mx-auto rounded-lg m-5" >

            <h3 className="text-xl font-bold mb-2 text-gray-800">🧑‍ Users</h3>
            <Search onSearch={onSearch}></Search>
            <h4 className="text-sm text-gray-600 mb-6 text-center">
                <small>Total: {total}</small>
            </h4>

            {/*<Pagination totalPages={totalPages} currentPage={currentPage} pageSize={pageSize} route="job_applications"></Pagination>*/}
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
                    {jsonData?.map((user) => (
                        <tr key={user.id}>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-800">
                                {user.title}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                {user.email}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                {user.fullname}
                            </td>
                            <td className="px-6 py-4 whitespace-nowrap text-right text-sm">
                                <Link
                                    href={`/job_applications/${user.id}`}
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

Users.getInitialProps = async (context) => {
    const {page = 1, pageSize = 25} = context.query;
    return {page, pageSize};
};

export default Users;
