codeunit 50514 "sale order Events "
{

    Permissions = tabledata "Sales Header" = rimd, tabledata "Sales Line" = rimd, tabledata "Sales Shipment Header" = rimd;
    // sales Header to Salesshipment HEader
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnInsertShipmentHeaderOnAfterTransferfieldsToSalesShptHeader, '', false, false)]
    local procedure MyProcedure(var SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")

    begin
        SalesShptHeader.DataFLow := SalesHeader."Data FLow field";

    end;

    // Sale Line to Sale Shipment Line 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterInsertShipmentLine, '', false, false)]
    local procedure SaleLineToSaleShipmtLine(var SalesLine: Record "Sales Line"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine.SAleLineTosaleShipmtLine := SalesLine."Custom Line";

    end;
    // Sale Header to Posted sale header (Sales Invoice Header)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesInvHeaderInsert, '', false, false)]
    local procedure SaleHeaderToSaleInvoiceHeader(SalesHeader: Record "Sales Header"; var SalesInvHeader: Record "Sales Invoice Header")
    begin
        SalesInvHeader.CustomDataFlow := SalesHeader."Data FLow field";
    end;

    // Doubts
    // Sales Line to Posted sale Line (Sales Invoice Line)
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterSalesInvLineInsert, '', false, false)]
    local procedure SaleLineToSaleInvoiceLine(SalesLine: Record "Sales Line"; var SalesInvLine: Record "Sales Invoice Line")
    begin
        SalesInvLine.CustomLine := SalesLine."Custom Line";
    end;


    // sale Invoice Header to Sale Credit memo(Table Name : Sale Header) 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Correct Posted Sales Invoice", OnAfterCreateCorrectiveSalesCrMemo, '', false, false)]
    local procedure OnAfterCreateCorrectiveSalesCrMemo(SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.CustomSaleCreditMemodData := SalesInvoiceHeader.CustomSaleCredtmemo;
    end;
    // Sales Credit Memo Header to Posted Sale Credit Memo

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", OnAfterInsertCrMemoHeader, '', true, true)]
    local procedure OnBeforePostSalesCreditMemo(var SalesHeader: Record "Sales Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        SalesCrMemoHeader."Cr.MemoTO Posted Cr. Memo" := SalesHeader.CustomSaleCreditMemodData;
    end;

    // ================================
    // ==============================

    // sale Header to Gen.Journal Line
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", OnAfterCopyGenJnlLineFromSalesHeader, '', false, false)]
    local procedure CopyFromSalesHeader(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine.DataFlowCheck := SalesHeader."Data FLow field";
    end;

    // Gen.Journal to G/L entry

    [EventSubscriber(ObjectType::Table, Database::"G/L Entry", OnAfterCopyGLEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyGLEntryFromGenJnlLine(var GenJournalLine: Record "Gen. Journal Line"; var GLEntry: Record "G/L Entry")
    begin
        GLEntry."Custom Data Flow check" := GenJournalLine.DataFlowcheck;
    end;

    // // Sale Line to Gen.Journal Line
    // [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", onaftercopy, 'ElementName', SkipOnMissingLicense, SkipOnMissingPermission)]
    // local procedure MyProcedure()
    // begin

    // end;

    // Gen Journal Line to Customer Ledger entries .
    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", OnAfterCopyCustLedgerEntryFromGenJnlLine, '', false, false)]
    local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.DataFlowCheck := GenJournalLine.DataFlowcheck;
    end;

    // Sale Lines to Item journal line
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesLine, '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Custom Field" := salesLine."Custom Line";
    end;

    // Sale Header to Item journal line
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", OnAfterCopyItemJnlLineFromSalesHeader, '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine.DataFromSaleHeader := SalesHeader."Data FLow field";
    end;


    // item journal line to item ledger entry
    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", OnAfterCopyTrackingFromItemJnlLine, '', false, false)]
    local procedure OnAfterCopyTrackingFromItemJnlLine(ItemJnlLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry.CustomField := ItemJnlLine."Custom field";
    end;

    // Sale Line  as well as header to Value Entry table via (ItemJournal Line)

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnBeforeSetValueEntrySourceFieldsFromItemJnlLine, '', false, false)]
    local procedure OnBeforeSetValueEntrySourceFieldsFromItemJnlLine(ItemJournalLine: Record "Item Journal Line"; var ValueEntry: Record "Value Entry")
    begin
        ValueEntry."DataFromSale Header" := ItemJournalLine.DataFromSaleHeader;  // Sale header DataFlow to Value entry table
        ValueEntry."DataFromSale Line" := ItemJournalLine."Custom Field"; //Data From Sale Line to Value Entry Table;
    end;



    // [EventSubscriber(ObjectType::Codeunit, codeunit::"Sales-Post", , 'ElementName', SkipOnMissingLicense, SkipOnMissingPermission)]
    // local procedure MyProcedure()
    // begin

    // end;



    // Sale Quote to Sale order 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order", OnBeforeInsertSalesOrderHeader, '', false, false)]
    local procedure SaleQuoteToSaleOrder(var SalesOrderHeader: Record "Sales Header"; var SalesQuoteHeader: Record "Sales Header")
    begin
        SalesOrderHeader.SQToSO := SalesQuoteHeader.SaleQuote;
    end;




}