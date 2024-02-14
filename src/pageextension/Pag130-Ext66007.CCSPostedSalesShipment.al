/// <summary>
/// PageExtension CCS PostedSalesShipment (ID 66007) extends Record Posted Sales Shipment //130.
/// </summary>
pageextension 66007 "CCS PostedSalesShipment" extends "Posted Sales Shipment" //130
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print Delivery Note")
            {
                ApplicationArea = all;
                Caption = 'Delivery Note';
                Image = Print;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Print the Delivery Note';
                trigger OnAction()
                var
                    SalesShipmentHeaderRec: Record "Sales Shipment Header";
                begin
                    SalesShipmentHeaderRec.Reset();
                    SalesShipmentHeaderRec.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Delivery Note", true, true, SalesShipmentHeaderRec);

                end;
            }
        }
    }

    var
        myInt: Integer;
}