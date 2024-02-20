pageextension 66009 "Sales Credit Memo Extension" extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("CCS Posted CM Print Option"; Rec."CCS Posted CM Print Option")
            {
                ApplicationArea = all;
                Caption = 'Credit Memo Print Option';
                ToolTip = 'Specifies the value of the Credit Memo Print Option field.';
            }
        }
    }
}