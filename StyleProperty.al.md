## Style Properties in BC .

```al
pageextension 50512 "MyPurchase order Ext" extends "Purchase Order List"
{
    layout
    {
        modify("No.")
        {
            Style = Unfavorable;
            StyleExpr = changecolorgbln;
            Editable = false;

        }
        modify("Buy-from Vendor No.")
        {
            Style = Ambiguous;
            StyleExpr = changecolorgbln;
            Editable = false;


        }
        // Add changes to page layout here
    }

    local procedure changecolr()

    begin
        if rec.Status = rec.Status::Open then
            changecolorgbln := true
        else
            changecolorgbln := false;

    end;

    var
        changecolorgbln: Boolean;


    trigger OnAfterGetRecord()
    begin
        changecolr();
    end;
}
```
