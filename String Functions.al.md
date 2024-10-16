## String Fucntions in BC ::

```
table 50511 "String Function Practice "
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Original String"; Text[50])
        {
            DataClassification = ToBeClassified;



        }
        field(2; "string2"; text[50])
        {

            DataClassification = ToBeClassified;
        }

    }

    keys
    {

    }



}

// pages 

page 50511 "String Fucntions"
{
    PageType = Card;
    Caption = 'String Functions Practice ';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "String Function Practice ";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Original String"; Rec."Original String")
                {
                    ApplicationArea = all;
                    // Style = Favorable;

                }
                field(string2; Rec.string2)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CopyStr)
            {

                trigger OnAction()
                var
                    OriginalString: Text[100];
                    ModifiedString1: Text[100];
                    Modifiedstring2: Text[100];
                    modifiedstring3: Text[100];
                begin
                    OriginalString := 'CASH CONCENTRATION TRANSFER DEBIT TO ACCOUNT 000000721687793 TRN: 004';
                    ModifiedString1 := CopyStr(OriginalString, 1, 1) + CopyStr(OriginalString, 6, 1) + CopyStr(OriginalString, 8, 1) + ' ' + CopyStr(OriginalString, 20, 2) + CopyStr(OriginalString, 23, 2);
                    ModifiedString2 := CopyStr(OriginalString, 29, 8) + ' ' + CopyStr(OriginalString, 38, 3) + '. ' + CopyStr(OriginalString, 52, 9) + ' ' + CopyStr(OriginalString, 62, 8);

                    ModifiedString3 := ModifiedString1 + '. ' + Modifiedstring2;
                    Message(modifiedstring3);



                end;
            }
            action(Strfunctions)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    OriginalStr: Text;
                    newStr: Text;
                    replaceText: Text;
                    ByText: Text;

                begin
                    OriginalStr := 'CASH CONCENTRATION TRANSFER DEBIT TO ACCOUNT 000000721687793 TRN: 004';
                    replaceText := 'CASH CONCENTRATION TRANSFER';
                    ByText := 'CCN TRNS.';

                    // newStr := ConvertStr(OriginalStr, replace, ByText);
                    // newStr:RE
                    // Message(newStr);
                end;
            }
            action("pastr&trim")
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Originaltext: Text;
                    padstring: text;
                begin
                    Originaltext := Rec."Original String";
                    padstring := PadStr(Originaltext, 5);
                    Message(padstring);
                    padstring := Originaltext.Trim(); // remove all leading -trailing white spaces
                    Message(padstring);



                end;
            }
            action(Selectstr)
            {
                ApplicationArea = all;
                trigger OnAction()

                var
                    Originaltect: Text;
                    newtext: Text;
                begin
                    Originaltect := rec."Original String";
                    newtext := SelectStr(2, Originaltect);
                    Message(newtext);
                end;
            }
            action(Strposition)
            {
                ApplicationArea = all;
                trigger OnAction()

                var
                    Originaltect: Text;
                    substr: text;
                    newtext: Integer;
                begin
                    Originaltect := rec."Original String";
                    substr := rec.string2;


                    newtext := StrPos(Originaltect, substr);
                    Message('THe string postion is %1:', newtext);
                end;

            }
            action(IncString)
            {
                ApplicationArea = all;
                ToolTip = 'Increases a positive number or decrease a negative number inside a string by one (1).';
                trigger OnAction()

                var
                    Originaltect: Text;
                    substr: text;
                    newtext: Text;
                begin
                    Originaltect := rec."Original String";
                    substr := rec.string2;


                    newtext := IncStr(Originaltect);
                    Message('After Incstr Fucntion used the o/p Increae by one :%1', newtext);
                end;
            }
        }

    }
}
```
