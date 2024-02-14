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
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Pre Sold Quantity"; Rec."Pre Sold Quantity")
                {
                    ApplicationArea = all;
                }
                field("Free Available Stock"; Rec."Free Available Stock")
                {
                    ApplicationArea = all;
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