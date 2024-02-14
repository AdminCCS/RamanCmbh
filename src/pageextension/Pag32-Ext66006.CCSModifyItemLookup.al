pageextension 66006 "CCS ModifyItemLookup" extends "Item Lookup" //32
{
    layout
    {
        addafter("No.")
        {
            field("CCS Blocking Order Invt"; Rec."CCS Blocking Order Invt")
            {
                ApplicationArea = all;
            }
            field("CCS Instant Ord Invt"; Rec."CCS Instant Ord Invt")
            {
                ApplicationArea = all;
            }
            field("Free Available Stock"; Rec."Free Available Stock")
            {
                ApplicationArea = all;
            }
            field(Inventory; Rec.Inventory)
            {
                ApplicationArea = all;
            }
            field("CCS Color"; Rec."CCS Color")
            {
                ApplicationArea = all;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = all;
            }
            field("CCS Backlog order Invt"; Rec."CCS Backlog order Invt")
            {
                ApplicationArea = all;
            }
            field("CCS Masterbox"; Rec."CCS Masterbox")
            {
                ApplicationArea = all;
            }
            field("CCS Masterbox EAN"; Rec."CCS Masterbox EAN")
            {
                ApplicationArea = all;
            }
            field("CCS MRP order Invt"; Rec."CCS MRP order Invt")
            {
                ApplicationArea = all;
            }
            field("CCS Rec. Street Price"; Rec."CCS Rec. Street Price")
            {
                ApplicationArea = all;
            }
            field("CCS EAN"; Rec."CCS EAN")
            {
                ApplicationArea = all;
            }
        }
    }
}
