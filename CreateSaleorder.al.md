## Creating Sale Order Header from the Purchase order(Header)
```
codeunit 50512 PurchaseorderTosaleorder
{
    procedure CreatesaleorderFromPurchaseorder(var PurchaseRec: Record "Purchase Header")
    var
        SaleheaderRec: Record "Sales Header";
        SaleLineRec: Record "Sales Line";
        PurchaseLine: Record "Purchase Line";
        CustomerRec: Record "Customer";
        DefaultCustomerNo: Code[20];
        LineNoCheck: Integer;
    begin
        // Define a default customer number

        PurchaseRec.SetRange(Status, PurchaseRec.Status::Released);
        // Initialize the Sales Header
        SaleheaderRec.Init();
        SaleheaderRec."Document Type" := SaleheaderRec."Document Type"::Order;


        // Validate customer and assign details from the Purchase Order
        SaleheaderRec.Validate("Sell-to Customer No.", PurchaseRec."Customer No");  // Use corresponding customer no.
        SaleheaderRec."Due Date" := PurchaseRec."Due Date";
        SaleheaderRec."Order Date" := PurchaseRec."Order Date";
        SaleheaderRec."CIN No." := PurchaseRec."Vendor Invoice No.";

        // Insert the new Sales Order (Sales Header)
        SaleheaderRec.Insert(true);
        SaleheaderRec.Modify(true);

```
