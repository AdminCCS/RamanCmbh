report 66009 "Product Sales"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\ProductSales.rdl';

    dataset
    {
        dataitem("Customer Posting Group"; "Customer Posting Group")
        {
            RequestFilterFields = Code;
            trigger OnPreDataItem()
            var

            begin
                custpostgrpfilter := GetFilter(Code);
                if (varFromYear = varFromYear::" ") or (varToYear = varToYear::" ") then
                    Error('From Year and To Year must be selected.');
                if varFromYear > varToYear then
                    Error('From Year must be less than To Year');
                Evaluate(fromYear, Format(varFromYear));
                Evaluate(toYear, Format(varToYear));
                fromStartDate := DMY2Date(01, 01, fromYear);
                fromEndDate := DMY2Date(31, 12, fromYear);
                toStartDate := DMY2Date(01, 01, toyear);
                toEndDate := DMY2Date(31, 12, toyear);
                if itemno = '' then
                    Error('Please select the Item.');
            end;

            trigger OnAfterGetRecord()
            var
                i: Integer;
            begin
                if Code = '' then
                    CurrReport.Skip();
                while i < 12 do begin
                    ProdSales.Init();
                    ProdSales.FY_Options := ProdSales.FY_Options::FromYear;
                    ProdSales.Year := Format(fromYear);
                    if i = 0 then begin
                        ProdSales.Month := 'JANUARY';
                        ProdSales.MonthSort := 1;
                    end;
                    if i = 1 then begin
                        ProdSales.Month := 'FEBRUARY';
                        ProdSales.MonthSort := 2;
                    end;
                    if i = 2 then begin
                        ProdSales.Month := 'MARCH';
                        ProdSales.MonthSort := 3;
                    end;
                    if i = 3 then begin
                        ProdSales.Month := 'APRIL';
                        ProdSales.MonthSort := 4;
                    end;
                    if i = 4 then begin
                        ProdSales.Month := 'MAY';
                        ProdSales.MonthSort := 5;
                    end;
                    if i = 5 then begin
                        ProdSales.Month := 'JUNE';
                        ProdSales.MonthSort := 6;
                    end;
                    if i = 6 then begin
                        ProdSales.Month := 'JULY';
                        ProdSales.MonthSort := 7;
                    end;
                    if i = 7 then begin
                        ProdSales.Month := 'AUGUST';
                        ProdSales.MonthSort := 8;
                    end;
                    if i = 8 then begin
                        ProdSales.Month := 'SEPTEMBER';
                        ProdSales.MonthSort := 9;
                    end;
                    if i = 9 then begin
                        ProdSales.Month := 'OCTOBER';
                        ProdSales.MonthSort := 10;
                    end;
                    if i = 10 then begin
                        ProdSales.Month := 'NOVEMBER';
                        ProdSales.MonthSort := 11;
                    end;
                    if i = 11 then begin
                        ProdSales.Month := 'DECEMBER';
                        ProdSales.MonthSort := 12;
                    end;
                    ProdSales."Customer Posting Group" := Code;
                    ProdSales."Sale Amount" := 0;
                    ProdSales.Insert();
                    if i = 11 then
                        completed := true;
                    i += 1;
                end;
                i := 0;
                while i < 12 do begin
                    ProdSales.Init();
                    ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                    ProdSales.Year := Format(toYear);
                    if i = 0 then begin
                        ProdSales.Month := 'JANUARY';
                        ProdSales.MonthSort := 1;
                    end;
                    if i = 1 then begin
                        ProdSales.Month := 'FEBRUARY';
                        ProdSales.MonthSort := 2;
                    end;
                    if i = 2 then begin
                        ProdSales.Month := 'MARCH';
                        ProdSales.MonthSort := 3;
                    end;
                    if i = 3 then begin
                        ProdSales.Month := 'APRIL';
                        ProdSales.MonthSort := 4;
                    end;
                    if i = 4 then begin
                        ProdSales.Month := 'MAY';
                        ProdSales.MonthSort := 5;
                    end;
                    if i = 5 then begin
                        ProdSales.Month := 'JUNE';
                        ProdSales.MonthSort := 6;
                    end;
                    if i = 6 then begin
                        ProdSales.Month := 'JULY';
                        ProdSales.MonthSort := 7;
                    end;
                    if i = 7 then begin
                        ProdSales.Month := 'AUGUST';
                        ProdSales.MonthSort := 8;
                    end;
                    if i = 8 then begin
                        ProdSales.Month := 'SEPTEMBER';
                        ProdSales.MonthSort := 9;
                    end;
                    if i = 9 then begin
                        ProdSales.Month := 'OCTOBER';
                        ProdSales.MonthSort := 10;
                    end;
                    if i = 10 then begin
                        ProdSales.Month := 'NOVEMBER';
                        ProdSales.MonthSort := 11;
                    end;
                    if i = 11 then begin
                        ProdSales.Month := 'DECEMBER';
                        ProdSales.MonthSort := 12;
                    end;
                    ProdSales."Customer Posting Group" := Code;
                    ProdSales."Sale Amount" := 0;
                    ProdSales.Insert();
                    if i = 11 then
                        completed := true;
                    i += 1;
                end;
                //------sales invoice line
                SInvLine.Reset();
                SInvLine.SetRange("Posting Date", fromStartDate, fromEndDate);
                SInvLine.SetRange(Type, SInvLine.Type::Item);
                if itemno <> '' then
                    SInvLine.SetRange("No.", itemno);
                if SInvLine.FindSet() then
                    repeat
                        SInvHdr.GET(SInvLine."Document No.");
                        if SInvHdr."Customer Posting Group" = Code then
                            // fromCLE.Reset();
                            // fromCLE.SetRange("Customer Posting Group", Code);
                            // //fromCLE.SetRange("Posting Date", fromStartDate, fromEndDate);
                            // fromCLE.SetRange("Document No.", SInvLine."Document No.");
                            // //fromCLE.Setfilter("Document Type", '%1|%2', fromCLE."Document Type"::Invoice, fromCLE."Document Type"::"Credit Memo");
                            // if fromCLE.FindSet() then
                            //     repeat
                            //fromCLE.CalcFields("Amount (LCY)");
                            case Date2DMY(SInvLine."Posting Date", 2) of
                                1:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JANUARY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;

                                            //Unit price*quantity-unit cost lcy*quantity
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                2:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'FEBRUARY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[2] += SInvLine.GetLineAmountExclVAT();
                                3:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'MARCH';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[3] += SInvLine.GetLineAmountExclVAT();
                                4:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'APRIL';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                5:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'MAY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                6:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JUNE';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                7:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JULY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                8:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'AUGUST';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                9:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'SEPTEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                10:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'OCTOBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                11:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'NOVEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                12:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'DECEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                            end;
                    //until fromCLE.Next() = 0;
                    until SInvLine.Next() = 0;
                SInvLine.Reset();
                SInvLine.SetRange("Posting Date", toStartDate, toEndDate);
                SInvLine.SetRange(Type, SInvLine.Type::Item);
                if itemno <> '' then
                    SInvLine.SetRange("No.", itemno);
                if SInvLine.FindSet() then
                    repeat
                        SInvHdr.GET(SInvLine."Document No.");
                        if SInvHdr."Customer Posting Group" = Code then
                            case Date2DMY(SInvLine."Posting Date", 2) of
                                1:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JANUARY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                2:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'FEBRUARY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[2] += SInvLine.GetLineAmountExclVAT();
                                3:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'MARCH';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[3] += SInvLine.GetLineAmountExclVAT();
                                4:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'APRIL';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                5:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'MAY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                6:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JUNE';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                7:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JULY';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                8:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'AUGUST';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                9:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'SEPTEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                10:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'OCTOBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                11:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'NOVEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                12:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SInvHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'DECEMBER';
                                            ProdSales."Customer Posting Group" := SInvHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SInvLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SInvLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SInvLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SInvLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SInvLine.Quantity;
                                            ProdSales.Margin += ((SInvLine."Unit Price" * SInvLine.Quantity) - (SInvLine."Unit Cost (LCY)" * SInvLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                            end;
                    // until toCLE.Next() = 0;
                    //------------filling total line
                    until SInvLine.Next() = 0;

                //------sales Credit Memo line
                SCrmLine.Reset();
                SCrmLine.SetRange("Posting Date", fromStartDate, fromEndDate);
                SCrmLine.SetRange(Type, SCrmLine.Type::Item);
                if itemno <> '' then
                    SCrmLine.SetRange("No.", itemno);
                if SCrmLine.FindSet() then
                    repeat
                        SCrmHdr.GET(SCrmLine."Document No.");
                        if SCrmHdr."Customer Posting Group" = Code then
                            case Date2DMY(SCrmLine."Posting Date", 2) of
                                1:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JANUARY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                2:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'FEBRUARY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[2] += SCrmLine.GetLineAmountExclVAT();
                                3:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'MARCH';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[3] += SCrmLine.GetLineAmountExclVAT();
                                4:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'APRIL';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                5:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'MAY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                6:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JUNE';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                7:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'JULY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                8:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'AUGUST';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                9:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'SEPTEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                10:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'OCTOBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                11:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'NOVEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                12:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(fromYear);
                                            ProdSales.Month := 'DECEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                                        ProdSales.SetRange(Year, Format(fromYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                            end;
                    //until fromCLE.Next() = 0;
                    until SCrmLine.Next() = 0;
                SCrmLine.Reset();
                SCrmLine.SetRange("Posting Date", toStartDate, toEndDate);
                SCrmLine.SetRange(Type, SCrmLine.Type::Item);
                if itemno <> '' then
                    SCrmLine.SetRange("No.", itemno);
                if SCrmLine.FindSet() then
                    repeat
                        SCrmHdr.GET(SCrmLine."Document No.");
                        if SCrmHdr."Customer Posting Group" = Code then
                            case Date2DMY(SCrmLine."Posting Date", 2) of
                                1:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JANUARY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JANUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                2:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'FEBRUARY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'FEBRUARY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[2] += SCrmLine.GetLineAmountExclVAT();
                                3:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'MARCH';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MARCH');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                //ArrFromSales[3] += SCrmLine.GetLineAmountExclVAT();
                                4:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'APRIL';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'APRIL');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                5:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'MAY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'MAY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                6:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JUNE';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JUNE');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                7:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'JULY';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'JULY');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                8:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'AUGUST';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'AUGUST');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                9:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'SEPTEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'SEPTEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                10:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'OCTOBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'OCTOBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                11:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'NOVEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'NOVEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                                12:
                                    begin
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        ProdSales.SetRange("Customer Posting Group", SCrmHdr."Customer Posting Group");
                                        if not ProdSales.FindFirst() then begin
                                            ProdSales.Init();
                                            ProdSales.Year := Format(toYear);
                                            ProdSales.Month := 'DECEMBER';
                                            ProdSales."Customer Posting Group" := SCrmHdr."Customer Posting Group";
                                            ProdSales."Sale Amount" := SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" := SCrmLine.Quantity;
                                            ProdSales.Insert();
                                        end else begin
                                            ProdSales."Sale Amount" += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales."Sale Quantity" += SCrmLine.Quantity;
                                            ProdSales.Modify();
                                        end;
                                        ProdSales.Reset();
                                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                                        ProdSales.SetRange(Year, Format(toYear));
                                        ProdSales.SetRange(Month, 'DECEMBER');
                                        if ProdSales.findfirst() then begin
                                            ProdSales.TotalSales += SCrmLine.GetLineAmountExclVAT();
                                            ProdSales.TotalSaleQty += SCrmLine.Quantity;
                                            ProdSales.Margin += ((SCrmLine."Unit Price" * SCrmLine.Quantity) - (SCrmLine."Unit Cost (LCY)" * SCrmLine.Quantity));
                                            if ProdSales.TotalSales <> 0 then
                                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                                            ProdSales.Modify()
                                        end;
                                    end;
                            end;
                    // until toCLE.Next() = 0;
                    //------------filling total line
                    until SCrmLine.Next() = 0;
            end;

            trigger OnPostDataItem()
            var
                ProdSalesNew: Record "Product Sales";
            begin
                ProdSales.Reset();
                //ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                //ProdSales.SetRange(Year, Format(toYear));
                ProdSales.SetFilter(Month, '%1|%2|%3|%4', 'TOTAL', 'PERMONTH');
                if ProdSales.FindSet() then
                    ProdSales.DeleteAll();
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                ProdSalesNew.SetRange(Year, Format(toyear));
                ProdSalesNew.SetFilter(Month, '<>%1', 'TOTAL');
                //ProdSalesNew.SetRange("Customer Posting Group", Code);
                if ProdSalesNew.FindSet() then
                    repeat
                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                        ProdSales.SetRange(Year, Format(toyear));
                        ProdSales.SetRange(Month, 'TOTAL');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                            ProdSales.Year := Format(toyear);
                            ProdSales.Month := 'TOTAL';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            ProdSales."Sale Amount" := ProdSalesNew."Sale Amount";
                            ProdSales."Sale Quantity" := ProdSalesNew."Sale Quantity";
                            ProdSales.TotalSales := ProdSalesNew.TotalSales;
                            ProdSales.TotalSaleQty := ProdSalesNew.TotalSaleQty;
                            ProdSales.Margin := ProdSalesNew.Margin;
                            if ProdSales.TotalSales <> 0 then
                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                            ProdSales.MonthSort := 13;
                            ProdSales.Insert();
                        end else begin
                            ProdSales."Sale Amount" += ProdSalesNew."Sale Amount";
                            ProdSales.TotalSales += ProdSalesNew.TotalSales;
                            ProdSales."Sale Quantity" += ProdSalesNew."Sale Quantity";
                            ProdSales.TotalSaleQty += ProdSalesNew.TotalSaleQty;
                            ProdSales.Margin += ProdSalesNew.Margin;
                            if ProdSales.TotalSales <> 0 then
                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                            ProdSales.Modify();
                        end;
                    until ProdSalesNew.Next() = 0;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                ProdSalesNew.SetRange(Year, Format(toyear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                //ProdSalesNew.SetRange("Customer Posting Group", Code);
                if ProdSalesNew.FindSet() then
                    repeat
                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                        ProdSales.SetRange(Year, Format(toyear));
                        ProdSales.SetRange(Month, 'PERMONTH');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                            ProdSales.Year := Format(toyear);
                            ProdSales.Month := 'PERMONTH';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            ProdSales."Sale Amount" := ProdSalesNew."Sale Amount" / 12;
                            ProdSales.TotalSales := ProdSalesNew.TotalSales / 12;
                            ProdSales."Sale Quantity" := ProdSalesNew."Sale Quantity" / 12;
                            ProdSales.TotalSaleQty := ProdSalesNew.TotalSaleQty / 12;
                            ProdSales.Margin := ProdSalesNew.Margin / 12;
                            ProdSales.MonthSort := 14;
                            ProdSales.Insert();
                        end;
                    until ProdSalesNew.Next() = 0;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                ProdSalesNew.SetRange(Year, Format(toyear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                ProdSalesNew.SetFilter(TotalSales, '<>%1', 0);
                if ProdSalesNew.FindFirst() then begin
                    // ProdSales.Init();
                    // ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                    // ProdSales.Year := Format(toyear);
                    // ProdSales.Month := ' ';
                    // ProdSales."Customer Posting Group" := '';

                    // ProdSales.MonthSort := 15;
                    // ProdSales.Insert();
                    ProdSales.Init();
                    ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                    ProdSales.Year := Format(toyear);
                    ProdSales.Month := 'Total Turnover';
                    ProdSales."Customer Posting Group" := '';
                    ProdSales.TotalSales := ProdSalesNew.TotalSales;
                    ProdSales."Sale Amount" := 0;
                    toTotalSale := ProdSalesNew.TotalSales;
                    ProdSales.MonthSort := 15;
                    j := ProdSales.MonthSort;
                    ProdSales.Insert();
                end;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                ProdSalesNew.SetRange(Year, Format(toyear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                ProdSalesNew.SetFilter("Sale Amount", '<>%1', 0);
                if ProdSalesNew.FindFirst() then
                    repeat

                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::ToYear);
                        ProdSales.SetRange(Year, Format(toyear));
                        ProdSales.SetFilter(Month, ProdSalesNew."Customer Posting Group" + ' %');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::ToYear;
                            ProdSales.Year := Format(toyear);
                            ProdSales.Month := ProdSalesNew."Customer Posting Group" + ' %';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            //ProdSales."Sale Amount" := ProdSalesNew."Sale Amount" / 12;
                            if toTotalSale <> 0 then
                                ProdSales.TotalSales := (ProdSalesNew."Sale Amount" * 100) / toTotalSale;
                            ProdSales.MonthSort := j + 1;
                            ProdSales.Insert();
                            j := ProdSales.MonthSort;
                        end;
                    until ProdSalesNew.Next() = 0;
                //-----------from year totals
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                ProdSalesNew.SetRange(Year, Format(fromYear));
                ProdSalesNew.SetFilter(Month, '<>%1', 'TOTAL');
                //ProdSalesNew.SetRange("Customer Posting Group", Code);
                if ProdSalesNew.FindSet() then
                    repeat
                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                        ProdSales.SetRange(Year, Format(fromYear));
                        ProdSales.SetRange(Month, 'TOTAL');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::FromYear;
                            ProdSales.Year := Format(fromYear);
                            ProdSales.Month := 'TOTAL';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            ProdSales."Sale Amount" := ProdSalesNew."Sale Amount";
                            ProdSales.TotalSales := ProdSalesNew.TotalSales;
                            ProdSales."Sale Quantity" := ProdSalesNew."Sale Quantity";
                            ProdSales.TotalSaleQty := ProdSalesNew.TotalSaleQty;
                            ProdSales.Margin := ProdSalesNew.Margin;
                            if ProdSales.TotalSales <> 0 then
                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                            ProdSales.MonthSort := 13;
                            ProdSales.Insert();
                        end else begin
                            ProdSales."Sale Amount" += ProdSalesNew."Sale Amount";
                            ProdSales.TotalSales += ProdSalesNew.TotalSales;
                            ProdSales."Sale Quantity" += ProdSalesNew."Sale Quantity";
                            ProdSales.TotalSaleQty += ProdSalesNew.TotalSaleQty;
                            ProdSales.Margin += ProdSalesNew.Margin;
                            //ProdSales."Margin %" += ProdSalesNew."Margin %";
                            if ProdSales.TotalSales <> 0 then
                                ProdSales."Margin %" := (ProdSales.Margin * 100) / ProdSales.TotalSales;
                            ProdSales.Modify();
                        end;
                    until ProdSalesNew.Next() = 0;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                ProdSalesNew.SetRange(Year, Format(fromYear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                //ProdSalesNew.SetRange("Customer Posting Group", Code);
                if ProdSalesNew.FindSet() then
                    repeat
                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                        ProdSales.SetRange(Year, Format(fromYear));
                        ProdSales.SetRange(Month, 'PERMONTH');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::FromYear;
                            ProdSales.Year := Format(fromYear);
                            ProdSales.Month := 'PERMONTH';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            ProdSales."Sale Amount" := ProdSalesNew."Sale Amount" / 12;
                            ProdSales.TotalSales := ProdSalesNew.TotalSales / 12;
                            ProdSales."Sale Quantity" := ProdSalesNew."Sale Quantity" / 12;
                            ProdSales.TotalSaleQty := ProdSalesNew.TotalSaleQty / 12;
                            ProdSales.Margin := ProdSalesNew.Margin / 12;
                            ProdSales.MonthSort := 14;
                            ProdSales.Insert();
                        end;
                    until ProdSalesNew.Next() = 0;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                ProdSalesNew.SetRange(Year, Format(fromYear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                ProdSalesNew.SetFilter(TotalSales, '<>%1', 0);
                if ProdSalesNew.FindFirst() then begin

                    ProdSales.FY_Options := ProdSales.FY_Options::FromYear;
                    ProdSales.Year := Format(fromYear);
                    ProdSales.Month := 'Total Turnover';
                    ProdSales."Customer Posting Group" := '';
                    ProdSales."Sale Amount" := 0;
                    ProdSales.TotalSales := ProdSalesNew.TotalSales;
                    fromTotalSale := ProdSalesNew.TotalSales;
                    ProdSales.MonthSort := 15;
                    j := 15;
                    ProdSales.Insert();
                end;
                ProdSalesNew.Reset();
                ProdSalesNew.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                ProdSalesNew.SetRange(Year, Format(fromYear));
                ProdSalesNew.SetFilter(Month, '%1', 'TOTAL');
                ProdSalesNew.SetFilter("Sale Amount", '<>%1', 0);
                if ProdSalesNew.FindFirst() then
                    repeat

                        ProdSales.Reset();
                        ProdSales.SetRange(FY_Options, ProdSales.FY_Options::FromYear);
                        ProdSales.SetRange(Year, Format(fromYear));
                        ProdSales.SetFilter(Month, ProdSalesNew."Customer Posting Group" + ' %');
                        ProdSales.SetRange("Customer Posting Group", ProdSalesNew."Customer Posting Group");
                        if not ProdSales.FindFirst() then begin
                            ProdSales.Init();
                            ProdSales.FY_Options := ProdSales.FY_Options::FromYear;
                            ProdSales.Year := Format(fromYear);
                            ProdSales.Month := ProdSalesNew."Customer Posting Group" + ' %';
                            ProdSales."Customer Posting Group" := ProdSalesNew."Customer Posting Group";
                            //ProdSales."Sale Amount" := ProdSalesNew."Sale Amount" / 12;
                            if fromTotalSale <> 0 then
                                ProdSales.TotalSales := (ProdSalesNew."Sale Amount" * 100) / fromTotalSale;
                            ProdSales.MonthSort := j + 1;
                            ProdSales.Insert();
                            j := ProdSales.MonthSort;
                        end;
                    until ProdSalesNew.Next() = 0;


            end;
        }

        dataitem("Product Sales"; "Product Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(FromYear), MonthSort = filter(< 15));
            column(Year; Year)
            { }
            column(Month; Month)
            { }
            column(Customer_Posting_Group; "Customer Posting Group")
            { }
            column(Sale_Amount; "Sale Amount")
            { }
            column(TotalSales; TotalSales)
            { }
            column(Sale_Quantity; "Sale Quantity")
            { }
            column(TotalSaleQty; TotalSaleQty)
            { }
            column(MonthSort; MonthSort)
            { }
            column(Margin; Margin)
            { }
            column(Margin__; "Margin %")
            { }
            column(itemno; itemno)
            { }
            column(custpostgrpfilter; custpostgrpfilter)
            { }
            column(Description; ItemRec.Description)
            { }
            column(Goods_Group; ItemRec."Goods Group")
            { }
            column(Unit_Qty_40_HC_feet; ItemRec."CCS Unit Qty 40 HC feet Cont.")
            { }
            column(Rec_Sales_Price; ItemRec."CCS Rec. Sales Price")
            { }
            column(Vendor_No; ItemRec."Vendor No.")
            { }
            column(Vendor_Item_No; ItemRec."Vendor Item No.")
            { }
            column(Item__Picture; ItemRec.Picture)
            { }
            column(Inventory; ItemRec.Inventory)
            { }
            column(Blocking_Order_Invt; ItemRec."CCS Blocking Order Invt")
            { }
            column(Free_Available_Stock; ItemRec."Free Available Stock")
            { }
            column(Vendor_Name; VendRec.Name)
            { }
            column(Vendor_Currency; VendRec."Currency Code")
            { }
            column(purchVal1; purchArr[1])
            { }
            column(purchVal2; purchArr[2])
            { }
            column(purchVal3; purchArr[3])
            { }
            column(AlloverSales; AlloverSales)
            { }
            column(AlloverMargin; AlloverMargin)
            { }
            column(AlloverMargin_per; AlloverMargin_per)
            { }
            column(AlloverPurchQty; AlloverPurchQty)
            { }
            column(AlloverPurchAmount; AlloverPurchAmount)
            { }
            column(OpenPurchQty; OpenPurchQty)
            { }
            column(Disposition_Invt; ItemRec."CCS MRP order Invt")
            { }
            column(FreeIncomingQty; FreeIncomingQty)
            { }
            trigger OnPreDataItem()

            begin
                if itemno <> '' then
                    ItemRec.Get(itemno);
                ItemRec.CalcFields(Inventory, "CCS Blocking Order Invt", "CCS MRP order Invt");
                if ItemRec."Vendor No." <> '' then
                    VendRec.Get(ItemRec."Vendor No.");
                j := 0;
                purchLine.Reset();
                purchLine.SetRange(Type, purchLine.Type::Item);
                purchLine.SetRange("No.", itemno);
                purchLine.SetCurrentKey("Posting Date");
                purchLine.SetAscending("Posting Date", false);
                if purchLine.Findfirst() then
                    repeat
                        j += 1;
                        purchArr[j] := purchLine.Amount / purchLine.Quantity;
                    until (purchLine.Next() = 0) or (j = 3);

                purchLine.Reset();
                purchLine.SetRange(Type, purchLine.Type::Item);
                purchLine.SetRange("No.", itemno);
                if purchLine.FindSet() then
                    repeat
                        AlloverPurchQty += purchLine.Quantity;
                    until purchLine.Next() = 0;

                PurchCrMLine.Reset();
                PurchCrMLine.SetRange(Type, purchLine.Type::Item);
                PurchCrMLine.SetRange("No.", itemno);
                if PurchCrMLine.FindSet() then
                    repeat
                        AlloverPurchQty -= PurchCrMLine.Quantity;
                    until PurchCrMLine.Next() = 0;

                SalesInvLine.Reset();
                SalesInvLine.SetCurrentKey("Document No.", "No.");
                SalesInvLine.SetRange("No.", itemno);
                if SalesInvLine.FindSet() then
                    repeat
                        AlloverSales += SalesInvLine.Amount;
                        AlloverMargin += ((SalesInvLine."Unit Price" * SalesInvLine.Quantity) - (SalesInvLine."Unit Cost (LCY)" * SalesInvLine.Quantity));
                    until SalesInvLine.Next() = 0;

                SalesCrmLine.Reset();
                SalesCrmLine.SetCurrentKey("Document No.", "No.");
                SalesCrmLine.SetRange("No.", itemno);
                if SalesCrmLine.FindSet() then
                    repeat
                        AlloverSales -= SalesCrmLine.Amount;
                        AlloverMargin -= ((SalesCrmLine."Unit Price" * SalesCrmLine.Quantity) - (SalesCrmLine."Unit Cost (LCY)" * SalesCrmLine.Quantity));
                    until SalesInvLine.Next() = 0;
                AlloverMargin_per := (AlloverMargin / AlloverSales) * 100;
                //---------------
                purchLine.Reset();
                purchLine.SetRange(Type, purchLine.Type::Item);
                purchLine.SetRange("No.", itemno);
                purchLine.SetRange("Buy-from Vendor No.", ItemRec."Vendor No.");
                if purchLine.FindSet() then
                    repeat
                        AlloverPurchAmount += purchLine.Amount;
                    until purchLine.Next() = 0;

                PurchCrMLine.Reset();
                PurchCrMLine.SetRange(Type, purchLine.Type::Item);
                PurchCrMLine.SetRange("No.", itemno);
                PurchCrMLine.SetRange("Buy-from Vendor No.", ItemRec."Vendor No.");
                if PurchCrMLine.FindSet() then
                    repeat
                        AlloverPurchAmount -= PurchCrMLine.Amount;
                    until PurchCrMLine.Next() = 0;

                purchOrderLine.Reset();
                purchOrderLine.SetRange(Type, purchOrderLine.Type::Item);
                purchOrderLine.SetRange("No.", itemno);

                if purchOrderLine.FindSet() then
                    repeat
                        OpenPurchQty += purchOrderLine.Quantity;
                    until purchOrderLine.Next() = 0;
                FreeIncomingQty := OpenPurchQty - itemRec."CCS MRP order Invt";

            end;



        }
        dataitem("To_Product_Sales";
        "Product Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(ToYear), Year = filter(<> '3000'), MonthSort = filter(< 15));
            column(ToYear;
            Year)
            { }
            column(ToMonth;
            Month)
            { }
            column(ToCustomer_Posting_Group;
            "Customer Posting Group")
            { }
            column(ToSale_Amount;
            "Sale Amount")
            { }
            column(ToTotalSales;
            TotalSales)
            { }
            column(ToSale_Quantity;
            "Sale Quantity")
            { }
            column(ToTotalSaleQty;
            TotalSaleQty)
            { }
            column(ToMonthSort; MonthSort)
            { }
            column(ToMargin; Margin)
            { }
            column(ToMargin__; "Margin %")
            { }
        }
        dataitem("Comp_Product_Sales"; "Product Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(ToYear), Year = filter('3000'));
            column(CompYear; Year)
            { }
            column(CompMonth; Month)
            { }
            column(CompCustomer_Posting_Group; "Customer Posting Group")
            { }
            column(CompSale_Amount; "Sale Amount")
            { }
            // column(ToTotalSales; TotalSales)
            // { }
            column(CompMonthSort; MonthSort)
            { }
            // column(ToMargin; Margin)
            // { }
            // column(ToMargin__; "Margin %")
            // { }
        }
        dataitem(ToTFrom; "Product Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(FromYear), MonthSort = filter(>= 15));
            column(ToTFromYear; Year)
            { }
            column(ToTFromMonth; Month)
            { }
            column(ToTFromCustomer_Posting_Group; "Customer Posting Group")
            { }
            column(ToTFromSale_Amount; "Sale Amount")
            { }
            column(ToTFromTotalSales; TotalSales)
            { }
            column(ToTFromSale_Quantity; "Sale Quantity")
            { }
            column(ToTFromTotalSaleQty; TotalSaleQty)
            { }
            column(ToTFromMonthSort; MonthSort)
            { }
        }
        dataitem(ToT_To; "Product Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(ToYear), Year = filter(<> '3000'), MonthSort = filter(>= 15));
            column(ToT_ToToYear; Year)
            { }
            column(ToT_ToToMonth; Month)
            { }
            column(ToT_ToToCustomer_Posting_Group; "Customer Posting Group")
            { }
            column(ToT_ToToSale_Amount; "Sale Amount")
            { }
            column(ToT_ToToTotalSales; TotalSales)
            { }
            column(ToT_ToToSale_Quantity; "Sale Quantity")
            { }
            column(ToT_ToToTotalSaleQty; TotalSaleQty)
            { }
            column(ToT_ToToMonthSort; MonthSort)
            { }
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    field(FromYear; varFromYear)
                    {
                        ApplicationArea = All;
                        Caption = 'From Year';
                        ToolTip = 'Specifies the value of the From Year field.';
                    }
                    field(ToYear; varToYear)
                    {
                        ApplicationArea = All;
                        Caption = 'To Year';
                        ToolTip = 'Specifies the value of the To Year field.';
                    }
                    field(itemno; itemno)
                    {
                        ApplicationArea = All;
                        Caption = 'Item No.';
                        TableRelation = Item."No.";
                        ToolTip = 'Specifies the value of the Item No. field.';
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            yearint := Date2DMY(Today, 3);
            Evaluate(varToYear, Format(yearint));
            yearint := Date2DMY(CalcDate('<CY-1Y>', Today), 3);
            Evaluate(varFromYear, Format(yearint));
        end;
    }

    trigger OnPreReport()
    begin
        ProdSales.DeleteAll();
    end;

    var
        VendRec: Record Vendor;
        ItemRec: Record Item;
        ProdSales: Record "Product Sales";
        SCrmHdr: Record "Sales Cr.Memo Header";
        SCrmLine: Record "Sales Cr.Memo Line";
        SInvHdr: Record "Sales Invoice Header";
        SInvLine: Record "Sales Invoice Line";
        completed: Boolean;
        itemno: Code[20];
        fromEndDate: Date;
        fromStartDate: Date;
        toEndDate: Date;
        toStartDate: Date;
        fromTotalSale: Decimal;
        toTotalSale: Decimal;
        fromYear: Integer;
        j: Integer;
        toyear: Integer;
        yearint: Integer;
        varFromYear: Option " ","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        varToYear: Option " ","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        custpostgrpfilter: Text;
        purchArr: array[3] of Decimal;
        purchLine: Record "Purch. Inv. Line";
        purchOrderLine: Record "Purchase Line";
        PurchCrMLine: Record "Purch. Cr. Memo Line";
        AlloverPurchQty: Decimal;
        SalesInvLine: Record "Sales Invoice Line";
        SalesCrmLine: Record "Sales Cr.Memo Line";
        AlloverSales: Decimal;
        AlloverMargin: Decimal;
        AlloverMargin_per: Decimal;
        AlloverPurchAmount: Decimal;
        OpenPurchQty: Decimal;
        FreeIncomingQty: Decimal;
}