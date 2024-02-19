/// <summary>
/// Unknown CustDetailedAgeingExt (ID 66001) extends Record 106.
/// </summary>
reportextension 66001 CustDetailedAgeingExt extends 106
{
    dataset
    {
        add(Header)
        {
            column(Cust_Ledger_Entry_Original_Amount_Caption; "Cust. Ledger Entry".FieldCaption("Original Amount"))
            {
            }
            column(Cust_Ledger_Entry_Amount_LCY_Caption; "Cust. Ledger Entry".FieldCaption("Amount (LCY)"))
            {
            }
        }
        modify(Customer)
        {
            trigger OnAfterAfterGetRecord()

            begin
                TotalOriginalAmt := 0;
                TotalAmountLcy := 0;
            end;
        }
        // Add changes to dataitems and columns here
        add("Cust. Ledger Entry")
        {
            column(Cust_Ledger_Entry_Original_Amount; "Original Amount") { }
            column(Cust_Ledger_Entry_Amount__LCY_; "Amount (LCY)") { }
            //column(TotalOriginalAmt; TotalOriginalAmt) { }
            //column(TotalAmountLcy; TotalAmountLcy) { }
        }

        modify("Cust. Ledger Entry")
        {


            trigger OnBeforeAfterGetRecord()
            var

            begin
                SetAutoCalcFields("Original Amount", "Amount (LCY)");
            end;

            trigger OnAfterAfterGetRecord()

            begin
                TotalOriginalAmt += "Original Amount";
                TotalAmountLcy += "Amount (LCY)";
            end;
        }
        add(Integer)
        {
            column(TotalOriginalAmt; TotalOriginalAmt) { }
            column(TotalAmountLcy; TotalAmountLcy) { }
        }
    }
    var
        TotalAmountLcy: Decimal;
        TotalOriginalAmt: Decimal;


}