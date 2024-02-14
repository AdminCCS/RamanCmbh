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
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = all;
            }
            field("CCS Instant Ord Invt"; Rec."CCS Instant Ord Invt")
            {
                ApplicationArea = All;
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
            field("CCS Blocking Order Invt"; Rec."CCS Blocking Order Invt")
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
            field("CCS Unit Qty 40 HC feet Cont."; Rec."CCS Unit Qty 40 HC feet Cont.")
            {
                ApplicationArea = all;
            }
            field("CCS Rec. Sales Price"; Rec."CCS Rec. Sales Price")
            {
                ApplicationArea = All;
            }
            field("CCS Model Status"; Rec."CCS Model Status")
            {
                ApplicationArea = All;
            }
            field("CCS Brand"; Rec."CCS Brand")
            {
                ApplicationArea = All;
            }
            field("Free Available Stock"; Rec."Free Available Stock")
            {
                ApplicationArea = All;
            }
            field("VPE length in cm"; Rec."VPE length in cm")
            {
                ApplicationArea = All;
            }
            field("VPE width in cm"; Rec."VPE width in cm")
            {
                ApplicationArea = All;
            }
            field("VPE height in cm"; Rec."VPE height in cm")
            {
                ApplicationArea = All;
            }
            field("Product length in cm"; Rec."Product length in cm")
            {
                ApplicationArea = All;

            }
            field("Product height in cm"; Rec."Product height in cm")
            {
                ApplicationArea = All;
            }
            field("Product width in cm"; Rec."Product width in cm")
            {
                ApplicationArea = All;
            }
            field("BDA Languages"; Rec."BDA Languages")
            {
                ApplicationArea = All;
            }
            field("Goods Group"; Rec."Goods Group")
            {
                ApplicationArea = All;
            }
            field("Net Weight"; Rec."Net Weight")
            {
                ApplicationArea = All;
            }
            field("Gross Weight"; Rec."Gross Weight")
            {
                ApplicationArea = All;
            }
            field("Unit Volume"; Rec."Unit Volume")
            {
                ApplicationArea = All;
            }
            field("Country/Region of Origin Code"; Rec."Country/Region of Origin Code")
            {
                ApplicationArea = All;

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
