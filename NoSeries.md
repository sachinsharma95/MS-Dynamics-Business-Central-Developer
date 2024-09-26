 ## No SERIES GENERATION.

#### Steps:
-------
Step1 Ceate a Field in Purchase & Payable by page extension.
```al
pageextension 50510 "No Series" extends "Purchases & Payables Setup"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posted Invoice Nos.")
        {
            field("PurchaseEntry No."; Rec.PurchaseEntryNo)
            {
                ApplicationArea = all;
            }

        }
    }
}
```
----
#### Step 2

Make Table and Pages (list).
Make field ENtry No 
```al
table 50509 "Purchase order No Series "
{
    DataClassification = ToBeClassified;
    Caption = 'No Series Purchase Order';


    fields
    {
        field(1; "Entry No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Entry No';


        }

        field(2; "First Name"; Text[30])
        {
            DataClassification = ToBeClassified;

        }
        field(3; "Last Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Salary; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Status; Text[20])
        {
            DataClassification = ToBeClassified;

        }
        field(7; Password; Text[20])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }
    var
        PurchSetup: Record "Purchases & Payables Setup";

    procedure GenerateNoSeries(): Code[20]
    var
        PurchSetup: Record "Purchases & Payables Setup";

    begin
        PurchSetup.Get();
        PurchSetup.TestField(PurchaseEntryNo);
        exit(PurchSetup.PurchaseEntryNo);


    end;


    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GetNoseries: Codeunit "Purchase order No Series";
    begin
        PurchSetup.Get();
        PurchSetup.TestField(PurchaseEntryNo);
        if "Entry No" = '' then begin
            NoSeriesMgt.InitSeries(GetNoseries.GenerateNoSeries(), '', Today, "Entry No", PurchSetup.PurchaseEntryNo);
        end;

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
## PAesg 

```al
page 50607 "Purchase order No Series"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Purchase Order No Series';
    SourceTable = "Purchase order No Series ";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = all;
                    Editable = false;

                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;

                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    var
                        Mypassword: Codeunit "Purchase order No Series";
                    begin

                        Rec.Password := Mypassword.Genratepassword(Rec."First Name", Rec."Last Name", Rec.City);
                    end;
                }
                field(Salary; Rec.Salary)
                {
                    ApplicationArea = all;
                    trigger OnValidate()
                    begin
                        if Rec.Salary > 10000 then
                            Rec.Status := 'Sufficient'
                        else
                            Rec.Status := 'Insufficient';
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                    // trigger OnValidate()
                    // begin
                    //     if Rec.Salary > 10000 then
                    //         rec.Status := 'Sufficient';
                    // end;
                }
                field(Password; Rec.Password)
                {
                    ApplicationArea = All;
                    // Password =true;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate password")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}
```
## Logics::
```al
  var
        PurchSetup: Record "Purchases & Payables Setup";

    procedure GenerateNoSeries(): Code[20]
    var
        PurchSetup: Record "Purchases & Payables Setup";

    begin
        PurchSetup.Get();
        PurchSetup.TestField(PurchaseEntryNo);
        exit(PurchSetup.PurchaseEntryNo);


    end;


    trigger OnInsert()
    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GetNoseries: Codeunit "Purchase order No Series";
    begin
        PurchSetup.Get();
        PurchSetup.TestField(PurchaseEntryNo);
        if "Entry No" = '' then begin
            NoSeriesMgt.InitSeries(GetNoseries.GenerateNoSeries(), '', Today, "Entry No", PurchSetup.PurchaseEntryNo);
        end;

    end;
```
## testField : Tests that the content of the field is not zero or blank (empty string).


111
