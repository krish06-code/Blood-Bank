const PageHeader = ({ title, subtitle }) => {
  return (
    <div className="page-header">
      <div>
        <h1>{title}</h1>
        {subtitle && <p className="subtitle">{subtitle}</p>}
      </div>
    </div>
  );
};

export default PageHeader;
