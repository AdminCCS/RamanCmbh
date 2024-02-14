/// <summary>
/// PageExtension CCS ModifySO (ID 66003) extends Record Sales Order //42.
/// </summary>
pageextension 66003 "CCS ModifySO" extends "Sales Order" //42
{
    layout
    {
        addafter(WorkDescription)
        {
            field("Order Type"; rec."ccs Order Type")
            {
                ApplicationArea = all;
            }
        }
    }

}
