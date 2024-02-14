tableextension 66017 "CCS ModifyPurchRcptLine" extends "Purch. Rcpt. Line" //121
{
    fields
    {
        field(66000; "Pre Sold Quantity"; Decimal)
        {
            Caption = 'Pre-Sold Quantity';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                 "Document No." = FIELD("Document No.")));

        }

    }
}