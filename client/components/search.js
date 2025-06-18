const Search = ({onSearch}) => {
    return (
        <div className="relative w-full">
            <svg
                className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
            >
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-4.35-4.35M16.5 10.5a6 6 0 11-12 0 6 6 0 0112 0z" />
            </svg>

            <input
                onKeyDown={(e) => {
                    if (e.key === 'Enter') {
                        onSearch(e.target.value);
                    }
                }}
                type="text"
                placeholder="Search..."
                className="w-full pl-10 pr-4 py-2 bg-white rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>
    )
}

export default Search
