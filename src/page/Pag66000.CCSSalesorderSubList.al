page 66000 "CCS Sales order Sub List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Line";
    Editable = false;
    SourceTableView = where("Document Type" = const(Order));
    layout
    {
        area(Content)
        {
            repeater(SalesLineList)
            {

                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("CCS Order Type"; Rec."CCS Order Type")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("CCS Masterbox Qty"; Rec."CCS Masterbox Qty")
                {
                    ApplicationArea = all;
                }
                field("CCS Cartons"; Rec."CCS Cartons")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

}