pageextension 66006 "CCS ModifyItemLookup" extends "Item Lookup" //32
{
    layout
    {
        addafter("No.")
        {
            field("CCS Blocking Order Invt"; Rec."CCS Blocking Order Invt")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Blocking Order Inventory field.';
            }
            field("CCS Instant Ord Invt"; Rec."CCS Instant Ord Invt")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Instant Order Inventory field.';
            }
            field("Free Available Stock"; Rec."Free Available Stock")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Free Available Stock field.';
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Inventory field.';
            }
            field("CCS Color"; Rec."CCS Color")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Color field.';
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Qty. on Sales Order field.';
            }
            field("CCS Backlog order Invt"; Rec."CCS Backlog order Invt")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Backlog order Inventory field.';
            }
            field("CCS Masterbox"; Rec."CCS Masterbox")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Masterbox Qty. field.';
            }
            field("CCS Masterbox EAN"; Rec."CCS Masterbox EAN")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Masterbox EAN field.';
            }
            field("CCS MRP order Invt"; Rec."CCS MRP order Invt")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Disposition order Inventory field.';
            }
            field("CCS Rec. Street Price"; Rec."CCS Rec. Street Price")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Rec. Street Price field.';
            }
            field("CCS EAN"; Rec."CCS EAN")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the EAN field.';
            }
        }
    }
}
