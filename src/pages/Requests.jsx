import { useState } from 'react';
import PageHeader from '../components/PageHeader';
import ProcedureForm from '../components/ProcedureForm';
import OutputConsole from '../components/OutputConsole';

const Requests = () => {
  const [output, setOutput] = useState('');
  const [mockData, setMockData] = useState(null);

  const bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  const requestBloodFields = [
    { label: "Request ID", type: "number" },
    { label: "Patient ID", type: "number" },
    { label: "Inventory ID", type: "number" },
    { label: "Date", type: "date" },
    { label: "Volume (in liters)", type: "number" },
    { label: "Blood Group", type: "select", options: bloodGroups }
  ];

  const handleRequestBlood = (inputs) => {
    setOutput(`request_blood(${inputs[0]}, ${inputs[1]}, ${inputs[2]}, TO_DATE('${inputs[3]}', 'YYYY-MM-DD'), ${inputs[4]}, '${inputs[5]}');`);
    setMockData(null);
  };

  const handleShowAll = () => {
    setOutput(`show_all_requests();`);
    setMockData([
      { RequestID: 1001, PatientID: 101, BloodGroup: "O+", Volume: 2, Status: "Pending", Date: "2024-04-26" },
      { RequestID: 1002, PatientID: 102, BloodGroup: "AB-", Volume: 1, Status: "Fulfilled", Date: "2024-04-25" }
    ]);
  };

  return (
    <div>
      <PageHeader title="Blood Requests" subtitle="Process and view blood requests from patients" />
      
      <div className="procedures-grid">
        <ProcedureForm title="Request Blood" fields={requestBloodFields} onSubmit={handleRequestBlood} submitText="Submit Request" />
        <ProcedureForm title="Show All Requests" fields={[]} onSubmit={handleShowAll} submitText="View All" />
      </div>

      <OutputConsole output={output} mockData={mockData} />
    </div>
  );
};

export default Requests;
