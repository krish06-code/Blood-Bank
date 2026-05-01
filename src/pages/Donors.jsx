import { useState } from 'react';
import PageHeader from '../components/PageHeader';
import ProcedureForm from '../components/ProcedureForm';
import OutputConsole from '../components/OutputConsole';

const Donors = () => {
  const [output, setOutput] = useState('');
  const [mockData, setMockData] = useState(null);

  const bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  const insertDonorFields = [
    { label: "Donor ID", type: "number" },
    { label: "Name", type: "text" },
    { label: "Blood Group", type: "select", options: bloodGroups },
    { label: "Last Donation Date", type: "date" },
    { label: "Phone", type: "text" },
    { label: "City", type: "text" }
  ];
  
  const findDonorsFields = [
    { label: "Blood Group", type: "select", options: bloodGroups }
  ];
  
  const rewardHistoryFields = [
    { label: "Donor ID", type: "number" }
  ];

  const handleInsertDonor = (inputs) => {
    setOutput(`insert_donor(${inputs[0]}, '${inputs[1]}', '${inputs[2]}', TO_DATE('${inputs[3]}', 'YYYY-MM-DD'), '${inputs[4]}', '${inputs[5]}');`);
    setMockData(null);
  };

  const handleFindDonors = (inputs) => {
    setOutput(`find_donors_by_blood_group('${inputs[0]}');`);
    setMockData([
      { ID: 104, Name: "John Doe", BloodGroup: inputs[0], LastDonation: "2023-11-01", Phone: "555-0100", City: "New York" },
      { ID: 215, Name: "Jane Smith", BloodGroup: inputs[0], LastDonation: "2024-01-15", Phone: "555-0199", City: "Boston" }
    ]);
  };

  const handleRewardHistory = (inputs) => {
    setOutput(`show_donor_reward_history(${inputs[0]});`);
    setMockData([
      { RewardID: 1, DonorID: inputs[0], PointsEarned: 50, Date: "2023-11-01" },
      { RewardID: 2, DonorID: inputs[0], PointsEarned: 50, Date: "2024-01-15" }
    ]);
  };

  const handleShowAll = () => {
    setOutput(`show_all_donors();`);
    setMockData([
      { ID: 1, Name: "Alice Brown", BloodGroup: "O+", LastDonation: "2024-02-10", Phone: "555-1111", City: "Chicago" },
      { ID: 2, Name: "Bob White", BloodGroup: "A-", LastDonation: "2023-08-22", Phone: "555-2222", City: "Miami" },
      { ID: 3, Name: "Charlie Green", BloodGroup: "AB+", LastDonation: "2024-03-01", Phone: "555-3333", City: "Seattle" },
      { ID: 4, Name: "Diana Prince", BloodGroup: "O-", LastDonation: "2024-04-12", Phone: "555-4444", City: "Austin" }
    ]);
  };

  return (
    <div>
      <PageHeader title="Donor Management" subtitle="Manage and query blood donors" />
      
      <div className="procedures-grid">
        <ProcedureForm title="Insert Donor" fields={insertDonorFields} onSubmit={handleInsertDonor} />
        <ProcedureForm title="Find Donors by Blood Group" fields={findDonorsFields} onSubmit={handleFindDonors} submitText="Find Donors" />
        <ProcedureForm title="Donor Reward History" fields={rewardHistoryFields} onSubmit={handleRewardHistory} submitText="Show History" />
        <ProcedureForm title="Show All Donors" fields={[]} onSubmit={handleShowAll} submitText="Generate Command" />
      </div>

      <OutputConsole output={output} mockData={mockData} />
    </div>
  );
};

export default Donors;
