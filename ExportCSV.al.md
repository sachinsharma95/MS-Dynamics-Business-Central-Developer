## Export Customer Ledger Entry Data in the CSV File
### It is By Using the Text Builder 

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
        FileName: Text;
        TextBuilder: TextBuilder;



    begin
        // Set the CSV file name
        FileName := 'TestFile' + UserId + '_' + Format(CurrentDateTime) + '.txt';

        TextBuilder.AppendLine('Entry No' + ',' + 'PostingDate' + ',' + 'Document Type' + ',' + 'Document No' + ',' + 'Customer No' + ',' + 'Customer Name' + ',' + 'Description' + ',' + 'Currency Code' + ',' + 'Original Amount');
        CustledgerRec.Reset();
        CustledgerRec.SetAutoCalcFields(Amount);

        if CustledgerRec.FindSet() then
            repeat

                TextBuilder.AppendLine(Format(CustledgerRec."Entry No.") + ',' + Format(CustledgerRec."Posting Date") + ',' + Format(CustledgerRec."Document Type") + ',' + CustledgerRec."Document No." + ',' + CustledgerRec."Customer No." + ',' + CustledgerRec."Customer Name" + ',' + CustledgerRec.Description + ',' + Format(CustledgerRec."Currency Code") + ',' + Format(CustledgerRec."Original Amount"));
            until CustledgerRec.Next() = 0;

        // Create a temporary blob and get the output stream
        TempBlob.CreateOutStream(OutStream);
        OutStream.WriteText(TextBuilder.ToText());
        TempBlob.CreateInStream(InStream);
        DownloadFromStream(InStream, '', '', '', FileName);



        // Download the CSV file
    end;
}

```
