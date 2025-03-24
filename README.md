# virtuoso-nosql-bridge
A Stored Procedure that allows users to query a non-SQL RDBMS via ODBC

**JDBC Drivers can be utilized in combination with OpenLink Software's ODBC-JDBC Bridge ([Free Trial](https://shop.openlinksw.com/license_generator/uda-download/#))**

# Instructions

## Connect an ODBC DSN to Virtuoso Using
```
vd_remote_data_source('{DSN Name}', null, '{Username}', '{Password}');
vdd_disconnect_data_source('{DSN Name}');
```
#### Example using the OpenLink Software ODBC-JDBC Bridge + Neo4j JDBC Driver
```
vd_remote_data_source('Neo4j Aura', null, 'neo4j', '12345');
vdd_disconnect_data_source('Neo4j Aura');
```

## Run A Test Query
Run a Test Query Using
```
nosql_query(dsn, query);
```
#### Cypher Query Example using the OpenLink Software ODBC-JDBC Bridge + Neo4j JDBC Driver
```
nosql_query('Neo4j Aura', 'MATCH (p:Person) LIMIT 10;');
```
> Note: Make sure to escape single quotes in a query using `\'`.


## Querying with Modifiable Result Sets

In order to use the result set with a SELECT query, use a derived table:

```
SELECT {Columns}
FROM nosql_query(dsn, query)({column 1} {datatype}, ... )
WHERE dsn = '{DSN Name}' AND query='{Query Text}'
```

#### Cypher Query Example using the OpenLink ODBC-JDBC Bridge + Neo4j JDBC Driver
```
SELECT
  x.name,
  x.age 
FROM
  nosql_query(dsn, query)(name VARCHAR, age INTEGER) x
WHERE
  dsn = 'Neo4j Aura2' AND query = 'MATCH (p:People) RETURN p.name, p.age';
```
