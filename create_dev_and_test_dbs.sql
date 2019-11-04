CREATE ROLE pentosapi WITH LOGIN PASSWORD 'pentosapi'  CREATEDB;

CREATE DATABASE pentosapi_development;
CREATE DATABASE pentosapi_test;

GRANT ALL PRIVILEGES ON DATABASE "pentosapi_development" to pentosapi;
GRANT ALL PRIVILEGES ON DATABASE "pentosapi_test" to pentosapi;
