/// <summary>
/// Unknown Posted Sales CrMemo Extension (ID 66000) extends Record Standard Sales - Credit Memo.
/// </summary>
reportextension 66000 "Posted Sales CrMemo Extension" extends "Standard Sales - Credit Memo"
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            column(CCS_Posted_CM_Print_Option; "CCS Posted CM Print Option")
            { }
            column(RepLabel; RepLabel)
            { }
        }
        modify(Header)
        {
            // modify the new, added field
            trigger OnBeforeAfterGetRecord()
            begin
                if ("CCS Posted CM Print Option" = "CCS Posted CM Print Option"::"Credit Memo") then
                    RepLabel := 'Gutschrift'
                else
                    RepLabel := 'Rechnungskorrektur';
            end;
        }
    }


    var
        RepLabel: Text[30];


}