/// <summary>
/// TableExtension CCS ModifySalesLine (ID 66006) extends Record Sales Line //37.
/// </summary>
tableextension 66006 "CCS ModifySalesLine" extends "Sales Line" //37
{
    fields
    {
        field(66000; "CCS Masterbox Qty"; Decimal)
        {
            Caption = 'Masterbox Qty';
            DataClassification = CustomerContent;
        }
        field(66001; "CCS Unit Cost"; Boolean)
        {
            Caption = 'Unit Cost';
            DataClassification = CustomerContent;
        }
        field(66002; "CCS Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Instant Order","Blocking Order","Disposition order","Backlog order";

        }
        field(66003; "CCS Cartons"; Decimal)
        {
            Caption = 'Cartons';
            DataClassification = CustomerContent;
        }
        field(66004; "CCS Rebate 1 %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rebate 1 %';
            trigger OnValidate()
            begin
                Validate("Line Discount %", CalcRebateDisc("CCS Rebate 1 %"));

            end;

        }
        field(66005; "CCS Rebate 2 %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rebate 2 %';
            trigger OnValidate()
            begin
                Validate("Line Discount %", CalcRebateDisc("CCS Rebate 2 %"));
            end;
        }
        field(66006; "CCS BA Number"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BA Number';
            trigger OnLookup()
            var
                SalesLine: Record "Sales Line";
                ConsumeQty: Decimal;
            begin
                if rec."CCS BA Number" = '' then
                    TestField(Quantity, 0);
                SalesLine.Reset();
                SalesLine.SetRange("Document Type", rec."Document Type");
                SalesLine.SetRange("CCS Order Type", rec."CCS Order Type"::"Blocking Order");
                SalesLine.SetRange("No.", rec."No.");
                SalesLine.SetFilter(Quantity, '>%1', 0);
                if page.RunModal(page::"CCS Sales order Sub List", SalesLine) = ACTION::LookupOK THEN begin
                    "CCS BA Number" := SalesLine."Document No.";
                    if ("CCS Order Type" = "CCS Order Type"::"Instant Order") and ("CCS BA Number" <> '') then begin
                        ConsumeQty := 0;
                        SalesLine.Reset();
                        SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
                        SalesLine.Setfilter("Document No.", '<>%1', rec."Document No.");
                        SalesLine.SetRange("No.", Rec."No.");
                        if SalesLine.FindFirst() then
                            repeat
                                ConsumeQty += SalesLine.Quantity;
                            until SalesLine.next = 0;

                        SalesLine.Reset();
                        SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
                        SalesLine.SetRange("Document No.", rec."Document No.");
                        SalesLine.SetFilter("Line No.", '<>%1', rec."Line No.");
                        SalesLine.SetRange("No.", Rec."No.");
                        if SalesLine.FindFirst() then
                            repeat
                                ConsumeQty += SalesLine.Quantity;
                            until SalesLine.next = 0;
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", "CCS BA Number");
                        SalesLine.SetRange("No.", "No.");
                        if SalesLine.FindFirst() then begin
                            if Quantity > (SalesLine."Initial Qty" - ConsumeQty) then
                                Error('Max quantity available to select is %1 with BA Number %2', FORMAT((SalesLine."Initial Qty" - ConsumeQty)), "CCS BA Number")

                        end else
                            error('Order no.%1 not valid Block Order', "CCS BA Number");

                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", "CCS BA Number");
                        SalesLine.SetRange("No.", "No.");
                        if SalesLine.FindFirst() then begin
                            SalesLine.Quantity := SalesLine."Initial Qty" - (Rec.Quantity + ConsumeQty);
                            SalesLine.Modify();
                        end;
                    end;
                    if ("CCS Order Type" = "CCS Order Type"::"Instant Order") and (xrec."CCS BA Number" <> '') and (xrec."CCS BA Number" <> rec."CCS BA Number") then begin
                        SalesLine.Reset();
                        SalesLine.SetRange("Document No.", xRec."CCS BA Number");
                        SalesLine.SetRange("No.", "No.");
                        if SalesLine.FindFirst() then begin
                            SalesLine.Quantity := SalesLine.Quantity + Rec.Quantity;
                            SalesLine.Modify();
                        end;
                    end;
                end
            end;

            trigger OnValidate()
            var
                SalesLine: Record "Sales Line";
                ConsumeQty: Decimal;
            begin
                if ("CCS Order Type" = "CCS Order Type"::"Instant Order") and ("CCS BA Number" <> '') then begin
                    ConsumeQty := 0;
                    SalesLine.Reset();
                    SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
                    SalesLine.Setfilter("Document No.", '<>%1', rec."Document No.");
                    SalesLine.SetRange("No.", Rec."No.");
                    if SalesLine.FindFirst() then
                        repeat
                            ConsumeQty += SalesLine.Quantity;
                        until SalesLine.next = 0;

                    SalesLine.Reset();
                    SalesLine.SetRange("CCS BA Number", Rec."CCS BA Number");
                    SalesLine.SetRange("Document No.", rec."Document No.");
                    SalesLine.SetFilter("Line No.", '<>%1', rec."Line No.");
                    SalesLine.SetRange("No.", Rec."No.");
                    if SalesLine.FindFirst() then
                        repeat
                            ConsumeQty += SalesLine.Quantity;
                        until SalesLine.next = 0;



                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "CCS BA Number");
                    SalesLine.SetRange("No.", "No.");
                    if SalesLine.FindFirst() then begin
                        if Quantity > (SalesLine."Initial Qty" - ConsumeQty) then
                            Error('Max quantity available to select is %1 with BA Number %2', FORMAT((SalesLine."Initial Qty" - ConsumeQty)), "CCS BA Number")

                    end else
                        error('Order no.%1 not valid Block Order', "CCS BA Number");

                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", "CCS BA Number");
                    SalesLine.SetRange("No.", "No.");
                    if SalesLine.FindFirst() then begin
                        SalesLine.Quantity := SalesLine."Initial Qty" - (Rec.Quantity + ConsumeQty);
                        SalesLine.Modify();
                    end;
                end;
                if ("CCS Order Type" = "CCS Order Type"::"Instant Order") and (xrec."CCS BA Number" <> '') and (xrec."CCS BA Number" <> rec."CCS BA Number") then begin
                    SalesLine.Reset();
                    SalesLine.SetRange("Document No.", xRec."CCS BA Number");
                    SalesLine.SetRange("No.", "No.");
                    if SalesLine.FindFirst() then begin
                        SalesLine.Quantity := SalesLine.Quantity + Rec.Quantity;
                        SalesLine.Modify();
                    end;
                end;

            end;
        }
        field(66007; "CCS PO Number"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PO Number';
            trigger OnLookup()
            var
                PurchaseHeader: Record "Purchase Header";
                PurchaseLine: Record "Purchase Line";
            begin
                //PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
                PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                PurchaseLine.SetRange("No.", rec."No.");
                PurchaseLine.SetFilter(Quantity, '>%1', 0);
                if page.RunModal(66001, PurchaseLine) = ACTION::LookupOK THEN begin
                    "CCS PO Number" := PurchaseLine."Document No.";
                    if ("CCS PO Number" <> '') and (Quantity > 0) then begin
                        PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                        PurchaseLine.SetRange("Document No.", "CCS PO Number");
                        PurchaseLine.SetRange("No.", rec."No.");
                        if PurchaseLine.FindFirst() then begin
                            PurchaseLine.CalcFields("Pre Sold Quantity");
                            if rec.Quantity > (PurchaseLine.Quantity - PurchaseLine."Pre Sold Quantity") then
                                error('Max quantiy available for PO No.%1 is %2', rec."CCS PO Number", format((PurchaseLine.Quantity - PurchaseLine."Pre Sold Quantity")));

                        end else
                            error('Order no.%1 not valid Purchase Order', "CCS PO Number");
                    end;
                end;
            end;

            trigger OnValidate()
            var
                PurchaseLine: Record "Purchase Line";
            begin
                if ("CCS PO Number" <> '') and (Quantity > 0) then begin
                    PurchaseLine.SetRange("Document Type", PurchaseLine."Document Type"::Order);
                    PurchaseLine.SetRange("Document No.", "CCS PO Number");
                    PurchaseLine.SetRange("No.", rec."No.");
                    if PurchaseLine.FindFirst() then begin
                        PurchaseLine.CalcFields("Pre Sold Quantity");
                        if rec.Quantity > (PurchaseLine.Quantity - PurchaseLine."Pre Sold Quantity") then
                            error('Max quantiy available for PO No.%1 is %2', rec."CCS PO Number", format((PurchaseLine.Quantity - PurchaseLine."Pre Sold Quantity")));

                    end else
                        error('Order no.%1 not valid Purchase Order', "CCS PO Number");
                end;
            end;
        }
        field(66008; "Initial Qty"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Initial Quantity';
            Editable = false;
        }
    }


    local procedure CalcRebateDisc(DiscPer: Decimal): Decimal
    var
        rebatAmt: Decimal;
    begin
        // if DiscPer = 0 then
        //     rebatAmt := (Quantity * "Unit Price") - "Line Amount";
        // if DiscPer <> 0 then
        rebatAmt := "Line Amount" * DiscPer / 100;
        rebatAmt := "Line Amount" - rebatAmt;
        exit(abs((rebatAmt / (Quantity * "Unit Price") * 100) - 100));
    end;
}





