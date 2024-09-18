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
