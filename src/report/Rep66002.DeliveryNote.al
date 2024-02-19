/// <summary>
/// Report Delivery Note (ID 66002).
/// </summary>
report 66002 "Delivery Note"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Delivery Note';
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\DeliveryNote.rdl';

    dataset
    {
        dataitem("Sales Shipment Header"; "Sales Shipment Header")
        {
            column(ShipmentMethodDescription; ShipmentMethod.Description)
            {
            }
            column(PaymentInstructions_Txt; PaymentInstructions_Txt)
            { }
            column(Header_No; "No.")
            {
                IncludeCaption = true;
            }
            column(Header_NoCaption; fieldcaption("No."))
            {

            }
            column(ReportTitle; ReportTitle)
            {

            }
            column(CompanyInfo_Logo; CompanyInfo.Picture)
            {
                // IncludeCaption = true;
            }
            column(DocumentDate; "Document Date")
            { }
            column(CompanyInfo_Details; CompanyInfo.Name + '-' + CompanyInfo.Address + '-' + CompanyInfo."Country/Region Code" + '-' + CompanyInfo."Post Code" + '-' + CompanyInfo.City) { }
            column(DeliveryNoteNo; "No.") { }
            column(DateofIssue; "Posting Date") { }
            column(Referance; "External Document No.") { }
            column(Debtor; "Bill-to Customer No.") { }
            column(KdUstidNo; Customer."VAT Registration No.") { }
            column(DeliveryCondition; ' ') { }
            column(VertrNr; SalespersonPurchaser2.code) { }
            column(DeliveryNoteNo_Lbl; DeliveryNoteNo_Lbl) { }
            column(DateofIssue_Lbl; DateofIssue_Lbl) { }
            column(OrderNumber; "Order No.") { }
            column(ContactPerson; SalespersonPurchaser2.Name) { }
            column(Referance_Lbl; Referance_Lbl) { }
            column(Debtor_Lbl; Debtor_Lbl) { }
            column(KdUstidNo_Lbl; KdUstidNo_Lbl) { }
            column(OrderNumber_Lbl; OrderNumber_Lbl) { }
            column(DeliveryCondition_Lbl; DeliveryCondition_Lbl) { }
            column(VertrNr_Lbl; VertrNr_Lbl) { }
            column(ContactPerson_Lbl; ContactPerson_Lbl) { }
            column(ShippingDeliveryAddress_Lbl; ShippingDeliveryAddress_Lbl) { }
            column(ShortLine_Lbl; ShortLine_Lbl) { }

            column(ShipToAddr1; ShipToAddr[1])
            {
            }
            column(ShipToAddr2; ShipToAddr[2])
            {
            }
            column(ShipToAddr3; ShipToAddr[3])
            {
            }
            column(ShipToAddr4; ShipToAddr[4])
            {
            }
            column(ShipToAddr5; ShipToAddr[5])
            {
            }
            column(ShipToAddr6; ShipToAddr[6])
            {
            }
            column(ShipToAddr7; ShipToAddr[7])
            {
            }
            column(ShipToAddr8; ShipToAddr[8])
            {
            }


            dataitem("Sales Shipment Line"; "Sales Shipment Line")
            {
                DataItemLinkReference = "Sales Shipment Header";
                DataItemLink = "Document No." = field("No.");
                column(ItemEAN; ItemEAN)
                { }
                column(EANVPE; eanvpe)
                { }
                column(Zollopos; tarrif)
                { }
                column(Pos_Lbl; Pos_Lbl) { }

                column(ArticleNo_Lbl; ArticleNo_Lbl)
                {

                }
                column(Qty_Lbl; Qty_Lbl) { }
                column(Unit_Lbl; Unit_Lbl) { }
                column(PU; "CCS Masterbox Qty") { }
                column(Carton; "CCS Cartons") { }
                column(PU_Lbl; pu_lbl) { }//MasterBox
                column(Carton_Lbl; Carton_Lbl) { }//CCS Cartons

                column(ArticleDescription_Lbl; ArticleDescription_Lbl) { }
                column(ItemDescription_Lbl; ItemDescription_Lbl) { }
                column(SrNo; SrNo) { }
                column(Type; Type)
                {
                    IncludeCaption = true;
                }
                column(Item_No; "No.")
                {
                    IncludeCaption = true;
                }
                column(ItemNoCaption; Fieldcaption("No."))
                {
                }
                column(Unit_of_Measure_Code; "Unit of Measure Code")
                {
                    IncludeCaption = true;
                }
                column(Unit_of_Measure_Code_Caption; Fieldcaption("Unit of Measure Code"))
                {

                }
                column(Quantity; Quantity)
                {

                }
                column(QuantityCaption; Fieldcaption(Quantity))
                {

                }
                column(Line_Description; Description)
                {

                }
                column(DescriptionCaption; Fieldcaption(Description))
                {

                }
                column(VolumeN; VolumeN)
                { }
                column(TotalCarton; TotalCarton)
                {
                }
                column(TotalWeight; TotalWeight)
                { }
                column(Line_No_; "Line No.")
                { }
                column(ItemDescription; "Description 2") { }
                trigger OnPreDataItem()
                begin
                    SrNo := 0;
                end;

                trigger OnAfterGetRecord()
                var
                    Item: Record Item;
                begin

                    Clear(Item);
                    ItemEAN := '';
                    eanVpe := '';
                    Tarrif := '';
                    if item.get("Sales Shipment Line"."No.") then begin
                        VolumeN += round(Quantity * item."Unit Volume", 0.01);

                        ItemEAN := item."CCS EAN";
                        eanVpe := item."CCS Masterbox EAN";
                        Tarrif := item."Tariff No.";
                        SrNo += 1;

                        TotalWeight += Round(Quantity * item."Gross Weight");
                        TotalCarton += "CCS Cartons";
                    end;


                end;

            }
            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language1.GetLanguageIdOrDefault("Language Code");

                ShipToAddr[1] := "Sales Shipment Header"."Ship-to Name";
                ShipToAddr[2] := "Sales Shipment Header"."Ship-to Contact";
                ShipToAddr[3] := "Sales Shipment Header"."Ship-to Address";
                ShipToAddr[4] := "Sales Shipment Header"."Ship-to Address 2";
                ShipToAddr[5] := "Sales Shipment Header"."Ship-to Post Code" + ' ' + "Sales Shipment Header"."Ship-to City";
                ShipToAddr[6] := "Sales Shipment Header"."Ship-to Country/Region Code";
                CompressArray(ShipToAddr);
                Clear(PaymentInstructions_Txt);
                if PaymentTerms.get("Payment Terms Code") then
                    PaymentInstructions_Txt := PaymentTerms.Description;
                Clear(ShipmentMethod);
                if ShipmentMethod.get("Shipment Method Code") then;
                Clear(Customer);
                if Customer.get("Sell-to Customer No.") then;

                Clear(SalespersonPurchaser2);
                if SalespersonPurchaser2.get("Salesperson Code") then;


            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Executes the ActionName action.';
                }
            }
        }

    }
    labels
    {
        titlecaption = 'Delivery Note', Comment = 'Title', MaxLength = 999, Locked = false;
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

    end;

    var
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        PaymentTerms: Record "Payment Terms";
        SalespersonPurchaser2: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        Language1: Codeunit Language;
        eanVpe: Code[20];
        Tarrif: Code[20];
        TotalCarton: Decimal;
        TotalWeight: Decimal;
        VolumeN: Decimal;

        SrNo: Integer;
        ArticleDescription_Lbl: Label 'Artikelbezeichnung / EAN'; //Artikelbezeichnung / EAN  //Article Description/EAN

        ArticleNo_Lbl: Label 'Artikelnr.'; // Artikelnr. //Article No.
        Carton_Lbl: Label 'Karton';//Karton //Carton
        ContactPerson_Lbl: Label 'Ansprechpartner/Sachbearbeiter';//Ansprechpartner/Sachbearbeiter //Contact Person/Clerk
        DateofIssue_Lbl: Label 'Austell-Datum';//Austell-Datum //Date of issue
        Debtor_Lbl: Label 'Debitor/Kd.-Nr.';//Debitor/Kd.-Nr. //Debtor/Kd.-Nr.
        DeliveryCondition_Lbl: Label 'Lieferbedingung'; //Lieferbedingung //Delivery Condition
        DeliveryNoteNo_Lbl: Label 'Lieferscheinnr.'; //Lieferscheinnr. //Delivery Note No.
        ItemDescription_Lbl: Label 'Artikelbeschreibung';//Artikelbeschreibung // Item Description
        KdUstidNo_Lbl: Label 'Kd. Ust-Id Nr.';//Kd. Ust-Id Nr.//Kd. Ust-Id No.
        OrderNumber_Lbl: Label 'Auftragsnr.';//Auftragsnr. //Order Number.
        Pos_Lbl: Label 'Pos.';
        PU_Lbl: Label 'VPE';//VPE //PU
        Qty_Lbl: Label 'Menge';//Menge //Quantity
        Referance_Lbl: Label 'Referenz';//Referenz //Reference

        ReportTitle: Label 'Lieferschein'; //Lieferschein //Delivery Note
        ShippingDeliveryAddress_Lbl: Label 'Lieferanschrift'; //Versand / Lieferanschrift  // Shipping/delivery address
        ShortLine_Lbl: Label 'Bei Rückfragen bitte angeben!'; //Bei Rückfragen bitte angeben!  //Please specify when making inquiries!
        Unit_Lbl: Label 'Einheit';//Einheit //Unit
        VertrNr_Lbl: Label 'Vertr.-Nr.';//Vertr.-Nr. //Vertr.-Nr.
        ItemEAN: Text;
        PaymentInstructions_Txt: Text;
        ShipToAddr: array[8] of Text[100];
}