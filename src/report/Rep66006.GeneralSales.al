report 66006 "General Sales"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Src\Layouts\GeneralSales.rdl';


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
            end;

            trigger OnAfterGetRecord()
            var
                ArrFromSales: array[12] of Decimal;
                ArrtoSales: array[12] of Decimal;
                i: Integer;
            begin
                if Code = '' then
                    CurrReport.Skip();
                while i < 12 do begin
                    Gensales.Init();
                    Gensales.FY_Options := Gensales.FY_Options::FromYear;
                    Gensales.Year := Format(fromYear);
                    if i = 0 then begin
                        Gensales.Month := 'JANUARY';
                        Gensales.MonthSort := 1;
                    end;
                    if i = 1 then begin
                        Gensales.Month := 'FEBRUARY';
                        Gensales.MonthSort := 2;
                    end;
                    if i = 2 then begin
                        Gensales.Month := 'MARCH';
                        Gensales.MonthSort := 3;
                    end;
                    if i = 3 then begin
                        Gensales.Month := 'APRIL';
                        Gensales.MonthSort := 4;
                    end;
                    if i = 4 then begin
                        Gensales.Month := 'MAY';
                        Gensales.MonthSort := 5;
                    end;
                    if i = 5 then begin
                        Gensales.Month := 'JUNE';
                        Gensales.MonthSort := 6;
                    end;
                    if i = 6 then begin
                        Gensales.Month := 'JULY';
                        Gensales.MonthSort := 7;
                    end;
                    if i = 7 then begin
                        Gensales.Month := 'AUGUST';
                        Gensales.MonthSort := 8;
                    end;
                    if i = 8 then begin
                        Gensales.Month := 'SEPTEMBER';
                        Gensales.MonthSort := 9;
                    end;
                    if i = 9 then begin
                        Gensales.Month := 'OCTOBER';
                        Gensales.MonthSort := 10;
                    end;
                    if i = 10 then begin
                        Gensales.Month := 'NOVEMBER';
                        Gensales.MonthSort := 11;
                    end;
                    if i = 11 then begin
                        Gensales.Month := 'DECEMBER';
                        Gensales.MonthSort := 12;
                    end;
                    Gensales."Customer Posting Group" := Code;
                    Gensales."Sale Amount" := 0;
                    Gensales.Insert();
                    IF i = 11 then
                        completed := True;
                    i += 1;
                end;
                i := 0;
                while i < 12 do begin
                    Gensales.Init();
                    Gensales.FY_Options := Gensales.FY_Options::ToYear;
                    Gensales.Year := Format(toYear);
                    if i = 0 then begin
                        Gensales.Month := 'JANUARY';
                        Gensales.MonthSort := 1;
                    end;
                    if i = 1 then begin
                        Gensales.Month := 'FEBRUARY';
                        Gensales.MonthSort := 2;
                    end;
                    if i = 2 then begin
                        Gensales.Month := 'MARCH';
                        Gensales.MonthSort := 3;
                    end;
                    if i = 3 then begin
                        Gensales.Month := 'APRIL';
                        Gensales.MonthSort := 4;
                    end;
                    if i = 4 then begin
                        Gensales.Month := 'MAY';
                        Gensales.MonthSort := 5;
                    end;
                    if i = 5 then begin
                        Gensales.Month := 'JUNE';
                        Gensales.MonthSort := 6;
                    end;
                    if i = 6 then begin
                        Gensales.Month := 'JULY';
                        Gensales.MonthSort := 7;
                    end;
                    if i = 7 then begin
                        Gensales.Month := 'AUGUST';
                        Gensales.MonthSort := 8;
                    end;
                    if i = 8 then begin
                        Gensales.Month := 'SEPTEMBER';
                        Gensales.MonthSort := 9;
                    end;
                    if i = 9 then begin
                        Gensales.Month := 'OCTOBER';
                        Gensales.MonthSort := 10;
                    end;
                    if i = 10 then begin
                        Gensales.Month := 'NOVEMBER';
                        Gensales.MonthSort := 11;
                    end;
                    if i = 11 then begin
                        Gensales.Month := 'DECEMBER';
                        Gensales.MonthSort := 12;
                    end;
                    Gensales."Customer Posting Group" := Code;
                    Gensales."Sale Amount" := 0;
                    Gensales.Insert();
                    IF i = 11 then
                        completed := True;
                    i += 1;
                end;
                fromCLE.Reset();
                fromCLE.SetRange("Customer Posting Group", Code);
                fromCLE.SetRange("Posting Date", fromStartDate, fromEndDate);
                //fromCLE.SetRange(Positive, true);
                if custno <> '' then
                    fromCLE.SetFilter("Customer No.", custno);
                fromCLE.Setfilter("Document Type", '%1|%2', fromCLE."Document Type"::Invoice, fromCLE."Document Type"::"Credit Memo");
                if fromCLE.FindSet() then
                    repeat
                        //fromCLE.CalcFields("Amount (LCY)");
                        case Date2DMY(fromCLE."Posting Date", 2) of
                            1:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JANUARY');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'JANUARY';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JANUARY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            2:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'FEBRUARY');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'FEBRUARY';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'FEBRUARY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            //ArrFromSales[2] += fromCLE."Sales (LCY)";
                            3:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'MARCH');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'MARCH';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'MARCH');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            //ArrFromSales[3] += fromCLE."Sales (LCY)";
                            4:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'APRIL');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'APRIL';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'APRIL');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            5:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'MAY');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'MAY';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'MAY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            6:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JUNE');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'JUNE';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JUNE');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            7:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JULY');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'JULY';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'JULY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            8:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'AUGUST');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'AUGUST';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'AUGUST');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            9:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'SEPTEMBER');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'SEPTEMBER';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'SEPTEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            10:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'OCTOBER');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'OCTOBER';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'OCTOBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            11:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'NOVEMBER');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'NOVEMBER';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'NOVEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            12:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'DECEMBER');
                                    Gensales.SetRange("Customer Posting Group", fromCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(fromYear);
                                        Gensales.Month := 'DECEMBER';
                                        Gensales."Customer Posting Group" := fromCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := fromCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += fromCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                                    Gensales.SetRange(Year, Format(fromYear));
                                    Gensales.SetRange(Month, 'DECEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += fromCLE."Sales (LCY)";
                                        Gensales.Margin += fromCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;

                        end;

                    until fromCLE.Next() = 0;

                toCLE.Reset();
                toCLE.SetRange("Customer Posting Group", Code);
                toCLE.SetRange("Posting Date", toStartDate, toEndDate);
                //toCLE.SetRange(Positive, true);
                if custno <> '' then
                    toCLE.SetFilter("Customer No.", custno);
                toCLE.Setfilter("Document Type", '%1|%2', toCLE."Document Type"::Invoice, toCLE."Document Type"::"Credit Memo");
                if toCLE.FindSet() then
                    repeat
                        //toCLE.CalcFields("Sales (LCY)");
                        case Date2DMY(toCLE."Posting Date", 2) of
                            1:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JANUARY');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'JANUARY';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JANUARY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            2:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'FEBRUARY');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'FEBRUARY';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'FEBRUARY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            //ArrFromSales[2] += toCLE."Sales (LCY)";
                            3:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'MARCH');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'MARCH';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'MARCH');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            //ArrFromSales[3] += toCLE."Sales (LCY)";
                            4:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'APRIL');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'APRIL';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'APRIL');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            5:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'MAY');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'MAY';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'MAY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            6:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JUNE');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'JUNE';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JUNE');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            7:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JULY');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'JULY';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'JULY');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            8:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'AUGUST');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'AUGUST';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'AUGUST');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            9:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'SEPTEMBER');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'SEPTEMBER';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'SEPTEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            10:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'OCTOBER');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'OCTOBER';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'OCTOBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            11:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'NOVEMBER');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'NOVEMBER';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";
                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'NOVEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;
                            12:
                                begin
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'DECEMBER');
                                    Gensales.SetRange("Customer Posting Group", toCLE."Customer Posting Group");
                                    if not Gensales.FindFirst() then begin
                                        Gensales.Init();
                                        Gensales.Year := Format(toYear);
                                        Gensales.Month := 'DECEMBER';
                                        Gensales."Customer Posting Group" := toCLE."Customer Posting Group";
                                        Gensales."Sale Amount" := toCLE."Sales (LCY)";

                                        Gensales.Insert();
                                    end else begin
                                        Gensales."Sale Amount" += toCLE."Sales (LCY)";
                                        Gensales.Modify();
                                    end;
                                    Gensales.Reset();
                                    Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                                    Gensales.SetRange(Year, Format(toYear));
                                    Gensales.SetRange(Month, 'DECEMBER');
                                    if Gensales.findfirst then begin
                                        Gensales.TotalSales += toCLE."Sales (LCY)";
                                        Gensales.Margin += toCLE."Profit (LCY)";
                                        Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                                        Gensales.Modify()
                                    end;
                                end;

                        end;

                    until toCLE.Next() = 0;
                //------------filling total line


            end;

            trigger OnPostDataItem()
            var
                GensalesNew: Record "General Sales";
                i: Integer;
            begin
                Gensales.Reset();
                //Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                //Gensales.SetRange(Year, Format(toYear));
                Gensales.SetFilter(Month, '%1|%2|%3|%4', 'TOTAL', 'PERMONTH');
                if Gensales.FindSet() then
                    Gensales.DeleteAll();
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                GensalesNew.SetRange(Year, Format(toyear));
                GensalesNew.SetFilter(Month, '<>%1', 'TOTAL');
                //GensalesNew.SetRange("Customer Posting Group", Code);
                if GensalesNew.FindSet() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                        Gensales.SetRange(Year, Format(toyear));
                        Gensales.SetRange(Month, 'TOTAL');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::ToYear;
                            Gensales.Year := Format(toyear);
                            Gensales.Month := 'TOTAL';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            Gensales."Sale Amount" := GensalesNew."Sale Amount";
                            Gensales.TotalSales := GensalesNew.TotalSales;
                            Gensales.Margin := GensalesNew.Margin;
                            if Gensales.TotalSales <> 0 then
                                Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                            Gensales.MonthSort := 13;
                            Gensales.Insert();
                        end else begin
                            Gensales."Sale Amount" += GensalesNew."Sale Amount";
                            Gensales.TotalSales += GensalesNew.TotalSales;
                            Gensales.Margin += GensalesNew.Margin;
                            if Gensales.TotalSales <> 0 then
                                Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                            Gensales.Modify();
                        end;
                    until GensalesNew.Next() = 0;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                GensalesNew.SetRange(Year, Format(toyear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                //GensalesNew.SetRange("Customer Posting Group", Code);
                if GensalesNew.FindSet() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                        Gensales.SetRange(Year, Format(toyear));
                        Gensales.SetRange(Month, 'PERMONTH');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::ToYear;
                            Gensales.Year := Format(toyear);
                            Gensales.Month := 'PERMONTH';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            Gensales."Sale Amount" := GensalesNew."Sale Amount" / 12;
                            Gensales.TotalSales := GensalesNew.TotalSales / 12;
                            Gensales.Margin := GensalesNew.Margin / 12;
                            Gensales.MonthSort := 14;
                            Gensales.Insert();

                        end;

                    until GensalesNew.Next() = 0;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                GensalesNew.SetRange(Year, Format(toyear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                GensalesNew.SetFilter(TotalSales, '<>%1', 0);
                if GensalesNew.FindFirst() then begin
                    // Gensales.Init();
                    // Gensales.FY_Options := Gensales.FY_Options::ToYear;
                    // Gensales.Year := Format(toyear);
                    // Gensales.Month := ' ';
                    // Gensales."Customer Posting Group" := '';

                    // Gensales.MonthSort := 15;
                    // Gensales.Insert();
                    Gensales.Init();
                    Gensales.FY_Options := Gensales.FY_Options::ToYear;
                    Gensales.Year := Format(toyear);
                    Gensales.Month := 'Total Turnover';
                    Gensales."Customer Posting Group" := '';
                    Gensales.TotalSales := GensalesNew.TotalSales;
                    Gensales."Sale Amount" := 0;
                    toTotalSale := GensalesNew.TotalSales;
                    Gensales.MonthSort := 15;
                    j := Gensales.MonthSort;
                    Gensales.Insert();
                end;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                GensalesNew.SetRange(Year, Format(toyear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                GensalesNew.SetFilter("Sale Amount", '<>%1', 0);
                if GensalesNew.FindFirst() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                        Gensales.SetRange(Year, Format(toyear));
                        Gensales.SetFilter(Month, GensalesNew."Customer Posting Group" + ' %');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::ToYear;
                            Gensales.Year := Format(toyear);
                            Gensales.Month := GensalesNew."Customer Posting Group" + ' %';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            //Gensales."Sale Amount" := GensalesNew."Sale Amount" / 12;
                            Gensales.TotalSales := (GensalesNew."Sale Amount" * 100) / toTotalSale;
                            Gensales.MonthSort := j + 1;
                            Gensales.Insert();
                            j := Gensales.MonthSort;

                        end;
                    until GensalesNew.Next() = 0;
                //-----------from year totals   
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                GensalesNew.SetRange(Year, Format(fromYear));
                GensalesNew.SetFilter(Month, '<>%1', 'TOTAL');
                //GensalesNew.SetRange("Customer Posting Group", Code);
                if GensalesNew.FindSet() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                        Gensales.SetRange(Year, Format(fromYear));
                        Gensales.SetRange(Month, 'TOTAL');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::FromYear;
                            Gensales.Year := Format(fromYear);
                            Gensales.Month := 'TOTAL';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            Gensales."Sale Amount" := GensalesNew."Sale Amount";
                            Gensales.TotalSales := GensalesNew.TotalSales;
                            Gensales.Margin := GensalesNew.Margin;
                            if Gensales.TotalSales <> 0 then
                                Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                            Gensales.MonthSort := 13;
                            Gensales.Insert();
                        end else begin
                            Gensales."Sale Amount" += GensalesNew."Sale Amount";
                            Gensales.TotalSales += GensalesNew.TotalSales;
                            Gensales.Margin += GensalesNew.Margin;
                            //Gensales."Margin %" += GensalesNew."Margin %";
                            if Gensales.TotalSales <> 0 then
                                Gensales."Margin %" := (Gensales.Margin * 100) / Gensales.TotalSales;
                            Gensales.Modify();
                        end;
                    until GensalesNew.Next() = 0;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                GensalesNew.SetRange(Year, Format(fromYear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                //GensalesNew.SetRange("Customer Posting Group", Code);
                if GensalesNew.FindSet() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                        Gensales.SetRange(Year, Format(fromYear));
                        Gensales.SetRange(Month, 'PERMONTH');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::FromYear;
                            Gensales.Year := Format(fromYear);
                            Gensales.Month := 'PERMONTH';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            Gensales."Sale Amount" := GensalesNew."Sale Amount" / 12;
                            Gensales.TotalSales := GensalesNew.TotalSales / 12;
                            Gensales.Margin := GensalesNew.Margin / 12;
                            Gensales.MonthSort := 14;
                            Gensales.Insert();

                        end;

                    until GensalesNew.Next() = 0;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                GensalesNew.SetRange(Year, Format(fromYear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                GensalesNew.SetFilter(TotalSales, '<>%1', 0);
                if GensalesNew.FindFirst() then begin
                    // Gensales.Init();
                    // Gensales.FY_Options := Gensales.FY_Options::FromYear;
                    // Gensales.Year := Format(fromYear);
                    // Gensales.Month := ' ';
                    // Gensales."Customer Posting Group" := '';

                    // Gensales.MonthSort := 15;
                    // Gensales.Insert();
                    // Gensales.Init();
                    Gensales.FY_Options := Gensales.FY_Options::FromYear;
                    Gensales.Year := Format(fromYear);
                    Gensales.Month := 'Total Turnover';
                    Gensales."Customer Posting Group" := '';
                    Gensales."Sale Amount" := 0;
                    Gensales.TotalSales := GensalesNew.TotalSales;
                    fromTotalSale := GensalesNew.TotalSales;
                    Gensales.MonthSort := 15;
                    j := Gensales.MonthSort;
                    Gensales.Insert();
                end;
                GensalesNew.Reset();
                GensalesNew.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                GensalesNew.SetRange(Year, Format(fromYear));
                GensalesNew.SetFilter(Month, '%1', 'TOTAL');
                GensalesNew.SetFilter("Sale Amount", '<>%1', 0);
                if GensalesNew.FindFirst() then
                    repeat
                        Gensales.Reset();
                        Gensales.SetRange(FY_Options, Gensales.FY_Options::FromYear);
                        Gensales.SetRange(Year, Format(fromYear));
                        Gensales.SetFilter(Month, GensalesNew."Customer Posting Group" + ' %');
                        Gensales.SetRange("Customer Posting Group", GensalesNew."Customer Posting Group");
                        if not Gensales.FindFirst() then begin
                            Gensales.Init();
                            Gensales.FY_Options := Gensales.FY_Options::FromYear;
                            Gensales.Year := Format(fromYear);
                            Gensales.Month := GensalesNew."Customer Posting Group" + ' %';
                            Gensales."Customer Posting Group" := GensalesNew."Customer Posting Group";
                            //Gensales."Sale Amount" := GensalesNew."Sale Amount" / 12;
                            Gensales.TotalSales := (GensalesNew."Sale Amount" * 100) / fromTotalSale;
                            Gensales.MonthSort := j + 1;
                            Gensales.Insert();
                            j := Gensales.MonthSort;

                        end;
                    until GensalesNew.Next() = 0;
                Gensales2.Reset();
                //Gensales.SetRange(FY_Options, Gensales.FY_Options::ToYear);
                Gensales2.SetRange(Year, '3000');
                //Gensales.SetFilter(Month, '%1|%2|%3|%4', 'TOTAL', 'PERMONTH');
                if Gensales2.FindSet() then
                    repeat
                        Gensales2.Delete();
                    until Gensales2.Next() = 0;
                i := 0;
                while i <= 12 do begin

                    if i = 0 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'JANUARY');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'JANUARY');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;
                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JANUARY';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 1;
                        Gensales.Insert();

                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JANUARY';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 1;
                        Gensales.Insert();
                    end;
                    if i = 1 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'FEBRUARY');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'FEBRUARY');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;
                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'FEBRUARY';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 2;
                        Gensales.Insert();
                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'FEBRUARY';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 2;
                        Gensales.Insert();
                    end;
                    if i = 2 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'MARCH');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'MARCH');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;
                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'MARCH';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 3;
                        Gensales.Insert();
                        Gensales.Reset();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'MARCH';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 3;
                        Gensales.Insert();
                    end;

                    if i = 3 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'APRIL');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'APRIL');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'APRIL';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 4;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'APRIL';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 4;
                        Gensales.Insert();

                    end;
                    if i = 4 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'MAY');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'MAY');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'MAY';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 5;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'MAY';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 5;
                        Gensales.Insert();
                    end;
                    if i = 5 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'JUNE');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'JUNE');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JUNE';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 6;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JUNE';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 6;
                        Gensales.Insert();
                    end;
                    if i = 6 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'JULY');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'JULY');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JULY';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 7;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'JULY';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 7;
                        Gensales.Insert();
                    end;
                    if i = 7 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'AUGUST');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'AUGUST');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'AUGUST';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 8;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'AUGUST';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 8;
                        Gensales.Insert();
                    end;
                    if i = 8 then begin

                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'SEPTEMBER');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'SEPTEMBER');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'SEPTEMBER';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 9;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'SEPTEMBER';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 9;
                        Gensales.Insert();
                    end;
                    if i = 9 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'OCTOBER');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'OCTOBER');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'OCTOBER';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 10;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'OCTOBER';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 10;
                        Gensales.Insert();
                    end;
                    if i = 10 then begin

                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'NOVEMBER');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'NOVEMBER');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'NOVEMBER';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 11;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'NOVEMBER';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 11;
                        Gensales.Insert();
                    end;
                    if i = 11 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'DECEMBER');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'DECEMBER');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'DECEMBER';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 12;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'DECEMBER';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 12;
                        Gensales.Insert();
                    end;
                    if i = 12 then begin
                        fromTurnOver := 0;
                        toTurnOver := 0;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::FromYear);
                        GensalesNew.SetRange(Year, Format(fromYear));
                        GensalesNew.SetRange(Month, 'TOTAL');
                        if GensalesNew.FindFirst() then begin
                            fromTurnOver := GensalesNew.TotalSales;
                            fromMargin := GensalesNew.Margin;
                        end;
                        GensalesNew.RESET;
                        GensalesNew.SetRange(FY_Options, GensalesNew.FY_Options::ToYear);
                        GensalesNew.SetRange(Year, Format(toYear));
                        GensalesNew.SetRange(Month, 'TOTAL');
                        if GensalesNew.FindFirst() then begin
                            toTurnOver := GensalesNew.TotalSales;
                            toMargin := GensalesNew.Margin;
                        end;

                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'TOTAL';
                        Gensales."Customer Posting Group" := 'TURNOVER DIFFERENCE';
                        Gensales."Sale Amount" := toTurnOver - fromTurnOver;
                        Gensales.MonthSort := 13;
                        Gensales.Insert();
                        Gensales.Init();
                        Gensales.FY_Options := Gensales.FY_Options::ToYear;
                        Gensales.Year := '3000';
                        Gensales.Month := 'TOTAL';
                        Gensales."Customer Posting Group" := 'MARGIN DIFFERENCE';
                        Gensales."Sale Amount" := toMargin - fromMargin;
                        Gensales.MonthSort := 13;
                        Gensales.Insert();
                    end;
                    i += 1;
                end;
            end;
        }


        dataitem("General Sales"; "General Sales")
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
            column(MonthSort; MonthSort)
            { }
            column(Margin; Margin)
            { }
            column(Margin__; "Margin %")
            { }
            column(custno; custno)
            { }
            column(custpostgrpfilter; custpostgrpfilter)
            { }
        }
        dataitem("To_General_Sales"; "General Sales")
        {
            DataItemTableView = sorting(Year) where(FY_Options = const(ToYear), Year = filter(<> '3000'), MonthSort = filter(< 15));
            column(ToYear; Year)
            { }
            column(ToMonth; Month)
            { }
            column(ToCustomer_Posting_Group; "Customer Posting Group")
            { }
            column(ToSale_Amount; "Sale Amount")
            { }
            column(ToTotalSales; TotalSales)
            { }
            column(ToMonthSort; MonthSort)
            { }
            column(ToMargin; Margin)
            { }
            column(ToMargin__; "Margin %")
            { }
        }
        dataitem("Comp_General_Sales"; "General Sales")
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
        dataitem(ToTFrom; "General Sales")
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
            column(ToTFromMonthSort; MonthSort)
            { }

        }
        dataitem(ToT_To; "General Sales")
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

                    }
                    field(ToYear; varToYear)
                    {
                        ApplicationArea = All;
                        Caption = 'To Year';
                    }
                    field(custno; custno)
                    {
                        ApplicationArea = All;
                        Caption = 'Customer No.';
                        TableRelation = Customer."No.";

                    }
                }
            }
        }

        trigger OnOpenPage()
        var
            myInt: Integer;
        begin
            yearint := Date2DMY(Today, 3);
            Evaluate(varToYear, Format(yearint));
            yearint := Date2DMY(CalcDate('<CY-1Y>', Today), 3);
            Evaluate(varFromYear, Format(yearint));
        end;
    }


    trigger OnPreReport()
    begin
        Gensales.DeleteAll();

    end;

    var
        varFromYear: Option " ","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        varToYear: Option " ","2020","2021","2022","2023","2024","2025","2026","2027","2028","2029","2030";
        fromStartDate: Date;
        fromEndDate: Date;
        toStartDate: Date;
        toEndDate: Date;
        fromYear: Integer;
        toyear: Integer;
        fromCLE: Record "Cust. Ledger Entry";
        toCLE: Record "Cust. Ledger Entry";
        Gensales: Record "General Sales";
        Gensales2: Record "General Sales";
        completed: Boolean;
        fromTotalSale: Decimal;
        toTotalSale: Decimal;
        yearint: Integer;
        custno: Code[20];
        custpostgrpfilter: Text;
        fromTurnOver: Decimal;
        toTurnOver: Decimal;
        fromMargin: Decimal;
        toMargin: Decimal;
        j: Integer;
}