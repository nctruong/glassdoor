import Link from 'next/link';
import auth from "../services/authService";
import {useEffect, useState} from "react";

const Header = ({currentUser}) => {
    const [signedIn, setSignIn] = useState(false);
    const [links, setLinks] = useState([]);

    useEffect(() => {
        setSignIn(auth.isLoggedIn)
    })

    useEffect(() => {
        setLinks([
            !signedIn && {label: 'Sign Up', href: '/auth/signup'},
            !signedIn && {label: 'Sign In', href: '/auth/signin'},
            {label: 'Jobs', href: '/'},
            {label: 'Jobs Applications', href: '/job_applications/'},
            {label: 'Users', href: '/users/'}
        ]
            .filter((linkConfig) => linkConfig)
            .map(({label, href}) => {
                return (
                    <li key={href}
                        className="text-gray-900 inline-flex items-center px-1 pt-1 text-sm font-medium hover:text-indigo-600">
                        <Link href={href} style={{'margin-left': '15px'}}>
                            {label}
                        </Link>
                    </li>
                );
            }))
    }, [signedIn]);

    return (

        <nav className="bg-white border-b border-gray-200 shadow-md">
            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div className="flex justify-between h-16">
                    <div className="flexspace-x-5">
                        <div className="flex flex-col items-left">
                            <span className="text-xl font-bold text-indigo-600"><h1><Link href="/">Glassdoor-Demo</Link></h1></span>
                            <span className="text-xl font-bold text-gray"><Link
                                className="navbar-brand ml-5" href="https://www.linkedin.com/in/willnguyendotdev/"
                                style={{marginLeft: 15 + 'px'}}>
                                <small>Will Nguyen.</small>
                            </Link>
                            </span>
                        </div>
                    </div>
                    <ul className="flex space-x-5">
                        {links}

                        {signedIn && (
                        <li
                            className="text-gray-900 inline-flex items-center px-1 pt-1 text-sm font-medium hover:text-indigo-600">
                            <Link href='/auth/signout' style={{'margin-left': '15px'}}>
                                Sign out
                            </Link>
                        </li>
                        )}
                    </ul>
                </div>
            </div>
        </nav>
    );
};

export default Header
