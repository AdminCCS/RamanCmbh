report 66007 "CCS PO Arivals"
{
    ApplicationArea = All;
    Caption = 'PO Arrivals';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Src\Layouts\POArivals.rdlc';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(order));
            RequestFilterFields = "No.", "CCS ETD", "CCS Container No.";
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = sorting("Document Type", "Receipt No.", "Receipt Line No.") where(Type = const(Item));
                DataItemLinkReference = PurchaseHeader;
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                column(shipmentMethod; PurchaseHeader."Shipment Method Code")
                { }
                column(PaymentTerms; PurchaseHeader."Payment Terms Code")
                { }
                column(Prepayment; PurchaseHeader."Prepayment Due Date")
                { }
                column(Currency_Code; PurchaseHeader."Currency Code")
                { }
                column(CCSPurchaseOrderStatus_PurchaseHeader; PurchaseHeader."CCS Purchase Order Status")
                {
                }
                column(CCSPODCode_PurchaseHeader; PurchaseHeader."CCS POD Code")
                {
                }
                column(No_PurchaseHeader; PurchaseHeader."No.")
                {
                }
                column(CCSETD_PurchaseHeader; PurchaseHeader."CCS ETD")
                {
                }
                column(CCS_Container_No_; PurchaseHeader."CCS Container No.")
                { }
                column(No_PurchaseLine; "No.")
                {
                }
                column(Description_PurchaseLine; Description)
                {
                }
                column(Quantity_PurchaseLine; Quantity)
                {
                }
                column(MasterBoxQty; Item."CCS Masterbox")
                { }
                column(ModelStatus; item."CCS Model Status")
                { }
                column(volume; item."Unit Volume")
                { }
                column(OrderInventory; item."CCS Instant Ord Invt")
                { }
                column(TotalCBM; TotalCBM)
                { }
                column(TotalQty; TotalQty)
                { }
                trigger OnAfterGetRecord()
                begin
                    item.get("Purchase Line"."No.");
                    TotalCBM := "Purchase Line".Quantity * item."Unit Volume";
                end;
            }
            trigger OnPreDataItem()
            begin
                SetCurrentKey("CCS Container No.");
            end;

        }
    }
    var
        Item: Record Item;
        TotalCBM: Decimal;
        TotalQty: Decimal;

}

