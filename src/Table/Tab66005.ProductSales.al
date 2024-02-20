table 66005 "Product Sales"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Year; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
        }
        field(2; Month; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Month';
        }
        field(3; "Customer Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Posting Group';
        }
        field(4; "Sale Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Sale Amount';
        }
        field(5; FY_Options; Option)
        {
            OptionMembers = "FromYear","ToYear";
            DataClassification = CustomerContent;
            Caption = 'FY_Options';
        }
        field(6; MonthSort; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'MonthSort';
        }
        field(7; TotalSales; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'TotalSales';
        }
        field(8; Margin; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Margin';
        }
        field(9; "Margin %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Margin %';
        }
    }

    keys
    {
        key(Key1; Year, Month, "Customer Posting Group", FY_Options)
        {
            Clustered = true;
        }
    }
}