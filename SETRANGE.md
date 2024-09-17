# Dynamics 365 Business Central: Filtering and Record Retrieval Methods



# SETRANGE, SETFILTER, FINDFIRST, FINDSET, FINDENEXT

## 1. SETRANGE
- **Description**: `SETRANGE` is used to set a filter on a field for a specific range of values or an exact match.
- **Usage**: It’s simpler than `SETFILTER` when dealing with exact values or ranges.
- **Syntax**:
  ```al
  Rec.SETRANGE(Field, Value); // Exact match
  Rec.SETRANGE(Field, FromValue, ToValue); // Range of values
  ```
### Fethcing the data from Customer table to sale header where Location code = EAST , using the SETRANGE function.
```al
var

                    Customer_rec: Record Customer; // Taking data from the customer so we are makign the record var of Customer 

                begin
                    Customer_rec.Reset(); // Reseting the predefined filters
                    Customer_rec.SetRange("No.", Rec."Sell-to Customer No.");// Applying fiter on the Customer  not based on PK
                     Customer_rec.SetRange("Location Code", 'EAST'); // based on EAST Location code filter
                    if Customer_rec.FindFirst() then begin
                        Rec."Customer Amt" := Customer_rec."Credit Limit (LCY)";
                        Rec.Validate("Customer Amt", Customer_rec."Credit Limit (LCY)");// Using the validation its choice 
                    end;


                end;
```
## SETFILTER 
- **Description**: SETFILTER is more flexible than SETRANGE, allowing complex filtering, including wildcards, ranges, and logical operations.
- **Usage**: Use it for inequality, partial matches, or combined conditions.
Syntax:
```al
Copy code
Rec.SETFILTER(Field, 'Condition', Value);
```
# EXample not Equalt to EAST CODE
```al
var

                    Customer_rec: Record Customer; // Taking data from the customer

                begin
                    Customer_rec.Reset();
                    Customer_rec.SetRange("No.", Rec."Sell-to Customer No.");// Applying fiter on the Customer
                    Customer_rec.SetFilter("Location Code", '<>EAST');Not Equal to EAST.

                    if Customer_rec.FindFirst() then begin
                        Rec."Customer Amt" := Customer_rec."Credit Limit (LCY)";
                        Rec.Validate("Customer Amt", Customer_rec."Credit Limit (LCY)");
                    end;
                end;

```
# 3. FINDSET
Description: FINDSET retrieves multiple records that meet the current filter and is used when you want to loop through a result set.
Usage: It is the most efficient way to retrieve a set of records when you need to iterate over them.
Syntax:
al
```Copy code
if Rec.FINDSET([ForUpdate]) then begin
    repeat
        // Process record
    until Rec.NEXT = 0;
end;
Example: Loop through all customers in a specific country
al
Copy code
if CustomerRec.FINDSET then begin
    repeat
        // Process each customer
    until CustomerRec.NEXT = 0;
end;
```
# 4. FINDNEXT
- **Description**: FINDNEXT is used to move to the next record in a set after using FINDSET or FINDFIRST.
Usage: It is called inside loops to continue fetching records.
Syntax:
```al
Copy code
Rec.FINDNEXT;
Example:
al
Copy code
if Rec.FINDSET then begin
    repeat
        // Process each record
    until Rec.FINDNEXT = 0;
end;
```
# 5. FINDFIRST
- **Description:** FINDFIRST retrieves the first record that matches the current filters. It does not loop through records.
- **Usage**: Use this when you only need the first matching record.
```
Syntax:
al
Copy code
if Rec.FINDFIRST then begin
    // Process first record
end;
Example: Get the first customer in the database
al
Copy code
if CustomerRec.FINDFIRST then begin
    // Process first customer
end;
```
## Summary Table for SETRANGE, SETFILTER, FINDSET, FINDNEXT, and FINDFIRST

| **Method**   | **Use Case**                                 | **Returns Multiple Records?** | **Example Use**                          |
|--------------|----------------------------------------------|------------------------------|------------------------------------------|
| **SETRANGE** | Exact value or range filtering               | No                           | `SETRANGE("Country Code", 'US')`         |
| **SETFILTER**| Complex conditions (wildcards, inequality)   | No                           | `SETFILTER("Name", '*Bike*')`            |
| **FINDSET**  | Loop through multiple records                | Yes                          | Loop through customers in a region       |
| **FINDNEXT** | Move to the next record in a set (within loop)| Yes (in loop)                | Retrieve next record in a set            |
| **FINDFIRST**| Fetch the first record that matches filters  | No                           | Get the first customer                   |
