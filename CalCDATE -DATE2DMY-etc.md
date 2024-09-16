# All About the CalCDATE , DATE2Month, and DATE Objects in Businee Central 
### ref Posting Date of sale order as refrenced 

    ```

    actions
    {
        addafter("F&unctions")
        {
            action(CurrYear)
            {
                ApplicationArea = All;
                Caption = 'Get year & Week  ';
                Promoted = true;
                // PromotedOnly = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    GetCurrentYEar(Rec."Posting Date");

                end;
            }

        }
        // Add changes to page actions here

        addbefore(CurrYear)
        {
            action("Month Date")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category5;
                Caption = 'Month Date';
                trigger OnAction()
                begin
                    GetMonth(Rec."Posting Date");
                end;
            }
        }

        addbefore("Month Date")
        {
            action("Month Name")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category6;
                Caption = 'Month Name';

                trigger OnAction()
                begin
                    GetMonth_Name(Rec."Posting Date");
                end;

            }

        }
    }
    // task1
    local procedure GetCurrentYEar(GivenDate: Date)
    var
        ThisYearStartDate: Date;
        ThisYearEndDate: Date;
        ThisweekStarDate: Date;
        ThisweekEndDate: Date;
        PreviousWeekStartDate: Date;
        Month: Integer;
        YearMsg: Label 'This year: %1 ~ %2\This Week: %3 ~ %4';
        Monthmsg: Label 'month is: %5';

    begin
        ThisYearStartDate := CalcDate('<-CY>', GivenDate);
        ThisYearEndDate := CalcDate('CY', GivenDate);
        ThisweekStarDate := CalcDate('<-CW>', GivenDate);
        ThisweekEndDate := CalcDate('<CW>', GivenDate);


        Message(YearMsg, ThisYearStartDate, ThisYearEndDate, ThisweekStarDate, ThisweekEndDate);
    end;
    // Get MonthDate throgh the calcDate Formula .
    // Task2s
    local procedure GetMonth(GivenDate1: Date)
    var
        ThisMonthStartDate: Date;
        ThisMonthENdDate: Date;

        LastMonthStartDate: Date;
        LastMonthEndDate: Date;

        NextMonthStartDate: Date;
        NextmonthEndDate: Date;
        Month: Integer;
        monthmsg: Label 'This MonthDate : %1 ~ %2 \ LastMonth Date : %3 ~%4\Next Month: %5 ~%6';




    begin
        ThisMonthStartDate := CalcDate('<-CM>', GivenDate1);
        ThisMonthENdDate := CalcDate('<CM>', GivenDate1);

        LastMonthStartDate := CalcDate('<-CM-1M>', GivenDate1);
        LastMonthEndDate := CalcDate('<CM-1M>', GivenDate1);

        NextMonthStartDate := CalcDate('<-CM+1M>', GivenDate1);
        NextmonthEndDate := CalcDate('<CM+1M>', GivenDate1);


        Message(monthmsg, ThisMonthStartDate, ThisMonthENdDate, LastMonthStartDate, LastMonthEndDate, NextMonthStartDate, NextmonthEndDate);

    end;


    // get Day, Month , Year Based on the Date 
    local procedure GetMonth_Name(GivenDate1: Date)
    var
        Day: Integer;
        Month: Integer;
        Year: Integer;
        monthmsg: Label 'The Daye  of the given Date is :%1 \The month of the given date is: %2 \ The year of the Given Date is: %3';
    begin
        // Extract the month directly from the Posting Date
        Day := Date2DMY(GivenDate1, 1); // Extract Daye

        Month := Date2DMY(GivenDate1, 2); // 2 for extracting the month
        Year := Date2DMY(GivenDate1, 3);// Extract Year 

        // Show the extracted month in a message
        Message(monthmsg, Day, Month, Year);
    end;


}
```

