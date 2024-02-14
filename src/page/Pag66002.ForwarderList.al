page 66002 "Forwarder List"
{
    UsageCategory = Lists;
    PageType = List;
    ApplicationArea = All;
    SourceTable = Forwarder;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description.';
                }
            }
        }
    }
}
