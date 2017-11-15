CREATE EXTENSION "uuid-ossp";

CREATE TABLE product (
  id uuid NOT NULL,
  lookupcode character varying(32) NOT NULL DEFAULT(''),
  quantity int NOT NULL DEFAULT(0),
  price int NOT NULL DEFAULT(0),
  active boolean NOT NULL DEFAULT(false),
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT product_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_product_lookupcode
  ON product
  USING btree
  (lower(lookupcode::text) COLLATE pg_catalog."default");

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 100
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode1'
     , 125
     , current_timestamp
);

INSERT INTO product VALUES (
       uuid_generate_v4()
     , 'lookupcode3'
     , 150
     , current_timestamp
);

CREATE TABLE employee (
  id uuid NOT NULL,
  employeeid character varying(32) NOT NULL DEFAULT(''),
  firstname character varying(128) NOT NULL DEFAULT(''),
  lastname character varying(128) NOT NULL DEFAULT(''),
  password character varying(512) NOT NULL DEFAULT(''),
  active boolean NOT NULL DEFAULT(FALSE),
  classification int NOT NULL DEFAULT(0),
  managerid uuid NOT NULL,
  createdon timestamp without time zone NOT NULL DEFAULT now(),
  CONSTRAINT employee_pkey PRIMARY KEY (id)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_employee_employeeid
  ON employee
  USING hash(employeeid);

CREATE TABLE Transaction (
  id uuid NOT NULL,
  RecordId character varying(32) NOT NULL DEFAULT(''),
  CashierId character varying(32) NOT NULL DEFAULT(''),
  TransactionTotal int NOT NULL DEFAULT(0),
  TransactionType character(6), CHECK((TransactionType='sale') OR (TransactionType='return')),
  ReferenceId int NOT NULL DEFAULT(0),
  CreatedOn Date
) WITH (
  OIDS=FALSE
);
 
CREATE INDEX ix_Transaction_RecordId
  ON Transaction
  USING hash(RecordId);
  
CREATE TABLE TransactionEntry (
  id uuid NOT NULL,
  ItemName character varying(32) NOT NULL DEFAULT(''),
  Amount int NOT NULL DEFAULT(0),
  Price int NOT NULL DEFAULT(0)
) WITH (
  OIDS=FALSE
);

CREATE INDEX ix_TransactionEntry_ItemName
  ON Transaction
  USING hast(ItemName);
