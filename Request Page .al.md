Q. :
![image](https://github.com/user-attachments/assets/b15caa8f-84b2-4872-bc8d-c567f2c4164f)

	Report Page for File Import			
				
	Journal Template	User defined		
	Journal Batch Name	User defined		
				
		OK	Cancel	
				
	On clicking the OK BC will ask the user to select the file which user wants to import			
				
![image](https://github.com/user-attachments/assets/86480a24-57fd-49b1-aeb5-04baedc1fe77)

--------------------------------
----------------------------
O/P
```al
report 50550 "File Import Report"
{
    Caption = 'File Import Report';
    ProcessingOnly = true; // No dataset needed, only logic
    ApplicationArea = all;
    UsageCategory = ReportsAndAnalysis;

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Report Page for File Import")
                {
                    field("Journal Template"; GenJournalTemplate)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Select the Journal Template to be used.';
                        Editable = true;
                    }
                    field("Journal Batch Name"; GenJournalBatch)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Enter the name of the Journal Batch.';
                        Editable = true;
                    }
                }
            }
        }
    }

    trigger OnPostReport()
    var
        FileName: Text;
        InStream: InStream;
        Dialog: Dialog;
    begin
        // Open a file dialog to allow the user to select a file
        if UploadIntoStream('Select a file to import', '', '', FileName, InStream) then begin
            Message('You selected the file: %1', FileName);

            // Add your file processing logic here
            ProcessFile(InStream, GenJournalTemplate, GenJournalBatch);
        end else
            Error('No file was selected. The process has been canceled.');
    end;

    procedure ProcessFile(FileStream: InStream; TemplateCode: Code[10]; BatchName: Code[10])
    begin
        // Logic to process the file
        Message('Processing file for Template "%1" and Batch "%2".', TemplateCode, BatchName);
        // Add specific logic for parsing and handling the file contents
    end;

    var
        GenJournalTemplate: Code[10];
        GenJournalBatch: Code[10];
}
```
