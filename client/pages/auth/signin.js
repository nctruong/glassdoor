import {useState} from "react";
import useRequest from "../../hooks/use-request.js";
import Router from "next/router";

export default () => {
    const [email, setEmail] = useState('test@example.com')
    const [password, setPassword] = useState('Password123!')

    const { doRequest, errors } = useRequest({
        url: '/api/v1/auth/login',
        method: 'POST',
        body: {email, password},
        onSuccess: (data) => {
            console.log(`---data`, data);
            localStorage.setItem('token', data.jwt);
            Router.push('/')
        }
    })

    const onSubmit = async (e) => {
        e.preventDefault()
        await doRequest()
    }
    return <form onSubmit={onSubmit} className="max-w-md mx-auto bg-white p-8 rounded-2xl shadow-md space-y-6 mt-10">
        <h1 className="text-2xl font-semibold text-center text-gray-800">Sign In</h1>

        <div className="space-y-1">
            <label htmlFor="email" className="block text-sm font-medium text-gray-700">Email</label>
            <input
                value={email}
                onChange={e => setEmail(e.target.value)}
                id="email"
                type="email"
                placeholder="you@example.com"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>

        <div className="space-y-1">
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">Password</label>
            <input
                value={password}
                onChange={e => setPassword(e.target.value)}
                id="password"
                type="password"
                placeholder="Your password"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>

        {errors && (
            <div className="text-sm text-red-600">{errors}</div>
        )}

        <button
            type="submit"
            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-lg transition duration-150 cursor-pointer"
        >
            Sign In
        </button>
    </form>
}
