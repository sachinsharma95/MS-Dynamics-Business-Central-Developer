## Inseert and Modift top 5 Record from CUstomer STD table to CUstome Table .
## CUstomPage Task

```al
codeunit 50507 "Custom Page task codeunit"
{
    procedure InsertCustomer()
    var
        i: Integer;
    begin
        i := 0;
        CustomerRec.Reset();
        if CustomerRec.FindSet() then begin
            repeat
                i := i + 1;
                if i <= 8 then begin  //inserted top 8 record

                    MyCustomTableRec.Init();
                    MyCustomTableRec."No." := CustomerRec."No.";
                    MyCustomTableRec.Name := CustomerRec.Name;
                    MyCustomTableRec.Address := CustomerRec.Address;
                    MyCustomTableRec.Contact := CustomerRec.Contact;
                    MyCustomTableRec."Credit Limit (LCY)" := CustomerRec."Credit Limit (LCY)";
                    MyCustomTableRec.Payments := CustomerRec.Payments;
                    MyCustomTableRec.Insert();
                end else begin
                    break;
                end;
            until CustomerRec.Next() = 0;
        end;
    end;

    // Modify Record into the Custom Table 
    procedure modifyRececord()
    var
        i: Integer;
    begin
        i := 0;
        if MyCustomTableRec.FindSet() then begin
            repeat
                i := i + 1;
                if i <= 5 then begin
                    MyCustomTableRec.Name := MyCustomTableRec.Name + ' ' + 'DS' + ' ' + 'TEST';
                    MyCustomTableRec.Address := MyCustomTableRec.Address + ' ' + 'TEST';
                    MyCustomTableRec.Modify(true);
                end
            until MyCustomTableRec.Next() = 0;
        end;

    end;

    // Global Varibale
    var
        MyCustomTableRec: Record "Custom Table Task";
        CustomerRec: Record Customer;
}









































// codeunit 50507 "Custom Page task codeunit"
// {

//     procedure InsertCustomer()


//     begin
//         CustomerRec.Reset();
//         CustomerRec.DeleteAll();
//         CustomerRec.get(CustomerRec."No.");
//         if CustomerRec.FindSet() then begin
//             repeat
//                 MyCustomTableRec."No." := CustomerRec."No.";
//                 MyCustomTableRec.Name := CustomerRec.Name;
//                 MyCustomTableRec.Address := CustomerRec.Address;
//                 MyCustomTableRec.Contact := CustomerRec.Contact;
//                 MyCustomTableRec."Credit Limit (LCY)" := CustomerRec."Credit Limit (LCY)";
//                 MyCustomTableRec.Payments := CustomerRec.Payments;
//                 MyCustomTableRec.INSERT(true);
//             until CustomerRec.Next() = 0;
//         end;

//     end;


//     var
//         MyCustomTableRec: Record "Custom Table Task";
//         CustomerRec: Record Customer;
// }`
```
