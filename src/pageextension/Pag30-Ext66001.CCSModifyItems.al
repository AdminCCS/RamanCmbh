/// <summary>
/// PageExtension CCS ModifyItems (ID 66001) extends Record Item Card //30.
/// </summary>
pageextension 66001 "CCS ModifyItems" extends "Item Card" //30
{

    layout
    {
        modify("Description 2")
        {
            ShowMandatory = true;
        }
        modify("No.")
        {
            ShowMandatory = true;
        }
        modify("Item Category Code")
        {
            ShowMandatory = true;
        }
        modify("Net Weight")
        {
            ShowMandatory = true;
            BlankZero = true;
        }
        modify("Gross Weight")
        {
            ShowMandatory = true;
            BlankZero = true;
        }
        modify("Unit Volume")
        {
            ShowMandatory = true;
            BlankZero = true;
        }
        addafter(Warehouse)
        {

            group(CCSSetups)
            {
                Caption = 'CCS Setups';
                field("CCS Unit Qty 20 feet Cont."; Rec."CCS Unit Qty 20 feet Cont.")
                {
                    ApplicationArea = all;
                }

                field("CCS Unit Qty 40 feet Cont."; Rec."CCS Unit Qty 40 feet Cont.")
                {
                    ApplicationArea = all;
                }
                field("CCS Unit Qty 40 HC feet Cont."; Rec."CCS Unit Qty 40 HC feet Cont.")
                {
                    ApplicationArea = all;
                }
                field("CCS Rec. Sales Price"; Rec."CCS Rec. Sales Price")
                {
                    ApplicationArea = all;
                }


                field("CCS Rec. Street Price"; Rec."CCS Rec. Street Price")
                {
                    ApplicationArea = all;
                }
                field("CCS Pallet Info."; Rec."CCS Pallet Info.")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("CCS Model Status"; Rec."CCS Model Status")
                {
                    ApplicationArea = all;
                }
                field("CCS Custom Tax"; Rec."CCS Custom Tax")
                {
                    ApplicationArea = all;
                }
                field("CCS Battery"; Rec."CCS Battery")
                {
                    ApplicationArea = all;
                }
                field("CCS Color"; Rec."CCS Color")
                {
                    ApplicationArea = all;
                }
                field("CCS EAN"; Rec."CCS EAN")
                {
                    ApplicationArea = all;
                }
                field("CCS Masterbox EAN"; Rec."CCS Masterbox EAN")
                {
                    ApplicationArea = all;
                }
                field("CCS Item Status"; Rec."CCS Item Status")
                {
                    ApplicationArea = all;
                    Visible = false;
                }

                field("CCS Packsize Unit"; Rec."CCS Packsize Unit")
                {
                    ApplicationArea = all;
                    Visible = false;

                }

                field("CCS Packsize Masterbox"; Rec."CCS Masterbox")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    BlankZero = true;
                }
                field("CCS Brand"; rec."CCS Brand")
                {
                    ApplicationArea = all;
                }
                field(InventoryInhand; rec.Inventory)
                {
                    Caption = 'Inventory';
                    ApplicationArea = Basic, Suite;
                    Enabled = IsInventoriable;
                    HideValue = IsNonInventoriable;
                    Importance = Promoted;
                    ToolTip = 'Specifies how many units, such as pieces, boxes, or cans, of the item are in inventory.';

                    trigger OnAssistEdit()
                    var
                        AdjustInventory: Page "Adjust Inventory";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);

                        if RecRef.IsDirty() then begin
                            rec.Modify(true);
                            Commit();
                        end;

                        AdjustInventory.SetItem(rec."No.");
                        if AdjustInventory.RunModal() in [ACTION::LookupOK, ACTION::OK] then
                            rec.Get(rec."No.");
                        CurrPage.Update()
                    end;
                }
                field("CCS Instant Ord Invt"; rec."CCS Instant Ord Invt")
                {
                    Caption = 'Instant Order Inventory';
                    ApplicationArea = all;

                }
                field("CCS Blocking Order Invt"; rec."CCS Blocking Order Invt")
                {
                    Caption = 'Blocking Order Inventory';
                    ApplicationArea = all;

                }
                field("CCS MRP order Invt"; rec."CCS MRP order Invt")
                {
                    Caption = 'Disposition Order Inventory';
                    ApplicationArea = all;

                }
                field("CCS Backlog order Invt"; rec."CCS Backlog order Invt")
                {
                    Caption = 'Backlog Order Inventory';
                    ApplicationArea = all;

                }
                field("Free Available Stock"; rec."Free Available Stock")
                {
                    Caption = 'Free Available Stock', Locked = false;
                    //PromotedActionCategories = ENU = 'Free Available Stock', DEU = 'Kostenloser verfügbarer stock.';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Quantity pallet height 1,05m"; Rec."Quantity pallet height 1,05m")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Pallet height 2,20m"; Rec."Pallet height 2,20m")
                {
                    ApplicationArea = all;
                }
                field("VPE length in cm"; Rec."VPE length in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VPE width in cm"; Rec."VPE width in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("VPE height in cm"; Rec."VPE height in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Volume in m³"; Rec."Volume in m³")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Product length in cm"; Rec."Product length in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Product height in cm"; Rec."Product height in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Product width in cm"; Rec."Product width in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Produkt LxHxB"; Rec."Produkt LxHxB")
                {
                    ApplicationArea = all;
                }
                field("Cable length in m"; Rec."Cable length in m")
                {
                    ApplicationArea = all;
                }
                field("Connector shape"; Rec."Connector shape")
                {
                    ApplicationArea = all;
                }
                field("VK P/P/K in gr."; Rec."VK P/P/K in gr.")
                {
                    ApplicationArea = all;
                }

                field("VK foil in gr."; Rec."VK foil in gr.")
                {
                    ApplicationArea = all;
                }
                field("VK PE foam in gr."; Rec."VK PE foam in gr.")
                {
                    ApplicationArea = all;
                }
                field("VK Styroport in gr."; Rec."VK Styroport in gr.")
                {
                    ApplicationArea = all;
                }
                field("VPE P/P/K in gr."; Rec."VPE P/P/K in gr.")
                {
                    ApplicationArea = all;
                }
                field("Green dot"; Rec."Green dot")
                {
                    ApplicationArea = all;
                }
                field("VPE film in gr."; Rec."VPE film in gr.")
                {
                    ApplicationArea = all;
                }
                field("VPE LxHxB"; Rec."VPE LxHxB")
                {
                    ApplicationArea = all;
                }
                field("GS Co. License"; Rec."GS Co. License")
                {
                    ApplicationArea = all;
                }
                field("BDA Languages"; Rec."BDA Languages")
                {
                    ApplicationArea = all;
                }
                field("Quantity Pallet height 2.20m"; rec."Quantity Pallet height 2.20m")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Goods Group"; Rec."Goods Group")
                {
                    ApplicationArea = all;
                }
                field("PU Styroport in gr."; Rec."PU Styroport in gr.")
                {
                    ApplicationArea = all;
                }
                field("PU PE foam in gr."; Rec."PU PE foam in gr.")
                {
                    ApplicationArea = all;
                }
                field("Pal. Location Krt"; Rec."Pal. Location Krt")
                {
                    ApplicationArea = all;
                }
                field("Technical 1"; Rec."Technical 1")
                {
                    ApplicationArea = all;
                }
                field("Technical 2"; Rec."Technical 2")
                {
                    ApplicationArea = all;
                }
                field("Technical 3"; Rec."Technical 3")
                {
                    ApplicationArea = all;
                }
                field("Technical 4"; Rec."Technical 4")
                {
                    ApplicationArea = all;
                }
                field("Technical 5"; Rec."Technical 5")
                {
                    ApplicationArea = all;
                }

            }
        }

    }
    trigger OnAfterGetRecord()
    var

    begin
        Rec.CalcFields(Inventory, "CCS Instant Ord Invt", "CCS Blocking Order Invt");
        rec."Free Available Stock" := Rec.Inventory - (Rec."CCS Instant Ord Invt" + Rec."CCS Blocking Order Invt");
    end;

    var
        freeAvailableStock: Decimal;

}
