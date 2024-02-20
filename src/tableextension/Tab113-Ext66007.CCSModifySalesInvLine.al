tableextension 66007 "CCS ModifySalesInvLine" extends "Sales Invoice Line" //113
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
        field(66002; "Order Type"; Option)
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
        }
        field(66005; "CCS Rebate 2 %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rebate 2 %';
        }
        field(66006; "CCS BA Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BA Number';
        }
        field(66007; "CCS PO Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PO Number';
        }
    }
}
