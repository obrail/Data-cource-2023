
-- Creating the location table
CREATE TABLE location (
  location_id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  city VARCHAR(50),
  state VARCHAR(50),
  zip_code VARCHAR(10)
);

-- Creating the people table
CREATE TABLE people (
  person_id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  email VARCHAR(255),
  phone VARCHAR(20),
  location_id INTEGER REFERENCES location(location_id)
);



INSERT INTO location (address, city, state, zip_code) VALUES ('123 Main St', 'Anytown', 'CA', '12345');

INSERT INTO people (first_name, last_name, email, phone, location_id) VALUES ('John', 'Doe', 'johndoe@example.com', '555-1234', 1);

select * from "location" 
select * from people  




CREATE TABLE PEOPLES_AUDIT_LOG (
  id INTEGER NOT NULL,
  old_row_data JSONB,
  new_row_data JSONB,
  dml_timestamp TIMESTAMP NOT NULL DEFAULT NOW(),
  dml_type VARCHAR(20) NOT NULL
);

CREATE UNIQUE INDEX PEOPLES_AUDIT_LOG_IDX ON PEOPLES_AUDIT_LOG (id, dml_type, dml_timestamp);

CREATE OR REPLACE FUNCTION log_people_changes()
RETURNS TRIGGER AS $$
BEGIN
  IF (TG_OP = 'DELETE') THEN
    RAISE EXCEPTION 'Delete operation is not permitted';
  ELSIF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
    INSERT INTO PEOPLES_AUDIT_LOG (id, old_row_data, new_row_data, dml_type)
    VALUES (NEW.person_id, to_jsonb(OLD), to_jsonb(NEW), TG_OP[1]);
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER people_audit_log_trigger
AFTER INSERT OR UPDATE OR DELETE
ON people
FOR EACH ROW
EXECUTE FUNCTION log_people_changes();

select * from peoples_audit_log 
select * from 

INSERT INTO location (address, city, state, zip_code) VALUES ('123 Stefan Cel Mare', 'Chisinau', 'MD', '12345');
INSERT INTO people  (first_name, last_name, email, phone, location_id) VALUES ('Mary', 'Dock', 'jmarydock@example.com', '444-1234', 2);

