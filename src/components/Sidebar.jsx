import { Link, useLocation } from 'react-router-dom';
import { Home, Users, HeartPulse, Droplets, Activity } from 'lucide-react';

const Sidebar = () => {
  const location = useLocation();

  const links = [
    { name: 'Dashboard', path: '/', icon: <Home size={20} /> },
    { name: 'Donors', path: '/donors', icon: <Users size={20} /> },
    { name: 'Patients', path: '/patients', icon: <HeartPulse size={20} /> },
    { name: 'Donations', path: '/donations', icon: <Droplets size={20} /> },
    { name: 'Requests', path: '/requests', icon: <Activity size={20} /> },
  ];

  return (
    <div className="sidebar">
      <div className="sidebar-header">
        <span className="drop-icon">🩸</span>
        <h2>Blood Bank</h2>
      </div>
      <nav className="sidebar-nav">
        {links.map((link) => (
          <Link
            key={link.path}
            to={link.path}
            className={`nav-link ${location.pathname === link.path ? 'active' : ''}`}
          >
            {link.icon}
            <span>{link.name}</span>
          </Link>
        ))}
      </nav>
      <div className="sidebar-footer">
        <p>Premium Admin</p>
      </div>
    </div>
  );
};

export default Sidebar;
