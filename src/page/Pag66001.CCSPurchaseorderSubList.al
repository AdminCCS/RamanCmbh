/// <summary>
/// Page CCS Purchase order Sub List (ID 66001).
/// </summary>
page 66001 "CCS Purchase order Sub List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Purchase Line";
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
                field("Pre Sold Quantity"; Rec."Pre Sold Quantity")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Pre-Sold Quantity field.';
                }
                field("Free Available Stock"; Rec."Free Available Stock")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Free Available Stock field.';
                }

            }
        }
    }
    trigger OnAfterGetRecord()
    var

    begin
        Rec.CalcFields("Pre Sold Quantity");
        rec."Free Available Stock" := Rec.Quantity - (Rec."Pre Sold Quantity");
    end;

}