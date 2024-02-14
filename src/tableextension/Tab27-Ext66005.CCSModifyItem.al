tableextension 66005 "CCS Modify Item" extends Item //27
{
    fields
    {
        field(66000; "CCS Rec. Street Price"; Decimal)
        {
            Caption = 'Rec. Street Price';
            DataClassification = CustomerContent;
        }
        field(66001; "CCS Unit Qty 20 feet Cont."; Decimal)
        {
            Caption = 'Unit Qty 20 feet Cont.';
            DataClassification = CustomerContent;
        }
        field(66002; "CCS Unit Qty 40 feet Cont."; Decimal)
        {
            Caption = 'Unit Qty 40 feet Cont.';
            DataClassification = CustomerContent;
        }
        field(66003; "CCS Unit Qty 40 HC feet Cont."; Decimal)
        {
            Caption = 'Unit Qty 40 HC feet Cont.';
            DataClassification = CustomerContent;
        }
        field(66004; "CCS Pallet Info."; Text[100])
        {
            Caption = 'Pallet Info.';
            DataClassification = CustomerContent;
        }
        field(66005; "CCS Model Status"; Option)
        {
            Caption = 'Model Status';
            DataClassification = CustomerContent;
            OptionMembers = "SOR","EOL","N";
        }
        field(66006; "CCS Custom Tax"; Decimal)
        {
            Caption = 'Custom Tax';
            DataClassification = CustomerContent;
        }
        field(66007; "CCS Battery"; Integer)
        {
            Caption = 'Battery';
            DataClassification = CustomerContent;
        }
        field(66008; "CCS Packsize Unit"; Decimal)
        {
            Caption = 'Packsize Unit';
            DataClassification = CustomerContent;
        }
        field(66009; "CCS Color"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Color';
        }
        field(66010; "CCS Masterbox"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Masterbox Qty.';
        }
        field(66011; "CCS Item Status"; Option)
        {
            OptionMembers = "S","A","N";
            Caption = 'Item Status';
        }
        field(66012; "CCS EAN"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'EAN';
        }
        field(66013; "CCS Masterbox EAN"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Masterbox EAN';
        }
        field(66014; "CCS Rec. Sales Price"; Decimal)
        {
            Caption = 'Rec. Sales Price';
            DataClassification = CustomerContent;
        }
        field(66015; "CCS Brand"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Brand';
        }

        field(66016; "CCS Instant Ord Invt"; Decimal)
        {

            Caption = 'Instant Order Inventory';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                 "CCS Order Type" = const("Instant Order")));

            DecimalPlaces = 0 : 5;
            Editable = false;

        }
        field(66017; "CCS Blocking Order Invt"; Decimal)
        {
            Caption = 'Blocking Order Inventory';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                 "CCS Order Type" = const("Blocking Order")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(66018; "CCS MRP order Invt"; Decimal)
        {
            Caption = 'Disposition order Inventory';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                 "CCS Order Type" = const("Disposition order")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(66019; "CCS Backlog order Invt"; Decimal)
        {
            Caption = 'Backlog order Inventory';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line".Quantity WHERE(Type = const(Item), "No." = FIELD("No."),
                                                                 "CCS Order Type" = const("Backlog order")));
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(66020; "Free Available Stock"; Decimal)
        {
            Caption = 'Free Available Stock';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(66021; "Quantity pallet height 1,05m"; Decimal)
        {
            Caption = 'Quantity pallet height 1,05m';
            DataClassification = CustomerContent;
        }
        field(66022; "Pallet height 2,20m"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Pallet height 2,20m';

        }
        field(66023; "VPE length in cm"; Decimal)
        {
            Caption = 'VPE length in m';
            DataClassification = CustomerContent;
        }
        field(66024; "VPE width in cm"; Decimal)
        {
            Caption = 'VPE width in m';
            DataClassification = CustomerContent;
        }
        field(66025; "VPE height in cm"; Decimal)
        {
            Caption = 'VPE height in m';
            DataClassification = CustomerContent;
        }
        field(66026; "Volume in m³"; Decimal)
        {
            Caption = 'Volume in m³';
            DataClassification = CustomerContent;
        }
        field(66027; "Product length in cm"; Decimal)
        {
            Caption = 'Product length in cm';
            DataClassification = CustomerContent;
        }
        field(66028; "Product width in cm"; Decimal)
        {
            Caption = 'Product width in cm';
            DataClassification = CustomerContent;
        }
        field(66029; "Product height in cm"; Decimal)
        {
            Caption = 'Product height in cm';
            DataClassification = CustomerContent;
        }
        field(66030; "Cable length in m"; Decimal)
        {
            Caption = 'Cable length in m';
            DataClassification = CustomerContent;
        }
        field(66031; "Connector shape"; Text[50])
        {
            Caption = 'Connector shape';
            DataClassification = CustomerContent;
        }
        field(66032; "VK P/P/K in gr."; Decimal)
        {
            Caption = 'VK P/P/K in gr.';
            DataClassification = CustomerContent;
        }
        field(66033; "VK Styroport in gr."; Decimal)
        {
            Caption = 'VK Styroport in gr.';
            DataClassification = CustomerContent;
        }
        field(66034; "VK foil in gr."; Decimal)
        {
            Caption = 'VK foil in gr.';
            DataClassification = CustomerContent;
        }
        field(66035; "VK PE foam in gr."; Decimal)
        {
            Caption = 'VK PE foam in gr.';
            DataClassification = CustomerContent;
        }
        field(66036; "Green dot"; Boolean)
        {
            Caption = 'Green dot';
            DataClassification = CustomerContent;
        }
        field(66037; "VPE P/P/K in gr."; Decimal)
        {
            Caption = 'VPE P/P/K in gr.';
            DataClassification = CustomerContent;
        }
        field(66038; "VPE Styroport in gr."; Decimal)
        {
            Caption = 'VPE Styroport in gr.';
            DataClassification = CustomerContent;
        }
        field(66039; "VPE film in gr."; Decimal)
        {
            Caption = 'VPE film in gr.';
            DataClassification = CustomerContent;
        }
        field(66040; "VPE PE foam in gr."; Decimal)
        {
            Caption = 'VPE PE foam in gr.';
            DataClassification = CustomerContent;
        }
        field(66041; "GS Co. License"; Boolean)
        {
            Caption = 'GS Co. License';
            DataClassification = CustomerContent;
        }
        field(66042; "BDA Languages"; Text[50])
        {
            Caption = 'BDA Languages';
            DataClassification = CustomerContent;
        }
        field(66043; "Quantity Pallet height 2.20m"; Decimal)
        {
            Caption = 'Quantity Pallet height 2.20m';
            DataClassification = CustomerContent;
        }
        field(66044; "Goods Group"; Text[50])
        {
            Caption = 'Goods Group';
            DataClassification = CustomerContent;
        }
        field(66045; "PU Styroport in gr."; Decimal)
        {
            Caption = 'PU Styroport in gr.';
            DataClassification = CustomerContent;
        }
        field(66046; "PU PE foam in gr."; Decimal)
        {
            Caption = 'PU PE foam in gr.';
            DataClassification = CustomerContent;
        }

        Field(66047; "CCS Image Included"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Image Included';
        }
        field(66048; "Pal. Location Krt"; Text[50])
        {
            Caption = 'Pal. Location Krt';
            DataClassification = CustomerContent;
        }
        field(66049; "Technical 1"; Text[50])
        {
            Caption = 'Technical 1';
            DataClassification = CustomerContent;
        }
        field(66050; "Technical 2"; Text[50])
        {
            Caption = 'Technical 2';
            DataClassification = CustomerContent;
        }
        field(66051; "Technical 3"; Text[50])
        {
            Caption = 'Technical 3';
            DataClassification = CustomerContent;
        }
        field(66052; "Technical 4"; Text[50])
        {
            Caption = 'Technical 4';
            DataClassification = CustomerContent;
        }
        field(66053; "Technical 5"; Text[50])
        {
            Caption = 'Technical 5';
            DataClassification = CustomerContent;
        }
        field(66054; "Produkt LxHxB"; Decimal)
        {
            Caption = 'Produkt LxHxB';
            DataClassification = CustomerContent;
        }
        field(66055; "VPE LxHxB"; Decimal)
        {
            Caption = 'VPE LxHxB';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(CCSNewKey1; "Goods Group")
        { }
    }
    fieldgroups
    {
        addlast(DropDown; Inventory, "Free Available Stock", "CCS Blocking Order Invt", "CCS Instant Ord Invt")
        {
        }
    }


}
