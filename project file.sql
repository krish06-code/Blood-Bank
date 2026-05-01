-- Hospital Table
CREATE TABLE hospital (
  hospital_id     NUMBER PRIMARY KEY,
  name            VARCHAR2(100),
  address         VARCHAR2(200),
  contact         VARCHAR2(15)
);

-- Donor Table
CREATE TABLE donor (
  donor_id        NUMBER PRIMARY KEY,
  name            VARCHAR2(100),
  blood_type      VARCHAR2(5),
  last_donation   DATE,
  contact         VARCHAR2(15),
  address         VARCHAR2(200),
  reward_points   NUMBER DEFAULT 0
);

-- Patient Table
CREATE TABLE patient (
  patient_id      NUMBER PRIMARY KEY,
  name            VARCHAR2(100),
  blood_type      VARCHAR2(5),
  diagnosis       VARCHAR2(200),
  contact         VARCHAR2(15),
  hospital_id     NUMBER,
  FOREIGN KEY (hospital_id) REFERENCES hospital(hospital_id)
);

-- Blood Inventory Table
CREATE TABLE blood_inventory (
  inventory_id    NUMBER PRIMARY KEY,
  blood_type      VARCHAR2(5),
  quantity        FLOAT,
  expiry_date     DATE,
  status          VARCHAR2(10)
);

-- Blood Donation Table
CREATE TABLE blood_donation (
  donation_id     NUMBER PRIMARY KEY,
  donor_id        NUMBER,
  donation_date   DATE,
  quantity        FLOAT,
  blood_type      VARCHAR2(5),
  status          VARCHAR2(10),
  inventory_id    NUMBER,
  FOREIGN KEY (donor_id) REFERENCES donor(donor_id),
  FOREIGN KEY (inventory_id) REFERENCES blood_inventory(inventory_id)
);

-- Donor Reward Table
CREATE TABLE donor_reward (
  reward_id       NUMBER PRIMARY KEY,
  donor_id        NUMBER,
  points          NUMBER,
  earned_date     DATE,
  reward_type     VARCHAR2(20),
  FOREIGN KEY (donor_id) REFERENCES donor(donor_id)
);

-- Blood Request Table
CREATE TABLE blood_request (
  request_id      NUMBER PRIMARY KEY,
  patient_id      NUMBER,
  inventory_id    NUMBER,
  request_date    DATE,
  quantity        FLOAT,
  status          VARCHAR2(10),
  FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
  FOREIGN KEY (inventory_id) REFERENCES blood_inventory(inventory_id)
);

-- Blood expiration trigger
CREATE OR REPLACE TRIGGER trg_blood_expiry_check
BEFORE UPDATE OR INSERT ON blood_inventory
FOR EACH ROW
BEGIN
  IF :NEW.expiry_date < SYSDATE AND :NEW.status = 'IN' THEN
    :NEW.status := 'EXPIRED';
  END IF;
END;
/

-- Audit trail for inventory changes
CREATE OR REPLACE TRIGGER trg_inventory_audit
AFTER UPDATE ON blood_inventory
FOR EACH ROW
DECLARE
  v_operation VARCHAR2(10);
BEGIN
  IF :OLD.quantity != :NEW.quantity THEN
    DBMS_OUTPUT.PUT_LINE('INVENTORY CHANGE: ' || :OLD.inventory_id || 
                         ' - Type: ' || :OLD.blood_type || 
                         ' - Old Qty: ' || :OLD.quantity || 
                         ' - New Qty: ' || :NEW.quantity);
  END IF;
END;
/

SELECT * FROM donor;
SELECT * FROM patient;
SELECT * FROM hospital;
SELECT * FROM blood_inventory;
SELECT * FROM blood_donation;
SELECT * FROM donor_reward;
SELECT * FROM blood_request;

-- Hospitals
INSERT INTO hospital VALUES (1, 'AIIMS Delhi', 'New Delhi', '01126588500');
INSERT INTO hospital VALUES (2, 'Lilavati Hospital', 'Mumbai', '02226568300');
INSERT INTO hospital VALUES (3, 'Fortis Hospital', 'Bangalore', '08066214444');
INSERT INTO hospital VALUES (4, 'KIMS Hospital', 'Hyderabad', '04044885000');
INSERT INTO hospital VALUES (5, 'Apollo Hospital', 'Chennai', '04428293333');
INSERT INTO hospital VALUES (6, 'Medanta Hospital', 'Gurgaon', '01244514141');
INSERT INTO hospital VALUES (7, 'CMC Hospital', 'Vellore', '04162280100');
INSERT INTO hospital VALUES (8, 'Nanavati Hospital', 'Mumbai', '02226267500');
INSERT INTO hospital VALUES (9, 'Max Hospital', 'Delhi', '01126515050');
INSERT INTO hospital VALUES (10, 'PGIMER Chandigarh', 'Chandigarh', '01722755223');

-- Donors
INSERT INTO donor VALUES (1, 'Alice Sharma', 'A+', TO_DATE('2025-01-10', 'YYYY-MM-DD'), '9876543210', 'Delhi', 10);
INSERT INTO donor VALUES (2, 'Raj Verma', 'B+', TO_DATE('2024-12-01', 'YYYY-MM-DD'), '9998887776', 'Mumbai', 20);
INSERT INTO donor VALUES (3, 'Rohan Mehta', 'O+', TO_DATE('2025-02-14', 'YYYY-MM-DD'), '9988776655', 'Gurgaon', 15);
INSERT INTO donor VALUES (4, 'Neha Kapoor', 'AB+', TO_DATE('2024-11-20', 'YYYY-MM-DD'), '9876543211', 'Bangalore', 25);
INSERT INTO donor VALUES (5, 'Imran Khan', 'B-', TO_DATE('2025-01-30', 'YYYY-MM-DD'), '9123456789', 'Hyderabad', 30);
INSERT INTO donor VALUES (6, 'Divya Iyer', 'O-', TO_DATE('2025-03-18', 'YYYY-MM-DD'), '9898989898', 'Chennai', 20);
INSERT INTO donor VALUES (11, 'Anil Deshmukh', 'A-', TO_DATE('2024-12-05', 'YYYY-MM-DD'), '9900112233', 'Pune', 10);
INSERT INTO donor VALUES (8, 'Simran Gill', 'B+', TO_DATE('2025-04-01', 'YYYY-MM-DD'), '9871234567', 'Ludhiana', 35);
INSERT INTO donor VALUES (9, 'Karthik Reddy', 'A+', TO_DATE('2025-01-25', 'YYYY-MM-DD'), '9845012345', 'Hyderabad', 5);
INSERT INTO donor VALUES (10, 'Pooja Jain', 'AB-', TO_DATE('2025-03-01', 'YYYY-MM-DD'), '9765432190', 'Jaipur', 40);

-- Patients
INSERT INTO patient VALUES (101, 'Ravi Gupta', 'A+', 'Anemia', '9112233445', 1);
INSERT INTO patient VALUES (102, 'Sneha Roy', 'B+', 'Surgery', '9223344556', 2);
INSERT INTO patient VALUES (103, 'Amit Bansal', 'O+', 'Thalassemia', '9112345670', 3);
INSERT INTO patient VALUES (104, 'Meera Joshi', 'AB+', 'Accident Trauma', '9223344567', 4);
INSERT INTO patient VALUES (105, 'Farhan Shaikh', 'B-', 'Liver Transplant', '9334455667', 5);
INSERT INTO patient VALUES (106, 'Kavita Pillai', 'O-', 'Leukemia', '9445566778', 6);
INSERT INTO patient VALUES (107, 'Vikram Rao', 'A-', 'Cancer Treatment', '9556677889', 7);
INSERT INTO patient VALUES (108, 'Ritu Jain', 'B+', 'Postpartum Bleeding', '9667788990', 8);
INSERT INTO patient VALUES (109, 'Sidharth Sen', 'A+', 'Road Accident', '9778899001', 9);
INSERT INTO patient VALUES (110, 'Tanya Das', 'AB-', 'Major Surgery', '9889900112', 10);

-- Blood Inventory
INSERT INTO blood_inventory VALUES (1001, 'A+', 1.0, TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1002, 'B+', 1.5, TO_DATE('2025-06-10', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1003, 'O+', 2.0, TO_DATE('2025-06-15', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1004, 'AB+', 1.2, TO_DATE('2025-06-20', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1005, 'B-', 1.0, TO_DATE('2025-06-05', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1006, 'O-', 1.5, TO_DATE('2025-06-12', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1007, 'A-', 1.1, TO_DATE('2025-06-18', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1008, 'B+', 0.9, TO_DATE('2025-06-22', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1009, 'A+', 1.3, TO_DATE('2025-06-25', 'YYYY-MM-DD'), 'IN');
INSERT INTO blood_inventory VALUES (1010, 'AB-', 0.7, TO_DATE('2025-06-30', 'YYYY-MM-DD'), 'IN');

--Blood Donation
INSERT INTO blood_donation VALUES (201, 1, TO_DATE('2025-01-10', 'YYYY-MM-DD'), 1.0, 'A+', 'Recorded', 1001);
INSERT INTO blood_donation VALUES (202, 2, TO_DATE('2024-12-01', 'YYYY-MM-DD'), 1.5, 'B+', 'Recorded', 1002);
INSERT INTO blood_donation VALUES (203, 3, TO_DATE('2025-02-14', 'YYYY-MM-DD'), 2.0, 'O+', 'Recorded', 1003);
INSERT INTO blood_donation VALUES (204, 4, TO_DATE('2024-11-20', 'YYYY-MM-DD'), 1.2, 'AB-', 'Recorded', 1004);
INSERT INTO blood_donation VALUES (205, 5, TO_DATE('2025-01-30', 'YYYY-MM-DD'), 1.0, 'A-', 'Recorded', 1005);
INSERT INTO blood_donation VALUES (206, 6, TO_DATE('2025-03-18', 'YYYY-MM-DD'), 1.5, 'B-', 'Recorded', 1006);
INSERT INTO blood_donation VALUES (207, 7, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 1.1, 'AB+', 'Recorded', 1007);
INSERT INTO blood_donation VALUES (208, 8, TO_DATE('2025-04-01', 'YYYY-MM-DD'), 0.9, 'O-', 'Recorded', 1008);
INSERT INTO blood_donation VALUES (209, 9, TO_DATE('2025-01-25', 'YYYY-MM-DD'), 1.3, 'A+', 'Recorded', 1009);
INSERT INTO blood_donation VALUES (210, 10, TO_DATE('2025-03-01', 'YYYY-MM-DD'), 0.7, 'B+', 'Recorded', 1010);

--Donor Reward
INSERT INTO donor_reward VALUES (301, 1, 20, TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Silver Badge');
INSERT INTO donor_reward VALUES (302, 2, 30, TO_DATE('2024-12-05', 'YYYY-MM-DD'), 'Gold Badge');
INSERT INTO donor_reward VALUES (303, 3, 15, TO_DATE('2025-02-20', 'YYYY-MM-DD'), 'Bronze Badge');
INSERT INTO donor_reward VALUES (304, 4, 25, TO_DATE('2024-11-25', 'YYYY-MM-DD'), 'Silver Badge');
INSERT INTO donor_reward VALUES (305, 5, 10, TO_DATE('2025-01-05', 'YYYY-MM-DD'), 'Bronze Badge');
INSERT INTO donor_reward VALUES (306, 6, 40, TO_DATE('2025-03-10', 'YYYY-MM-DD'), 'Gold Badge');
INSERT INTO donor_reward VALUES (307, 7, 35, TO_DATE('2025-02-10', 'YYYY-MM-DD'), 'Gold Badge');
INSERT INTO donor_reward VALUES (308, 8, 50, TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Platinum Badge');
INSERT INTO donor_reward VALUES (309, 9, 45, TO_DATE('2025-01-28', 'YYYY-MM-DD'), 'Gold Badge');
INSERT INTO donor_reward VALUES (310, 10, 60, TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Platinum Badge');

--Blood Request
INSERT INTO blood_request VALUES (401, 101, 1001, TO_DATE('2025-04-15', 'YYYY-MM-DD'), 1.0, 'Pending');
INSERT INTO blood_request VALUES (402, 102, 1002, TO_DATE('2025-04-17', 'YYYY-MM-DD'), 0.5, 'Pending');
INSERT INTO blood_request VALUES (403, 103, 1001, TO_DATE('2025-04-18', 'YYYY-MM-DD'), 1.0, 'Approved');
INSERT INTO blood_request VALUES (404, 104, 1003, TO_DATE('2025-04-20', 'YYYY-MM-DD'), 1.5, 'Pending');
INSERT INTO blood_request VALUES (405, 105, 1002, TO_DATE('2025-04-22', 'YYYY-MM-DD'), 0.75, 'Pending');
INSERT INTO blood_request VALUES (406, 106, 1001, TO_DATE('2025-04-23', 'YYYY-MM-DD'), 1.0, 'Approved');
INSERT INTO blood_request VALUES (407, 107, 1003, TO_DATE('2025-04-24', 'YYYY-MM-DD'), 1.0, 'Pending');
INSERT INTO blood_request VALUES (408, 108, 1002, TO_DATE('2025-04-25', 'YYYY-MM-DD'), 0.5, 'Approved');
INSERT INTO blood_request VALUES (409, 109, 1001, TO_DATE('2025-04-27', 'YYYY-MM-DD'), 1.0, 'Approved');
INSERT INTO blood_request VALUES (410, 110, 1003, TO_DATE('2025-04-28', 'YYYY-MM-DD'), 1.5, 'Pending');

-- 1. Insert Donor
CREATE OR REPLACE PROCEDURE insert_donor (
  p_id donor.donor_id%TYPE,
  p_name donor.name%TYPE,
  p_type donor.blood_type%TYPE,
  p_last donor.last_donation%TYPE,
  p_contact donor.contact%TYPE,
  p_address donor.address%TYPE
) AS
BEGIN
  INSERT INTO donor(donor_id, name, blood_type, last_donation, contact, address)
  VALUES (p_id, p_name, p_type, p_last, p_contact, p_address);
END;
/

-- 2. Insert Patient
CREATE OR REPLACE PROCEDURE insert_patient (
  p_id patient.patient_id%TYPE,
  p_name patient.name%TYPE,
  p_type patient.blood_type%TYPE,
  p_diag patient.diagnosis%TYPE,
  p_contact patient.contact%TYPE,
  p_hosp_id patient.hospital_id%TYPE
) AS
BEGIN
  INSERT INTO patient VALUES (p_id, p_name, p_type, p_diag, p_contact, p_hosp_id);
END;
/

-- 3. Record Blood Donation

CREATE SEQUENCE donor_reward_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE PROCEDURE add_donation (
  p_donation_id NUMBER,
  p_donor_id NUMBER,
  p_date DATE,
  p_quantity FLOAT,
  p_type VARCHAR2,
  p_inventory_id NUMBER
) AS
BEGIN
  INSERT INTO blood_inventory VALUES (p_inventory_id, p_type, p_quantity, p_date + 42, 'IN');
  INSERT INTO blood_donation VALUES (p_donation_id, p_donor_id, p_date, p_quantity, p_type, 'Recorded', p_inventory_id);
  UPDATE donor SET reward_points = reward_points + 10, last_donation = p_date WHERE donor_id = p_donor_id;
  INSERT INTO donor_reward VALUES (donor_reward_seq.NEXTVAL, p_donor_id, 10, SYSDATE, 'Donation');
END;
/

-- 4. Record Blood Request
CREATE OR REPLACE PROCEDURE request_blood (
  p_request_id   NUMBER,
  p_patient_id   NUMBER,
  p_inventory_id NUMBER,
  p_date         DATE,
  p_quantity     FLOAT
) AS
BEGIN
  INSERT INTO blood_request (request_id, patient_id, inventory_id, request_date, quantity, status)
  VALUES (p_request_id, p_patient_id, p_inventory_id, p_date, p_quantity, 'Requested');

  UPDATE blood_inventory
  SET quantity = quantity - p_quantity
  WHERE inventory_id = p_inventory_id;
END;
/


-- 5. Show All Donors
CREATE OR REPLACE PROCEDURE show_donors IS
BEGIN
  FOR r IN (SELECT * FROM donor ORDER BY name) LOOP
    DBMS_OUTPUT.PUT_LINE(r.donor_id || ' - ' || r.name || ' - ' || r.blood_type || ' - ' || r.reward_points);
  END LOOP;
END;
/

-- 6. Show Patients by Hospital
CREATE OR REPLACE PROCEDURE show_patients_by_hospital(p_hospital_id NUMBER) IS
BEGIN
  FOR r IN (
    SELECT name, diagnosis, blood_type FROM patient
    WHERE hospital_id = p_hospital_id
  ) LOOP
    DBMS_OUTPUT.PUT_LINE(r.name || ' | ' || r.blood_type || ' | ' || r.diagnosis);
  END LOOP;
END;
/

-- 7. Blood Inventory Summary
CREATE OR REPLACE PROCEDURE show_inventory_summary IS
BEGIN
  FOR rec IN (
    SELECT blood_type,
           SUM(quantity) AS total_units
    FROM blood_inventory
    WHERE status = 'IN'
    GROUP BY blood_type
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Group: ' || rec.blood_type || ' | Units: ' || rec.total_units);
  END LOOP;
END;
/

-- 8. Show Blood Requests
CREATE OR REPLACE PROCEDURE show_requests IS
BEGIN
  FOR r IN (
    SELECT br.request_id, p.name, bi.blood_type, br.quantity
    FROM blood_request br
    JOIN patient p ON br.patient_id = p.patient_id
    JOIN blood_inventory bi ON br.inventory_id = bi.inventory_id
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('Request: ' || r.request_id || ', Patient: ' || r.name || ', Type: ' || r.blood_type || ', Qty: ' || r.quantity);
  END LOOP;
END;
/

-- 9. Donor Rewards History
CREATE OR REPLACE PROCEDURE show_rewards(p_donor_id NUMBER) IS
BEGIN
  FOR r IN (SELECT * FROM donor_reward WHERE donor_id = p_donor_id) LOOP
    DBMS_OUTPUT.PUT_LINE('Earned on ' || r.earned_date || ': ' || r.points || ' points (' || r.reward_type || ')');
  END LOOP;
END;
/

--10. Donors by Blood Group
CREATE OR REPLACE PROCEDURE find_donors_by_blood_group(p_blood_group VARCHAR2) AS
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- Donors with Blood Type: ' || p_blood_group || ' ---');
  FOR donor_rec IN (
    SELECT donor_id, name, blood_type, last_donation, contact, address FROM donor
    WHERE blood_type = p_blood_group
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || donor_rec.donor_id || ', Name: ' || donor_rec.name ||
                         ', Last Donation: ' || TO_CHAR(donor_rec.last_donation, 'YYYY-MM-DD') ||
                         ', Contact: ' || donor_rec.contact || ', Address: ' || donor_rec.address);
  END LOOP;
END;
/

SET SERVEROUTPUT ON;

BEGIN
  DBMS_OUTPUT.PUT_LINE('--- BLOOD BANK MANAGEMENT SYSTEM MENU ---');
  DBMS_OUTPUT.PUT_LINE('1. Insert Donor                 - Add a new blood donor');
  DBMS_OUTPUT.PUT_LINE('2. Insert Patient               - Register a new patient');
  DBMS_OUTPUT.PUT_LINE('3. Add Blood Donation           - Record a blood donation from donor');
  DBMS_OUTPUT.PUT_LINE('4. Request Blood                - Create a new blood request for a patient');
  DBMS_OUTPUT.PUT_LINE('5. Show All Donors              - List all registered donors');
  DBMS_OUTPUT.PUT_LINE('6. Show Patients by Hospital    - List patients linked to a hospital');
  DBMS_OUTPUT.PUT_LINE('7. Show Inventory Summary       - View blood group-wise stock summary');
  DBMS_OUTPUT.PUT_LINE('8. Show All Requests            - Display all blood requests');
  DBMS_OUTPUT.PUT_LINE('9. Show Donor Reward History    - View rewards earned by a donor');
  DBMS_OUTPUT.PUT_LINE('10. Find Donors by Blood Group  - Display donors by selected blood type');
  DBMS_OUTPUT.PUT_LINE('0. Exit                         - Exit the program');
END;
/

DECLARE
  v_choice NUMBER := &choice;
  v_bg VARCHAR2(5);
BEGIN
  CASE v_choice
    WHEN 1 THEN insert_donor(7, 'Deepak Yadav', 'AB+', TO_DATE('2025-05-01', 'YYYY-MM-DD'), '9988123456', 'Delhi');
    WHEN 2 THEN insert_patient(104, 'Priya Sen', 'O-', 'Emergency', '9112345678', 1);
    WHEN 3 THEN add_donation(2015, 2, TO_DATE('2025-05-02', 'YYYY-MM-DD'), 0.5, 'B+', 1011);
    WHEN 4 THEN request_blood(3003, 107, 1007, TO_DATE('2025-05-03', 'YYYY-MM-DD'), 0.7);
    WHEN 5 THEN show_donors;
    WHEN 6 THEN show_patients_by_hospital(1);
    WHEN 7 THEN show_inventory_summary;
    WHEN 8 THEN show_requests;
    WHEN 9 THEN show_rewards(2);
    WHEN 10 THEN
      v_bg := '&blood_group';
      find_donors_by_blood_group(v_bg);
    WHEN 0 THEN DBMS_OUTPUT.PUT_LINE('Exiting...');
    ELSE DBMS_OUTPUT.PUT_LINE('Invalid choice!');
  END CASE;
END;
/