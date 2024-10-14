## The `CalculateDays` procedure is designed to find the total number of days, working days (Monday to Friday), and non-working days (weekends) between two dates. Here’s a breakdown of how it works in a simpler way:

### 1. **Variables Initialization**
- `TotalDays`: Keeps track of the total number of days between the two dates.
- `WorkingDays`: Counts only the days that are Monday to Friday (working days).
- `NonWorkingDays`: Counts the weekend days (Saturday and Sunday).

### 2. **Loop Through Dates**
- **Starting from the first date** (`StartDate`), the program checks each day one by one until it reaches the **end date** (`EndDate`).
- For each day:
  - **TotalDays** is increased by 1.
  - The program checks what day of the week it is using the `Date2DWY` function:
    - If the day is **Monday to Friday** (any day except Saturday or Sunday), it adds 1 to the **WorkingDays** counter.
    - If the day is **Saturday or Sunday**, it adds 1 to the **NonWorkingDays** counter.
  
- After processing each day, it moves to the **next day**.

### 3. **Stop the Loop**
- The loop keeps running until the current date is beyond the **EndDate**.

### 4. **Display Results**
- When the loop finishes, it displays a message showing:
  - Total number of days.
  - Total number of working days (Monday-Friday).
  - Total number of non-working days (weekends).

### Code Walkthrough in Simple Terms

```al
page 50715 "Calc Working & Non-Working Day"
{
    PageType = Card;
    ApplicationArea = All;
    Caption = 'Working & Non Working Day';
    UsageCategory = Administration;
    SourceTable = "Working Day Table";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = all;
                    Caption = 'Start Date';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Caption = 'End Date';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Working & Non-Working Day")
            {
                ApplicationArea = all;
                Image = DateRange;
                trigger OnAction()
                var
                    StartDate: Date;
                    EndDate: Date;
                    CurrentDate: Date;
                    TotalDays: Integer;
                    WorkingDays: Integer;
                    NonWorkingDays: Integer;
                begin
                    TotalDays := 0;
                    WorkingDays := 0;
                    NonWorkingDays := 0;
                    StartDate := rec.StartDate;
                    EndDate := rec."End Date";

                    CurrentDate := StartDate;
                    // Loop through each day from StartDate to EndDate
                    repeat
                        TotalDays += 1;  // Increment total days

                        // Check if it's a weekday (Mon-Fri)
                        if not (Date2DWY(CurrentDate, 1) in [1, 7]) then
                            WorkingDays += 1  // If it's Mon-Fri, increment working days
                        else
                            NonWorkingDays += 1;  // If it's Sat or Sun, increment non-working days

                        // Move to the next day
                        CurrentDate := CurrentDate + 1;
                    until CurrentDate > EndDate;

                    // Display the result
                    Message('Total Days: %1, Working Days: %2, Non-Working Days: %3', TotalDays, WorkingDays, NonWorkingDays);

                end;


            }
        }
    }
}
```
### Key Points:
- **TotalDays** counts every day between the start and end.
- **WorkingDays** counts only Monday to Friday.
- **NonWorkingDays** counts weekends.

