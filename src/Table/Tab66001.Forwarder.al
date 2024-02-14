table 66001 "Forwarder"
{
    DrillDownPageId = "Forwarder List";
    LookupPageId = "Forwarder List";
    DataClassification = CustomerContent;
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
