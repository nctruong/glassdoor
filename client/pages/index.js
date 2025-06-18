// app/dashboard/page.tsx
import Link from 'next/link';

const mockApplications = [
    { id: 1, title: 'Frontend Engineer', candidate: 'Alice Le', email: 'alice@example.com', salary: '1200' },
    { id: 2, title: 'Backend Engineer', candidate: 'Bob Nguyen', email: 'bob@example.com', salary: '1500' },
    { id: 3, title: 'DevOps Engineer', candidate: 'Carol Tran', email: 'carol@example.com', salary: '1800' },
];

export default function DashboardPage() {
    return (
        <div >

                <h1 className="text-2xl font-semibold mb-4">Dashboard</h1>

                {/* Stats */}
                <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                    <div className="bg-white p-4 rounded-lg shadow">
                        <h2 className="text-gray-500 text-sm">Total Applications</h2>
                        <p className="text-xl font-bold">324</p>
                    </div>
                    <div className="bg-white p-4 rounded-lg shadow">
                        <h2 className="text-gray-500 text-sm">Jobs Posted</h2>
                        <p className="text-xl font-bold">15</p>
                    </div>
                    <div className="bg-white p-4 rounded-lg shadow">
                        <h2 className="text-gray-500 text-sm">Pending Reviews</h2>
                        <p className="text-xl font-bold">8</p>
                    </div>
                </div>

                {/* Applications Table */}
                <div className="bg-white rounded-lg shadow overflow-x-auto">
                    <table className="min-w-full table-auto">
                        <thead className="bg-gray-50 text-left">
                        <tr>
                            <th className="px-4 py-2 text-sm font-medium text-gray-500">Job Title</th>
                            <th className="px-4 py-2 text-sm font-medium text-gray-500">Candidate</th>
                            <th className="px-4 py-2 text-sm font-medium text-gray-500">Email</th>
                            <th className="px-4 py-2 text-sm font-medium text-gray-500">Salary</th>
                            <th className="px-4 py-2 text-sm font-medium text-gray-500 text-right">Action</th>
                        </tr>
                        </thead>
                        <tbody className="divide-y divide-gray-200">
                        {mockApplications.map((app) => (
                            <tr key={app.id}>
                                <td className="px-4 py-2 text-sm text-gray-700">{app.title}</td>
                                <td className="px-4 py-2 text-sm text-gray-700">{app.candidate}</td>
                                <td className="px-4 py-2 text-sm text-gray-500">{app.email}</td>
                                <td className="px-4 py-2 text-sm text-gray-500">${app.salary}</td>
                                <td className="px-4 py-2 text-sm text-right">
                                    <Link href={`/applications/${app.id}`} className="text-blue-600 hover:underline">
                                        View
                                    </Link>
                                </td>
                            </tr>
                        ))}
                        </tbody>
                    </table>
                </div>

        </div>
    );
}
