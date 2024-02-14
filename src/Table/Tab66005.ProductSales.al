table 66005 "Product Sales"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Year; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(2; Month; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(3; "Customer Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(4; "Sale Amount"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(5; FY_Options; Option)
        {
            OptionMembers = "FromYear","ToYear";
            DataClassification = CustomerContent;

        }
        field(6; MonthSort; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(7; TotalSales; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(8; Margin; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(9; "Margin %"; Decimal)
        {
            DataClassification = CustomerContent;

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