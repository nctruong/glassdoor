import Link from "next/link.js";
import {usePathname} from 'next/navigation'
import clsx from 'clsx'

const SideBar = ({currentUser}) => {
    const pathname = usePathname()

    const navItems = [
        {label: 'Dashboard', href: '/'},
        {label: 'Job Applications', href: '/job_applications'},
        {label: 'Jobs', href: '/jobs'},
    ]

    return (
        <aside className="w-64 bg-white shadow-md p-5 hidden md:block">
            <h2 className="text-xl font-bold mb-6">Admin</h2>
            <nav className="space-y-3">
                {navItems.map(({ label, href }) => (
                    <Link
                        key={href}
                        href={href}
                        className={clsx(
                            'block px-2 py-1 rounded-md font-medium',
                            pathname === href
                                ? 'bg-blue-100 text-blue-700'
                                : 'text-gray-600 hover:text-blue-500'
                        )}
                    >
                        {label}
                    </Link>
                ))}
            </nav>
        </aside>
    )
}

export default SideBar;

