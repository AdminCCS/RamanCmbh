/// <summary>
/// TableExtension CCS ModifySalesHeader (ID 66011) extends Record Sales Header //36.
/// </summary>
tableextension 66011 "CCS ModifySalesHeader" extends "Sales Header" //36
{
    fields
    {
        field(66000; "CCS Order Type"; Option)
        {
            Caption = 'Order Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Instant Order","Blocking Order","Disposition order","Backlog order";

            trigger OnValidate()
            var
                salesLine: Record "Sales Line";
            begin
                SalesLine.SetRange("Document No.", rec."No.");
                if not SalesLine.IsEmpty then
                    error('Please delete lines before changing the Order Type.');
            end;
        }
        field(66001; "CCS Posted CM Print Option"; Option)
        {
            Caption = 'Credit Memo Print Option';
            DataClassification = CustomerContent;
            OptionMembers = "Credit Memo","Invoice correction";
        }
    }
}
