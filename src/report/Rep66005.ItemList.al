report 66005 "Item List"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\ItemList.rdl';
    ApplicationArea = All;
    Caption = 'Item List';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        // dataitem(Customer; Customer)
        // {

        //     DataItemTableView = SORTING("Customer Price Group") where("Customer Price Group" = filter(<> ''));
        //     RequestFilterFields = "No.";
        //     dataitem("Sales Price"; "Sales Price")
        //     {
        //         DataItemTableView = SORTING("Sales Type", "Sales Code", "Item No.", "Starting Date", "Currency Code", "Variant Code", "Unit of Measure Code", "Minimum Quantity") where("Sales Type" = filter("Customer Price Group"));
        //         DataItemLink = "Sales Code" = FIELD("Customer Price Group");

        dataitem(Item; Item)
        {
            //DataItemLink = "No." = FIELD("Item No.");
            DataItemTableView = SORTING("Gen. Prod. Posting Group");
            //PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Technical 1", "Technical 2", "Technical 3", "Technical 4", "Technical 5", "CCS Brand";

            column(Text000; Text000Lbl)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(TIME; Time)
            {
            }
            column(COMPANYNAME; COMPANYPROPERTY.DisplayName())
            {
            }
            column(Item__No__; Item."No.")
            {
            }
            column(Item_Description; Item.Description)
            {
            }
            column(Item__Unit_Cost_; Item."Unit Cost")
            {
            }
            column(Item__Picture; Item.Picture)
            {
            }
            column(Item__Base_Unit_of_Measure_; Item."Base Unit of Measure")
            {
            }
            column(Item_Inventory; Item.Inventory)
            {
            }
            column(IncludeImage; IncludeImage)
            {
            }
            column(Gen_Prod_Posting_Group; Item."Gen. Prod. Posting Group")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Item__No__Caption; FieldCaption(Item."No."))
            {
            }
            column(Item_DescriptionCaption; FieldCaption(Item.Description))
            {
            }
            column(Item__Unit_Cost_Caption; FieldCaption(Item."Unit Cost"))
            {
            }

            column(Model_Status; item."CCS Model Status")
            {
            }
            column(Tarrif_No; item."Tariff No.")
            {
            }
            column(BDA_Languages; item."BDA Languages")
            {
            }
            column(Cabel_Length_in_m; item."CCS Masterbox")
            {
            }
            column(Connector_shape; item."Connector shape")
            {
            }
            column(Goods_Group; item."Goods Group")
            {
            }
            column(CCS_EAN; item."CCS EAN")
            {
            }
            column(CCS_Masterbox_EAN; item."CCS Masterbox EAN")
            {
            }
            column(Net_Weight; item."Net Weight")
            {
            }
            column(Gross_Weight; item."Gross Weight")
            {
            }
            column(CCS_Unit_Qty_40_HC; item."CCS Unit Qty 40 HC feet Cont.")
            {
            }
            column(Unit_Volume; item."Unit Volume")
            {
            }
            // column(Product_HLW; (item."Product length in cm" * Item."Product height in cm" * Item."Product width in cm"))
            // {
            // }
            // column(VPE_HLW; (item."VPE height in cm" * Item."VPE length in cm" * Item."VPE width in cm"))
            // {
            // }
            column(Product_HLW; Item."Produkt LxHxB")
            {
            }
            column(VPE_HLW; item."VPE LxHxB")
            {
            }
            column(Pal_Location_Krt; Item."Pal. Location Krt")
            {
            }
            column(Pallet_height_220; Item."Pallet height 2,20m")
            {
            }
            column(Rec_Street_Price; Item."CCS Rec. Street Price")
            {
            }
            column(Rec_Sales_Price; Item."CCS Rec. Sales Price")
            {
            }
            column(Item_Category_Code; Item."Item Category Code")
            { }
            // column(Customer_No; )
            // {
            // }
            // column(Customer_Spec_Price; )
            // {
            // }
            column(Free_Available_Stock; Item."Free Available Stock")
            {
            }
            column(Technical_1_Val; Item."Technical 1")
            {
            }
            column(Technical_2_Val; Item."Technical 2")
            {
            }
            column(Technical_3_Val; Item."Technical 3")
            {
            }
            column(Technical_4_Val; Item."Technical 4")
            {
            }
            column(Technical_5_Val; Item."Technical 5")
            {
            }
            column(Cust_Price; SalesPrice)
            {
            }
            column(Customer_No; CustCode)
            {
            }
            column(Customer_Curr; custcurr)
            {
            }
            column(HideCustomer; HideCustomer)
            { }
            trigger OnAfterGetRecord()

            begin
                SalesPrice := 0;
                if CustCode <> '' then begin
                    if RecCustomer.Get(CustCode) then begin
                        if RecCustomer."Customer Price Group" <> '' then begin
                            RecSalesPrice.Reset();
                            RecSalesPrice.SetRange("Sales Code", RecCustomer."Customer Price Group");
                            //RecSalesPrice.SetRange("Sales Type", "Sales Price"."Sales Type");
                            RecSalesPrice.SetRange("Item No.", "No.");
                            IF RecSalesPrice.FindSet() then
                                repeat
                                    if (RecSalesPrice."Starting Date" <= Today) and ((RecSalesPrice."Ending Date" >= Today) or (RecSalesPrice."Ending Date" = 0D)) then
                                        SalesPrice := RecSalesPrice."Unit Price";
                                until RecSalesPrice.Next() = 0;
                        end;

                    end;
                    if SalesPrice <> 0 then begin
                        custcurr := RecCustomer."Currency Code";
                    end else
                        CurrReport.Skip();
                end;

                // RecSalesPrice.Reset();
                // RecSalesPrice.SetRange("Sales Code", "Sales Price"."Sales Code");
                // RecSalesPrice.SetRange("Sales Type", "Sales Price"."Sales Type");
                // RecSalesPrice.SetRange("Item No.", "No.");
                // IF RecSalesPrice.FindSet() then
                //     repeat
                //         if (RecSalesPrice."Starting Date" <= Today) and ((RecSalesPrice."Ending Date" >= Today) or (RecSalesPrice."Ending Date" = 0D)) then
                //             SalesPrice := RecSalesPrice."Unit Price";
                //     until RecSalesPrice.Next() = 0;
            end;
        }
        //}

        //}

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(IncludeImage; IncludeImage)
                    {
                        ApplicationArea = All;
                        Caption = 'Include Image';

                    }
                    field(CustCode; CustCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No.';
                        TableRelation = Customer."No.";

                    }

                }
            }
        }

    }

    trigger OnPreReport()

    begin
        if CustCode = '' then
            HideCustomer := true;
    end;

    var
        Item2: Record Item;
        NonstockItem: Record "Nonstock Item";
        UnitCost: Decimal;
        Text000Lbl: Label 'Item List';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        RecCustomer: Record Customer;
        SalesPrice: Decimal;
        RecSalesPrice: Record "Sales Price";
        IncludeImage: Boolean;
        HideCustomer: Boolean;
        CustCode: Code[20];
        custcurr: Code[10];


}

