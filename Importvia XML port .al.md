## Create table and Pages and xmlport file .

 #### step 1 Table 
```al
table 50610 "Imported Data"
{
    DataClassification = ToBeClassified;
    Caption = 'TableToImportData';

    fields
    {
        field(1; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Item No")
        {
            Clustered = true;
        }
    }
}

```
Step 2  cretae Pages and Action Import 
```al
page 50510 "Imported Data List"
{
    PageType = List;
    ApplicationArea = All;
    Caption = 'ImportviaXMLport';
    UsageCategory = Administration;

    sourceTable = "Imported Data";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Name"; Rec."Name") { }
                field("Amount"; Rec.Amount) { }
                field("Description"; Rec.Description) { }
                field("Item No"; Rec."Item No") { }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportData)
            {
                Caption = 'Import Data';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Xmlport.Run(50611, false, true);
                end;
            }
        }
    }
}
```

## Step # very Import XML File
```al
xmlport 50611 "CSV Import XMLPort"
{
    Format = VariableText;
    Direction = Import;
    // UseRequestPage = false;
    schema
    {
        textelement(Root)
        {
            tableelement(ImportData; "Imported Data")
            {
                XmlName = 'ImportedDAta';


                fieldelement(Name; ImportData."Name") { }
                fieldelement(Amount; ImportData."Amount")
                {


                }
                fieldelement(Description; ImportData."Description") { }
                fieldelement(ItemNo; ImportData."Item No") { }
                trigger OnAfterInitRecord()
                begin
                    if IsFirstline then begin
                        IsFirstline := false;
                        currXMLport.Skip();
                    end;
                end;
            }
        }





    }
    trigger OnPreXmlPort()
    begin
        IsFirstline := true;
    end;

    var
        IsFirstline: Boolean;
}
```
### Logicd to Skip Header !
```al
- add afteer the field element and in the root?
see XML code aboce from last line
```
### Step 4 codeunit to Upload the data 

```al
CodeUnit Logics

codeunit 50611 "CSV Import Handler"
{
    procedure ImportCSV()
    var
        FileName: Text;
        InStream: InStream;
        FileManagement: Codeunit "File Management";
    begin
        if UploadIntoStream('Select a file to import', '', 'CSV File (*.csv)|*.csv', FileName, InStream) then begin
            XMLPORT.IMPORT(50611, InStream);
            Message('Data imported successfully from %1.', FileName);
        end else
            Message('Import canceled.');
    end;
}
```
