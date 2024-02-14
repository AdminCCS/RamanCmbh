/// <summary>
/// PageExtension CCS Modify PO Subform (ID 66004) extends Record Purchase Order Subform //54.
/// </summary>
pageextension 66004 "CCS Modify PO Subform" extends "Purchase Order Subform" //54
{
    layout
    {
        addafter("Quantity Invoiced")
        {
            field("Pre Sold Quantity"; rec."Pre Sold Quantity")
            {
                ApplicationArea = all;
            }
            field("Free Available Stock"; rec."Free Available Stock")
            {
                Caption = 'Remaining Available Quantity';
                ApplicationArea = all;
                Editable = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    var

    begin
        Rec.CalcFields("Pre Sold Quantity");
        rec."Free Available Stock" := Rec.Quantity - (Rec."Pre Sold Quantity");
    end;

    var
        freeAvailableStock: Decimal;
}