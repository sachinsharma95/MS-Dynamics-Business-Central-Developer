## Export Customer Ledger Entry Data in the CSV File

----
```al
codeunit 50506 "Export CSV Buffer Codeunit"
{
    Description = 'We are exporting the Customer ledger entry data to CSV format';
    procedure ExportCustLedgerEntries(var CustledgerRec: Record "Cust. Ledger Entry")
    var
        OutStream: OutStream;
        InStream: InStream;
        TempBlob: Codeunit "Temp Blob";
        CSVFileName: Text;
        Line: Text;
        FileName: Text;
    begin
        // Set the CSV file name
        CSVFileName := StrSubstNo('Customer_Ledger_Entries_%1_%2.csv', CurrentDateTime, UserId);

        // Create a temporary blob and get the output stream
        TempBlob.CreateOutStream(OutStream);

        // Write the header (column names) to the CSV file
        Line := CustledgerRec.FieldCaption("Entry No.") + ',' +
                CustledgerRec.FieldCaption("Posting Date") + ',' +
                CustledgerRec.FieldCaption("Document Type") + ',' +
                CustledgerRec.FieldCaption("Document No.") + ',' +
                CustledgerRec.FieldCaption("Customer No.") + ',' +
                CustledgerRec.FieldCaption("Customer Name") + ',' +
                CustledgerRec.FieldCaption(Description) + ',' +
                CustledgerRec.FieldCaption("Currency Code") + ',' +
                CustledgerRec.FieldCaption("Original Amount") + ',' +
                CustledgerRec.FieldCaption("Amount (LCY)") + ',' +
                CustledgerRec.FieldCaption("Bal. Account No.") + ',' +
                CustledgerRec.FieldCaption("Remaining Amount") + ',' +
                CustledgerRec.FieldCaption("Remaining Amt. (LCY)") + ',' +
                CustledgerRec.FieldCaption(Open);
        OutStream.WriteText(Line);

        // Write the data (rows) to the CSV file
        if CustledgerRec.FindSet() then
            repeat
                Line := Format(CustledgerRec."Entry No.") + ',' +
                        Format(CustledgerRec."Posting Date") + ',' +
                        Format(CustledgerRec."Document Type") + ',' +
                        Format(CustledgerRec."Document No.") + ',' +
                        Format(CustledgerRec."Customer No.") + ',' +
                        Format(CustledgerRec."Customer Name") + ',' +
                        Format(CustledgerRec.Description) + ',' +
                        Format(CustledgerRec."Currency Code") + ',' +
                        Format(CustledgerRec."Original Amount") + ',' +
                        Format(CustledgerRec."Amount (LCY)") + ',' +
                        Format(CustledgerRec."Bal. Account No.") + ',' +
                        Format(CustledgerRec."Remaining Amount") + ',' +
                        Format(CustledgerRec."Remaining Amt. (LCY)") + ',' +
                        Format(CustledgerRec.Open);
                OutStream.WriteText(Line);
            until CustledgerRec.Next() = 0;

        // Create an InStream from the TempBlob after writing is complete
        TempBlob.CreateInStream(InStream);

        // Download the CSV file
        DownloadFromStream(InStream, '', '', CSVFileName, FileName);
    end;
}
```
