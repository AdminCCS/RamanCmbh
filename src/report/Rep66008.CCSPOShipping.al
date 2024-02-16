report 66008 "CCS PO Shipping"
{
    ApplicationArea = All;
    Caption = 'PO Shipping';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = 'Src\Layouts\POShipping.rdlc';
    dataset
    {
        dataitem(PurchaseHeader; "Purchase Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = const(order));
            RequestFilterFields = "No.", "CCS ETD", "CCS Container No.";
            CalcFields = "CCS Total Balance Amt", "CCS Total Deposit Amt";
            column(shipmentMethod;
            PurchaseHeader."Shipment Method Code")
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
            column(CCSDepositExchange_PurchaseHeader; PurchaseHeader."CCS Deposit Exchange")
            {
            }
            column(CCSDepositPaymentDate_PurchaseHeader; PurchaseHeader."CCS Deposit Payment Date")
            {
            }
            column(CCSDepositPaymentStatus_PurchaseHeader; PurchaseHeader."CCS Deposit Payment Status")
            {
            }

            column(CCSBalanceExchange_PurchaseHeader; PurchaseHeader."CCS Balance Exchange")
            {
            }
            column(CCSBalancePaymentDate_PurchaseHeader; PurchaseHeader."CCS Balance Payment Date")
            {
            }
            column(CCSBalancePaymentStatus_PurchaseHeader; PurchaseHeader."CCS Balance Payment Status")
            {
            }
            column(CCSCommercialInvoiceStatus_PurchaseHeader; PurchaseHeader."CCS Commercial Invoice Status")
            {
            }
            column(CCSInspection_PurchaseHeader; PurchaseHeader."CCS Inspection")
            {
            }
            column(CCSInspectionAgent_PurchaseHeader; PurchaseHeader."CCS Inspection Agent")
            {
            }
            column(CCSInspectionReportNo_PurchaseHeader; PurchaseHeader."CCS Inspection Report No.")
            {
            }
            column(CCSPackingListStatus_PurchaseHeader; PurchaseHeader."CCS Packing List Status")
            {
            }
            column(CCSBillofLadingCopyStatus_PurchaseHeader; PurchaseHeader."CCS Bill of Lading Copy Status")
            {
            }
            column(CCSBillofLadingNo_PurchaseHeader; PurchaseHeader."CCS Bill of Lading No.")
            {
            }
            column(CCSReleaseStatus_PurchaseHeader; PurchaseHeader."CCS Release Status")
            {
            }
            column(CCSPortAgent_PurchaseHeader; PurchaseHeader."CCS Port Agent")
            {
            }
            column(totalOrderAmt; PurchaseHeader."CCS Total Balance Amt" + PurchaseHeader."CCS Total Deposit Amt")
            { }
            column(CCSFinalExchange_PurchaseHeader; PurchaseHeader."CCS Final Exchange")
            { }
            column(sealNo; PurchaseHeader."CCS Seal No.")
            { }
            column(forwarder; PurchaseHeader."CCS Forwarder Code")
            { }
            column(shipcost; PurchaseHeader."CCS Shipping Cost")
            { }
            column(shipPaymentDate; PurchaseHeader."CCS Shipping Payment Date")
            { }
            column(CCSDepositAmount_PurchaseHeader; PurchaseHeader."CCS Deposit Amount")
            {
            }
            column(CCSBalanceAmount_PurchaseHeader; PurchaseHeader."CCS Balance Amount")
            {
            }
            column(Total_Container_Amt; PurchaseHeader."CCS Total Balance Amt")
            { }
            column(CCS_Total_Deposit_Amt; "CCS Total Deposit Amt")
            { }
            column(SubTotalCarton; SubTotalCarton)
            { }
            column(SubTotalCbm; TotalCbm)
            { }
            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = sorting("Document Type", "Receipt No.", "Receipt Line No.") where(Type = const(Item));
                DataItemLinkReference = PurchaseHeader;
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
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
                column(TotalCBM; quantity * Item."Unit Volume")
                { }
                column(TotalCarton; TotalCarton)
                { }
                column(goodgroup; item."Goods Group")
                { }
                column(Vendorname; vendor.Name)
                { }
                column(Unit_Price__LCY_; "Direct Unit Cost")
                { }
                trigger OnPreDataItem()
                begin
                    SubTotalCarton := 0;
                    TotalCbm := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    TotalCarton := 0;
                    item.get("Purchase Line"."No.");
                    if vendor.get("Purchase Line"."Buy-from Vendor No.") then;
                    if Item."CCS Masterbox" <> 0 then
                        TotalCarton := Quantity / item."CCS Masterbox";

                    SubTotalCarton += TotalCarton;
                    TotalCbm += Quantity * Item."Unit Volume";
                end;



            }
            trigger OnPreDataItem()
            begin
                SetCurrentKey("CCS Container No.");
            end;

            trigger OnAfterGetRecord()
            begin

            end;


        }
    }
    var
        Item: Record Item;
        TotalCarton: Decimal;
        SubTotalCarton: Decimal;
        TotalCbm: Decimal;
        Vendor: Record Vendor;

}
