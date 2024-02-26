/// <summary>
/// Report CustLedgerEntryReport (ID 66003).
/// </summary>
report 66003 "CustLedgerEntryReport"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;
    Caption = 'Customer vs Balance';
    DefaultLayout = RDLC;
    // RDLCLayout = 'CustomerBalance.rdl';
    RDLCLayout = 'CustomerBalance.rdlc';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_; "No.") { }
            column(Balance__LCY_; "Balance (LCY)") { }
            column(Debit_Amount__LCY_; "Debit Amount (LCY)") { }
            column(Credit_Amount__LCY_; "Credit Amount (LCY)") { }
            column(BalanceTotal; BalanceTotal)
            { }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLinkReference = customer;
                DataItemLink = "Customer No." = field("No.");
                RequestFilterFields = "Customer No.", "Posting Date";
                column(Posting_Date; "Posting Date") { }
                column(Document_Type; "Document Type") { }
                column(Document_No_; "Document No.") { }
                column(Description; Description) { }
            }
            trigger OnAfterGetRecord()
            begin

                BalanceTotal := "Balance (LCY)" + ("Debit Amount (LCY)" - "Credit Amount (LCY)");
            end;
        }
    }

    var
        BalanceTotal: Decimal;
}
