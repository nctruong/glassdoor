import { useEffect } from 'react';
import Router from 'next/router';
import useRequest from '../../hooks/use-request';

export default () => {
  useEffect(() => {
    localStorage.removeItem('token');
    Router.push('/auth/signin');
  }, []);

  return <div>Signing you out...</div>;
};
