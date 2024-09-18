# Read the Data FROM Excel Buffer to BC.

#### SO Import Buffer Table.al
```al
table 50505 "SO Import Excel Buffer Table"
{
    DataClassification = ToBeClassified;
    Caption = 'SO Import Buffer';


    fields
    {
        field(1; "Batch Name"; Code[10])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = False;
        }
        field(3; "File Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Sheet Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Imported Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Imported Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Sell-to Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(8; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Currency code "; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;

        }
        field(11; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "External Document No."; Code[35])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Type; Enum "Sales Line Type")
        {
            DataClassification = ToBeClassified;
            Caption = 'Type';
        }
        field(14; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;

        }
        field(16; "Unit Price"; Decimal)
        {
            Caption = 'Unit Price';
            AutoFormatType = 2;
            AutoFormatExpression = 'Currency Code';
            DataClassification = CustomerContent;
        }



    }

    keys
    {
        key(Key1; "Batch Name", "Line No")
        {
            // Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
```
### Worksheet Page
```al
pageextension 50502 "Sale Order Extension" extends "Sales Order"
{
    PromotedActionCategories = ',,,Custom Button';
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            field("Pro Formal No."; Rec."Pro Formal No.")
            {
                ApplicationArea = all;
            }
            field("Provisional No."; Rec."Provisional No.")
            {
                ApplicationArea = all;
            }
            field("CIN No."; Rec."CIN No.")
            {
                ApplicationArea = all;
            }
            field("Total Amt"; Rec."Total Amt")
            {
                ApplicationArea = all;
            }
            field("Customer Amt"; Rec."Customer Amt")
            {
                ApplicationArea = all;
            }
            field("Payment Amt sum"; Rec."Payment Amt sum")
            {
                ApplicationArea = all;
            }
        }
    }

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
        addafter("Month Name")
        {
            action("Get Cutomer Amt")
            {
                ApplicationArea = all;
                Promoted = true;

                PromotedCategory = Category6;
                trigger OnAction()
                var

                    Customer_rec: Record Customer; // Taking data from the customer

                begin
                    Customer_rec.Reset();
                    Customer_rec.SetRange("No.", Rec."Sell-to Customer No.");// Applying fiter on the Customer
                    Customer_rec.SetFilter("Location Code", '<>EAST');

                    // Customer_rec.SetRange("Location Code", 'EAST'); // based on EAST Location code filter
                    if Customer_rec.FindFirst() then begin
                        Rec."Customer Amt" := Customer_rec."Credit Limit (LCY)";
                        Rec.Validate("Customer Amt", Customer_rec."Credit Limit (LCY)");
                    end;


                end;
            }
        }
        // Task Another Check Status of Pending of the CUstomer and Order Date 

        addafter("Get Cutomer Amt")
        {
            action("Check Status")
            {
                ApplicationArea = all;
                Promoted = true;

                // PromotedCategory = Category6;
                trigger OnAction()
                var
                    SaleHeaderREC: Record "Sales Header";
                begin
                    SaleHeaderREC.reset();
                    SaleHeaderREC.SetFilter(SaleHeaderREC.Status, 'Released');
                    if SaleHeaderREC.FindSet() then begin
                        // repeat
                        Message('The Cust Name of Pending Status is: %1  \ Order Date is : %2', SaleHeaderREC."Bill-to Name", SaleHeaderREC."Order Date");
                        // until SaleHeaderREC.Next() = 0;
                    end;
                end;
            }
        }
        //   SETFILTER TASK

        addafter("Check Status")
        {
            action("Filter Based on Credit Limit")
            {
                ApplicationArea = all;
                Promoted = true;
                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                begin
                    // Set a filter on Country and Credit Limit
                    CustomerRec.SETRANGE("Country/Region Code", 'US');
                    CustomerRec.SETFILTER("Credit Limit (LCY)", '>10000');

                    // Find and loop through the filtered customers
                    if CustomerRec.FINDFIRST then begin
                        repeat
                            Message('Customer No.: %1\ Name: %2\ Credit Limit: %3',
                                CustomerRec."No.", CustomerRec.Name, CustomerRec."Credit Limit (LCY)");
                        until CustomerRec.Next() = 0;
                    end else begin
                        Message('No customers found in US with Credit Limit greater than 10,000.');
                    end;
                end;


            }


        }


        // Modify Task Completed

        modify(Post)
        {
            trigger OnBeforeAction()

            begin
                if Rec."Customer Amt" = 0 then
                    Error('Customer AMt should bne grater than 0.');
            end;
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
        Format: Text;
        monthmsg: Label 'The Daye  of the given Date is :%1 \The month of the given date is: %2 \ The year of the Given Date is: %3\DATE IN TEXT:%4';
    begin
        // Extract the month directly from the Posting Date
        Day := Date2DMY(GivenDate1, 1); // Extract Daye

        Month := Date2DMY(GivenDate1, 2); // 2 for extracting the month
        Year := Date2DMY(GivenDate1, 3);// Extract Year 
        Format := FORMAT(GivenDate1, 1);

        // Show the extracted month in a message
        Message(monthmsg, Day, Month, Year, Format);
    end;
    //  Show Name from Sale header WHo Status Released
    // Onopen Page trigger 
    trigger OnOpenPage()
    var
        SaleHeaderREC: Record "Sales Header";

    begin
        // SaleHeaderREC.reset();
        // SaleHeaderREC.SetFilter(SaleHeaderREC.Status, 'Released');
        // if SaleHeaderREC.FindSet() then begin
        //     // repeat

        //     // until SaleHeaderREC.Next() = 0;
        // end;
        rec.SetFilter(Status, 'Released');
    end;
}

```

## Logic Explanation 
# AL Code: ReadExcelSheet Procedure

This AL (Application Language) code is used in Microsoft Dynamics 365 Business Central to read an Excel sheet and process its data.

## Code Breakdown

```al
local procedure ReadExcelSheet()
    var
        FileMgt: Codeunit "File Management";
        IStream: InStream;
        FromFile: Text[100];
local procedure ReadExcelSheet(): This defines a local procedure called ReadExcelSheet. A procedure is like a function that performs a specific task.
var: This defines variables that will be used in the procedure:
FileMgt: A variable of type Codeunit "File Management". It is used to manage file operations (like opening files).
IStream: This is of type InStream. It is a data stream that will be used to read data from the uploaded file.
FromFile: A text variable (maximum length of 100 characters) to store the name or path of the uploaded file.
al
Copy code
begin
    UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream):
This uploads an Excel file and stores it as a stream (IStream).
UploadExcelMsg is a message that is displayed to the user while selecting the file.
FromFile will store the file name (or path) of the uploaded file, and IStream will receive the file's content.
al
Copy code
    if FromFile <> '' then begin
if FromFile <> '' then: This checks if a file has been uploaded (i.e., if FromFile is not an empty string). If a file has been uploaded, the next steps are executed; otherwise, it throws an error.
al
Copy code
        FileName := FileMgt.GetFileName(FromFile);
        SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream);
FileName := FileMgt.GetFileName(FromFile):
This gets the name of the uploaded file using the File Management codeunit.
SheetName := TempExcelBuffer.SelectSheetsNameStream(IStream):
This selects the sheet name from the Excel file. It uses TempExcelBuffer (which is another codeunit or table related to Excel data) to read the sheet names from the uploaded file's data stream (IStream).
al
Copy code
    end else
        Error(NoFileFoundMsg);
else Error(NoFileFoundMsg): If no file is uploaded (i.e., FromFile is empty), it raises an error using NoFileFoundMsg, which is a predefined message like "No file found".
al
Copy code
    TempExcelBuffer.Reset();
    TempExcelBuffer.DeleteAll();
TempExcelBuffer.Reset(): Resets the TempExcelBuffer so that it can be used fresh, clearing any previous filters or temporary data.

TempExcelBuffer.DeleteAll(): Deletes all existing data in the TempExcelBuffer to ensure that it starts empty when new Excel data is read.

al
Copy code
    TempExcelBuffer.OpenBookStream(IStream, SheetName);
TempExcelBuffer.OpenBookStream(IStream, SheetName):
This opens the Excel workbook stream (IStream) and selects the specified sheet (SheetName) for reading.
al
Copy code
    TempExcelBuffer.ReadSheet();
end;
TempExcelBuffer.ReadSheet(): Reads the data from the selected Excel sheet into the TempExcelBuffer. This allows further processing of the data, such as using it in the Business Central system.
Summary:
This code is designed to upload an Excel file, select a sheet, and read the data from that sheet into a buffer (TempExcelBuffer). It performs the following steps:

Uploads an Excel file.
Verifies if the file is uploaded.
Gets the file name and selects a sheet from the file.
Clears any previous data from the buffer.
Opens the sheet and reads the data from it.
