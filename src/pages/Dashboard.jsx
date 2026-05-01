import PageHeader from '../components/PageHeader';
import { BarChart, Bar, XAxis, YAxis, Tooltip, ResponsiveContainer, CartesianGrid } from 'recharts';

const data = [
  { group: 'O+', units: 150 },
  { group: 'O-', units: 5 },
  { group: 'A+', units: 80 },
  { group: 'A-', units: 30 },
  { group: 'B+', units: 45 },
  { group: 'B-', units: 20 },
  { group: 'AB+', units: 15 },
  { group: 'AB-', units: 10 },
];

const Dashboard = () => {
  return (
    <div>
      <PageHeader title="Dashboard Overview" subtitle="Welcome to the premium admin panel" />
      
      {/* Critical Alert */}
      <div className="critical-alert fade-in mb-4">
        <strong>⚠️ CRITICAL SHORTAGE:</strong> O- Negative blood inventory is severely low (5 units remaining). Please contact registered O- donors immediately.
      </div>

      <div className="stats-grid mb-4">
        <div className="stat-card">
          <div className="stat-icon drop-icon">🩸</div>
          <div className="stat-info">
            <h4>Total Donors</h4>
            <p>1,248</p>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon">🏥</div>
          <div className="stat-info">
            <h4>Hospitals</h4>
            <p>42</p>
          </div>
        </div>
        <div className="stat-card">
          <div className="stat-icon">📈</div>
          <div className="stat-info">
            <h4>Requests Today</h4>
            <p>15</p>
          </div>
        </div>
      </div>
      
      <div className="card mt-4">
        <h3 style={{ marginBottom: '1.5rem', color: 'var(--secondary)' }}>Current Blood Inventory</h3>
        <div style={{ width: '100%', height: 300 }}>
          <ResponsiveContainer>
            <BarChart data={data} margin={{ top: 10, right: 30, left: 0, bottom: 0 }}>
              <CartesianGrid strokeDasharray="3 3" opacity={0.2} />
              <XAxis dataKey="group" stroke="var(--secondary)" />
              <YAxis stroke="var(--secondary)" />
              <Tooltip 
                contentStyle={{ borderRadius: '10px', border: 'none', boxShadow: '0 4px 12px rgba(0,0,0,0.1)' }}
                cursor={{ fill: 'rgba(255, 71, 87, 0.05)' }}
              />
              <Bar dataKey="units" fill="var(--primary)" radius={[4, 4, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
