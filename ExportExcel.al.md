## Exporting the Customer Ledger Entries data in Excel File.

#### Step 1 Create the action in the STD Custome Ledger Entires. by Page Extnesion.

```al
pageextension 50709 "Export Customer led to Excel" extends "Customer Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("F&unctions")
        {
            action("ExportToExcel")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction()
// Call the Fucntion from the codeunit.
                var
                    ExportExcelCodeunit: Codeunit "Export excel Buffer Codeunit";
                begin
                    ExportExcelCodeunit.ExportCustLedgerEntries(Rec);

                end;
            }

        }
        // Add changes to page actions here
    }

    local procedure ExportCustomeledger_Excel()
    var
        CustomLedgerRec: Record "Cust. Ledger Entry";
        TempExcelBuffer: Record "Excel Buffer" temporary;
        CustomeLedgerLabel: Label 'Custom Ledger Entries';
        ExcelFilename: Label 'Customer LadgerEntries %1_%2';


    begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        // 
        TempExcelBuffer.NewRow();



    end;
}
```

## Export the Excel Login Using the Excel Buffer .

```al

codeunit 50505 "Export excel Buffer Codeunit"
{
    procedure ExportCustLedgerEntries(var CustledgerRec: Record "Cust. Ledger Entry")
    var
        TemplExcelBuffer: Record "Excel Buffer" temporary;
        CUstLabel: Label 'Customer ledger entries';
        ExcelFileName: Label 'Customer Ledger Entries_%1_%2';

    begin
        TemplExcelBuffer.Reset();
        TemplExcelBuffer.DeleteAll();
        TemplExcelBuffer.NewRow();

        // Now we will give caption to the excel file( Give the heading to the field of Excel)
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Entry No."), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Posting Date"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Document Type"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Document No."), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Customer No."), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Customer Name"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption(Description), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Currency Code"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Original Amount"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Amount (LCY)"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Bal. Account No."), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Remaining Amount"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption("Remaining Amt. (LCY)"), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);
        TemplExcelBuffer.AddColumn(CustledgerRec.FieldCaption(Open), false, '', true, false, false, '', TemplExcelBuffer."Cell Type"::Text);

        if CustledgerRec.FindSet() then
            repeat
                TemplExcelBuffer.NewRow(); // will create new row

                // Now we will adding value to respective column
                TemplExcelBuffer.AddColumn(CustledgerRec."Entry No.", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Posting Date", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Document Type", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Document No.", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Customer No.", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Customer Name", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec.Description, false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Currency Code", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Original Amount", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Amount (LCY)", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Bal. Account No.", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Remaining Amount", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec."Remaining Amt. (LCY)", false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
                TemplExcelBuffer.AddColumn(CustledgerRec.Open, false, '', false, false, false, '', TemplExcelBuffer."Cell Type"::Text);
            until CustledgerRec.Next() = 0;

        TemplExcelBuffer.CreateNewBook(CUstLabel);
        TemplExcelBuffer.WriteSheet(CUstLabel, CompanyName, UserId);
        TemplExcelBuffer.CloseBook();
        TemplExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TemplExcelBuffer.OpenExcel();
    end;
}
```
