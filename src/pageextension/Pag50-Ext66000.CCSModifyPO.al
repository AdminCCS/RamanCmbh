pageextension 66000 "CCS Modify PO" extends "Purchase Order" //50
{
    layout
    {
        addafter(Status)
        {
            field("Purchase Order Status"; rec."CCS Purchase Order Status")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Purchase Order Status field.';
            }
            field("CCS ETD"; rec."CCS ETD")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Estimated Time of Delivery field.';
            }
            field("CCS ETA"; rec."CCS ETA")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Estimated time of Arrival field.';
            }
        }
        addafter(PurchLines)
        {
            group(PODetails)
            {
                Caption = 'PO Details';

                field("CCS POD Code"; Rec."CCS POD Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the POD Code field.';
                }
                field("CCS Seal No."; Rec."CCS Seal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Seal No. field.';
                }
                field("CCS Inspection"; Rec."CCS Inspection")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inspection field.';
                }
                field("CCS Port Agent"; Rec."CCS Port Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Port Agent field.';
                }
                field("CCS Container No."; Rec."CCS Container No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Container No. field.';
                }
                field("CCS Shipping Cost"; Rec."CCS Shipping Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Cost field.';
                }
                field("CCS Balance Amount"; Rec."CCS Balance Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Amount field.';
                }
                field("CCS Deposit Amount"; Rec."CCS Deposit Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Amount field.';
                }
                field("CCS Final Exchange"; Rec."CCS Final Exchange")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Final Exchange field.';
                }
                field("CCS Forwarder Code"; Rec."CCS Forwarder Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Forwarder Code field.';
                }
                field("CCS Release Status"; Rec."CCS Release Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Release Status field.';
                }
                field("CCS Balance Exchange"; Rec."CCS Balance Exchange")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Exchange field.';
                }
                field("CCS Deposit Exchange"; Rec."CCS Deposit Exchange")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Exchange field.';
                }
                field("CCS Inspection Agent"; Rec."CCS Inspection Agent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inspection Agent field.';
                }
                field("CCS Agent Invoice No."; Rec."CCS Agent Invoice No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Invoice No. field.';
                }
                field("CCS Bill of Lading No."; Rec."CCS Bill of Lading No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill of Lading No. field.';
                }
                field("CCS Packing List Status"; Rec."CCS Packing List Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Packing List Status field.';
                }
                field("CCS Agent Invoice Amount"; Rec."CCS Agent Invoice Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agent Invoice Amount field.';
                }
                field("CCS Balance Payment Date"; Rec."CCS Balance Payment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Payment Date field.';
                }
                field("CCS Deposit Payment Date"; Rec."CCS Deposit Payment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Payment Date field.';
                }
                field("CCS Inspection Report No."; Rec."CCS Inspection Report No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Inspection Report No. field.';
                }
                field("CCS Shipping Payment Date"; Rec."CCS Shipping Payment Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shipping Payment Date field.';
                }
                field("CCS Balance Payment Status"; Rec."CCS Balance Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Balance Payment Status field.';
                }
                field("CCS Deposit Payment Status"; Rec."CCS Deposit Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Deposit Payment Status field.';
                }
                field("CCS Commercial Invoice Status"; Rec."CCS Commercial Invoice Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Commercial Invoice Status field.';
                }
                field("CCS Bill of Lading Copy Status"; Rec."CCS Bill of Lading Copy Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bill of Lading Copy Status field.';
                }
            }
        }
    }
}