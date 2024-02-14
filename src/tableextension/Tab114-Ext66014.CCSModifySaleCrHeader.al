tableextension 66014 "CCS ModifySaleCrHeader" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(66000; "CCS Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Instant Order","Blocking Order","Disposition order","Backlog order";
        }
        field(66001; "CCS Posted CM Print Option"; Option)
        {
            Caption = 'Credit Memo Print Option';
            DataClassification = CustomerContent;
            Editable = false;
            OptionMembers = "Credit Memo","Invoice correction";

        }
    }
}
