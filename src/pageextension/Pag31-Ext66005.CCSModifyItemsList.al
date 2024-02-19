/// <summary>
/// PageExtension CCS ModifyItemsList (ID 66005) extends Record Item List //31.
/// </summary>
pageextension 66005 "CCS ModifyItemsList" extends "Item List" //31
{
    layout
    {
        addafter("No.")
        {
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
            field("CCS Instant Ord Invt"; Rec."CCS Instant Ord Invt")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Instant Order Inventory field.';
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
            field("CCS Blocking Order Invt"; Rec."CCS Blocking Order Invt")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Blocking Order Inventory field.';
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
            field("CCS Unit Qty 40 HC feet Cont."; Rec."CCS Unit Qty 40 HC feet Cont.")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Unit Qty 40 HC feet Cont. field.';
            }
            field("CCS Rec. Sales Price"; Rec."CCS Rec. Sales Price")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Rec. Sales Price field.';
            }
            field("CCS Model Status"; Rec."CCS Model Status")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Model Status field.';
            }
            field("CCS Brand"; Rec."CCS Brand")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Brand field.';
            }
            field("Free Available Stock"; Rec."Free Available Stock")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Free Available Stock field.';
            }
            field("VPE length in cm"; Rec."VPE length in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VPE length in m field.';
            }
            field("VPE width in cm"; Rec."VPE width in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VPE width in m field.';
            }
            field("VPE height in cm"; Rec."VPE height in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VPE height in m field.';
            }
            field("Product length in cm"; Rec."Product length in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product length in cm field.';
            }
            field("Product height in cm"; Rec."Product height in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product height in cm field.';
            }
            field("Product width in cm"; Rec."Product width in cm")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Product width in cm field.';
            }
            field("BDA Languages"; Rec."BDA Languages")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the BDA Languages field.';
            }
            field("Goods Group"; Rec."Goods Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Goods Group field.';
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Net Weight field.';
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Gross Weight field.';
            }
            field("Unit Volume"; Rec."Unit Volume")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Unit Volume field.';
            }
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Country/Region of Origin Code field.';
            }
        }
    }
    trigger OnAfterGetRecord()
    var

    begin
        Rec.CalcFields(Inventory, "CCS Instant Ord Invt", "CCS Blocking Order Invt");
        rec."Free Available Stock" := Rec.Inventory - (Rec."CCS Instant Ord Invt" + Rec."CCS Blocking Order Invt");
    end;
}
