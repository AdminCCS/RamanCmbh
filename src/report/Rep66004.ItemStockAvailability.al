/// <summary>
/// Report Item Stock Availability (ID 66004).
/// </summary>
report 66004 "Item Stock Availability"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\ItemStockAvail.rdl';
    Caption = 'Item Stock Availability';

    dataset
    {
        dataitem(Item; Item)
        {
            //PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Description";
            CalcFields = Inventory, "CCS Instant Ord Invt", "CCS Blocking Order Invt", "CCS Backlog order Invt";
            column(CompanyName; COMPANYPROPERTY.DisplayName())
            {
            }
            column(ItemTableCaptItemFilter; TableCaption + ': ' + ItemFilter)
            {
            }
            column(ItemFilter; ItemFilter)
            {
            }
            column(No_Item; "No.")
            {
            }
            column(Description_Item; Description)
            {
            }
            column(CCS_Model_Status; "CCS Model Status")
            {
            }
            column(Inventory; Inventory)
            { }
            column(CCS_Instant_Ord_Invt; "CCS Instant Ord Invt")
            { }
            column(CCS_Blocking_Order_Invt; "CCS Blocking Order Invt")
            { }
            column(CCS_Backlog_order_Invt; "CCS Backlog order Invt")
            { }
            column(FreeAvailableStock; FreeAvailableStock)
            { }
            column(Picture; Picture)
            {
            }
            column(ImageInclude; ImageInclude)
            { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                //PrintOnlyIfDetail = true;
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("Document Type", Type, "No.") where(Type = const(Item), "Document Type" = const(Order));
                column(PONo_; "Document No.")
                { }
                column(EDD; EDD)
                { }
                column(Pre_Sold_Quantity; "Pre Sold Quantity")
                { }
                column(RemainingAvalQty; RemainingAvalQty)
                { }
                column(POstatus; POstatus)
                { }
                column(Quantity; Quantity)
                { }

                trigger OnAfterGetRecord()
                var
                    PurchHeader: Record "Purchase Header";
                begin
                    if Quantity = "Qty. Invoiced (Base)" then
                        CurrReport.Skip();

                    "Purchase Line".CalcFields("Pre Sold Quantity");
                    RemainingAvalQty := "Purchase Line".Quantity - ("Purchase Line"."Pre Sold Quantity");
                    if PurchHeader.get("Purchase Line"."Document Type", "Purchase Line"."Document No.") then
                        POstatus := FORMAT(PurchHeader."CCS Purchase Order Status");
                    EDD := PurchHeader."CCS ETD";

                end;
            }

            trigger OnAfterGetRecord()

            begin
                FreeAvailableStock := item.Inventory - (item."CCS Instant Ord Invt" + item."CCS Blocking Order Invt");
            end;

        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Option)
                {
                    Caption = 'Options';
                    field(ImageIncludeField; ImageInclude)
                    {
                        ApplicationArea = All;
                        Caption = 'Image Include';
                        ToolTip = 'Specifies that Item Image will be shown on report or not.';
                    }
                }
            }
        }
        trigger OnInit()
        begin
            ImageInclude := Item."CCS Image Included";
        end;
    }

    trigger OnPreReport()
    begin
        ItemFilter := Item.GetFilters;

    end;

    var
        ImageInclude: Boolean;
        EDD: Date;
        FreeAvailableStock: Decimal;
        RemainingAvalQty: Decimal;
        ItemFilter: Text;
        POstatus: Text;
}