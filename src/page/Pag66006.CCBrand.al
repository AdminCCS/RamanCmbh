page 66006 "CCS Brand"
{
    ApplicationArea = All;
    Caption = 'Brand List';
    PageType = List;
    SourceTable = Brands;
    UsageCategory = Lists;
    CardPageId = "Brand Card";
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
