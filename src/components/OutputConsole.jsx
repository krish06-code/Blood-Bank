import { useEffect, useRef } from 'react';

const OutputConsole = ({ output, mockData }) => {
  const consoleRef = useRef(null);

  useEffect(() => {
    if (output && consoleRef.current) {
      consoleRef.current.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  }, [output, mockData]);

  if (!output) return null;

  return (
    <div className="output-section glass-panel fade-in mt-4" ref={consoleRef}>
      <h3>Generated PL/SQL Call</h3>
      <div className="code-block">
        <code>{output}</code>
      </div>

      {mockData && mockData.length > 0 && (
        <div className="mock-data-table mt-4">
          <h3 style={{ color: 'var(--secondary)', marginBottom: '1rem' }}>Query Results (Mock Data)</h3>
          <div className="table-responsive">
            <table className="modern-table">
              <thead>
                <tr>
                  {Object.keys(mockData[0]).map((key) => (
                    <th key={key}>{key}</th>
                  ))}
                </tr>
              </thead>
              <tbody>
                {mockData.map((row, idx) => (
                  <tr key={idx}>
                    {Object.values(row).map((val, i) => (
                      <td key={i}>{val}</td>
                    ))}
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
};

export default OutputConsole;
