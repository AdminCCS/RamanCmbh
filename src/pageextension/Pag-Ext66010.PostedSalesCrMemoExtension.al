pageextension 66010 "Posted Sales CrMemo Extension" extends "Posted Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
        addafter("Responsibility Center")
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