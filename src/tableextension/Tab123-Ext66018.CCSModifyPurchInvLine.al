tableextension 66018 "CCS ModifyPurchInvLine" extends "Purch. Inv. Line" //123
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