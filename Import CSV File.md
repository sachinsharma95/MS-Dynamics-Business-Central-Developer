# Import CSV File in BC without XML Port


## CSV Table.al

```al
table 50506 "Import CSV File"
{
    DataClassification = ToBeClassified;
    Caption = 'Import CSV File';


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
## Step2 Create Worksheet Page
```al
page 50605 "So Import Excel Worksheet Page"
{
    AutoSplitKey = true;
    PageType = Worksheet;
    ApplicationArea = All;
    Caption = 'So Import Worksheet';
    DelayedInsert = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    SaveValues = true;
    UsageCategory = Tasks;
    SourceTable = "SO Import Excel Buffer Table";
    SourceTableView = sorting("Batch Name", "Line No");

    layout
    {
        area(Content)
        {
            field(BatchName; BatchName)
            {
                ApplicationArea = all;
                Caption = 'BatchName';
            }
            repeater(Group)
            {
                Editable = false;
                field("Batch Name"; REC."Batch Name")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = all;
                    Visible = False;
                }
                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = all;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Currency code"; Rec."Currency code ")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }

                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = all;
                }
                field("Sheet Name"; Rec."Sheet Name")
                {
                    ApplicationArea = all;
                }
                field("Imported Date"; Rec."Imported Date")
                {
                    ApplicationArea = all;
                }
                field("Imported Time"; Rec."Imported Time")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

   
}


```
## Step 3 Create 3 Procdureres and call then on Actions
```al
 actions
    {
        area(Processing)
        {
            action("&Import")
            {
                ApplicationArea = All;
                Caption = '&Import';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Importing the Data from Excel';

                trigger OnAction()
                var
                begin
                    if BatchName = '' then
                        Error(BatchIsBlankmsg);
                    ReadExcelsheet();
                    ImportExcelData();




                end;
            }
        }
    }

    var
        BatchName: Code[10];
        FileName: Text[100];
        SheetName: Text[100];
        TempExcelBuffer: Record "Excel Buffer" temporary;
        UploadExcelmsg: Label 'Please choose Excel file';
        NoFileFoundmsg: Label 'No Excel File Found !';
        BatchIsBlankmsg: Label 'Batch Name is Blank';
        ExcelImportSuccess: Label 'Excel Successfully Imported';

    // Read CSV Sheet Procedure
    local procedure ReadExcelsheet()
    var
        Filemgt: Codeunit "File Management";
        Istream: InStream;
        FromFile: Text[100];
    begin
        UploadIntoStream(UploadExcelMsg, '', '', FromFile, IStream);
        if FromFile <> '' then begin
            FileName := Filemgt.GetFileName(FromFile);
            SheetName := TempExcelBuffer.SelectSheetsNameStream(Istream)

        end else
            Error(NoFileFoundmsg);
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.OpenBookStream(Istream, SheetName);
        TempExcelBuffer.ReadSheet();


    end;
    // import CSV DATA 
    local procedure ImportExcelData()
    var
        SOImportBuffer: Record "SO Import Excel Buffer Table";
        RowNo: Integer;
        ColNo: Integer;
        LineNo: Integer;
        MaxRowNo: Integer;
    begin
        RowNo := 0;
        ColNo := 0;
        MaxRowNo := 0;
        LineNo := 0;
        SOImportBuffer.Reset();
        if SOImportBuffer.FindLast() then
            LineNo := SOImportBuffer."Line No";
        TempExcelBuffer.Reset();
        if TempExcelBuffer.FindLast() then begin
            MaxRowNo := TempExcelBuffer."Row No.";
        end;

        for RowNo := 2 to MaxRowNo do begin  // From Row 2 Because Row for Header 
            LineNo := LineNo + 10000;
            SOImportBuffer.Init();
            Evaluate(SOImportBuffer."Batch Name", BatchName);
            SOImportBuffer."Line No" := LineNo;
            Evaluate(SOImportBuffer."Document No", GetValueAtCell(RowNo, 1));
            Evaluate(SOImportBuffer."Sell-to Customer No.", GetValueAtCell(RowNo, 2));
            Evaluate(SOImportBuffer."Posting Date", GetValueAtCell(RowNo, 3));
            Evaluate(SOImportBuffer."Currency code ", GetValueAtCell(RowNo, 4));
            Evaluate(SOImportBuffer."Document Date", GetValueAtCell(RowNo, 5));
            Evaluate(SOImportBuffer."External Document No.", GetValueAtCell(RowNo, 6));
            Evaluate(SOImportBuffer.Type, GetValueAtCell(RowNo, 7));
            Evaluate(SOImportBuffer."No.", GetValueAtCell(RowNo, 8));
            Evaluate(SOImportBuffer.Quantity, GetValueAtCell(RowNo, 9));
            Evaluate(SOImportBuffer."Unit Price", GetValueAtCell(RowNo, 10));
            SOImportBuffer."Sheet Name" := SheetName;
            SOImportBuffer."File Name" := FileName;
            SOImportBuffer."Imported Date" := Today;
            SOImportBuffer."Imported Time" := Time;
            SOImportBuffer.Insert();
        end;
        Message(ExcelImportSuccess);
    end;
//This Procdedure to get the value
    local procedure GetValueAtCell(RowNo: Integer; ColNo: Integer): Text
    begin

        TempExcelBuffer.Reset();
        If TempExcelBuffer.Get(RowNo, ColNo) then
            exit(TempExcelBuffer."Cell Value as Text")
        else
            exit('');
    end;

```
