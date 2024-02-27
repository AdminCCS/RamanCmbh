/// <summary>
/// Codeunit CCS EventSubscriber (ID 66000).
/// </summary>
codeunit 66000 "CCS EventSubscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("CCS Order Type", '%1|%2|%3', SalesLine."CCS Order Type"::"Backlog order", SalesLine."CCS Order Type"::"Blocking Order", SalesLine."CCS Order Type"::"Disposition order");
        if SalesLine.FindFirst() then
            Error('Order Type must be Instant Order in all Lines to post.');
        //SalesHeader.TestField("CCS Order Type", SalesHeader."CCS Order Type"::"Instant Order");
    end;

    [EventSubscriber(ObjectType::page, page::"Sales Order Subform", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateEventQtySalesLine(var Rec: Record "Sales Line"; var xRec: Record "Sales Line")
    var
        Item: Record Item;
        PurchaseLine: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        ConsumeQty: Decimal;
        OpenQty: Decimal;
        Qty: Decimal;
        RemQty: Decimal;
    begin
        if rec."CCS Order Type" = rec."CCS Order Type"::"Blocking Order" then begin
            SalesLine.Reset();
            SalesLine.SetRange("CCS BA Number", Rec."Document No.");
            SalesLine.SetRange("No.", Rec."No.");
            if SalesLine.FindFirst() then
                error('Can not change quantity for this order, this order tagged on order no. %1', SalesLine."Document No.");

            rec."Initial Qty" := rec.Quantity;
            rec.Modify(true);
        end;

        if rec.Quantity < 0 then begin
            SalesHeader.TestField("CCS Order Type", SalesHeader."CCS Order Type"::"Backlog order");
            rec.TestField("CCS Order Type", rec."CCS Order Type"::"Backlog order");
        end;
        rec."CCS Cartons" := 0;
        if rec.Quantity > 0 then
            if rec."CCS Masterbox Qty" > 0 then begin
                rec."CCS Cartons" := rec.Quantity / rec."CCS Masterbox Qty";
                Qty := rec.Quantity;
                if (Qty mod 1) <> 0 then
                    Error('Quantity must not be in decimal.');
                if (qty mod rec."CCS Masterbox Qty") > 0 then begin
                    while (qty mod rec."CCS Masterbox Qty") <> 0 do
                        qty += 1;
                    if confirm(StrSubstNo(WarningLabel, Qty - rec."CCS Masterbox Qty", qty, rec."CCS Masterbox Qty", rec.Quantity, qty), false) then begin
                        Rec.validate(Quantity, qty);
                        rec."CCS Cartons" := rec.Quantity / rec."CCS Masterbox Qty";
                    end;
                end;
                rec.Modify(true);
            end;
        if (Rec."CCS Order Type" = Rec."CCS Order Type"::"Instant Order") and (Rec."CCS BA Number" <> '') then begin
            ConsumeQty := 0;
            SalesLine.Reset();
            SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
            SalesLine.Setfilter("Document No.", '<>%1', rec."Document No.");
            SalesLine.SetRange("No.", Rec."No.");
            if SalesLine.FindFirst() then
                repeat
                    ConsumeQty += SalesLine.Quantity;
                until SalesLine.next() = 0;
            SalesLine.Reset();
            SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
            SalesLine.SetRange("Document No.", rec."Document No.");
            SalesLine.SetFilter("Line No.", '<>%1', rec."Line No.");
            SalesLine.SetRange("No.", Rec."No.");
            if SalesLine.FindFirst() then
                repeat
                    ConsumeQty += SalesLine.Quantity;
                until SalesLine.next() = 0;

            //if (xRec."CCS BA Number" <> '') and (xRec.Quantity < rec.Quantity) and (xRec.Quantity <> 0) then begin
            SalesLine.Reset();
            SalesLine.SetRange("Document No.", Rec."CCS BA Number");
            SalesLine.SetRange("No.", Rec."No.");
            if SalesLine.FindFirst() then
                if Rec.Quantity > (SalesLine."Initial Qty" - ConsumeQty) then
                    Error('Max quantity available to select is %1 with BA Number %2', FORMAT(SalesLine.Quantity), Rec."CCS BA Number");
            // end;
            SalesLine.Reset();
            SalesLine.SetRange("Document No.", rec."CCS BA Number");
            SalesLine.SetRange("No.", rec."No.");
            if SalesLine.FindFirst() then begin
                SalesLine.Quantity := SalesLine."Initial Qty" - (Rec.Quantity + ConsumeQty);
                SalesLine.Modify();
            end;
        end;
        SalesHeader.get(rec."Document Type", rec."Document No.");
        if (SalesHeader."CCS Order Type" = SalesHeader."CCS Order Type"::"Instant Order") or ((SalesHeader."CCS Order Type" = SalesHeader."CCS Order Type"::"Blocking Order")) then
            if Item.get(rec."No.") then begin
                item.CalcFields(Inventory);
                OpenQty := 0;
                SalesLine.Reset();
                SalesLine.Setfilter("Document No.", '<>%1', rec."Document No.");
                SalesLine.SetFilter("CCS Order Type", '%1|%2', rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Instant Order");
                SalesLine.SetRange("No.", Rec."No.");
                if SalesLine.FindFirst() then
                    repeat
                        OpenQty += SalesLine.Quantity;
                    until SalesLine.next() = 0;
                SalesLine.Reset();
                SalesLine.SetRange("Document No.", rec."Document No.");
                SalesLine.SetFilter("CCS Order Type", '%1|%2', rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Instant Order");
                SalesLine.SetFilter("Line No.", '<>%1', rec."Line No.");
                SalesLine.SetRange("No.", Rec."No.");
                if SalesLine.FindFirst() then
                    repeat
                        OpenQty += SalesLine.Quantity;
                    until SalesLine.next() = 0;
                item.CalcFields("CCS Instant Ord Invt", "CCS Blocking Order Invt");
                RemQty := item.Inventory - (OpenQty);
                if rec.Quantity > (RemQty) then
                    Error(StrSubstNo(QtyError, RemQty, Item."No."));
                //if not Confirm(StrSubstNo(QtyWarning, Item.Inventory, Item."No."), false) then
                //  Error('');
            end;
        if (Rec."CCS Order Type" = Rec."CCS Order Type"::"Disposition order") and (rec."CCS PO Number" <> '') and (rec.Quantity > 0) then begin
            PurchaseLine.Reset();
            PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
            PurchaseLine.SetRange("Document No.", rec."CCS PO Number");
            PurchaseLine.SetRange("No.", rec."No.");
            if PurchaseLine.FindFirst() then begin
                PurchaseLine.CalcFields("Pre Sold Quantity");
                if rec.Quantity > (PurchaseLine.Quantity - (PurchaseLine."Pre Sold Quantity" - rec.Quantity)) then
                    error('Max quantiy available for PO No.%1 is %2', rec."CCS PO Number", format((PurchaseLine.Quantity - (PurchaseLine."Pre Sold Quantity" - rec.Quantity))));
            end;
        end;
        if (rec.Type = rec.Type::Item) and (rec."No." <> '') then begin
            item.Get(rec."No.");
            item.CalcFields(Inventory, "CCS Instant Ord Invt", "CCS Blocking Order Invt");
            item."Free Available Stock" := item.Inventory - (item."CCS Instant Ord Invt" + item."CCS Blocking Order Invt");
            item.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertEventSalesLine(var Rec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
    begin

        if SalesHeader.get(rec."Document Type", rec."Document No.") then
            rec."CCS Order Type" := SalesHeader."CCS Order Type";
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateEventSalesLine(var Rec: Record "Sales Line")
    var
        Item: Record Item;
    begin
        if rec.IsTemporary then
            exit;
        if rec."Document Type" = rec."Document Type"::Order then
            if rec.Type = rec.Type::item then
                if rec."No." <> '' then begin
                    Item.get(rec."No.");
                    rec."CCS Masterbox Qty" := Item."CCS Masterbox";
                end;
    end;

    [EventSubscriber(ObjectType::page, page::"Purchase Order Subform", 'OnAfterValidateEvent', 'Quantity', false, false)]
    local procedure OnAfterValidateEventQtyPurchLine(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line")
    var

        SalesLine: Record "Sales Line";

    begin

        SalesLine.Reset();
        SalesLine.SetRange(SalesLine."CCS PO Number", Rec."Document No.");
        SalesLine.SetRange("No.", Rec."No.");
        if SalesLine.FindFirst() then
            error('Can not change quantity for this order,this order tagged on Sales Order No. %1', SalesLine."Document No.");
        Rec.CalcFields("Pre Sold Quantity");
        rec."Free Available Stock" := Rec.Quantity - (Rec."Pre Sold Quantity");
    end;

    //[EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeDeleteEvent', '', false, false)]
    [EventSubscriber(ObjectType::page, page::"Sales Order Subform", 'OnDeleteRecordEvent', '', false, false)]
    local procedure OnBeforeDeleteEventSalesLine(var Rec: Record "Sales Line")
    var
        BANO: Code[20];
        PONO: Code[20];
    begin
        if not rec.IsTemporary then begin

            if rec."CCS BA Number" <> '' then begin
                BANO := rec."CCS BA Number";
                rec.VALIDATE(rec."CCS BA Number", '');
                rec.Validate(Quantity, 0);
                rec."CCS BA Number" := BANO;
            end;
            if rec."CCS PO Number" <> '' then begin
                PONO := rec."CCS PO Number";
                rec.VALIDATE(rec."CCS PO Number", '');
                rec.Validate(Quantity, 0);
                rec."CCS PO Number" := PONO;
            end;
        end;
    end;

    // [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    [EventSubscriber(ObjectType::Page, page::"Sales Order", 'OnDeleteRecordEvent', '', false, false)]
    local procedure OnBeforeDeleteEventSalesHeader(var Rec: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        docNos: Text;
    begin
        if not rec.IsTemporary then begin
            SalesLine.RESET();
            SalesLine.SetRange("Document Type", Rec."Document Type");
            SalesLine.SetRange("Document No.", Rec."No.");
            SalesLine.SetFilter("CCS PO Number", '<>%1', '');
            SalesLine.SetRange("Quantity Shipped", 0);
            if SalesLine.FindFirst() then
                Error('PO Number must be blank on Lines to delete.');

            SalesLine.RESET();
            SalesLine.SetRange("Document Type", Rec."Document Type");
            SalesLine.SetRange("Document No.", Rec."No.");
            SalesLine.SetFilter("CCS BA Number", '<>%1', '');
            SalesLine.SetRange("Quantity Shipped", 0);
            if SalesLine.FindFirst() then
                Error('BA Number must be blank on Lines to delete.');

            docNos := '';
            SalesLine.RESET();
            SalesLine.SetRange("Document Type", Rec."Document Type");
            SalesLine.SetRange("CCS BA Number", Rec."No.");
            SalesLine.SetRange("Quantity Shipped", 0);
            if SalesLine.Findset() then
                repeat
                    if docNos = '' then
                        docNos := SalesLine."Document No." else
                        if not (SalesLine."Document No." in [docNos]) then
                            docNos := docNos + ',' + SalesLine."Document No.";
                until SalesLine.Next() = 0;
            if docNos <> '' then
                if Dialog.Confirm('This Sales order is attached with Other SO. Do you want to remove the BA Number from other SO?', false, true) then begin
                    SalesLine.RESET();
                    SalesLine.SetRange("Document Type", Rec."Document Type");
                    SalesLine.SetRange("CCS BA Number", Rec."No.");
                    SalesLine.SetRange("Quantity Shipped", 0);
                    if SalesLine.FindSet() then
                        repeat
                            SalesLine.validate("CCS BA Number", '');
                            SalesLine.validate(Quantity, 0);
                            SalesLine.Modify(true);
                        until SalesLine.Next() = 0;
                    // salesLine.DeleteAll(true);

                    // SalesHeader.SetFilter("No.", docNos);
                    // if SalesHeader.FindSet then
                    //     repeat
                    //         salesLine.Reset();
                    //         salesLine.SetRange("Document No.", SalesHeader."No.");
                    //         salesLine.SetFilter("No.", '<>%1', '');
                    //         SalesLine.SetRange("Quantity Shipped", 0);
                    //         if salesLine.IsEmpty then
                    //             SalesHeader.Delete(true);
                    //     until SalesHeader.next = 0;
                end else
                    error('');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
    local procedure OnAfterPostPurchaseDoc(var PurchaseHeader: Record "Purchase Header")
    var
        SalesLine: Record "Sales Line";
    begin

        SalesLine.SetRange(SalesLine."CCS PO Number", PurchaseHeader."No.");
        SalesLine.SetFilter("CCS Order Type", '%1', SalesLine."CCS Order Type"::"Disposition order");
        if SalesLine.FindFirst() then
            repeat
                SalesLine.Validate("CCS Order Type", SalesLine."CCS Order Type"::"Blocking Order");
                SalesLine.VALIDATE("CCS PO Number", '');
                SalesLine."Initial Qty" := SalesLine.Quantity;
                SalesLine.Modify();
            until SalesLine.Next() = 0;
    end;

    // [EventSubscriber(ObjectType::Table, database::"Purchase Header", 'OnBeforeDeleteEvent', '', false, false)]
    [EventSubscriber(ObjectType::page, page::"Purchase Order", 'OnDeleteRecordEvent', '', false, false)]
    local procedure OnBeforeDeleteEventPurchHeader(var Rec: Record "Purchase Header")
    var
        purchLineRec: Record "Purchase Line";
        SalesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";
        docNos: Text;
    begin
        if not Rec.IsTemporary then
            if rec."No." <> '' then begin
                purchLineRec.Reset();
                purchLineRec.SetRange("Document Type", rec."Document Type");
                purchLineRec.SetRange("Document No.", Rec."No.");
                purchLineRec.SetFilter("No.", '<>%1', '');
                if purchLineRec.FindFirst() then
                    repeat
                        salesLine.Reset();
                        salesLine.SetRange("CCS PO Number", purchLineRec."Document No.");
                        salesLine.SetRange("No.", purchLineRec."No.");
                        if salesLine.FindSet() then
                            repeat
                                if docNos = '' then
                                    docNos := salesLine."Document No." else
                                    if not (salesLine."Document No." in [docNos]) then
                                        docNos := docNos + ',' + salesLine."Document No.";
                            until salesLine.Next() = 0;
                    until purchLineRec.Next() = 0;
                if docNos <> '' then
                    if Dialog.Confirm('Sales orders attached with this PO. Do you want to delete the PO and SO?', false, true) then begin
                        purchLineRec.Reset();
                        purchLineRec.SetRange("Document No.", rec."No.");
                        purchLineRec.SetFilter("No.", '<>%1', '');
                        if purchLineRec.FindSet() then
                            repeat
                                salesLine.Reset();
                                salesLine.SetRange("CCS PO Number", purchLineRec."Document No.");
                                salesLine.SetRange("No.", purchLineRec."No.");
                                //if salesLine.FindSet() then
                                salesLine.DeleteAll(true);
                            until purchLineRec.Next() = 0;
                        SalesHeader.SetFilter("No.", docNos);
                        if SalesHeader.FindSet() then
                            repeat
                                salesLine.Reset();
                                salesLine.SetRange("Document No.", SalesHeader."No.");
                                salesLine.SetFilter("No.", '<>%1', '');
                                if salesLine.IsEmpty then
                                    SalesHeader.Delete(true);
                            until SalesHeader.next() = 0;
                    end else
                        error('');
            end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure OnAfterValidateBilltoCust(var Rec: Record "Sales Header")
    begin

        Rec."Posting Date" := Today();
    end;

    // <summary>
    // Retrieves a translated field caption
    // </summary>
    // <param name="LanguageCode">The code of the language to which the field caption will be translated.</param>
    // <param name="TableID">The ID of the table where the field is located.</param>
    // <param name="FieldId">The ID of the field for which the caption will be translated.</param>
    // <returns>The field's caption translated in the specified language</returns>
    procedure GetTranslatedFieldCaption(LanguageCode: Code[10]; TableID: Integer; FieldId: Integer) TranslatedText: Text
    var
        "Field": Record "Field";
        Language: Codeunit Language;
        CurrentLanguageId: Integer;
        LanguageIdToSet: Integer;
    begin
        CurrentLanguageId := GlobalLanguage;
        LanguageIdToSet := Language.GetLanguageIdOrDefault(LanguageCode);
        if (LanguageCode <> '') and (LanguageIdToSet <> CurrentLanguageId) then begin
            GlobalLanguage(LanguageIdToSet);
            Field.Get(TableID, FieldId);
            TranslatedText := Field."Field Caption";
            GlobalLanguage(CurrentLanguageId);
        end else begin
            Field.Get(TableID, FieldId);
            TranslatedText := Field."Field Caption";
        end;
    end;

    var
        QtyError: Label 'Can not select more than %1 remaining stock available for that item %2.';
        WarningLabel: Label 'WARNING: You broke the Masterbox Qty.\Next less Qty can be: %1 \Next High Qty can be: %2 \Masterbox Qty: %3 \You want to replace %4 pcs with %5 pcs.';
}
