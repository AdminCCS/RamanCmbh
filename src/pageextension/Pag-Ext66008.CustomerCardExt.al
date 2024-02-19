pageextension 66008 CustomerCardExt extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
        modify("Shipment Method Code")
        {
            ShowMandatory = true;
        }
        modify("Currency Code")
        {
            ShowMandatory = true;
        }
        modify("VAT Bus. Posting Group")
        {
            ShowMandatory = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }
}