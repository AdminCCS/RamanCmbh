tableextension 66019 "CCS ModifyPurchCrMemoLine" extends "Purch. Cr. Memo Line" //125
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