pageextension 66011 "CCS SalesList" extends "Sales Order List" //9305
{
    layout
    {
        addafter("Assigned User ID")
        {
            field("Promised Delivery Date"; rec."Promised Delivery Date")
            {
                ApplicationArea = all;
            }
        }
    }
}
