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
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("CCS Order Type"; Rec."CCS Order Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Order Type field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("CCS Masterbox Qty"; Rec."CCS Masterbox Qty")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Masterbox Qty field.';
                }
                field("CCS Cartons"; Rec."CCS Cartons")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Cartons field.';
                }
            }
        }
    }

}