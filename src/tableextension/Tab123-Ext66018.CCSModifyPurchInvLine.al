tableextension 66018 "CCS ModifyPurchInvLine" extends "Purch. Inv. Line" //123
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