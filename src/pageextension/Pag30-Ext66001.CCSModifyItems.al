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
                    ToolTip = 'Specifies the value of the Unit Qty 20 feet Cont. field.';
                }

                field("CCS Unit Qty 40 feet Cont."; Rec."CCS Unit Qty 40 feet Cont.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Unit Qty 40 feet Cont. field.';
                }
                field("CCS Unit Qty 40 HC feet Cont."; Rec."CCS Unit Qty 40 HC feet Cont.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Unit Qty 40 HC feet Cont. field.';
                }
                field("CCS Rec. Sales Price"; Rec."CCS Rec. Sales Price")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Rec. Sales Price field.';
                }


                field("CCS Rec. Street Price"; Rec."CCS Rec. Street Price")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Rec. Street Price field.';
                }
                field("CCS Pallet Info."; Rec."CCS Pallet Info.")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Pallet Info. field.';
                }

                field("CCS Model Status"; Rec."CCS Model Status")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Model Status field.';
                }
                field("CCS Custom Tax"; Rec."CCS Custom Tax")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Custom Tax field.';
                }
                field("CCS Battery"; Rec."CCS Battery")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Battery field.';
                }
                field("CCS Color"; Rec."CCS Color")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Color field.';
                }
                field("CCS EAN"; Rec."CCS EAN")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the EAN field.';
                }
                field("CCS Masterbox EAN"; Rec."CCS Masterbox EAN")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Masterbox EAN field.';
                }
                field("CCS Item Status"; Rec."CCS Item Status")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item Status field.';
                }

                field("CCS Packsize Unit"; Rec."CCS Packsize Unit")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Packsize Unit field.';
                }

                field("CCS Packsize Masterbox"; Rec."CCS Masterbox")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    BlankZero = true;
                    ToolTip = 'Specifies the value of the Masterbox Qty. field.';
                }
                field("CCS Brand"; rec."CCS Brand")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Brand field.';
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
                    ToolTip = 'Specifies the value of the Instant Order Inventory field.';
                }
                field("CCS Blocking Order Invt"; rec."CCS Blocking Order Invt")
                {
                    Caption = 'Blocking Order Inventory';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Blocking Order Inventory field.';
                }
                field("CCS MRP order Invt"; rec."CCS MRP order Invt")
                {
                    Caption = 'Disposition Order Inventory';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Disposition Order Inventory field.';
                }
                field("CCS Backlog order Invt"; rec."CCS Backlog order Invt")
                {
                    Caption = 'Backlog Order Inventory';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Backlog Order Inventory field.';
                }
                field("Free Available Stock"; rec."Free Available Stock")
                {
                    Caption = 'Free Available Stock', Locked = false;
                    //PromotedActionCategories = ENU = 'Free Available Stock', DEU = 'Kostenloser verfügbarer stock.';
                    ApplicationArea = all;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Free Available Stock field.';
                }
                field("Quantity pallet height 1,05m"; Rec."Quantity pallet height 1,05m")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity pallet height 1,05m field.';
                }
                field("Pallet height 2,20m"; Rec."Pallet height 2,20m")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Pallet height 2,20m field.';
                }
                field("VPE length in cm"; Rec."VPE length in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the VPE length in m field.';
                }
                field("VPE width in cm"; Rec."VPE width in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the VPE width in m field.';
                }
                field("VPE height in cm"; Rec."VPE height in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the VPE height in m field.';
                }
                field("Volume in m³"; Rec."Volume in m³")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Volume in m³ field.';
                }
                field("Product length in cm"; Rec."Product length in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Product length in cm field.';
                }
                field("Product height in cm"; Rec."Product height in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Product height in cm field.';
                }
                field("Product width in cm"; Rec."Product width in cm")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Product width in cm field.';
                }
                field("Produkt LxHxB"; Rec."Produkt LxHxB")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Produkt LxHxB field.';
                }
                field("Cable length in m"; Rec."Cable length in m")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Cable length in m field.';
                }
                field("Connector shape"; Rec."Connector shape")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Connector shape field.';
                }
                field("VK P/P/K in gr."; Rec."VK P/P/K in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VK P/P/K in gr. field.';
                }

                field("VK foil in gr."; Rec."VK foil in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VK foil in gr. field.';
                }
                field("VK PE foam in gr."; Rec."VK PE foam in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VK PE foam in gr. field.';
                }
                field("VK Styroport in gr."; Rec."VK Styroport in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VK Styroport in gr. field.';
                }
                field("VPE P/P/K in gr."; Rec."VPE P/P/K in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VPE P/P/K in gr. field.';
                }
                field("Green dot"; Rec."Green dot")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Green dot field.';
                }
                field("VPE film in gr."; Rec."VPE film in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VPE film in gr. field.';
                }
                field("VPE LxHxB"; Rec."VPE LxHxB")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the VPE LxHxB field.';
                }
                field("GS Co. License"; Rec."GS Co. License")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the GS Co. License field.';
                }
                field("BDA Languages"; Rec."BDA Languages")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the BDA Languages field.';
                }
                field("Quantity Pallet height 2.20m"; rec."Quantity Pallet height 2.20m")
                {
                    ApplicationArea = all;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Quantity Pallet height 2.20m field.';
                }
                field("Goods Group"; Rec."Goods Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Goods Group field.';
                }
                field("PU Styroport in gr."; Rec."PU Styroport in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the PU Styroport in gr. field.';
                }
                field("PU PE foam in gr."; Rec."PU PE foam in gr.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the PU PE foam in gr. field.';
                }
                field("Pal. Location Krt"; Rec."Pal. Location Krt")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Pal. Location Krt field.';
                }
                field("Technical 1"; Rec."Technical 1")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Technical 1 field.';
                }
                field("Technical 2"; Rec."Technical 2")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Technical 2 field.';
                }
                field("Technical 3"; Rec."Technical 3")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Technical 3 field.';
                }
                field("Technical 4"; Rec."Technical 4")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Technical 4 field.';
                }
                field("Technical 5"; Rec."Technical 5")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Technical 5 field.';
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

}
