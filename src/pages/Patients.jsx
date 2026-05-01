import { useState } from 'react';
import PageHeader from '../components/PageHeader';
import ProcedureForm from '../components/ProcedureForm';
import OutputConsole from '../components/OutputConsole';

const Patients = () => {
  const [output, setOutput] = useState('');
  const [mockData, setMockData] = useState(null);

  const bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];

  const insertPatientFields = [
    { label: "Patient ID", type: "number" },
    { label: "Name", type: "text" },
    { label: "Blood Group", type: "select", options: bloodGroups },
    { label: "Diagnosis", type: "text" },
    { label: "Phone", type: "text" },
    { label: "Hospital ID", type: "number" }
  ];

  const showByHospitalFields = [
    { label: "Hospital ID", type: "number" }
  ];

  const handleInsertPatient = (inputs) => {
    setOutput(`insert_patient(${inputs[0]}, '${inputs[1]}', '${inputs[2]}', '${inputs[3]}', '${inputs[4]}', ${inputs[5]});`);
    setMockData(null);
  };

  const handleShowByHospital = (inputs) => {
    setOutput(`show_patients_by_hospital(${inputs[0]});`);
    setMockData([
      { PatientID: 101, Name: "Eve Adams", BloodGroup: "O+", Diagnosis: "Surgery", HospitalID: inputs[0] },
      { PatientID: 102, Name: "Frank Castle", BloodGroup: "AB-", Diagnosis: "Trauma", HospitalID: inputs[0] }
    ]);
  };

  return (
    <div>
      <PageHeader title="Patient Records" subtitle="Manage patients and hospital affiliations" />
      
      <div className="procedures-grid">
        <ProcedureForm title="Insert Patient" fields={insertPatientFields} onSubmit={handleInsertPatient} />
        <ProcedureForm title="Show Patients by Hospital" fields={showByHospitalFields} onSubmit={handleShowByHospital} submitText="Show Patients" />
      </div>

      <OutputConsole output={output} mockData={mockData} />
    </div>
  );
};

export default Patients;
