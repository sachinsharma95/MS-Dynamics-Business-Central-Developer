

# Date Functions in Microsoft Dynamics 365 Business Central (BC)

This repository contains a list of commonly used date-related functions in AL (Application Language) for Microsoft Dynamics 365 Business Central. These functions are essential for handling and manipulating dates within the Business Central environment.

## List of Date Functions

### 1. **Date2DMY (Date, Part)**
   Extracts the day, month, or year from a `Date` field.
   - **Parameters**:
     - `Date`: The date to extract from.
     - `Part`: Determines which part to extract (1 = Day, 2 = Month, 3 = Year).
   - **Example**:
     ```al
     Day := Date2DMY(SomeDate, 1);
     ```

### 2. **DMY2Date (Day, Month, Year)**
   Combines a day, month, and year into a single date.
   - **Parameters**:
     - `Day`: The day part.
     - `Month`: The month part.
     - `Year`: The year part.
   - **Example**:
     ```al
     MyDate := DMY2Date(10, 12, 2024);
     ```

### 3. **CALCDATE (DateFormula, Date)**
   Calculates a new date based on a date formula.
   - **Parameters**:
     - `DateFormula`: A date formula like `+1Y` (1 year), `+1D` (1 day), etc.
     - `Date`: The starting date.
   - **Example**:
     ```al
     NextYear := CalcDate('+1Y', TODAY);
     ```

### 4. **TODAY**
   Returns the current date (system date).
   - **Example**:
     ```al
     CurrentDate := TODAY;
     ```

### 5. **WORKDATE**
   Returns the current work date.
   - **Example**:
     ```al
     CurrentWorkDate := WORKDATE;
     ```

### 6. **CLOSINGDATE (Date)**
   Converts a date into a closing date, typically used in accounting periods.
   - **Example**:
     ```al
     CloseDate := CLOSINGDATE('2024-12-31');
     ```

### 7. **NORMALDATE (ClosingDate)**
   Converts a closing date into a regular date.
   - **Example**:
     ```al
     NormalDate := NORMALDATE(SomeClosingDate);
     ```

### 8. **DATE2DWY (Date, Part)**
   Extracts the day, week, or year from a date.
   - **Parameters**:
     - `Part`: 1 for Day of the Week, 2 for Week Number, 3 for Year.
   - **Example**:
     ```al
     Week := DATE2DWY(SomeDate, 2);
     ```

### 9. **DATE2GMT (Date, Time, TimeZone)**
   Converts a local date and time to GMT (UTC).
   - **Parameters**:
     - `Date`: The local date.
     - `Time`: The local time.
     - `TimeZone`: The time zone.
   - **Example**:
     ```al
     GMTDate := DATE2GMT(TODAY, TIME, 0);
     ```

### 10. **TIME**
   Returns the current time (system time).
   - **Example**:
     ```al
     CurrentTime := TIME;
     ```

### 11. **CALCFIELDS (FieldName)**
   Calculates the date fields in a record (commonly used with flow fields).
   - **Example**:
     ```al
     Rec.CALCFIELDS("Posting Date");
     ```

### 12. **GETRANGESTART**
   Returns the start date of a date range.
   - **Example**:
     ```al
     StartDate := GETRANGESTART(SomeDateField);
     ```

### 13. **GETRANGEEND**
   Returns the end date of a date range.
   - **Example**:
     ```al
     EndDate := GETRANGEEND(SomeDateField);
     ```

### 14. **FORMAT (Expression [, Length])**
   Converts a date to a string format.
   - **Example**:
     ```al
     FormattedDate := FORMAT(TODAY, 0);
     ```

### 15. **DATE2DATETIME (Date, Time)**
   Converts a date and time into a `DateTime` value.
   - **Example**:
     ```al
     DateTime := DATE2DATETIME(TODAY, TIME);
     ```

### 16. **DATETIME2DATE (DateTime)**
   Extracts the date portion from a `DateTime` value.
   - **Example**:
     ```al
     Date := DATETIME2DATE(SomeDateTime);
     ```

### 17. **DATETIME2TIME (DateTime)**
   Extracts the time portion from a `DateTime` value.
   - **Example**:
     ```al
     Time := DATETIME2TIME(SomeDateTime);
     ```

### 18. **DATEADD (Date, DeltaDays)**
   Adds a specific number of days to a date.
   - **Example**:
     ```al
     FutureDate := DATEADD(TODAY, 5); // Adds 5 days
     ```

### 19. **DATEDIFF (Date1, Date2)**
   Calculates the difference between two dates in days.
   - **Example**:
     ```al
     Difference := DATEDIFF(TODAY, SomePastDate);
     ```

### 20. **INCSTR (String, Increment)**
   Increments a date in string format.
   - **Example**:
     ```al
     NewDate := INCSTR(OldDate, 1); // Used for date strings
     ```

---

## License

This repository is open-source and available for public use under the [MIT License](LICENSE).

Feel free to contribute by submitting issues or pull requests.
