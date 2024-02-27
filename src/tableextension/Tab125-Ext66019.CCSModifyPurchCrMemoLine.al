tableextension 66019 "CCS ModifyPurchCrMemoLine" extends "Purch. Cr. Memo Line" //125
{
    fields
    {
        field(66000; "Pre Sold Quantity"; Decimal)
        {
            Caption = 'Pre-Sold Quantity';
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity where(Type = const(Item), "No." = field("No."),
                                                                 "Document No." = field("Document No.")));
        }
    }
}