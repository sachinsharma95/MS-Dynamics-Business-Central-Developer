codeunit 50515 PurchaseOrderEvents
{

    Permissions = tabledata "Purchase Header" = rimd;

    // purchase Header to item Journal Line (Item Journal.Line is Intermediate Table)
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromPurchHeader, '', false, false)]
    local procedure OnAfterCopyItemJnlLineFromPurchHeader(PurchHeader: Record "Purchase Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine.DataFromPurchaseHeader := PurchHeader.PurchHeaderDataFlow;
    end;

    // Item  jorunal line item ledger entry
    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterCopyTrackingFromItemJnlLine, '', false, false)]
    local procedure OnAfterCopyTrackingFromItemJnlLine(ItemJnlLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry.DataFromPurchHeader := ItemJnlLine.DataFromPurchaseHeader;
    end;

    // PurchaseHeader To General journal Line => UNPOSTED TRANSACTION

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromPurchHeader, '', false, false)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.DataFromPurchHeader := PurchaseHeader.PurchHeaderDataFlow;
    end;
    // Gen Jorunal Line to G/L Ledger entry
    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry.PurchaseHeaderDataFlow := GenJournalLine.DataFromPurchHeader;
    end;

    // G/L ENtry to Vendor Ledger entry
    [EventSubscriber(ObjectType::Table, Database::"Vendor Ledger Entry", OnAfterCopyVendLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyVendLedgerEntryFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        VendorLedgerEntry.FromPurchaseHeaderDataFlow := GenJournalLine.DataFromPurchHeader;
    end;

    // Tax entry VAT entry Table 

    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", OnAfterCopyFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")

    begin
        VATEntry.DataFromPurchaseHeader := GenJournalLine.DataFromPurchHeader;
        VATEntry.DataFromPurchaseLine := GenJournalLine.DataFlowcheck;
        // VATEntry.Modify(true);

    end;

    // purchase Header to Posted Purchase inv Header
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchInvHeaderInsert, '', false, false)]
    local procedure OnAfterPurchInvHeaderInsert(var PurchHeader: Record "Purchase Header"; var PurchInvHeader: Record "Purch. Inv. Header")
    begin
        PurchInvHeader.DataFromPurchHEader := PurchHeader.PurchHeaderDataFlow;
    end;
    // purchase Line to Posted Purchase inv Line 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterPurchInvLineInsert, '', false, false)]
    local procedure OnAfterPurchInvLineInsert(PurchLine: Record "Purchase Line"; var PurchInvLine: Record "Purch. Inv. Line")
    begin
        PurchInvLine.DataFromPurchaseLine := PurchLine."Data FLow Field";
    end;


    // Detailed vendor ledger entry

    // [EventSubscriber(ObjectType::Table, DataBase::"Detailed Vendor Ledg. Entry" , OnSetZeroTransNoOnBeforeDetailedVendorLedgEntryModify , '', false, false)]
    // local procedure DetailedVendorlegerentry(sender: Codeunit "Gen. Jnl.-Post Line")
    // begin

    // end;



    // =============== 
    // Purch Quote to Order 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Quote to Order", OnBeforeInsertPurchOrderLine, '', false, false)]
    local procedure MyProcedure(PurchQuoteHeader: Record "Purchase Header"; PurchOrderHeader: Record "Purchase Header"; PurchQuoteLine: Record "Purchase Line"; var PurchOrderLine: Record "Purchase Line")

    begin
        PurchOrderHeader."PurchQTO Order" := PurchQuoteHeader.PurchQuote;
        PurchOrderLine.PurchQLine := PurchQuoteLine.PurchQLine;
    end;

    // Purchase credit memo Header to posted Purch Credit Memo Hdr
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnAfterInsertCrMemoHeader, '', false, false)]
    local procedure OnAfterInsertCrMemoHeader(var PurchaseHeader: Record "Purchase Header"; var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.")
    begin
        PurchCrMemoHdr.DataFromPurchHdr := PurchaseHeader.PurchHeaderDataFlow;
    end;

    // Purchase credit memo Line to posted Purch Credit Memo Line
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostUpdateCreditMemoLineOnAfterPurchOrderLineModify, '', false, false)]
    // local procedure OnAfterInsertCrMemoHeader()
    // begin
    //     PurchCrMemoHdr.DataFromPurchHdr := PurchaseHeader.PurchHeaderDataFlow;
    // end;

}