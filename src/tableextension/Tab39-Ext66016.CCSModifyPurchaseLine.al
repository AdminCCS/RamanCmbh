/// <summary>
/// TableExtension CCS ModifyPurchaseLine (ID 66016) extends Record Purchase Line //39.
/// </summary>
tableextension 66016 "CCS ModifyPurchaseLine" extends "Purchase Line" //39
{
    fields
    {
        field(66000; "Pre Sold Quantity"; Decimal)
        {
            Caption = 'Pre-Sold Quantity';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                "CCS PO Number" = FIELD("Document No.")));
            Editable = false;
        }
        field(66001; "Free Available Stock"; Decimal)
        {

            Caption = 'Free Available Stock';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }

    }
    trigger OnDelete()
    var
        salesLine: record "Sales Line";
        SalesHeader: record "Sales Header";
        docNos: Text;
    begin
        if rec."Document No." <> '' then begin
            salesLine.Reset();
            salesLine.SetRange("CCS PO Number", rec."Document No.");
            salesLine.SetRange("No.", rec."No.");
            if salesLine.FindSet() then
                repeat
                    if docNos = '' then
                        docNos := salesLine."Document No." else
                        if NOT (salesLine."Document No." IN [docNos]) then
                            docNos := docNos + ',' + salesLine."Document No.";
                until salesLine.Next() = 0;
            if docNos <> '' then begin
                salesLine.Reset();
                salesLine.SetRange("CCS PO Number", rec."Document No.");
                salesLine.SetRange("No.", rec."No.");
                if salesLine.FindSet() then
                    salesLine.DeleteAll(true);

                SalesHeader.SetFilter("No.", docNos);
                if SalesHeader.FindSet then
                    repeat
                        salesLine.Reset();
                        salesLine.SetRange("Document No.", SalesHeader."No.");
                        salesLine.SetFilter("No.", '<>%1', '');
                        if not salesLine.FindFirst() then
                            SalesHeader.Delete(true);
                    until SalesHeader.next = 0;
            end;
        end;
    end;
}