import {useState} from 'react'
import Router from 'next/router'
import useRequest from '../../hooks/use-request'

export default () => {
    const [email, setEmail] = useState('test@example.com');
    const [password, setPassword] = useState('1234')

    const {doRequest, errors} = useRequest({
        url: '/api/users/signup',
        method: 'post',
        body: {email, password},
        onSuccess: async () => {
            console.log("Redirecting...");
            await Router.push('/')
        }
    })

    const onSubmit = async (e) => {
        console.log("Submitting...");
        e.preventDefault()
        await doRequest()
    }

    return <form
        onSubmit={onSubmit}
        className="max-w-md mx-auto mt-10 p-6 bg-white rounded-2xl shadow-md space-y-6"
    >
        <h1 className="text-2xl font-bold text-center text-gray-800">Sign Up</h1>

        <div className="space-y-1">
            <label htmlFor="email" className="block text-sm font-medium text-gray-700">
                Email
            </label>
            <input
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                id="email"
                type="email"
                placeholder="you@example.com"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>

        <div className="space-y-1">
            <label htmlFor="password" className="block text-sm font-medium text-gray-700">
                Password
            </label>
            <input
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                id="password"
                type="password"
                placeholder="••••••••"
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            />
        </div>

        {errors && <div className="text-red-500 text-sm">{errors}</div>}

        <button
            type="submit"
            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-xl transition duration-200"
        >
            Sign Up
        </button>
    </form>
}
