import { useState } from 'react';
import toast from 'react-hot-toast';

const ProcedureForm = ({ title, fields, onSubmit, submitText = "Simulate Procedure" }) => {
  const [formValues, setFormValues] = useState({});

  const handleInputChange = (idx, value) => {
    setFormValues({
      ...formValues,
      [idx]: value
    });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    
    // Validation
    for (let i = 0; i < fields.length; i++) {
      const field = fields[i];
      const val = formValues[i];
      const { label, type = 'text' } = typeof field === 'string' ? { label: field } : field;
      
      if (!val) {
        toast.error(`Please fill out ${label}`);
        return;
      }

      if (type === 'number') {
        if (isNaN(val) || Number(val) < 0) {
          toast.error(`${label} must be a valid positive number.`);
          return;
        }
      }

      if (label.toLowerCase().includes('phone') && val.length < 10) {
        toast.error(`Phone number must be at least 10 digits.`);
        return;
      }

      if (type === 'date') {
        const selectedDate = new Date(val);
        if (selectedDate > new Date()) {
          toast.error(`${label} cannot be in the future.`);
          return;
        }
      }
    }

    const inputs = fields.map((field, idx) => formValues[idx] || '');
    onSubmit(inputs);
    toast.success(`${title} procedure generated successfully!`);
  };

  if (!fields || fields.length === 0) {
    return (
      <div className="card procedure-card">
        <h3>{title}</h3>
        <button onClick={() => { onSubmit([]); toast.success(`${title} query generated!`); }} className="glow-button">
          {submitText}
        </button>
      </div>
    );
  }

  return (
    <div className="card procedure-card">
      <h3>{title}</h3>
      <form onSubmit={handleSubmit} className="procedure-form">
        <div className="inputs-grid">
          {fields.map((field, idx) => {
            const { label, type = 'text', options = [] } = typeof field === 'string' ? { label: field } : field;
            
            return (
              <div className="input-group" key={idx}>
                {type === 'select' ? (
                  <select
                    value={formValues[idx] || ''}
                    onChange={(e) => handleInputChange(idx, e.target.value)}
                    className="modern-input"
                    required
                  >
                    <option value="" disabled>Select {label}</option>
                    {options.map((opt) => (
                      <option key={opt} value={opt}>{opt}</option>
                    ))}
                  </select>
                ) : (
                  <input
                    type={type}
                    placeholder={label}
                    value={formValues[idx] || ''}
                    onChange={(e) => handleInputChange(idx, e.target.value)}
                    className="modern-input"
                    required
                  />
                )}
              </div>
            );
          })}
        </div>
        <button type="submit" className="glow-button">
          {submitText}
        </button>
      </form>
    </div>
  );
};

export default ProcedureForm;
