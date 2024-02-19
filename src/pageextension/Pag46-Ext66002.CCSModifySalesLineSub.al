/// <summary>
/// PageExtension CCS ModifySalesLineSub (ID 66002) extends Record Sales Order Subform //46.
/// </summary>
pageextension 66002 "CCS ModifySalesLineSub" extends "Sales Order Subform" //46
{
    layout
    {
        addbefore(Quantity)
        {
            field("Order Type"; rec."CCS Order Type")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Order Type field.';
                trigger OnValidate()
                begin
                    if rec."CCS Order Type" in [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
                        editPO := false;
                        editSO := false;
                    end;
                    if rec."CCS Order Type" in [rec."CCS Order Type"::"Instant Order"] then begin
                        editPO := false;
                        editSO := true;
                    end;
                    if rec."CCS Order Type" in [rec."CCS Order Type"::"Disposition order"] then begin
                        editSO := false;
                        editPO := true;
                    end;
                end;
            }
        }
        addbefore(Quantity)
        {
            field("CCS BA Number"; Rec."CCS BA Number")
            {
                ApplicationArea = all;
                Editable = editSO;
                ToolTip = 'Specifies the value of the BA Number field.';
            }
            field("CCS PO Number"; Rec."CCS PO Number")
            {
                ApplicationArea = all;
                Editable = editPO;
                ToolTip = 'Specifies the value of the PO Number field.';
            }
        }
        addafter(Quantity)
        {

            field("Unit Cost"; rec."Unit Cost")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Unit Cost field.';
            }

            field("CCS Masterbox Qty"; rec."CCS Masterbox Qty")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Masterbox Qty field.';
            }
            field
            ("CCS Cartons"; rec."CCS Cartons")
            {
                ApplicationArea = all;
                Editable = false;
                ToolTip = 'Specifies the value of the Cartons field.';
            }
            field("CCS Rebate 1 %"; rec."CCS Rebate 1 %")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Rebate 1 % field.';
            }
            field("CCS Rebate 2 %"; rec."CCS Rebate 2 %")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the value of the Rebate 2 % field.';
            }

        }
        modify("Unit Cost (LCY)")
        {
            Visible = true;
            Editable = true;
        }
    }
    trigger OnOpenPage()
    begin
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
            editPO := false;
            editSO := false;
        end;
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Instant Order"] then begin
            editPO := false;
            editSO := true;
        end;
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Disposition order"] then begin
            editSO := false;
            editPO := true;
        end;
    end;

    trigger OnAfterGetRecord()

    begin
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Blocking Order", rec."CCS Order Type"::"Backlog order"] then begin
            editPO := false;
            editSO := false;
        end;
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Instant Order"] then begin
            editPO := false;
            editSO := true;
        end;
        if rec."CCS Order Type" in [rec."CCS Order Type"::"Disposition order"] then begin
            editSO := false;
            editPO := true;
        end;
    end;

    trigger OnDeleteRecord(): Boolean
    begin

        // SalesLine.Reset();
        // SalesLine.SetRange("Document No.", Rec."CCS BA Number");
        // SalesLine.SetRange("No.", Rec."No.");
        // if SalesLine.FindFirst() then
        //     error('Can not delete this line,this order tagged on order no%1', SalesLine."Document No.");

    end;

    var
        editPO: Boolean;
        editSO: Boolean;
}
