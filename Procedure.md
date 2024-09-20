# AL Procedures in Microsoft Dynamics 365 Business Central

This README provides an overview of commonly used AL procedures in Business Central, including examples of usage.

---

## Table of Contents
- [Non-modifiable Procedures](#non-modifiable-procedures)
- [Modifiable Procedures](#modifiable-procedures)
- [Custom Procedures](#custom-procedures)
- [Creating a Procedure](#creating-a-procedure)
- [Frequently Used AL Procedures](#frequently-used-al-procedures)
    - [MESSAGE Procedure](#message-procedure)
    - [ERROR Procedure](#error-procedure)
    - [CONFIRM Procedure](#confirm-procedure)
    - [STRMENU Procedure](#strmenu-procedure)
- [Record Procedures](#record-procedures)
    - [SETCURRENTKEY Procedure](#setcurrentkey-procedure)
    - [SETRANGE Procedure](#setrange-procedure)
    - [SETFILTER Procedure](#setfilter-procedure)
    - [GET Procedure](#get-procedure)
    - [FIND Procedures](#find-procedures)

---

## Non-modifiable Procedures
These are system-defined procedures in AL that cannot be changed. They are critical to core system functionality and are used throughout the application.

## Modifiable Procedures
These procedures allow developers to modify system behavior for custom business logic. You can adjust these using AL code in extensions.

## Custom Procedures
User-defined procedures are written by developers to encapsulate reusable business logic. These procedures are helpful in organizing code and reducing redundancy.

## Creating a Procedure
To create a custom procedure, use the following syntax:
```al
procedure MyProcedure()
// Code to execute
begin
    // Add logic here
end;
procedure CalculateTotalAmount(SalesLine: Record "Sales Line")
begin
    TotalAmount := SalesLine.Quantity * SalesLine."Unit Price";
    MESSAGE('The total amount is %1', TotalAmount);
end;
```

## Frequently Used AL Procedures
- MESSAGE Procedure
#### Displays a message dialog to the user.

- Syntax:
```al
Copy code
MESSAGE('Your message here.');
```
Example:

```al
Copy code
MESSAGE('Hello %1, welcome to Business Central!', UserName);
````
```al
ERROR Procedure
Used to throw an error and stop the execution of code.

Syntax:

al
Copy code
ERROR('Error message here.');
Example:
```
al
Copy code
ERROR('An unexpected error occurred: %1', ErrorDetails);
CONFIRM Procedure
Displays a confirmation dialog with Yes/No options.

Syntax:

al
Copy code
if CONFIRM('Your confirmation message?') then
    // Code to execute if Yes
else
    // Code to execute if No
Example:

```al
Copy code
if CONFIRM('Do you want to post this order?') then
    PostOrder;
else
    MESSAGE('Posting canceled.');
```
```al
STRMENU Procedure
Displays a menu with multiple options for the user to select.

Syntax:

```al
Copy code
Choice := STRMENU('Option 1, Option 2, Option 3', DefaultOption);
Example:
```
```al
Copy code
Choice := STRMENU('Edit, View, Delete', 1);
if Choice = 1 then
    MESSAGE('You selected Edit.');

```

# Record Procedures in Microsoft Dynamics 365 Business Central

This section provides an overview of commonly used record procedures in AL language, including examples of how to use them in Business Central.

---

## Table of Contents
- [SETCURRENTKEY Procedure](#setcurrentkey-procedure)
- [SETRANGE Procedure](#setrange-procedure)
- [SETFILTER Procedure](#setfilter-procedure)
- [GET Procedure](#get-procedure)
- [FIND Procedures](#find-procedures)

---

## SETCURRENTKEY Procedure
Specifies the key to be used for sorting records.

**Syntax:**
```al
Rec.SETCURRENTKEY(FieldName);
```

**Example:**
```al
SalesLine.SETCURRENTKEY("Document No.", "Line No.");
```

---

## SETRANGE Procedure
Filters records by specifying a range of values for a field.

**Syntax:**
```al
Rec.SETRANGE(FieldName, LowValue, HighValue);
```

**Example:**
```al
SalesLine.SETRANGE("Posting Date", StartDate, EndDate);
```

---

## SETFILTER Procedure
Applies a filter to a record based on a specified expression.

**Syntax:**
```al
Rec.SETFILTER(FieldName, FilterExpression, Values);
```

**Example:**
```al
SalesLine.SETFILTER("Quantity", '>=%1', 10);
```

---

## GET Procedure
Retrieves a record based on its primary key.

**Syntax:**
```al
IF Rec.GET(PrimaryKeyValue) THEN
    // Code to execute if the record is found
ELSE
    // Code to execute if the record is not found
```

**Example:**
```al
IF Customer.GET(CustomerNo) THEN
    MESSAGE('Customer %1 found', Customer."No.")
ELSE
    ERROR('Customer not found');
```

---

## FIND Procedures
These procedures are used to find records in the database. Below are the most frequently used FIND procedures:

### FINDSET
Retrieves a set of records, often used in loops.

**Syntax:**
```al
IF Rec.FINDSET THEN
    REPEAT
        // Code to execute for each record
    UNTIL Rec.NEXT = 0;
```

**Example:**
```al
IF SalesLine.FINDSET THEN
    REPEAT
        MESSAGE('Item: %1, Quantity: %2', SalesLine."No.", SalesLine.Quantity);
    UNTIL SalesLine.NEXT = 0;
```

### FINDFIRST
Finds the first record that matches the filters.

**Syntax:**
```al
IF Rec.FINDFIRST THEN
    // Code to execute if a record is found
```

**Example:**
```al
IF Customer.FINDFIRST THEN
    MESSAGE('First customer found: %1', Customer."No.");
```

### FINDLAST
Finds the last record that matches the filters.

**Syntax:**
```al
IF Rec.FINDLAST THEN
    // Code to execute if a record is found
```

**Example:**
```al
IF SalesOrderHeader.FINDLAST THEN
    MESSAGE('Last order found: %1', SalesOrderHeader."No.");
```

### FIND('-')
Finds the first record in descending order.

**Syntax:**
```al
IF Rec.FIND('-') THEN
    // Code to execute for the record found
```

**Example:**
```al
IF SalesOrderHeader.FIND('-') THEN
    MESSAGE('First record found in descending order: %1', SalesOrderHeader."No.");
```

---

## Conclusion

These record procedures are crucial for working with data in Business Central. They allow you to retrieve, filter, and sort records efficiently.

