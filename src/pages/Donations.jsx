import { useState } from 'react';
import PageHeader from '../components/PageHeader';
import ProcedureForm from '../components/ProcedureForm';
import OutputConsole from '../components/OutputConsole';

const Donations = () => {
  const [output, setOutput] = useState('');
  const [mockData, setMockData] = useState(null);

  const bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  const addDonationFields = [
    { label: "Donation ID", type: "number" },
    { label: "Donor ID", type: "number" },
    { label: "Date", type: "date" },
    { label: "Volume (in liters)", type: "number" },
    { label: "Blood Group", type: "select", options: bloodGroups },
    { label: "Inventory ID", type: "number" }
  ];

  const handleAddDonation = (inputs) => {
    setOutput(`add_donation(${inputs[0]}, ${inputs[1]}, TO_DATE('${inputs[2]}', 'YYYY-MM-DD'), ${inputs[3]}, '${inputs[4]}', ${inputs[5]});`);
    setMockData(null);
  };

  const handleInventorySummary = () => {
    setOutput(`show_inventory_summary();`);
    setMockData([
      { BloodGroup: "O+", TotalUnits: 150, Status: "Healthy" },
      { BloodGroup: "O-", TotalUnits: 5, Status: "Critical Shortage" },
      { BloodGroup: "A+", TotalUnits: 80, Status: "Healthy" },
      { BloodGroup: "B+", TotalUnits: 45, Status: "Low" }
    ]);
  };

  return (
    <div>
      <PageHeader title="Blood Donations" subtitle="Record new donations and view inventory summary" />
      
      <div className="procedures-grid">
        <ProcedureForm title="Add Blood Donation" fields={addDonationFields} onSubmit={handleAddDonation} submitText="Record Donation" />
        <ProcedureForm title="Show Inventory Summary" fields={[]} onSubmit={handleInventorySummary} submitText="Show Summary" />
      </div>

      <OutputConsole output={output} mockData={mockData} />
    </div>
  );
};

export default Donations;
