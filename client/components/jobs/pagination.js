import Link from "next/link.js";

function Pagination({totalPages, currentPage, pageSize}) {
    return (
        <div className="flex justify-center mt-5 space-x-1">
            {Array.from({ length: totalPages }, (_, i) => (
                <Link
                    key={i}
                    href={`/?page=${i + 1}&pageSize=${pageSize}`}
                    className={`px-2 py-1 text-sm rounded border ${
                        currentPage === i + 1
                            ? 'bg-blue-600 text-white border-blue-600'
                            : 'text-blue-600 border-blue-300 hover:bg-blue-100'
                    } transition`}
                >
                    {i + 1}
                </Link>
            ))}
        </div>
    )
}

export default Pagination;
