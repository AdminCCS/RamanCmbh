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
            CalcFormula = sum("Sales Line".Quantity where(Type = const(Item), "No." = field("No."),
                                                                "CCS PO Number" = field("Document No.")));
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
        SalesHeader: Record "Sales Header";
        salesLine: Record "Sales Line";
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
                        if not (salesLine."Document No." in [docNos]) then
                            docNos := docNos + ',' + salesLine."Document No.";
                until salesLine.Next() = 0;
            if docNos <> '' then begin
                salesLine.Reset();
                salesLine.SetRange("CCS PO Number", rec."Document No.");
                salesLine.SetRange("No.", rec."No.");
                if salesLine.FindSet() then
                    salesLine.DeleteAll(true);

                SalesHeader.SetFilter("No.", docNos);
                if SalesHeader.FindSet() then
                    repeat
                        salesLine.Reset();
                        salesLine.SetRange("Document No.", SalesHeader."No.");
                        salesLine.SetFilter("No.", '<>%1', '');
                        if not salesLine.FindFirst() then
                            SalesHeader.Delete(true);
                    until SalesHeader.next() = 0;
            end;
        end;
    end;
}