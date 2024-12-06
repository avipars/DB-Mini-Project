Views: Your design is a general account of your database’s universe. In effect this
is a union of sub-criteria identified by a subset of users who specified them. To achieve
completeness in the practical sense, SQL provides views, which are kind of virtual tables. A
view has rows and columns because the database creates a real table for it. A view is created
by rendering subsets of records from selected fields in multiple tables of the database. A
CREATE VIEW statement is similar to CREATE TABLE, and record manipulation (additions,
deletions or updates) affect the original tables they draw records from. Under the hood, the
initial SELECT that created the view opens an implicit cursor that points to the respective
records in the base tables.
The WITH CHECK OPTION clause is very handy in that respect. It is applicable only
to updatable views, and deployed when the database needs to restrict the manipulation of
rows in the view where conditions governed by the WHERE clause of CREATE VIEW cannot
be satisfied.