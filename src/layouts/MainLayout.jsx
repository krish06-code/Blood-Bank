import { Outlet } from 'react-router-dom';
import Sidebar from '../components/Sidebar';

const MainLayout = () => {
  return (
    <div className="app-wrapper">
      <div className="background-shapes">
        <div className="shape shape-1"></div>
        <div className="shape shape-2"></div>
        <div className="shape shape-3"></div>
      </div>
      
      <div className="dashboard-container glass-container">
        <Sidebar />
        <main className="main-content-area">
          <Outlet />
        </main>
      </div>
    </div>
  );
};

export default MainLayout;
