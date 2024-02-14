tableextension 66003 "CCS ModifyPurchRcptheader" extends "Purch. Rcpt. Header" //120
{
    fields
    {
        field(66000; "CCS Purchase Order Status"; Option)
        {
            OptionMembers = "Pending",Booked,Shipped;
            dataClassification = CustomerContent;
            Caption = 'Purchase Order Status';
        }
        field(66001; "CCS ETD"; Date)
        {
            Caption = 'Estimated Time of Delivery';
            DataClassification = CustomerContent;
        }
        field(66002; "CCS ETA"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated time of Arrival';
        }
        field(66003; "CCS Container No."; Text[50])
        {
            Caption = 'Container No.';
            DataClassification = CustomerContent;
        }
        field(66004; "CCS Seal No."; Text[50])
        {
            Caption = 'Seal No.';
            DataClassification = CustomerContent;
        }
        // Define the lookup fields after creating the corresponding tables
        field(66005; "CCS Forwarder Code"; Code[20])
        {
            TableRelation = "Forwarder";
            Caption = 'Forwarder Code';
            DataClassification = CustomerContent;
        }
        field(66006; "CCS POD Code"; Code[20])
        {
            TableRelation = POD;
            Caption = 'POD Code';
            DataClassification = CustomerContent;
        }
        field(66007; "CCS Deposit Amount"; Decimal)
        {
            Caption = 'Deposit Amount';
            DataClassification = CustomerContent;
        }
        field(66008; "CCS Balance Amount"; Decimal)
        {
            Caption = 'Balance Amount';
            DataClassification = CustomerContent;
        }
        field(66009; "CCS Deposit Payment Date"; Date)
        {
            Caption = 'Deposit Payment Date';
            DataClassification = CustomerContent;
        }
        field(66010; "CCS Deposit Payment Status"; Enum "ccs Payment Status")
        {
            Caption = 'Deposit Payment Status';
            DataClassification = CustomerContent;
        }
        field(66011; "CCS Balance Payment Date"; Date)
        {
            Caption = 'Balance Payment Date';
            DataClassification = CustomerContent;
        }
        field(66012; "CCS Balance Payment Status"; Enum "ccs Payment Status")
        {
            Caption = 'Balance Payment Status';
            DataClassification = CustomerContent;
        }
        field(66013; "CCS Bill of Lading No."; Text[50])
        {
            Caption = 'Bill of Lading No.';
            DataClassification = CustomerContent;
        }
        field(66014; "CCS Shipping Cost"; Decimal)
        {
            Caption = 'Shipping Cost';
            DataClassification = CustomerContent;
        }
        field(66015; "CCS Shipping Payment Date"; Date)
        {
            Caption = 'Shipping Payment Date';
            DataClassification = CustomerContent;
        }
        field(66016; "CCS Deposit Exchange"; Decimal)
        {
            Caption = 'Deposit Exchange';
            DataClassification = CustomerContent;
        }
        field(66017; "CCS Balance Exchange"; Decimal)
        {
            Caption = 'Balance Exchange';
            DataClassification = CustomerContent;
        }
        field(66018; "CCS Final Exchange"; Decimal)
        {
            Caption = 'Final Exchange';
            DataClassification = CustomerContent;
        }
        field(66019; "CCS Commercial Invoice Status"; Enum "CCS Doc Status")
        {
            Caption = 'Commercial Invoice Status';
            DataClassification = CustomerContent;
        }
        field(66020; "CCS Packing List Status"; Enum "CCS Doc Status")
        {
            Caption = 'Packing List Status';
            DataClassification = CustomerContent;
        }
        field(66021; "CCS Bill of Lading Copy Status"; Enum "CCS Doc Status")
        {
            Caption = 'Bill of Lading Copy Status';
            DataClassification = CustomerContent;
        }
        field(66022; "CCS Release Status"; Enum "CCS Release Status")
        {
            Caption = 'Release Status';
            DataClassification = CustomerContent;
        }
        field(66028; "CCS Port Agent"; code[20])
        {
            Caption = 'Port Agent';
            TableRelation = "Port Agent";
            DataClassification = CustomerContent;
        }
        field(66023; "CCS Agent Invoice Amount"; Decimal)
        {
            Caption = 'Agent Invoice Amount';
            DataClassification = CustomerContent;
        }
        field(66024; "CCS Agent Invoice No."; Text[50])
        {
            Caption = 'Agent Invoice No.';
            DataClassification = CustomerContent;
        }
        field(66025; "CCS Inspection"; Option)
        {
            Caption = 'Inspection';
            OptionMembers = "No","Yes";
            OptionCaption = 'No,Yes';
        }
        field(66027; "CCS Inspection Agent"; code[20])
        {
            Caption = 'Inspection Agent';
            TableRelation = "Inspection Agent";
            DataClassification = CustomerContent;
        }
        field(66026; "CCS Inspection Report No."; Text[50])
        {
            Caption = 'Inspection Report No.';
            DataClassification = CustomerContent;
        }
    }

}