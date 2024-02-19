/// <summary>
/// Report ProformaInvoice (ID 66000).
/// </summary>
report 66000 "ProformaInvoice"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\ProInv.rdl';
    Caption = 'Pro Forma Invoice';
    ApplicationArea = All;

    dataset
    {
        dataitem(Header; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Pro Forma Invoice';
            column(DocumentDate; "Document Date")
            {
            }
            column(CompanyPicture; CompanyInformation.Picture)
            {
            }

            column(CompanyEMail; CompanyInformation."E-Mail")
            {
            }
            column(CompanyHomePage; CompanyInformation."Home Page")
            {
            }
            column(CompanyPhoneNo; CompanyInformation."Phone No.")
            {
            }
            column(CompanyVATRegNo; CompanyInformation.GetVATRegistrationNumber())
            {
            }
            column(CompanyAddress1; CompanyAddress[1])
            {
            }
            column(CompanyAddress2; CompanyAddress[2])
            {
            }
            column(CompanyAddress3; CompanyAddress[3])
            {
            }
            column(CompanyAddress4; CompanyAddress[4])
            {
            }
            column(CompanyAddress5; CompanyAddress[5])
            {
            }
            column(CompanyAddress6; CompanyAddress[6])
            {
            }
            column(CustomerAddress1; CustomerAddress[1])
            {
            }
            column(CustomerAddress2; CustomerAddress[2])
            {
            }
            column(CustomerAddress3; CustomerAddress[3])
            {
            }
            column(CustomerAddress4; CustomerAddress[4])
            {
            }
            column(CustomerAddress5; CustomerAddress[5])
            {
            }
            column(CustomerAddress6; CustomerAddress[6])
            {
            }
            column(CustomerAddress7; CustomerAddress[7])
            {
            }
            column(CustomerAddress8; CustomerAddress[8])
            {
            }
            column(SellToContactPhoneNoLbl; SellToContactPhoneNoLbl)
            {
            }
            column(SellToContactMobilePhoneNoLbl; SellToContactMobilePhoneNoLbl)
            {
            }
            column(SellToContactEmailLbl; SellToContactEmailLbl)
            {
            }
            column(BillToContactPhoneNoLbl; BillToContactPhoneNoLbl)
            {
            }
            column(BillToContactMobilePhoneNoLbl; BillToContactMobilePhoneNoLbl)
            {
            }
            column(BillToContactEmailLbl; BillToContactEmailLbl)
            {
            }
            column(SellToContactPhoneNo; SellToContact."Phone No.")
            {
            }
            column(SellToContactMobilePhoneNo; SellToContact."Mobile Phone No.")
            {
            }
            column(SellToContactEmail; SellToContact."E-Mail")
            {
            }
            column(BillToContactPhoneNo; BillToContact."Phone No.")
            {
            }
            column(BillToContactMobilePhoneNo; BillToContact."Mobile Phone No.")
            {
            }
            column(BillToContactEmail; BillToContact."E-Mail")
            {
            }
            column(YourReference; "Your Reference")
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
            }
            column(DocumentNo; "No.")
            {
            }
            column(CompanyLegalOffice; CompanyInformation.GetLegalOffice())
            {
            }
            column(SalesPersonName; SalespersonPurchaserName)
            {
            }
            column(Salesperson_Code; "Salesperson Code")
            { }
            column(ShipmentMethodDescription; ShipmentMethodDescription)
            {
            }
            column(Currency; CurrencyCode)
            {
            }
            column(CustomerVATRegNo; GetCustomerVATRegistrationNumber())
            {
            }
            column(CustomerVATRegistrationNoLbl; GetCustomerVATRegistrationNumberLbl())
            {
            }
            column(PageLbl; PageLbl)
            {
            }
            column(DocumentTitleLbl; DocumentCaption())
            {
            }
            column(YourReferenceLbl; FieldCaption("Your Reference"))
            {
            }
            column(ExternalDocumentNoLbl; FieldCaption("External Document No."))
            {
            }
            column(CompanyLegalOfficeLbl; CompanyInformation.GetLegalOfficeLbl())
            {
            }
            column(SalesPersonLbl; SalesPersonLblText)
            {
            }
            column(EMailLbl; CompanyInformation.FieldCaption("E-Mail"))
            {
            }
            column(HomePageLbl; CompanyInformation.FieldCaption("Home Page"))
            {
            }
            column(CompanyPhoneNoLbl; CompanyInformation.FieldCaption("Phone No."))
            {
            }
            column(ShipmentMethodDescriptionLbl; DummyShipmentMethod.TableCaption)
            {
            }
            column(CurrencyLbl; DummyCurrency.TableCaption)
            {
            }
            column(ItemLbl; Item.TableCaption)
            {
            }
            column(TariffLbl; Item.FieldCaption("Tariff No."))
            {
            }
            column(UnitPriceLbl; Item.FieldCaption("Unit Price"))
            {
            }
            column(ItemNoLbl; ItemLbl)
            {
            }
            column(MasterBoxLbl; Item.FieldCaption("CCS Masterbox"))
            {
            }

            column(CountryOfManufactuctureLbl; CountryOfManufactuctureLbl)
            {
            }
            column(AmountLbl; Line.FieldCaption(Amount))
            {
            }
            column(VATPctLbl; Line.FieldCaption("VAT %"))
            {
            }
            column(VATAmountLbl; DummyVATAmountLine.VATAmountText())
            {
            }
            column(TotalWeightLbl; TotalWeightLbl)
            {
            }
            column(TotalAmountLbl; TotalAmountLbl)
            {
            }
            column(TotalAmountInclVATLbl; TotalAmountInclVATLbl)
            {
            }
            column(QuantityLbl; Line.FieldCaption(Quantity))
            {
            }
            column(NetWeightLbl; Line.FieldCaption("Net Weight"))
            {
            }
            column(DeclartionLbl; DeclartionLbl)
            {
            }
            column(SignatureLbl; SignatureLbl)
            {
            }
            column(SignatureNameLbl; SignatureNameLbl)
            {
            }
            column(SignaturePositionLbl; SignaturePositionLbl)
            {
            }
            column(VATRegNoLbl; CompanyInformation.GetVATRegistrationNumberLbl())
            {
            }
            column(Sell_to_Customer_No_; "Sell-to Customer No.")
            {
            }

            column(ShiptoName; ShiptoName) { }
            column(ShipToAdd1; ShipToAdd1) { }
            column(ShiptoAdd2; ShiptoAdd2) { }
            column(ShiptoCity; ShiptoCity) { }
            column(ShipToPostCode; ShipToPostCode) { }
            column(ShipToCountry; ShipToCountry) { }
            column(Payment_Terms_Code; "Payment Terms Code")
            {

            }

            dataitem(Line; "Sales Line")
            {
                DataItemLink = "Document Type" = field("Document Type"), "Document No." = field("No.");
                DataItemLinkReference = Header;
                DataItemTableView = sorting("Document No.", "Line No.");
                column(No_; "No.")
                {
                }

                column(ItemDescription; Description)
                {
                }
                column(CountryOfManufacturing; Item."Country/Region of Origin Code")
                {
                }
                column(EAN; EAN)
                { }
                column(Tariff; Item."Tariff No.")
                {
                }
                column(Quantity; "Qty. to Invoice")
                {
                }
                column(Price; FormattedLinePrice)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 2;
                }
                column(Unit_Price; "Unit Price")
                { }
                column(NetWeight; "Net Weight")
                {
                }
                column(LineAmount; FormattedLineAmount)
                {
                    AutoFormatExpression = "Currency Code";
                    AutoFormatType = 1;
                }
                column(VATPct; "VAT %")
                {
                }
                column(VATAmount; FormattedVATAmount)
                {
                }
                column(MasterboxQty; "CCS Masterbox Qty")
                { }
                column(Cartons; "CCS Cartons")
                { }
                column(CartonLbl; 'Carton')
                {
                }
                column(Rebate_1; "CCS Rebate 1 %") { }
                column(CCS_Rebate_2__; "CCS Rebate 2 %")
                { }
                column(Line_Disc_Per; "Line Discount %")
                { }
                trigger OnAfterGetRecord()
                var
                    Location: Record Location;
                    AutoFormatType: Enum "Auto Format";
                begin
                    EAN := '';
                    if Item.Get("No.") then
                        EAN := item."CCS EAN";
                    OnBeforeLineOnAfterGetRecord(Header, Line);

                    if IsShipment() then
                        if Location.RequireShipment("Location Code") and ("Quantity Shipped" = 0) then
                            "Qty. to Invoice" := Quantity;

                    if Quantity = 0 then begin
                        LinePrice := "Unit Price";
                        LineAmount := 0;
                        VATAmount := 0;
                    end else begin
                        LinePrice := Round(Amount / Quantity, Currency."Unit-Amount Rounding Precision");
                        LineAmount := Round(Amount * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                        VATAmount := Round(
                            Amount * "VAT %" / 100 * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");

                        TotalAmount += LineAmount;

                        TotalWeight += Round("Qty. to Invoice" * item."Gross Weight");
                        TotalCarton += "CCS Cartons";
                        VolumeN += Round("Qty. to Invoice" * Item."Unit Volume");
                        TotalVATAmount += VATAmount;
                        TotalAmountInclVAT += Round("Amount Including VAT" * "Qty. to Invoice" / Quantity, Currency."Amount Rounding Precision");
                    end;

                    FormattedLinePrice := Format(LinePrice, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::UnitAmountFormat, CurrencyCode));
                    FormattedLineAmount := Format(LineAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedVATAmount := Format(VATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;

                trigger OnPreDataItem()
                begin
                    TotalWeight := 0;
                    TotalCarton := 0;
                    VolumeN := 0;
                    TotalAmount := 0;
                    TotalVATAmount := 0;
                    TotalAmountInclVAT := 0;
                    // SetRange(Type, Type::Item);

                    OnAfterLineOnPreDataItem(Header, Line);
                end;
            }
            dataitem(Totals; "Integer")
            {
                MaxIteration = 1;
                column(TotalWeight; TotalWeight)
                {
                }
                column(TotalCarton; TotalCarton)
                {
                }
                column(VolumeN; VolumeN) { }
                column(TotalValue; FormattedTotalAmount)
                {
                }
                column(TotalVATAmount; FormattedTotalVATAmount)
                {
                }
                column(TotalAmountInclVAT; FormattedTotalAmountInclVAT)
                {
                }

                trigger OnPreDataItem()
                var
                    AutoFormatType: Enum "Auto Format";
                begin
                    FormattedTotalAmount := Format(TotalAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalVATAmount := Format(TotalVATAmount, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                    FormattedTotalAmountInclVAT := Format(TotalAmountInclVAT, 0, AutoFormat.ResolveAutoFormat(AutoFormatType::AmountFormat, CurrencyCode));
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CurrReport.Language := Language1.GetLanguageIdOrDefault("Language Code");
                FormatDocumentFields(Header);
                if SellToContact.Get("Sell-to Contact No.") then;
                if BillToContact.Get("Bill-to Contact No.") then;
                if "Ship-to Code" <> '' then begin
                    ShipToAdd1 := "Ship-to Address";
                    ShiptoAdd2 := "Ship-to Address 2";
                    ShiptoName := "Ship-to Name";
                    ShiptoCity := "Ship-to Post Code" + ' ' + "Ship-to City";
                    ShipToPostCode := "Ship-to Post Code";
                    if "Ship-to Country/Region Code" <> '' then
                        RecCountry.Get("Ship-to Country/Region Code");
                    ShipToCountry := RecCountry.Name;
                end else begin
                    ShipToAdd1 := "Sell-to Address";
                    ShiptoAdd2 := "Sell-to Address 2";
                    ShiptoName := "Sell-to Customer Name";
                    ShiptoCity := "Sell-to Post Code" + ' ' + "Sell-to City";
                    ShipToPostCode := "Sell-to Post Code";
                    ShipToCountry := "Sell-to Country/Region Code";
                    if "Sell-to Country/Region Code" <> '' then
                        RecCountry.Get("Sell-to Country/Region Code");
                    ShipToCountry := RecCountry.Name;
                end;
            end;
        }
    }


    trigger OnInitReport()
    begin
        CompanyInformation.Get();
        CompanyInformation.CalcFields(Picture);

    end;

    var
        CompanyInformation: Record "Company Information";
        BillToContact: Record Contact;
        SellToContact: Record Contact;
        RecCountry: Record "Country/Region";
        Currency: Record Currency;
        DummyCurrency: Record Currency;
        Item: Record Item;
        DummyShipmentMethod: Record "Shipment Method";
        DummyVATAmountLine: Record "VAT Amount Line";
        AutoFormat: Codeunit "Auto Format";
        Language1: Codeunit Language;
        CurrencyCode: Code[10];
        LineAmount: Decimal;
        LinePrice: Decimal;
        TotalAmount: Decimal;
        TotalAmountInclVAT: Decimal;
        TotalCarton: Decimal;
        TotalVATAmount: Decimal;
        TotalWeight: Decimal;
        VATAmount: Decimal;
        VolumeN: Decimal;
        BillToContactEmailLbl: Label 'Bill-to Contact E-Mail';
        BillToContactMobilePhoneNoLbl: Label 'Bill-to Contact Mobile Phone No.';
        BillToContactPhoneNoLbl: Label 'Bill-to Contact Phone No.';
        CountryOfManufactuctureLbl: Label 'Country';
        DeclartionLbl: Label 'This document does not entitle you to deduct input tax.';
        DocumentTitleLbl: Label 'Pro Forma Invoice';
        ItemLbl: Label 'Item No.';
        PageLbl: Label 'Page';
        SellToContactEmailLbl: Label 'Sell-to Contact E-Mail';
        SellToContactMobilePhoneNoLbl: Label 'Sell-to Contact Mobile Phone No.';
        SellToContactPhoneNoLbl: Label 'Sell-to Contact Phone No.';
        SignatureLbl: Label 'For and on behalf of the above named company:';
        SignatureNameLbl: Label 'Name (in print) Signature';
        SignaturePositionLbl: Label 'Position in company';
        TotalWeightLbl: Label 'Total Weight';
        FormattedLineAmount: Text;
        FormattedLinePrice: Text;
        FormattedTotalAmount: Text;
        FormattedTotalAmountInclVAT: Text;
        FormattedTotalVATAmount: Text;
        FormattedVATAmount: Text;
        SalespersonPurchaserName: Text;
        ShipmentMethodDescription: Text;
        ShipToAdd1: Text;
        ShiptoAdd2: Text;
        ShiptoCity: Text;
        ShipToCountry: Text;
        ShiptoName: Text;
        ShipToPostCode: Text;
        EAN: Text[50];
        SalesPersonLblText: Text[50];
        TotalAmountInclVATLbl: Text[50];
        TotalAmountLbl: Text[50];
        CompanyAddress: array[8] of Text[100];
        CustomerAddress: array[8] of Text[100];

    local procedure FormatDocumentFields(SalesHeader: Record "Sales Header")
    var
        Customer: Record Customer;
        GeneralLedgerSetup: Record "General Ledger Setup";
        ResponsibilityCenter: Record "Responsibility Center";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        ShipmentMethod: Record "Shipment Method";
        FormatAddress: Codeunit "Format Address";
        FormatDocument: Codeunit "Format Document";
        TotalAmounExclVATLbl: Text[50];
    begin

        Customer.Get(SalesHeader."Sell-to Customer No.");
        FormatDocument.SetSalesPerson(SalespersonPurchaser, SalesHeader."Salesperson Code", SalesPersonLblText);
        SalespersonPurchaserName := SalespersonPurchaser.Name;

        FormatDocument.SetShipmentMethod(ShipmentMethod, SalesHeader."Shipment Method Code", SalesHeader."Language Code");
        ShipmentMethodDescription := ShipmentMethod.Description;

        FormatAddress.GetCompanyAddr(SalesHeader."Responsibility Center", ResponsibilityCenter, CompanyInformation, CompanyAddress);
        FormatAddress.SalesHeaderBillTo(CustomerAddress, SalesHeader);

        if SalesHeader."Currency Code" = '' then begin
            GeneralLedgerSetup.Get();
            GeneralLedgerSetup.TestField("LCY Code");
            CurrencyCode := GeneralLedgerSetup."LCY Code";
            Currency.InitRoundingPrecision();
        end else begin
            CurrencyCode := SalesHeader."Currency Code";
            Currency.Get(SalesHeader."Currency Code");
        end;

        FormatDocument.SetTotalLabels(SalesHeader."Currency Code", TotalAmountLbl, TotalAmountInclVATLbl, TotalAmounExclVATLbl);
    end;

    local procedure DocumentCaption(): Text
    var
        DocCaption: Text;
    begin
        OnBeforeGetDocumentCaption(Header, DocCaption);
        if DocCaption <> '' then
            exit(DocCaption);
        exit(DocumentTitleLbl);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterLineOnPreDataItem(var SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetDocumentCaption(SalesHeader: Record "Sales Header"; var DocCaption: Text)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLineOnAfterGetRecord(SalesHeader: Record "Sales Header"; var SalesLine: Record "Sales Line")
    begin
    end;
}