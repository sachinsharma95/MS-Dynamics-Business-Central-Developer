# Action in Business Central 
- **Action Properties**

  ```al
  page 50708 "Action Page"
  {
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Table";
    Caption = 'Action Practice Page';
    PromotedActionCategories = ',,,Custom,,Sachin';
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                part("Employeepart"; "Employee page")
                {
                    ApplicationArea = all;
                }
            }
            group(List)
            {
                part("DepartmentPage"; "Department Page")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    actions
    {
      // area(Processing)
        // {
        //     action("Display Message")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Message';
        //         Image = Apply;
        //         trigger OnAction()
        //         begin
        //             Message('Display action working');
        //         end;
        //     }
        //     action("Button1 ")
        //     {
        //         ApplicationArea = all;
        //         trigger OnAction()
        //         begin
        //             Message('Button1 Working');
        //         end;
        //     }
        // }
        area(Navigation)
        {
            action("nav Message")
            {
                ApplicationArea = All;
                Caption = 'Message';
                ShortcutKey = 'ctrl+O';
                Promoted = true;
                PromotedCategory = Category4;
                trigger OnAction()
                begin
                    Message('Display action working');
                end;
            }
            action("Button1 Nav")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Category6;
                trigger OnAction()
                begin
                    Message('Button1 Working');
                end;
            }
        }
        area(Processing)
        {
            group("More Info")
            {
                action(NewRecord)
                {
                    ApplicationArea = All;
                    Caption = 'New';
                    Image = NewDocument;
                    RunObject = page "Customer card";
                    trigger OnAction()
                    begin
                        // Code to create a new record 
                        end;    }
                action(EditRecord)
                {
                    ApplicationArea = All;
                    Caption = 'Edit';
                    Image = Edit;
                    trigger OnAction()
                    begin
                        // Code to edit the selected record
                        Message('Edit Button');
                    end;
                }
                action(DeleteRecord)
                {
                    ApplicationArea = All;
                    Caption = 'Delete';
                    Image = Delete;
                    trigger OnAction()
                    begin
                        // Code to delete the selected record
                        Message('Delete  Button');
                    end;
                }
            }
        }
    }


  // trigger OnOpenPage()
    // begin
    //     Message('Op Open Trigger working fine');
    // end;

  // trigger OnClosePage()
    // begin
    //     Message('Page closed successfully !');

  // end;

  // trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    // begin
    //     Message('Record Inserted successfully!');
    // end;

  }
```
