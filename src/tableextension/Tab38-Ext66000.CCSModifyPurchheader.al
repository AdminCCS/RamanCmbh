/// <summary>
/// TableExtension CCS Modify Purchheader (ID 66000) extends Record Purchase Header //38.
/// </summary>
tableextension 66000 "CCS Modify Purchheader" extends "Purchase Header" //38
{
    fields
    {
        field(66000; "CCS Purchase Order Status"; Option)
        {
            OptionMembers = "Pending",Booked,Shipped,Confirmed,OnProduction;
            DataClassification = CustomerContent;
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
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(66017; "CCS Balance Exchange"; Decimal)
        {
            Caption = 'Balance Exchange';
            DecimalPlaces = 0 : 5;
            DataClassification = CustomerContent;
        }
        field(66018; "CCS Final Exchange"; Decimal)
        {
            Caption = 'Final Exchange';
            DecimalPlaces = 0 : 5;
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
        field(66026; "CCS Inspection Report No."; Text[50])
        {
            Caption = 'Inspection Report No.';
            DataClassification = CustomerContent;
        }
        field(66027; "CCS Inspection Agent"; Code[20])
        {
            Caption = 'Inspection Agent';
            TableRelation = "Inspection Agent";
            DataClassification = CustomerContent;
        }
        field(66028; "CCS Port Agent"; Code[20])
        {
            Caption = 'Port Agent';
            TableRelation = "Port Agent";
            DataClassification = CustomerContent;
        }
        field(66029; "CCS Total Balance Amt"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Header"."CCS Balance Amount" where("CCS Container No." = field("CCS Container No.")));
            Caption = 'CCS Total Balance Amt';
        }
        field(66030; "CCS Total Deposit Amt"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Header"."CCS Deposit Amount" where("CCS Container No." = field("CCS Container No.")));
            Caption = 'CCS Total Deposit Amt';
        }
        field(66031; "CCS Total Shipping Cost"; Decimal)
        {
            Caption = 'Total Shipping Cost';
            FieldClass = FlowField;
            CalcFormula = sum("Purchase Header"."CCS Shipping Cost" where("CCS Container No." = field("CCS Container No.")));
        }
    }
    trigger OnDelete()
    begin
        /* if rec."No." <> '' then begin
            purchLineRec.Reset;
            purchLineRec.SetRange("Document Type", rec."Document Type");
            purchLineRec.SetRange("Document No.", "No.");
            purchLineRec.SetFilter("No.", '<>%1', '');
            if purchLineRec.FindFirst() then
                repeat
                    salesLine.Reset();
                    salesLine.SetRange("CCS PO Number", purchLineRec."Document No.");
                    salesLine.SetRange("No.", purchLineRec."No.");
                    if salesLine.FindSet() then
                        repeat
                            if docNos = '' then
                                docNos := salesLine."Document No." else
                                if NOT (salesLine."Document No." IN [docNos]) then
                                    docNos := docNos + ',' + salesLine."Document No.";
                        until salesLine.Next() = 0;
                until purchLineRec.Next() = 0;
            if docNos <> '' then
                if Dialog.Confirm('Sales orders attached with this PO.Do you want to delete the PO and SO?', false, true) then begin
                    purchLineRec.Reset;
                    purchLineRec.SetRange("Document No.", "No.");
                    purchLineRec.SetFilter("No.", '<>%1', '');
                    if purchLineRec.FindSet() then
                        repeat
                            salesLine.Reset();
                            salesLine.SetRange("CCS PO Number", purchLineRec."Document No.");
                            salesLine.SetRange("No.", purchLineRec."No.");
                            if salesLine.FindSet() then
                                salesLine.DeleteAll(true);
                        until purchLineRec.Next() = 0;
                    SalesHeader.SetFilter("No.", docNos);
                    if SalesHeader.FindSet then
                        repeat
                            salesLine.Reset();
                            salesLine.SetRange("Document No.", SalesHeader."No.");
                            salesLine.SetFilter("No.", '<>%1', '');
                            if not salesLine.FindFirst() then
                                SalesHeader.Delete(true);
                        until SalesHeader.next = 0;
                end else
                    error('');
        end; */
    end;
}